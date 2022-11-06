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

function lgc-write-manipulated-firmware-image()
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

function lgc-export-platform-env-vars()
{
	if [[ -z $1 ]]; then
		echo "No platform specified"
	fi

	export LG_KERNEL_LOCAL_WORKSPACE_PATH=""
	export LG_BAREBOX_LOCAL_WORKSPACE_PATH=""

	case "$1" in
		pfcxxx)
			export LG_PLATFORM=am3xxx_pfc_generic
			export LG_APIKEY=$JFROG_APIKEY
			export LG_PFCXXX_BUILDINFO_BUILDNAME="firmware :: pfc :: wago-pfc200 :: V03.10.xx :: pfcXXX"
			export LG_PFCXXX_BUILDNUMBER=latest
			export LG_PFCG2_BUILDINFO_BUILDNAME="firmware :: pfc :: trunk :: pfc-g2"
			export LG_PFCG2_BUILDNUMBER=latest
			export LG_BAREBOX_AM335X_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am335x_pfc :: master"
			export LG_BAREBOX_AM335X_BUILDNUMBER=latest
			export LG_BAREBOX_FASTBOOT_AM335X_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am335x_pfc :: release_w04.01.03_14"
			export LG_BAREBOX_FASTBOOT_AM335X_BUILDNUMBER=latest
			export LG_BAREBOX_AM35XX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am35xx_pfc :: master"
			export LG_BAREBOX_AM35XX_BUILDNUMBER=latest
			export LG_BAREBOX_FASTBOOT_AM35XX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am35xx_pfc :: release_w04.01.03_14"
			export LG_BAREBOX_FASTBOOT_AM35XX_BUILDNUMBER=latest
			export LG_KERNEL_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: am3xxx_pfc_generic :: master"
			export LG_KERNEL_BUILDNUMBER=latest
			;;

		vtpctp)
			export LG_PLATFORM=imx6_vtpctp
			export LG_APIKEY=$JFROG_APIKEY
			export LG_PFC_BUILDINFO_BUILDNAME="firmware :: pfc :: trunk :: vtpctp2"
			export LG_PFC_BUILDNUMBER=latest
			export LG_BAREBOX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: imx6_vtpctp :: master"
			export LG_BAREBOX_BUILDNUMBER=latest
			export LG_KERNEL_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: imx6_vtpctp :: master"
			export LG_KERNEL_BUILDNUMBER=latest
			;;
		cc100)
			export LG_PLATFORM=stm32mp1
			export LG_APIKEY=$JFROG_APIKEY
			export LG_PFC_BUILDINFO_BUILDNAME="firmware :: pfc :: trunk :: CC100"
			export LG_PFC_BUILDNUMBER=latest
			export LG_BAREBOX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: stm32mp1_cc100 :: master"
			export LG_BAREBOX_BUILDNUMBER=latest
			export LG_KERNEL_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: stm32mp1_cc100 :: master"
			export LG_KERNEL_BUILDNUMBER=latest
			;;
		*)
			echo "platform $1 is not supported."
			echo "supported platforms are: pfcxxx,vtpctp,cc100"
			;;
	esac
}
