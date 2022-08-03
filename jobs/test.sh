is_exist(){
   if hash $1 2>/dev/null; then
      echo "  ✅ $1"
   else
      echo "  ❌ $1"
      # exit 1
   fi
}

for i in brew fish peco ghq git gh ninja 
do
    is_exist $i
done

is_exist_file(){
    if [ -f "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
        # exit 1
    fi
}

for i in ~/.config/fish/config.fish ~/.config/starship.toml
do
    is_exist_file $i
done

is_exist_dir(){
    if [ -d "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
        # exit 1
    fi
}

for i in  ~/.config/fish ~/.config/iterm ~/.config/karabiner
do
    is_exist_dir $i
done

is_exist_link(){
    if [ -h "$1" ]; then
        echo "  ✅ $1"
    else 
        echo "  ❌ $1"
        # exit 1
    fi
}

for i in ~/.config ~/.gnupg ~/.tigrc ~/.gitconfig.remote ~/.Brewfile
do
    is_exist_link $i
done
