const fs = require('fs');
const path = require('path');
const os = require('os');
const child_process = require('child_process');
const {promisify} = require('util');
const awsCliConfig = fs.readFileSync(path.join(os.homedir(), '.aws', 'config')).toString();


const serviceMap = JSON.parse(fs.readFileSync(path.join(__dirname, 'servicemap.json')));
const parallel = 20;

const services = Object
  .entries(serviceMap)
  .filter(([serviceName]) => {
    const regex = `${serviceName}[\\s\\n]*\\=[\\s\\n]*endpoint_url[\\s\\n]*\\=`;
    return new RegExp(regex).test(awsCliConfig);
  });
const chunkedServices = services
  .reduce((acc, _, i) => {
    if (i % parallel === 0) {
      acc.push(services.slice(i, i + parallel))
    }

    return acc;
  }, []);

const chunks = chunkedServices
  .map(chunk =>
    () => Promise.all(chunk.map(async ([service, envVar]) =>
    `${envVar}="${
      ((await promisify(child_process.exec)(`aws configure --profile ${process.argv[2]} get ${service}.endpoint_url`)
        .catch(err => {
          if(err.code != 1) {
            throw err;
          }

          return '';
        })).stdout || '').replace(/\n/g, '')}"`)));

(async () => {

  const isNonAws = ((await promisify(child_process.exec)
    (`aws configure --profile ${process.argv[2]} get is_non_aws`).catch(err =>
        err.code == 1 ? '' : err))
    .stdout || '')
    .replace(/\n/g, '');

  if (!isNonAws) {
    console.log(Object
      .keys(process.env)
      .filter(x => x.startsWith('AWS_ENDPOINT_URL'))
      .map(varName => `${varName}=""`)
      .concat(['AWS_PROFILE=""'])
      .join('\n'));

    return;
  }

  const results = [];

  for (const chunk of chunks) {
    results.push((
      await chunk()).join('\n'));
  }

  console.log(results.join('\n'));
})();