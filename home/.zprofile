# PATH additions
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# Java: set JAVA_HOME if JDK exists
if [[ -z "${JAVA_HOME:-}" ]]; then
  _java="${ANDROID_STUDIO_JAVA_HOME:-$HOME/Applications/Android Studio.app/Contents/jbr/Contents/Home}"
  if [[ -d "$_java" ]]; then
    export JAVA_HOME="$_java"
  elif /usr/libexec/java_home &>/dev/null; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
  fi
  unset _java
fi
[[ -n "${JAVA_HOME:-}" ]] && export PATH="$JAVA_HOME/bin:$PATH"
