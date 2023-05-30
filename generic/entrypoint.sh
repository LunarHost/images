#!/bin/bash
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Advertising Plugin
if [ "${ADVERTISEMENT_PLUGIN}" == "Enabled" ]; then
    echo -e "\n[+] Advertisement Plugin is enabled, thank you for supporting TitaniteNode!"
    if [ -d plugins ]; then
    :
    else
        echo -e "\n[+] Plugins folder does not exist, creating it so the plugin can be installed."
        mkdir plugins
    fi
    if [ -f "plugins/TitaniteNode_AdvertisementPE.phar" ]; then
        echo -e "\n[+] Advertisement plugin is already installed, removing it so we can install the latest version."
        rm -rf plugins/TitaniteNode_AdvertisementPE.phar
    else 
        echo -e "\n[+] Retrieving the most recent version of the Advertisement plugin."
        curl -sSL -o plugins/TitaniteNode_AdvertisementPE.phar https://ashiepleb.com/TitaniteNode_AdvertisementPE.phar
    fi
elif [ "${ADVERTISEMENT_PLUGIN}" == "Disabled" ]; then
    :
    if [ -f "plugins/TitaniteNode_AdvertisementPE.phar" ]; then
        echo -e "\n[+] Advertisement plugin is installed, removing it as it is disabled"
        rm -rf plugins/TitaniteNode_AdvertisementPE.phar
    else
        echo -e "\n[+] Advertisement plugin is not installed as it is disabled"
    fi
fi

# Replace Startup variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "customer@titanitenode:~# ${MODIFIED_STARTUP}"

# Run the Server.
eval ${MODIFIED_STARTUP}
