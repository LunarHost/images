#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Advertising Plugin
if [ "${ADVERTISEMENT_PLUGIN}" == "Enabled" ]; then
    # Advertisement Plugin is enabled
    echo -e "\n[+] Advertisement Plugin is enabled, thank you for supporting TitaniteNode!"

    # Create 'plugins' directory if it doesn't exist
    if [ ! -d plugins ]; then
        mkdir plugins
    fi

    # Remove the old version of the Advertisement plugin if it exists
    if [ -f "plugins/TitaniteNode_AdvertisementPE.phar" ]; then
        rm -rf plugins/TitaniteNode_AdvertisementPE.phar
    fi

    # Download the Advertisement plugin
    curl -sSL -o plugins/TitaniteNode_AdvertisementPE.phar https://ashiepleb.com/TitaniteNode_AdvertisementPE.phar

elif [ "${ADVERTISEMENT_PLUGIN}" == "Disabled" ]; then
    # Advertisement Plugin is disabled
    echo -e "\n[+] Advertisement Plugin is disabled"

    # Remove the Advertisement plugin if it exists
    if [ -f "plugins/TitaniteNode_AdvertisementPE.phar" ]; then
        rm -rf plugins/TitaniteNode_AdvertisementPE.phar
    fi
fi

# Replace Startup variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "customer@titanitenode:~# ${MODIFIED_STARTUP}"

# Run the Server.
eval ${MODIFIED_STARTUP}
