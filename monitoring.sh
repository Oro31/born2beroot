echo "  #Architecture:" $(uname -a)
echo "  #CPU physical :" $(nproc --all)
echo "  #vCPU :" $(cat /proc/cpuinfo | grep processor | wc -l)
free -m | grep Mem | awk '{ print("     #Memory Usage: free:" $4 "MB used:(" $3/$2 * 100 "%)") }'
df -h / | grep /dev | awk '{ print("    #Disk Usage: free:" $4 " used:(" $5 ")") }'
cat /proc/loadavg | awk '{ print("      #CPU load:", $2 "%") }'
who -b | awk '{ print(" #Last boot: " $3, $4) }'
if df | grep mapper | awk 'END { print(NR) }' > 0; then echo "  #LVM use: yes"; fi
netstat -t | grep ESTABLISHED | awk 'END { print("      #Connexions TCP :", NR, "ESTABLISHED") }'
who | awk 'END { print("        #User log:", NR) }'
touch fichier
ip -4 -o addr show | grep enp0s3 | awk '{print($4)}' | cut -d'/' -f1 | tr -d "\n" >> fichier
ip link | grep ether | awk '{ print(" ("$2 ")") }' >> fichier
awk 'NR == 1 {print("   #Network: IP " $0) }' fichier
rm fichier
sudo cat /var/log/auth.log | grep sudo | awk 'END {print("      #Sudo :", NR, "cmd")}'
