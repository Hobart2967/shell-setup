const fs = require('fs');
const path = require('path');

const targetPath = path.join(process.cwd(), process.argv[2]);
if (!fs.existsSync(path.join(targetPath, '.git'))) {
  process.exit(1);
}

let repos = [];
const configPath = path.join(__dirname, 'git-repos.json');
if (!fs.existsSync(configPath)) {
  fs.writeFileSync(configPath, '[]');
} else {
  repos = JSON.parse(fs.readFileSync(configPath));
}

if (repos.includes(targetPath)) {
  process.exit(1);
}

console.log('Adding repository to machine registry.');
repos.push(targetPath);
fs.writeFileSync(configPath, JSON.stringify(repos, null, 2))