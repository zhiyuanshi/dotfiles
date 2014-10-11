# dotfiles

# Prerequisites

Set Zsh as your login shell:

    sudo apt-get update && sudo apt-get install zsh
    chsh -s $(which zsh)

## Set up

    git clone https://github.com/zhiyuanshi/dotfiles.git
    cd dotfiles
    rake up

You can safely run `rake up` multiple times to update:

    rake up