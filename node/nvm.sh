export NVM_DIR="$HOME/.nvm"

if [[ "$OSTYPE" =~ ^darwin.* ]]; then
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
else
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/etc/bash_completion.d/nvm" ] && . "$NVM_DIR/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

if ! command -v nvm &> /dev/null
then
    printf "\t$COLORS_BLUE =>$COLORS_GREEN Node Version Manager (NVM)$COLORS_BLUE was not installed yet.$COLORS_GREEN Install it?$COLORS_BLUE (y[es]/n[o]) [Default: n]$COLORS_RESET "
    read yn
    if [[ "$yn" == "y" ]]; then
        echo "\t$COLORS_GREEN Okay! Will start the installation process now ;)$COLORS_RESET"
	    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        if [[ "$OSTYPE" =~ ^darwin.* ]]; then
            [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
            [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
        else
            [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
            [ -s "$NVM_DIR/etc/bash_completion.d/nvm" ] && . "$NVM_DIR/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
        fi

        nvm install --lts
     else
        echo "\t$COLORS_YELLOW Hm. No NVM for you. Fine!$COLORS_RESET"
    fi
    echo ""
fi

# NVM Autoswitcher
find-up () {
    path=$(pwd)
    while [[ "$path" != "" && ! -e "$path/$1" ]]; do
        path=${path%/*}
    done
    echo "$path"
}

alias cdnvm_old=cd

NVM_DEFAULT_VERSION=''
if [ -f '.nvmrc' ]; then
    SPECIFIC_NODE="1"
else
    SPECIFIC_NODE="0"
fi

cdnvm(){
    cdnvm_old "$@";

    if [ -f '.nvmrc' ]; then
        NEW_SPECIFIC_NODE="1"
    else
        NEW_SPECIFIC_NODE="0"
    fi

    if [ "$NEW_SPECIFIC_NODE" = "0" ] && [ "$SPECIFIC_NODE" = "$NEW_SPECIFIC_NODE" ]; then
        return;
    fi

    SPECIFIC_NODE=$NEW_SPECIFIC_NODE

    nvm_path=$(find-up .nvmrc | tr -d '[:space:]')
    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        if [ ! -z "$NVM_DEFAULT_VERSION" ]; then
            default_version=$NVM_DEFAULT_VERSION
        else
            default_version=$(nvm version default);
            # If there is no default version, set it to `node`
            # This will use the latest version on your machine
            if [[ $default_version == "N/A" ]]; then
                nvm alias default node;
                default_version=$(nvm version default);
            fi
            NVM_DEFAULT_VERSION=$default_version
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            echo "No .nvmrc found, changing node version to default";
            nvm use default;
        fi

        elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        # Add the `v` suffix if it does not exists in the .nvmrc file
        if [[ $nvm_version != v* ]]; then
            nvm_version="v""$nvm_version"
        fi

        # If it is not already installed, install it
        if [[ $(nvm ls "$nvm_version" | tr -d '[:space:]') == "N/A" ]]; then
            echo "Installing node version $nvm_version";
            nvm install "$nvm_version";
        fi

        if [[ $(nvm current) != "$nvm_version" ]]; then
            echo "Found .nvmrc, Changing node version to $nvm_version";
            nvm use "$nvm_version";
        fi
    fi
}

#if command -v nvm &> /dev/null
#then
    alias cd='cdnvm'
#fi
