function print_env
    echo "SSH key for Github"
    echo "------------------"
    pbcopy < ~/.ssh/github.pub && pbpaste
    echo "------------------"
    echo "GPG"
    KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "sec" {print $5}' | tail -n 1)
    echo "git config --global user.signingkey $KEY_ID"
end