## Make sure ~/.ssh/config exists and set up
source ssh_config.sh

CONTINUE=true

while [[ "$CONTINUE" != false ]]; do
    echo "Do you want to add an(other) SSH Key? (y/n)"
    read -r response
    if [[ "$response" == 'y' ]]; then
        echo "Make sure you have copied the SSH key to ~/.ssh/keys";
        while [[ "$keyname" == '' ]]; do
            echo "What is the name of the key?"
            read -r keyname
        done
        chmod 0600 ~/.ssh/keys/"${keyname}"
        echo "What is the host of the key?"
        read -r host
        echo "What alias you want to use for this host / user?"
        read -r alias
        echo "What is the user of the key / host?"
        read -r user

        echo "
# ${user} @ ${host} with key ${keyname}
Host ${alias}
    HostName ${host}
    User ${user}
    IdentityFile ~/.ssh/keys/${keyname}
" >> ~/.ssh/config
        keyname=''
        host=''
        alias=''
        user=''
    else
        CONTINUE=false
    fi

done
