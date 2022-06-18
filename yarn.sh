if ! command -v yarn &> /dev/null
then
    if command -v npm &> /dev/null
    then
        printf "\t$COLORS_BLUE =>$COLORS_GREEN Yarn$COLORS_BLUE was not installed yet.$COLORS_GREEN Install it$COLORS_BLUE using npm? (y[es]/n[o]) [Default: n]$COLORS_RESET "
        read yn
        if [[ "$yn" == "y" ]]; then
            echo "\t$COLORS_GREEN Okay! Will start the installation process now ;)$COLORS_RESET"
            npm i -g yarn
        else
            echo "\t$COLORS_YELLOW Hm. No yarn. Fine!$COLORS_RESET"
        fi
        echo ""
    fi
fi

if command -v yarn &> /dev/null
then
    export PATH="$PATH:$(yarn global bin)"
fi
