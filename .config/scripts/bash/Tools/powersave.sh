#!/bin/bash
# Script to enable or disable some power saving features on the lenovo Ideapad 5
# Dependency: cpupower

power_save_mode(){
	#####################
	# cpupower commands #
	#####################
	cpupower idle-set -E
	cpupower set --perf-bias 15
	cpupower frequency-set -u 1GHz
	sudo cpupower frequency-set -g powersave

	#########
	# other #
	#########
	# disable turbo boost
	echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

	#####################
	# powertop commands #
	#####################
	# VM writeback timeout
	echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';

	# Enable SATA link power management for host0
	echo 'med_power_with_dipm' > '/sys/class/scsi_host/host0/link_power_management_policy';

	# Enable Audio codec power management
	echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';

	# NMI watchdog
	echo '0' > '/proc/sys/kernel/nmi_watchdog';

	# Runtime PM for I2C Adapter
	echo 'auto' > '/sys/bus/i2c/devices/i2c-7/device/power/control';

	# Autosuspend for USB device Goodix FingerPrint Device
	echo 'auto' > '/sys/bus/usb/devices/3-7/power/control';

	# PCI devices
	echo 'auto' > '/sys/bus/pci/devices/0000:00:14.3/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:04.0/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.5/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:14.2/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:0a.0/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata1/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
	2>2
	echo -e "\e[29mPower Save mode applied!\e[0m"
}

default_mode(){
	#####################
	# cpupower commands #
	#####################
	cpupower idle-set -E
	cpupower set --perf-bias 15
	cpupower frequency-set -u 4.7GHz
	sudo cpupower frequency-set -g powersave

	#########
	# other #
	#########
	# enable turbo boost
	echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo

	#####################
	# powertop commands #
	#####################
	# VM writeback timeout
	echo '' > '/proc/sys/vm/dirty_writeback_centisecs';

	# Disable SATA link power management for host0
	echo '' > '/sys/class/scsi_host/host0/link_power_management_policy';

	# Disable Audio codec power management
	echo '0' > '/sys/module/snd_hda_intel/parameters/power_save';

	# NMI watchdog
	echo '' > '/proc/sys/kernel/nmi_watchdog';

	# Runtime PM for I2C Adapter
	echo 'on' > '/sys/bus/i2c/devices/i2c-7/device/power/control';

	# Autosuspend for USB device Goodix FingerPrint Device
	echo 'on' > '/sys/bus/usb/devices/3-7/power/control';

	# PCI devices
	echo 'on' > '/sys/bus/pci/devices/0000:00:14.3/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:04.0/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:01:00.0/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:1f.5/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:14.2/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:0a.0/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:17.0/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:17.0/ata1/power/control';
	echo 'on' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
	echo -e "\e[96mPower Save mode applied!\e[0m"
}
main(){
	# check for root rights
	if [ $(id -u) -eq 0 ]
	then
		echo -e "\e[96mPower MANAGER SCRIPT\e[0m"
		echo ''
		echo -e "\e[96m1)Power Save Mode\e[0m"
		echo -e "\e[96m2)Default Mode\e[0m"
		read -r -p "Enter a selection:" response
		if [ "$response" == "1" ]; then
			power_save_mode
		elif [ "$response" == "2" ]; then
			default_mode
		else
			clear
			echo -e "\e[31mPlease enter a valid value\e[0m"
			main
		fi
	else
		echo -e "\e[31mPlease run script as root.\e[0m"
		exit
	fi
}
clear
main
