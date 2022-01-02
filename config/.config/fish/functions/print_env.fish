function print_env
    echo "SSH key for Github"
    echo "------------------"
    pbcopy < ~/.ssh/github.pub && pbpaste
    echo "------------------"
    echo "GPG"
    echo "git config --global user.signingkey $KEY_ID"
end