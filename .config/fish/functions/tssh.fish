function tssh
    ssh (tailscale status | awk '/^# / {next} /^[ \t]*$/ {next} /^\-/ {next} {print $2}' | peco | tr "\n" "\0")
end
