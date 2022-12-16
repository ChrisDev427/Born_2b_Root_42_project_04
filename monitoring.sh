#The architecture of your operating system and its kernel version.
arc=$(uname -a)

#The number of physical processors.
ppro=$(cat /proc/cpuinfo | grep "physical id" | awk '{print$3}' | wc -l)

#The number of virtual processors.
vpro=$(cat /proc/cpuinfo | grep "processor" | awk '{print$4}' | wc -l)

#The current available RAM on your server and its utilization rate as a percentage.
used_ram=$(free -m | grep "Mem:" | awk '{print$3}')
total_ram=$(free -m | grep "Mem:" | awk '{printf("%dMB", $2)}')
percent_used_ram=$(free -m | grep "Mem:" | awk '{printf("(%.2f%%)", $3/$2*100)}')

#The current available memory on your server and its utilization rate as a percentage.
used_mem=$(df -H --total | grep "total" | awk '{print$3}')
total_mem=$(df -H --total | grep "total" | awk '{printf("%dGb", $2)}')
percent_used_mem=$(df -H --total | grep "total" | awk '{printf("(%d%%)", $5)}')

#The current utilization rate of your processors as a percentage.
cpu_load=$(mpstat | grep "all" | awk '{printf("%.1f%%", $4+$6)}')

#The date and time of the last reboot.
last_boot=$(who -b | grep "system" | awk '{print$3" "$4}')

#Whether LVM is active or not.
activ_lvm=$(lvscan | grep '^  ACTIVE' | wc -l)
lvm_ret=$(if [ $activ_lvm != 0 ]; then echo yes; else echo no; fi)

#The number of active connections.
tcp=$(cat /proc/net/sockstat | grep 'TCP' | awk '{print$3}')

#The number of users using the server.
user_loged=$(who | wc -l)

#The IPv4 address of your server and its MAC (Media Access Control) address.
ipv4=$(hostname -I)
add_mac=$(ip link show | grep 'ether' | awk '{print$2}')

#The number of commands executed with the sudo program.
nb_sudo=$(journalctl _COMM=sudo | grep 'COMMAND' | wc -l)

wall "


██████╗░░█████╗░██████╗░███╗░░██╗  ██████╗░██████╗░███████╗
██╔══██╗██╔══██╗██╔══██╗████╗░██║  ╚════██╗██╔══██╗██╔════╝
██████╦╝██║░░██║██████╔╝██╔██╗██║  ░░███╔═╝██████╦╝█████╗░░
██╔══██╗██║░░██║██╔══██╗██║╚████║  ██╔══╝░░██╔══██╗██╔══╝░░
██████╦╝╚█████╔╝██║░░██║██║░╚███║  ███████╗██████╦╝███████╗
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝  ╚══════╝╚═════╝░╚══════╝

███████╗██╗░░░██╗░█████╗░██╗░░██╗██╗██╗███╗░░██╗  ██████╗░░█████╗░░█████╗░████████╗
██╔════╝██║░░░██║██╔══██╗██║░██╔╝╚█║██║████╗░██║  ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
█████╗░░██║░░░██║██║░░╚═╝█████═╝░░╚╝██║██╔██╗██║  ██████╔╝██║░░██║██║░░██║░░░██║░░░
██╔══╝░░██║░░░██║██║░░██╗██╔═██╗░░░░██║██║╚████║  ██╔══██╗██║░░██║██║░░██║░░░██║░░░
██║░░░░░╚██████╔╝╚█████╔╝██║░╚██╗░░░██║██║░╚███║  ██║░░██║╚█████╔╝╚█████╔╝░░░██║░░░
╚═╝░░░░░░╚═════╝░░╚════╝░╚═╝░░╚═╝░░░╚═╝╚═╝░░╚══╝  ╚═╝░░╚═╝░╚════╝░░╚════╝░░░░╚═╝░░░

	#Architecture: $arc
      	#CPU physycal : $ppro
      	#vCPU : $vpro
      	#Memory Usage: $used_ram/$total_ram $percent_used_ram
      	#Disk Usage: $used_mem/$total_mem $percent_used_mem
      	#CPU load: $cpu_load
      	#Last boot: $last_boot
      	#LVM use: $lvm_ret
      	#Connections TCP : $tcp ESTABLISHED
      	#user log: $user_loged
      	#Network: IP $ipv4 ($add_mac)
      	#Sudo : $nb_sudo cmd
	"
