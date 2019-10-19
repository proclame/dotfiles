echo "What is your name (for Git)?"
read -r response
git config --global --unset-all user.name
git config --global user.name "$response"

echo "What is your email address (for Git)?"
read -r response
git config --global --unset-all user.email
git config --global user.email $response

echo "Generating SSH Key to use with Github / Bitbucket"
## Generate new SSH Key for github & bitbucket
ssh-keygen -f ~/.ssh/git_rsa -t rsa -b 4096 -C $response -P ''
ssh-add ~/.ssh/git_rsa
## Provide instructions to add SSH Key to these services
pbcopy < ~/.ssh/git_rsa.pub
echo "Public key copied to clipboard, hit any key to open github settings page & bitbucket home page"
read -r response
open 'https://github.com/settings/keys'
open 'https://bitbucket.org/dashboard/overview'

## Make sure ~/.ssh/config exists and set up
source ssh_config.sh

echo '# Github
Host *.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/git_rsa

# Bitbucket
Host *.bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/git_rsa
' >> ~/.ssh/config
