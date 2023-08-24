binPath=$(command -v awsume)
if [ ! -z "$binPath" ]; then
  _awsume() {
      local cur prev opts
      COMPREPLY=()
      cur="${COMP_WORDS[COMP_CWORD]}"
      prev="${COMP_WORDS[COMP_CWORD-1]}"
      opts=$(awsume-autocomplete)
      COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
      return 0
  }
  complete -F _awsume awsume
fi
alias awsume=". awsume --output-profile default"

alias aws-login="aws-sso-util login --profile $AWS_DEFAULT_ACCOUNT"