#!/bin/bash

# Before changing the theme we need to create a temporary new
# profile and delete it if the new profile is installed.
#
# See: https://gist.github.com/queeup/1f3f95518e04b851b4713e5004c9f15e

# List settings with this command:
#   profile_uuid = gsettings get org.gnome.Terminal.ProfilesList default
#   gsettings list-recursively "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:<profile_uuid>/"
SETTINGS=(
	"audible-bell false"
	"cursor-colors-set false"
	"scrollbar-policy always"
	"use-system-font true"
	"scrollback-unlimited true"
	"bold-is-bright true"
	"default-size-columns 160"
	"default-size-rows 40"
	"rewrap-on-resize true"
)

# Logs an error message with a timestamp
log_error() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# Logs an info message with a timestamp
log_info() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*"
}

# Creates a temporary GNOME Terminal profile
create_temp_profile() {
	local new_profile_uuid
	local profile_list

	if ! new_profile_uuid=$(uuidgen); then
		log_error "Failed to generate UUID"
		return 1
	fi

	if ! profile_list=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d '[]'); then
		log_error "Failed to get current profile list"
		return 1
	fi

	# Append the new profile UUID to the list
	profile_list="${profile_list}, '${new_profile_uuid}'"

	# Update the profile list with the new profile included
	if ! gsettings set org.gnome.Terminal.ProfilesList list "[${profile_list}]"; then
		log_error "Failed to update profile list"
		return 1
	fi

	# Set the new profile as the default profile
	if ! gsettings set org.gnome.Terminal.ProfilesList default "${new_profile_uuid}"; then
		log_error "Failed to set default profile"
		return 1
	fi

	# Set a visible name for the new profile
	if ! gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"${new_profile_uuid}"/ \
		visible-name 'Temp'; then
		log_error "Failed to set visible name for the new profile"
		return 1
	fi

	log_info "Temporary profile created with UUID: ${new_profile_uuid}"
}

# Installs the Ayu Dark theme for GNOME Terminal
install_theme() {
	local script_apply="apply-colors.sh"
	local script_theme="catppuccin-mocha.sh"
	local base_url="https://github.com/Gogh-Co/Gogh/raw/master"

	# Download the apply-colors script to the /tmp directory
	if ! wget -q -O /tmp/${script_apply} ${base_url}/${script_apply}; then
		log_error "Failed to download ${script_apply}"
		return 1
	fi

	# Download the theme script to the /tmp directory
	if ! wget -q -O /tmp/${script_theme} ${base_url}/installs/${script_theme}; then
		log_error "Failed to download ${script_theme}"
		return 1
	fi

	# Execute the downloaded theme script with the necessary environment variables
	if ! GOH_APPLY_SCRIPT=/tmp/${script_apply} TERMINAL=gnome-terminal GOGH_NONINTERACTIVE=1 \
		bash /tmp/${script_theme}; then
		log_error "Failed to apply the theme"
		return 1
	fi

	log_info "Theme applied successfully"
}

# Sets the installed theme as the default and cleans up temporary profiles
set_installed_theme_as_default_and_cleanup() {
	local temp_profile_uuid
	local profile_list
	local profile_uuid
	local profile_name

	temp_profile_uuid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
	if [ -z "${temp_profile_uuid}" ]; then
		log_error "Failed to get the default profile UUID"
		return 1
	fi

	profile_list=$(gsettings get org.gnome.Terminal.ProfilesList list)
	if [ -z "${profile_list}" ]; then
		log_error "Failed to get current profile list"
		return 1
	fi

	profile_list=$(echo "${profile_list}" | sed "s/'$temp_profile_uuid', //; s/, '$temp_profile_uuid'//; \
    s/'$temp_profile_uuid'//")

	if ! gsettings set org.gnome.Terminal.ProfilesList list "${profile_list}"; then
		log_error "Failed to set the new profile list."
		return 1
	fi

	# Remove squared brackets, commas and single quotes from profile_list variable
	profile_list=$(echo "${profile_list}" | tr -d "[],'")

	for profile_uuid in ${profile_list}; do
		profile_name=$(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"${profile_uuid}"/ \
			visible-name | tr -d "'")
		if [ "${profile_name}" = "Ayu Dark" ]; then
			if ! gsettings set org.gnome.Terminal.ProfilesList default "${profile_uuid}"; then
				log_error "Failed to set Ayu Dark as the default profile"
				return 1
			fi
			log_info "Ayu Dark theme set as the default profile"
			return 0
		fi
	done

	log_error "Ayu Dark theme not found"
	return 1
}

# Function to set GNOME Terminal settings
set_terminal_settings() {
	for setting in "${SETTINGS[@]}"; do
		if ! gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$(gsettings get \
			org.gnome.Terminal.ProfilesList default | tr -d "'")"/ ${setting}; then
			log_error "Failed to set GNOME Terminal setting: ${setting}"
			return 1
		fi
	done

	log_info "GNOME Terminal settings applied successfully"
}

# Main script execution
create_temp_profile || exit 1
install_theme || exit 1
set_installed_theme_as_default_and_cleanup || exit 1
set_terminal_settings || exit 1

log_info "Script $(basename "$0") executed successfully"

exit 0
