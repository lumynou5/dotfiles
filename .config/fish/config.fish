if status is-interactive
	fish_config theme choose catppuccin-mocha
end

# nvm
function _nvm_auto --on-variable PWD
	nvm use --silent 2>/dev/null
end
_nvm_auto

# bun
set -x BUN_INSTALL ~/.bun
set -xp PATH $BUN_INSTALL/bin

# adb
set -xp PATH ~/Android/Sdk/platform-tools
