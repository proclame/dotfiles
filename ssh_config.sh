DIR=~/.ssh/
FILE=~/.ssh/config
if ! test -d "$DIR"; then
    echo "$DIR exist not"
    mkdir $DIR
fi

if ! test -f "$FILE"; then
    echo "$FILE exist not"
    touch "$FILE"
    echo 'Host *
    IgnoreUnknown UseKeychain
    UseKeychain yes
    AddKeysToAgent yes
' >> ~/.ssh/config

fi
