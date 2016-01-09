# dotfiles

My personal Emacs, Vim, Zsh (and etc.) configuration primarily intended for Haskell and Ruby development.

# Prerequisites

1. Set Zsh as your login shell:

  ```
  if ! command -v zsh >/dev/null; then
    sudo apt-get update && sudo apt-get install zsh
  fi
  chsh -s $(which zsh)
  ```

2. [Rake](https://github.com/ruby/rake)

# Set up

```
git clone https://github.com/zhiyuanshi/dotfiles.git
cd dotfiles
rake up
```

The last command will create symlinks. Therefore, if the path to this directory
is changed, you need to run `rake up` again.

You can safely run `rake up` multiple times to update:

```
rake up
```
