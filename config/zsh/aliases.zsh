alias lgc="labgrid-client"
alias lgcon="lgc power on"
alias lgcoff="lgc power off"
alias lgcc="lgc power cycle"

function lgc-export-place()
{
	export LG_PLACE="$1"
}

function lgc-write-image()
{
	local image="${1?please provide a image path}"
	local partition="${2}"

	echo "switch pfc off..."
	lgcoff

	echo "sd-mux to host..."
	lgc sd-mux host

	echo "write image...${partition:+to partition:$partition}"
	lgc write-image "$image" ${partition:+-p $partition}

	echo "sd-mux to dut..."
	lgc sd-mux dut

	echo "switch pfc on..."
	lgcon
}

function manipulate-firmware-image()
{
	local firmware_image="${1?please provide a firmware image}"
	local tmp_mnt_point="$(mktemp -d)"
	local dispatcher_conf="${tmp_mnt_point}/etc/serial_dispatcher.conf"
	local profile_file="${tmp_mnt_point}/root/.profile"

	sudo mount -o loop,offset=$((512*49152)) "${firmware_image}" \
							"${tmp_mnt_point}"

	# Change wago service console to linux console
	if [ -f "${dispatcher_conf}" ]; then
		sudo sed -i 's/BAUD=.*/BAUD=115200/' "${dispatcher_conf}"
		sudo sed -i 's/PARITY=.*/PARITY=0/' "${dispatcher_conf}"
		sudo sed -i 's/ACTIVATE_WSERVICE=.*/ACTIVATE_WSERVICE=0/' \
							"${dispatcher_conf}"
		sudo sed -i 's/ACTIVATE_SHELL=.*/ACTIVATE_SHELL=1/' \
							"${dispatcher_conf}"
	fi

	# Remove first login password change prompt
	sudo sed -i 's/\. \/etc\/profile.passwd/#\. \/etc\/profile.passwd/' \
								"${profile_file}"

	sudo umount "${tmp_mnt_point}"
	rmdir "${tmp_mnt_point}"
}

function lgc-write-maniulated-firmware-image()
{
	manipulate-firmware-image $1
	lgc-write-image $1
}

function lgc-switch-boot-medium()
{
	local medium="${1?wich boot-medium? host or dut?}"
	echo "switch pfc off..."
	lgcoff
	echo "sd-mux to $medium..."
	lgc sd-mux $medium
	lgcon
}
