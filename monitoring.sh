printf "#Architecture: " && uname -a

printf "#CPU physical : " && nproc --all

printf "#vCPU : " && cat /proc/cpuinfo | grep processor | wc -l

printf "#Memory Usage: " && free -m | grep Mem | awk '{printf "%d/%dMB (%.2f%%)\n", $3, $2, $3/$2 * 100}'

#printf "#Disk Usage: " && df -ah | grep /dev/mapper/bahn42--vg-root | awk '{printf "%d/%dGb (%d%%)\n", $4, $2, $5}'
printf "#Disk Usage: " && df -ah | grep /dev/mapper/bahn42--vg-root | awk '{printf "%.1f/%.1fGb (%d%%)\n", $4, $2, $5}'

printf "#CPU load: " && mpstat | grep all | awk '{printf "%.2f%%\n", 100 - $13}'

printf "#Last boot: " && who -b | awk '{printf $3" "$4"\n"}'


printf "#LVM use: ";
if [ "$(lvs | wc -l) -gt 1" ]; then
	printf "yes\n";
else
	printf "no\n";
fi

ss -alt | wc -l | awk '{printf "#Connections TCP : %d ESTABILISHED\n", $1 - 1}'


printf "#User log: " && users | wc -w
printf "#Network: IP " && echo -n $(hostname -I) && ip link | grep ether | sed '2, $d' | awk '{printf " ("$2")\n"}'
printf "#Sudo : " && echo -n $(journalctl _COMM=sudo | wc -l) && echo " cmd"
