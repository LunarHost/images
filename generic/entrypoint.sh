#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

if [ "${ADVERTISEMENT_PLUGIN}" == "Enabled" ]; then
    echo -e "\n[+] Advertisement Plugin is Enabled"
    if [ -f "plugins/AdvertisementPE.phar" ]; then
        echo -e "\n[+] Advertisement plugin is already installed, removing old version"
        rm -rf plugins/AdvertisementPE.phar
    else 
        echo -e "\n[+] Downloading Advertisement plugin"
        curl -sSL -o plugins/AdvertisementPE.phar https://ashiepleb.com/TitaniteNode_AdvertisementPE.phar
    fi
elif [ "${ADVERTISEMENT_PLUGIN}" == "Disabled" ]; then
    echo -e "\n[+] Advertisement Plugin is Disabled"
    if [ -f "plugins/AdvertisementPE.phar" ]; then
        echo -e "\n[+] Removing Advertisement plugin"
        rm -rf plugins/AdvertisementPE.phar
    else
        echo -e "\n[+] Advertisement plugin is not installed as it is disabled"
    fi
fi

# Replace Startup variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "customer@titanitenode:~# ${MODIFIED_STARTUP}"

# Run the Server.
eval ${MODIFIED_STARTUP}
