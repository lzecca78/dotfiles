#!/bin/bash

###vars
kustomize_version='1.0.7'
ark_version='0.9.3'


###functions
function install_with_wget() {
    local_path=$1
    url=$2
    wget -O $local_path $url && chmod +x $local_path
}

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

function completion_for_aliases() {
    grep -q -F '# Uncomment and edit these lines to add your own alias completions' ~/.bash_completion ||  wget https://raw.githubusercontent.com/cykerway/complete-alias/master/completions/bash_completion.sh -O ->> ~/.bash_completion
    grep -q -F 'complete -F _complete_alias kl' ~/.bash_completion || echo 'complete -F _complete_alias kl' >> ~/.bash_completion
    grep -q -F 'complete -F _complete_alias kt' ~/.bash_completion || echo 'complete -F _complete_alias kt' >> ~/.bash_completion
    grep -q -F 'complete -F _complete_alias ksn' ~/.bash_completion || echo 'complete -F _complete_alias ksn' >> ~/.bash_completion
}

function install_linux() {
    echo "installing kubetail utilities.... please wait"
        install_with_wget /usr/local/bin/kubetail https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail
        install_with_wget /etc/bash_completion.d/kubetail.bash https://raw.githubusercontent.com/johanhaleby/kubetail/master/completion/kubetail.bash
    echo "installing kubectx utility... please wait"
        install_with_wget /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
        install_with_wget /etc/bash_completion.d/kubectx.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash
    echo "installing kubens utility... please wait"
        install_with_wget /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
        install_with_wget /etc/bash_completion.d/kubens.bash https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.bash
    echo "installing kustomize utility.. please wait"
        install_with_wget /usr/local/bin/kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${kustomize_version}/kustomize_${kustomize_version}_linux_amd64
    echo "installing Heptio ark backup cli utility... please wait"
         wget -qO- https://github.com/heptio/ark/releases/download/v${ark_version}/ark-v${ark_version}-linux-amd64.tar.gz | tar xvz -C /usr/local/bin
}

function install_mac() {
    echo "installing kubens and kubectx utilities... please wait"
        brew install kubectx
    echo "installing kubetail utilities.. please wait"
        brew tap johanhaleby/kubetail && brew install kubetail
    echo "installing kustomize utility.. please wait"
        install_with_wget /usr/local/bin/kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${kustomize_version}/kustomize_${kustomize_version}_darwin_amd64
    echo "installing Heptio ark backup cli utility... please wait"
         wget -qO- https://github.com/heptio/ark/releases/download/v${ark_version}/ark-v${ark_version}-darwin-amd64.tar.gz | tar xvz -C /usr/local/bin
}


###execution
case "$OSTYPE" in
    linux*)
        install_linux
        add_aliases_linux
        completion_for_aliases
       ;;
    darwin*)
        install_mac
        add_aliases_mac
       ;;
    *)
        echo "unknown OSTYPE = ${OSTYPE}"
       ;;
esac
