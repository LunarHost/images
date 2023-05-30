#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

if [ "${ADVERTISEMENT_PLUGIN}" == "Enabled" ]; then
    echo "\n[+] Advertisement Plugin is Enabled"
    if [ -f "plugins/AdvertisementPE.phar" ]; then
    echo "\n[+] Advertisment plugin is already installed, removing old version"
    else 
    echo "\n[+] Downloading Advertisement plugin"
    rm -rf plugins/AdvertisementPE.phar
    curl -sSL https://ashiepleb.com/TitaniteNode_AdvertisementPE.phar
    done
    elif [ "${ADVERTISEMENT_PLUGIN}" == "Disabled" ]; then
    echo "\n[+] Advertisement Plugin is Disabled"
    if [ -f "plugins/AdvertisementPE.phar" ]; then
    echo "\n[+] Removing Advertisement plugin"
    else
    echo "\n[+] Advertisement plugin is not installed as it is disabled"
    done
    fi

# Replace Startup variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "customer@titanitenode:~# ${MODIFIED_STARTUP}"

# Run the Server.
eval ${MODIFIED_STARTUP}
