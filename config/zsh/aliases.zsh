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
	local firmware_image="${1}"
	local device="${2}"
	local tmp_mnt_point="$(mktemp -d)"
	local dispatcher_conf="${tmp_mnt_point}/etc/serial_dispatcher.conf"
	local profile_file="${tmp_mnt_point}/root/.profile"
	local inittab="${tmp_mnt_point}/etc/inittab"

	sudo mount -o loop,offset=$((512*49152)) "${firmware_image}" \
							"${tmp_mnt_point}"

	# Change wago service console to linux console on pfcxxx, vtpctp or cc100
	if [[ "${device}" =~ "^pfcxxx$|^cc100$|^vtpctp$" ]]; then
		if [[ -f "${dispatcher_conf}" ]]; then
			sudo sed -i 's/BAUD=.*/BAUD=115200/' "${dispatcher_conf}"
			sudo sed -i 's/PARITY=.*/PARITY=0/' "${dispatcher_conf}"
			sudo sed -i 's/ACTIVATE_WSERVICE=.*/ACTIVATE_WSERVICE=0/' \
								"${dispatcher_conf}"
			sudo sed -i 's/ACTIVATE_SHELL=.*/ACTIVATE_SHELL=1/' \
								"${dispatcher_conf}"
		fi
	# pfc300 does not have a serial dispatcher. We need to manipulate the
	# inittab directly here.
	elif [[ ${device} = "pfc300" ]]; then
		sudo sed -i 's|#console::respawn:/sbin/getty -L 115200 serial xterm|console::respawn:/sbin/getty -L 115200 ttyS2 xterm|' "${inittab}"
	fi

	# Remove first login password change prompt
	sudo sed -i 's/\. \/etc\/profile.passwd/#\. \/etc\/profile.passwd/' \
								"${profile_file}"

	sudo umount "${tmp_mnt_point}"
	rmdir "${tmp_mnt_point}"
}

function lgc-write-manipulated-firmware-image()
{
	local image="${1?please provide a image file}"
	local device="${2?please provide a target device e.g. one of: pfcxxx,vtpctp,cc100,pfc300}"

	manipulate-firmware-image "${image}" "${device}"
	lgc-write-image "${image}"
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
	export LG_APIKEY=$JFROG_APIKEY

	case "$1" in
		pfcxxx)
			export LG_PLATFORM=am3xxx_pfc_generic
			export LG_FIRMWARE_PFCXXX_BUILDINFO_BUILDNAME="firmware :: pfc :: release :: V03.10.xx :: pfcXXX"
			export LG_FIRMWARE_PFCXXX_BUILDNUMBER=latest
			export LG_FIRMWARE_PFCG2_BUILDINFO_BUILDNAME="firmware :: pfc :: pfc-g2 :: main"
			export LG_FIRMWARE_PFCG2_BUILDNUMBER=latest
			export LG_BAREBOX_AM335X_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am335x_pfc :: master"
			export LG_BAREBOX_AM335X_BUILDNUMBER=latest
			export LG_BAREBOX_BACKUP_AM335X_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am335x_pfc :: release_w04.01.09_14"
			export LG_BAREBOX_BACKUP_AM335X_BUILDNUMBER=latest
			export LG_BAREBOX_AM35XX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am35xx_pfc :: master"
			export LG_BAREBOX_AM35XX_BUILDNUMBER=latest
			export LG_BAREBOX_BACKUP_AM35XX_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: am35xx_pfc :: release_w04.01.09_14"
			export LG_BAREBOX_BACKUP_AM35XX_BUILDNUMBER=latest
			export LG_KERNEL_AM3XXX_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: am3xxx_pfc_generic :: master"
			export LG_KERNEL_AM3XXX_BUILDNUMBER=latest
			;;

		vtpctp)
			export LG_PLATFORM=imx6_vtpctp
			export LG_FIRMWARE_VTPCTP_BUILDINFO_BUILDNAME="firmware :: pfc :: vtpctp2 :: main"
			export LG_FIRMWARE_VTPCTP_BUILDNUMBER=latest
			export LG_BAREBOX_IMX6_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: imx6_vtpctp :: master"
			export LG_BAREBOX_IMX6_BUILDNUMBER=latest
			export LG_BAREBOX_BACKUP_IMX6_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: imx6_vtpctp :: release_w04.01.09_14"
			export LG_BAREBOX_BACKUP_IMX6_BUILDNUMBER=latest
			export LG_KERNEL_IMX6_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: imx6_vtpctp :: master"
			export LG_KERNEL_IMX6_BUILDNUMBER=latest
			;;
		cc100)
			export LG_PLATFORM=stm32mp1
			export LG_FIRMWARE_CC100_BUILDINFO_BUILDNAME="firmware :: pfc :: CC100 :: main"
			export LG_FIRMWARE_CC100_BUILDNUMBER=latest
			export LG_BAREBOX_STM32MP1_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: stm32mp1_cc100 :: master"
			export LG_BAREBOX_STM32MP1_BUILDNUMBER=latest
			export LG_BAREBOX_BACKUP_STM32MP1_BUILDINFO_BUILDNAME="firmware :: pfc :: barebox :: stm32mp1_cc100 :: release_w04.01.09_14"
			export LG_BAREBOX_BACKUP_STM32MP1_BUILDNUMBER=latest
			export LG_KERNEL_STM32MP1_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: stm32mp1_cc100 :: master"
			export LG_KERNEL_STM32MP1_BUILDNUMBER=latest
			;;
		pfc300)
			export LG_PLATFORM=am6xxx
			export LG_FIRMWARE_PFC300_BUILDINFO_BUILDNAME="firmware :: pfc :: pfc-300 :: main"
			export LG_FIRMWARE_PFC300_BUILDNUMBER=latest
			export LG_U_BOOT_AM6XXX_BUILDINFO_BUILDNAME="firmware :: pfc :: u-boot :: am6xxx_pfc300 :: next-am6xxx"
			export LG_U_BOOT_AM6XXX_BUILDNUMBER=latest
			export LG_U_BOOT_BACKUP_AM6XXX_BUILDINFO_BUILDNAME="firmware :: pfc :: u-boot :: am6xxx_pfc300 :: next-am6xxx"
			export LG_U_BOOT_BACKUP_AM6XXX_BUILDNUMBER=latest
			export LG_KERNEL_AM6XXX_BUILDINFO_BUILDNAME="firmware :: pfc :: kernel :: am6xxx_pfc_generic :: next-am6xxx"
			export LG_KERNEL_AM6XXX_BUILDNUMBER=latest
			;;
		*)
			echo "platform $1 is not supported."
			echo "supported platforms are: pfcxxx,vtpctp,cc100,pfc300"
			;;
	esac
}
