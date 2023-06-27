__git_prompt_git() {
  if wslpath -w . | grep -q '\\wsl'; then
    echo git $@
  else
    echo powershell.exe git.exe --no-optional-locks $@
  fi
}