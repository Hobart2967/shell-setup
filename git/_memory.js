const { promisify } = require('util');
const fs = require('fs');
const path = require('path');
const https = require('https');
const exec = promisify(require('child_process').exec)

const configPath = path.join(__dirname, 'git-repos.json');
if (!fs.existsSync(configPath)) {
  process.exit(1);
}

async function downloadGemojiList() {
  const configPath = path.join(__dirname, 'emoji.json');
  if (fs.existsSync(configPath)) {
    return JSON.parse(fs.readFileSync(configPath));
  }

  const url = 'https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json';
  try {
    const result = await new Promise(resolve => https.get(url, res => {
      let data = '';
      res.on('data', d => data += d);
      res.on('close', () => resolve(data));
    }));


    const list = JSON.parse(result);
    fs.writeFileSync(configPath, JSON.stringify(list, null, 2));
    return list;
  } catch (e) {
    console.log(e);
  }
}

(async function() {
  const tiemSpanInDays = process.argv[2]
    ? parseInt(process.argv[2])
    : 3;
  const since = new Date(new Date(Date.now()).getTime() - tiemSpanInDays * 24 * 60 * 60 * 1000);
  since.setHours(0);
  since.setMinutes(0);
  since.setSeconds(0);
  since.setMilliseconds(0);

  const repos = JSON.parse(fs.readFileSync(configPath));
  const results = await Promise.all(repos
    .map(repo =>
      exec(`git log --since="${since.toISOString()}" --branches --abbrev-commit --pretty="format:%ci\t%B"`, {
        cwd: repo
      })
      .then(result => ({ repo, result }))
      .catch(() => ({ repo, result: { stdout: '' } }))
    ));


  const output = results.filter(x => x.result.stdout.trim().length);
  if (!output.length) {
    console.log('\nNo chances since ' + since.toISOString())
    process.exit(1);
  }

  const emojis = await downloadGemojiList();
  const regexes = emojis
    .map(emojiInfo => emojiInfo.aliases
      .map(alias => ({
        pattern: new RegExp(`:${alias}:`, 'g'),
        replacement: emojiInfo.emoji
      })))
    .reduce((prev, cur) => [...prev, ...cur], []);

  console.log('\nShowing changes since ' + since.toString() + '\n');
  for (const { result, repo } of output) {
    console.log(`\x1b[36m==== ${path.basename(path.dirname(repo))}/${path.basename(repo)} ====\x1b[0m`);

    const text = regexes.reduce((prev, {pattern, replacement}) =>
      prev.replace(pattern, replacement), result.stdout);
    console.log(text
      .replace(/\n\n/g, '\n'));
  }
})();
