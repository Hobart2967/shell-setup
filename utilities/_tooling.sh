export EDITOR=/usr/bin/nano

CLEANED_OSTYPE="${OSTYPE:0:6}"

if [[ "$CLEANED_OSTYPE" == "darwin" ]]; then
  # Performance boost for midight commander on MacOS
  alias mc="mc --nosubshell"
fi