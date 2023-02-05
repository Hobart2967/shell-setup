const fs = require('fs');
const path = require('path');
const { promisify } = require('util');
const exec = promisify(require('child_process').exec)

const configPath = path.join(__dirname, 'git-repos.json');
if (!fs.existsSync(configPath)) {
  process.exit(1);
}

(async function() {
  const repos = JSON.parse(fs.readFileSync(configPath));
  const results = await Promise.all(repos
    .map(repo =>
      Promise.all([
        exec('git log --branches --not --remotes', {
          cwd: repo
        }),
        exec('git status --porcelain', {
          cwd: repo
        }),
      ]).then(results => ({
        repo,
        results
      }))));

  const unpushed = results
    .filter(x => x.results
      .some(x => x.stdout.trim().length))
    .map(({ repo }) => repo);

  if (unpushed.length) {
    console.log(`📙📙📙 You have non-pushed or non-committed changes in the following repositories: ${JSON.stringify(unpushed, null, 2)}.`)
    console.log(`\n📙📙📙 Check for details using:\n\n\t- git log --branches --not --remotes\n\t- git status`);
  }
})();
