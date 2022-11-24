#!/bin/bash
set -e

echo "Activating feature 'localFeatureShortProfile'"

## Functions
wget_install() {
    URL=$1
    ZIP=$2
    FOLDER=$3
    DST=/tmp

    wget "$URL"/"$ZIP" -O $DST/"$ZIP" &&
        tar xvf $DST/"$ZIP" -C $DST &&
        rm $DST/"$ZIP" &&
        cd $DST/"$FOLDER" &&
        make &&
        sudo make install &&
        cd / &&
        rm -rf ${DST:?}/"$FOLDER"
}

### user_ju
if [ ${USER_JU} == true ]; then
    echo "Setting up profile for 'user_ju'"

    # Install zoxide
    # curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    sudo apt-get update && sudo apt-get install -y zoxide
    ## Define the filename
    filename="$HOME/.bashrc"
    ## Type the text that you want to append
    newtext='eval "$(zoxide init bash)"'
    ## Check the new text is empty or not
    if [ "$newtext" != "" ]; then
        # Append the text by using '>>' symbol
        echo $newtext >>$filename
    fi

fi
