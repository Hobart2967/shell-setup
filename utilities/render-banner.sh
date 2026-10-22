#!/bin/zsh
source $PERSONAL_SHELL_SETUP_PATH/utilities/_colors.sh

banner=$1
BANNER_LINES=()
lines=6

render_letter() {
    unset line_index
    line_index=1
    while IFS=\= read var; do
        BANNER_LINES[line_index]=${BANNER_LINES[line_index]}' %s'$var
        line_index=$((line_index+1))
    done < <(figlet -f slant "$1" | sed -e 's/\\/\\\\/g')
}

banner_letters=$(echo $banner | fold -w1 | sed 's/.*/&/')
WORK_RAINBOW=("${RAINBOW[@]:0:7}")


for index in $lines
do
    BANNER_LINES[$index]=""
done

while IFS=\= read letter; do
    render_letter $letter
done < <(echo $banner | fold -w1 | sed 's/.*/&/')

for line_index in {1..$lines}
do
   printf "\t${BANNER_LINES[line_index]} %s\n" $WORK_RAINBOW $RAINBOW_RESET
done
