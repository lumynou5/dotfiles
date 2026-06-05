if status is-interactive
	fish_config theme choose catppuccin-mocha
end

# nvm
function _nvm_auto --on-variable PWD
	nvm use --silent 2>/dev/null
end
_nvm_auto

if status is-login
	# adb
	set -xp PATH ~/Android/Sdk/platform-tools
end
