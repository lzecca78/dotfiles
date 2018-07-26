#!/bin/bash


function add_aliases_mac() {
    grep -q -F 'source ~/.k8s_aliases' ~/.zshrc || echo 'source ~/.k8s_aliases' >> ~/.zshrc
    cat > ~/.k8s_aliases << EOF
alias kl='kubectl'
alias kt='kubetail'
alias ksn='kubens'
EOF
}

function add_aliases_linux() {
    grep -q -F 'source ~/.k8s_aliases' ~/.bashrc || echo 'source ~/.k8s_aliases' >> ~/.bashrc
    cat > ~/.k8s_aliases << EOF
alias kl='kubectl'
alias kt='kubetail'
alias ksn='kubens'
EOF
}


function install_linux() {
    echo "installing kubetail utilities.... please wait"
        wget -O /usr/local/bin/kubetail https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail && chmod +x /usr/local/bin/kubetail
        wget -O /etc/bash_completion.d/kubetail.bash  https://raw.githubusercontent.com/johanhaleby/kubetail/master/completion/kubetail.bash
    echo "installing kubectx utility... please wait"
        wget -O /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx && chmod +x /usr/local/bin/kubectx
        wget -O /etc/bash_completion.d/kubectx.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash
    echo "installing kubens utility... please wait"
        wget -O /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && chmod +x /usr/local/bin/kubens
        wget -O /etc/bash_completion.d/kubens.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash
}

function install_mac() {
    echo "installing kubens and kubectx utilities... please wait"
        brew install kubectx
    echo "installing kubetail utilities.. please wait"
        brew tap johanhaleby/kubetail && brew install kubetail
}


unameOut="$(uname -s)"
case "$OSTYPE" in
    linux*)  
        install_linux
        add_aliases_linux
       ;;
    darwin*)
        install_mac
        add_aliases_mac
       ;;
    *)
        echo "unknown OSTYPE = ${OSTYPE}"
       ;;
esac

