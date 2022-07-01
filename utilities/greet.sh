if [ "$MACHINE_TYPE" = "work" ]; then
  printf '\n'
  printf '%s__________%s.__  %s     %s   __  %s  _____ %s     %s       %s        %s ___________ %s             %s   %s   %s\n' $RAINBOW $RESET
  printf '%s\\______   \\%s  | %s_____ %s_/  |__%s/ ____\\%s_____%s______ %s _____  %s \\__    ___/%s___ %s_____   %s _____  %s\n' $RAINBOW $RESET
  printf '%s |     ___/%s  | %s\\__  \\%s\\   __%s\\   __\\%s/  _ \\%s_  __ \\%s/     \\ %s   |    |%s_/ __ \\%s\\__  \\  %s/     \\ %s\n' $RAINBOW $RESET
  printf '%s |    |   %s|  |__%s/ __ \\%s|  |  %s|  | %s(  <_> )%s  | \\%s/  Y Y  \\ %s  |    |%s\\  ___/ %s/ __ \\%s|  Y Y  \\%s\n' $RAINBOW $RESET
  printf '%s |____|   %s|____%s(____  /%s__|  %s|__|  %s\\____/%s|__|  %s|__|_|  /  %s |____|%s \\___  >%s____  /%s__|_|  /%s\n' $RAINBOW $RESET
  printf '%s          %s     %s     \\/ %s       %s            %s      %s    \\/      %s       %s  \\/   %s %s \\/   %s   \\/ %s \n' $RAINBOW $RESET
else
  printf '\n'
  printf '\n'
  printf '%s  ___ ___  %s     %s___.   %s      %s       %s  __ /\ %s      %s  ___ ___  %s        %s       %s       %s\n' $RAINBOW $RESET
  printf '%s /   |   \ %s ____%s\_ |__ %s_____ %s_______%s_/  |)/%s______ %s /   |   \ %s ____   %s_____  %s ____  %s\n' $RAINBOW $RESET
  printf '%s/    ~    \%s/  _ \%s| __ \%s\__  \%s\_  __ \%s   __/%s  ___/%s /    ~    \%s/  _ \ %s/     \_%s/ __ \ %s\n' $RAINBOW $RESET
  printf '%s\    Y    %s(  <_> %s| \_\ \%s/ __ \%s|  | \/%s|  | %s\___ \ %s \    Y    %s(  <_> |%s  Y Y  \%s  ___/ %s\n' $RAINBOW $RESET
  printf '%s \___|_  / %s\____/%s|___  %s(____  |%s__|   %s|__|%s/____  > %s \___|_  / %s\____/|%s__|_|  /%s\___  >%s\n' $RAINBOW $RESET
  printf '%s       \/  %s      %s    \/ %s    \/ %s       %s   %s     \/   %s      \/   %s       %s    \/  %s   \/ %s\n' $RAINBOW $RESET
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
