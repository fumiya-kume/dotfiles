BASE=pwd
BASE_CONFIG="$BASE/config"
JOB_PATH="$BASE/jobs"

echo "✅ Install Xcode"
. ./jobs/install_xcode.sh

echo "✅ Copy files"
. ./jobs/setup_config_files_copy.sh

echo "✅ Install Homebrew"
. ./jobs/setup_homebrew.sh

echo "✅ Set fish as default shell"
. ./jobs/setup_fish.sh

echo "✅ Set Mac defaults"
. ./jobs/setup_mac_defaults.sh

echo "✅ Setup gn"
. ./jobs/setup_gn.sh

echo "✅ Setup SSH for Github"
. ./jobs/setup_ssh_github.sh

echo "✅ Setup GPG for Github"
. ./jobs/setup_gpg.sh

echo "✅ Test configuration"
. ./jobs/test.sh