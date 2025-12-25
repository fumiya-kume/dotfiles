## Homebrew: add environment only if brew exists
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# Added by JetBrains Toolbox
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="/Library/TeX/texbin:$PATH"

# Java: set JAVA_HOME only if a JDK is installed
# Override with ANDROID_STUDIO_JAVA_HOME environment variable
_JAVA_CANDIDATE="${ANDROID_STUDIO_JAVA_HOME:-$HOME/Applications/Android Studio.app/Contents/jbr/Contents/Home}"
if [ -z "${JAVA_HOME:-}" ]; then
  if [ -d "$_JAVA_CANDIDATE" ]; then
    export JAVA_HOME="$_JAVA_CANDIDATE"
  elif /usr/libexec/java_home >/dev/null 2>&1; then
    export JAVA_HOME=$(/usr/libexec/java_home)
  fi
fi
if [ -n "${JAVA_HOME:-}" ]; then
  export PATH="$JAVA_HOME/bin:$PATH"
fi
