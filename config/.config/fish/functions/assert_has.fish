function assert_has
   if type -q $argv[1]
    echo "$argv[1] is executable"
   else
    echo "💥 Error: $argv[1] is not executable" 1>&2
   end
end
