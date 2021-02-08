#!/bin/bash

log(){
    echo ''
    echo '-------------------------------------'
    echo "$*"
    echo '-------------------------------------'
    echo ''
}

loop_parser(){
    while true
    do
        result=$(curl -s -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/xtls/xray-core/releases/latest | grep "$1" | cut -d '"' -f 4)
        if [ -n "$result" ]; then
            echo "$result"
            break
        fi
    done
}

log 'parser xray download url'

DOWNLOAD_URL_INTEL=$( loop_parser 'browser_download_url.*macos-64.zip"$' )
DOWNLOAD_URL_ARM=$( loop_parser 'browser_download_url.*macos-arm64-v8a.zip"$' )


if [ -z "$DOWNLOAD_URL_INTEL" ]; then
    
    log 'parser download url error, skip update.'
    exit 0
    
fi

log "download url: $DOWNLOAD_URL_INTEL  start downloading..."
log "download url: $DOWNLOAD_URL_ARM  start downloading..."


curl -s -L "$DOWNLOAD_URL_INTEL" > Xray-macos-64.zip || { log 'file download failed!' ; exit 1; }
curl -s -L "$DOWNLOAD_URL_ARM" > Xray-macos-arm64-v8a.zip || { log 'file download failed!' ; exit 1; }

if [ ! -e Xray-macos-64.zip ]; then
    log "intel file download failed!"
    exit 1
fi
if [ ! -e Xray-macos-arm64-v8a.zip ]; then
    log "arm file download failed!"
    exit 1
fi


V_HASH256_INTEL=$(sha256sum Xray-macos-64.zip |cut  -d ' ' -f 1)
V_HASH256_ARM=$(sha256sum Xray-macos-arm64-v8a.zip.zip |cut  -d ' ' -f 1)


log "file hash: $V_HASH256_INTEL parser intel xray-core version..."
log "file hash: $V_HASH256_ARM parser arm xray-core version..."


V_VERSION=$( loop_parser "tag_name" )
V_VERSION="${V_VERSION:1}"

if [ -z "$V_VERSION" ]; then
    
    log 'parser file version error, skip update.'
    exit 0
    
fi


log "file version: $V_VERSION start clone..."

git clone https://github.com/N4FA/homebrew-xray.git

log "update config...."

sed -i "s#^\s*intel_url.*#  url \"$DOWNLOAD_URL_INTEL\"#g" homebrew-xray/Formula/xray-core.rb
sed -i "s#^\s*intel_arm.*#  url \"$DOWNLOAD_URL_ARM\"#g" homebrew-xray/Formula/xray-core.rb

sed -Ee "/^ *sha256.*intel/s/[0-9a-f]{64}/${V_HASH256_INTEL}/" -i homebrew-xray/Formula/xray-core.rb
sed -Ee "/^ *sha256.*arm/s/[0-9a-f]{64}/${V_HASH256_ARM}/" -i homebrew-xray/Formula/xray-core.rb

sed -i "s#^\s*version.*#  version \"$V_VERSION\"#g" homebrew-xray/Formula/xray-core.rb

log "update config done. start update repo..."

cd homebrew-xray || exit
git commit -am "travis automated update version $V_VERSION"
git push  --quiet "https://${GH_TOKEN}@${GH_REF}" main:main

log "update repo done."
