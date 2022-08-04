is_exist(){
   if hash $1 2>/dev/null; then
      echo "  ✅ $1"
   else
      echo "  ❌ $1"
   fi
}

is_exist_file(){
    if [ -f "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
    fi
}

is_exist_dir(){
    if [ -d "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
    fi
}

is_exist_link(){
    if [ -h "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
    fi
}

is_exist brew
is_exist fish
is_exist peco
is_exist ghq
is_exist git
is_exist gh
is_exist ninja

is_exist_file ~/.config/fish/config.fish
is_exist_file ~/.config/starship.toml

is_exist_dir ~/.config/fish
is_exist_dir ~/.config/iterm
is_exist_dir ~/.config/karabiner

is_exist_link ~/.Brewfile
is_exist_link ~/.gitconfig.remote 
is_exist_link ~/.tigrc 
is_exist_link ~/.gnupg 
is_exist_link ~/.config 
