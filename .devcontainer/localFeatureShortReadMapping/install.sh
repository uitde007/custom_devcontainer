#!/bin/bash
set -e

# The install.sh script is the installation entrypoint for any dev container 'features' in this repository. 
#
# The tooling will parse the devcontainer-features.json + user devcontainer, and write 
# any build-time arguments into a feature-set scoped "devcontainer-features.env"
# The author is free to source that file and use it however they would like.
set -a
. ./devcontainer-features.env
set +a

### install prereqs
sudo apt-get update && \
sudo apt-get install -y gcc make libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev

## functions
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


if [ -n "${_BUILD_ARG_LOCALFEATURESHORTREADMAPPING}" ]; then
    echo "Activating feature 'localFeatureShortReadMapping'"

    # Build args are exposed to this entire feature set following the pattern:  _BUILD_ARG_<FEATURE ID>_<OPTION NAME>

    ### htslib
    if [ "${_BUILD_ARG_LOCALFEATURESHORTREADMAPPING_HTSLIB}" == true ]; then
        echo "Building feature 'Samtools'"
        wget_install https://github.com/samtools/htslib/releases/download/1.16/ htslib-1.16.tar.bz2 htslib
    fi

    ### samtool
    if [ "${_BUILD_ARG_LOCALFEATURESHORTREADMAPPING_SAMTOOLS}" == true ]; then
        echo "Building feature 'HTSlib'"
        wget_install https://github.com/samtools/samtools/releases/download/1.16.1/ samtools-1.16.1.tar.bz2 samtools
    fi

    ### bcftools
    if [ "${_BUILD_ARG_LOCALFEATURESHORTREADMAPPING_BCFTOOLS}" == true ]; then
        echo "Building feature 'BCFtools'"
        wget_install https://github.com/samtools/bcftools/releases/download/1.16/ bcftools-1.16.tar.bz2 bcftools
    fi

fi