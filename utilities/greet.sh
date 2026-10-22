if [ "$MACHINE_TYPE" != "home" ]; then
  WORK_RAINBOW=("${RAINBOW[@]:0:7}")

  $PERSONAL_SHELL_SETUP_PATH/utilities/render-banner.sh $MACHINE_TYPE
else
  HOME_RAINBOW=("${RAINBOW[@]:0:11}")
  printf '\n'
  printf '\n'
  printf '%s  ___ ___  %s     %s___.   %s      %s       %s  __ /\ %s      %s  ___ ___  %s        %s       %s       %s\n' $HOME_RAINBOW $RESET
  printf '%s /   |   \ %s ____%s\_ |__ %s_____ %s_______%s_/  |)/%s______ %s /   |   \ %s ____   %s_____  %s ____  %s\n' $HOME_RAINBOW $RESET
  printf '%s/    ~    \%s/  _ \%s| __ \%s\__  \%s\_  __ \%s   __/%s  ___/%s /    ~    \%s/  _ \ %s/     \_%s/ __ \ %s\n' $HOME_RAINBOW $RESET
  printf '%s\    Y    %s(  <_> %s| \_\ \%s/ __ \%s|  | \/%s|  | %s\___ \ %s \    Y    %s(  <_> |%s  Y Y  \%s  ___/ %s\n' $HOME_RAINBOW $RESET
  printf '%s \___|_  / %s\____/%s|___  %s(____  |%s__|   %s|__|%s/____  > %s \___|_  / %s\____/|%s__|_|  /%s\___  >%s\n' $HOME_RAINBOW $RESET
  printf '%s       \/  %s      %s    \/ %s    \/ %s       %s   %s     \/   %s      \/   %s       %s    \/  %s   \/ %s\n' $HOME_RAINBOW $RESET
  printf '\n'
fi

printf '\n'

DATE=$(date '+%A, %d %B of %Y')
TIME=$(date '+%H:%M')
echo -e "\t$YELLOW Welcome to duty, commander! It is $TIME on $DATE. $RESET\n"

echo -e "\t$YELLOW Please wait a jiffy, until I set things up for you...$RESET"

printf '\n'