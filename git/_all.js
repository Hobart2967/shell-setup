const { promisify } = require('util');
const fs = require('fs');
const path = require('path');
const { stderr } = require('process');
const exec = promisify(require('child_process').exec)

const configPath = path.join(__dirname, 'git-repos.json');
if (!fs.existsSync(configPath)) {
  process.exit(1);
}


(async function() {
  const repos = JSON.parse(fs.readFileSync(configPath));
  for (const repo of repos) {
    console.log(`\x1b[36m==== ${path.basename(path.dirname(repo))}/${path.basename(repo)} ====\x1b[0m`);
    const result = await exec(`git ${process.argv.slice(2).join(' ')}`, {
      cwd: repo,
      stdio: [0,1,2]
    }).catch(err => {
      stderr: `\x1b[31m${err.toString()}\x1b[0m`
    });

    if (result.stdout.trim()) {
      console.log(result.stdout.trim());
    }

    if (result.stderr.trim()) {
      console.log(result.stderr.trim());
    }
  }
})();
