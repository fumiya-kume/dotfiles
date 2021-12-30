gpg --full-gen-key -q --batch "$(BASE_CONFIG)/gpg-key.conf" > /dev/null

KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "sec" {print $5}' | tail -n 1)

echo $KEY_ID | xargs gpg --armor --export 
echo "git config --global user.signingkey $KEY_ID"