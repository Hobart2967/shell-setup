const { promisify } = require('util');
const fs = require('fs');
const path = require('path');
const https = require('https');
const exec = promisify(require('child_process').exec)

if(process.argv[2] === '--help') {
  console.log('\nUsage: git-memory [timeSpanInDays] [--all]\n');
  console.log('  timeSpanInDays \tValue from 0 to Infinity, number of days that should be inspected. Default: 3');
  console.log('  --all \t\tIf set, commits are **NOT** filtered by only yours. Default: false');
  process.exit(1);
}

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
  const timeSpanParam = process.argv[2] !== '--all' ? process.argv[2] : null;
  const tiemSpanInDays = timeSpanParam
    ? parseInt(timeSpanParam)
    : 3;
  const since = new Date(new Date(Date.now()).getTime() - tiemSpanInDays * 24 * 60 * 60 * 1000);
  since.setHours(0);
  since.setMinutes(0);
  since.setSeconds(0);
  since.setMilliseconds(0);


  let additionalArgs = '';
  if (!process.argv.includes('--all')) {
    const username = await
      exec(`git config user.name`);
    additionalArgs = `--author="${username.stdout.trim()}"`;
  }
  const repos = JSON.parse(fs.readFileSync(configPath));
  const results = await Promise.all(repos
    .map(repo =>
      exec(`git log --since="${since.toISOString()}" --branches --abbrev-commit --pretty="format:%ci\t%B" ${additionalArgs}`, {
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
    const repoName = `${path.basename(path.dirname(repo))}/${path.basename(repo)}`;
    console.log(' ');
    let text = regexes.reduce((prev, {pattern, replacement}) =>
      prev.replace(pattern, replacement), result.stdout);
    text = text
      .replace(/\n\n/g, '\n')
      .replace(/\n([^\d])/g, ' $1')
      .split('\n')
      .map(x => `${repoName}\t${x}`)
      .join('\n')
    console.log(text);
  }
})();
