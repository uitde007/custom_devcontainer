#!/bin/bash
set -e

### install prereqs
sudo apt-get update && \
sudo apt-get install -y gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev

## Functions
wget_install() {
    URL=$1
    ZIP=$2
    FOLDER=$3
    DST=/tmp

    wget "$URL"/"$ZIP" -O $DST/"$ZIP" && \
        tar xvf $DST/"$ZIP" -C $DST && \
        rm $DST/"$ZIP" && \
        cd $DST/"$FOLDER" && \
        make && \
        sudo make install && \
        cd / && \
        rm -rf ${DST:?}/"$FOLDER"
}


# Build
echo "Activating feature 'localFeatureShortReadMapping'"

# Build args are exposed to this entire feature set following the pattern:  _BUILD_ARG_<FEATURE ID>_<OPTION NAME>

### htslib
if [ ${HTSLIB} == true ]; then
    echo "Building feature 'Samtools'"
    wget_install https://github.com/samtools/htslib/releases/download/1.16/ htslib-1.16.tar.bz2 htslib-1.16
fi

### samtool
if [ ${SAMTOOLS} == true ]; then
    echo "Building feature 'HTSlib'"
    wget_install https://github.com/samtools/samtools/releases/download/1.16.1/ samtools-1.16.1.tar.bz2 samtools-1.16.1
fi

### bcftools
if [ ${BCFTOOLS} == true ]; then
    echo "Building feature 'BCFtools'"
    wget_install https://github.com/samtools/bcftools/releases/download/1.16/ bcftools-1.16.tar.bz2 bcftools-1.16
fi
