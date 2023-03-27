if [ "$MACHINE_TYPE" = "work" ]; then
  WORK_RAINBOW=("${RAINBOW[@]:0:8}")

  printf '%s _________ %s       %s        %s           %s ___________%s        %s        %s         %s \n' $WORK_RAINBOW $RESET
  printf '%s \_   ___ \%s    ____ %s _______%s    ____ %s \__    ___/%s  ____ %s _____  %s   _____ %s \n' $WORK_RAINBOW $RESET
  printf '%s /    \  \/%s   /  _ \%s \_  __ \%s _/ __ \%s   |    |  %s _/ __ \%s \__  \ %s  /     \%s \n' $WORK_RAINBOW $RESET
  printf '%s \     \____%s (  <_> )%s |  | \/%s \  ___/%s   |    |  %s \  ___/%s  / __ \_%s |  Y Y \%s \n' $WORK_RAINBOW $RESET
  printf '%s  \______  /%s  \____/%s  |__|  %s   \___  >%s  |____|  %s  \__  >%s (____  /%s|__|_| /%s \n' $WORK_RAINBOW $RESET
  printf '%s         \/%s       %s        %s         \/%s           %s     \/%s       \/%s      \/%s \n' $WORK_RAINBOW $RESET
  printf '\n'
  #printf '%s__________%s.__  %s     %s   __  %s  _____ %s     %s       %s        %s ___________ %s             %s   %s   %s\n' $RAINBOW $RESET
  #printf '%s\\______   \\%s  | %s_____ %s_/  |__%s/ ____\\%s_____%s______ %s _____  %s \\__    ___/%s___ %s_____   %s _____  %s\n' $RAINBOW $RESET
  #printf '%s |     ___/%s  | %s\\__  \\%s\\   __%s\\   __\\%s/  _ \\%s_  __ \\%s/     \\ %s   |    |%s_/ __ \\%s\\__  \\  %s/     \\ %s\n' $RAINBOW $RESET
  #printf '%s |    |   %s|  |__%s/ __ \\%s|  |  %s|  | %s(  <_> )%s  | \\%s/  Y Y  \\ %s  |    |%s\\  ___/ %s/ __ \\%s|  Y Y  \\%s\n' $RAINBOW $RESET
  #printf '%s |____|   %s|____%s(____  /%s__|  %s|__|  %s\\____/%s|__|  %s|__|_|  /  %s |____|%s \\___  >%s____  /%s__|_|  /%s\n' $RAINBOW $RESET
  #printf '%s          %s     %s     \\/ %s       %s            %s      %s    \\/      %s       %s  \\/   %s %s \\/   %s   \\/ %s \n' $RAINBOW $RESET
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

#printf '%s __      __   _                    _            _      _        _  %s \n' $YELLOW $RESET
#printf '%s \ \    / /__| |__ ___ _ __  ___  | |_ ___   __| |_  _| |_ _  _| | %s \n'  $YELLOW $RESET
#printf '%s  \ \/\/ / -_) / _/ _ \ `  \/ -_) |  _/ _ \ / _` | || |  _| || |_| %s \n'  $YELLOW $RESET
#printf '%s   \_/\_/\___|_\__\___/_|_|_\___|  \__\___/ \__,_|\_,_|\__|\_, (_) %s \n'  $YELLOW $RESET
#printf '%s                                                           |__/    %s \n'  $YELLOW $RESET
