def sublime_text_data_folder_path(os = :os_x)
  case os
  # Paths to data folder are documented at https://www.sublimetext.com/docs/3/revert.html
  when :os_x
    "~/Library/Application Support/Sublime Text 3"
  when :linux
    "~/.config/sublime-text-3"
  end
end

RULES = {
  ".bash_profile" => "~",
  ".zshrc" => "~",
  ".vimrc" => "~",
  ".spacemacs" => "~",
  # ".emacs" => "~",
  "Preferences.sublime-settings" => "#{sublime_text_data_folder_path}/Packages/User",
  ".gitconfig" => "~",
  ".hgrc" => "~",
  ".ghci" => "~",
  ".ocamlinit" => "~",
  ".irbrc" => "~",
  ".gemrc" => "~",
  ".rubocop.yml" => "~",
  ".railsrc" => "~",
  ".chktexrc" => "~",
  ".pgclirc" => "~",

  # http://stackoverflow.com/questions/7899845/emacs-synctex-skim-how-to-correctly-set-up-syncronization-none-of-the-exi
  ".latexmkrc" => "~"
}

desc "Setup dotfiles by creating symlinks"
task :up do
  # Ruby uses the system() C function, which uses /bin/sh, which is a symlink to
  # /bin/dash on Ubuntu by default. Ugh!
  #
  # http://stackoverflow.com/questions/1239510/how-do-i-specify-the-shell-to-use-for-a-ruby-system-call
  # system("sudo ln -s --force $(which bash) /bin/sh")

  dotfiles_dir = File.expand_path(File.dirname(__FILE__))

  RULES.each do |f, target_dir|
    local_path  = File.join(dotfiles_dir, f)
    remote_path = File.join(File.expand_path(target_dir), f)
    system("ln -s -f '#{local_path}' '#{remote_path}'")

    # Handle ".ghci is writable by someone else, IGNORING!"
    system("chmod g-w '#{File.expand_path('~/.ghci')}'")
    system("chmod g-w '#{dotfiles_dir}'")

    # if [[ -n $SSH_CONNECTION ]]; then
    #   export EDITOR="vim"
    # else
    #   export EDITOR="$EMACSCLIENT"
    # fi

    # Reverse copy my public SSH key
    system("cp ~/.ssh/id_rsa.pub '#{dotfiles_dir}'")
  end
end

desc "Show setup rules"
task :rules do
  RULES.each do |f, target_dir|
    puts "#{f} => #{target_dir}"
  end
end

desc "List files that are not covered by rake setup"
task :check do
  puts Dir.glob("{*,.*}").select {|f| File.file?(f) && !RULES.keys.include?(f) }
end
