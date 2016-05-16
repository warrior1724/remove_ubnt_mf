#!/bin/bash
# use clearmf.sh PASS USER
# Not to run in parallel, remove the "&" the end of lines

# In DNS server
# List with
# tcpdump -v -n port 53 -i eth1 | grep -i nxdomain | cut -f5-8 -d "." | cut -f3 -d " " > /opt/remove_ubnt_mf/iplist2.txt
# cat /opt/remove_ubnt_mf/iplist2.txt | sort -n | uniq > /opt/remove_ubnt_mf/iplist.txt

#In iplist.txt use:
#10.0.0.1
#10.0.0.4
#...

_input=/opt/remove_ubnt_mf/iplist.txt
pass=$1
user=$2

for ip in `grep -v ^# $_input | awk '{print $1}'`; do
        echo "Checking $ip..."
        #Only remove
        #sshpass -p $pass ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o ConnectTimeout=10 -o StrictHostKeyChecking=no $user@$ip "trigger_url  https://raw.githubusercontent.com/diegocanton/remove_ubnt_mf/master/desinfect.sh | sh" &
        
        #Only upgrade
        #sshpass -p $pass ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o ConnectTimeout=10 -o StrictHostKeyChecking=no $user@$ip "trigger_url  https://raw.githubusercontent.com/diegocanton/remove_ubnt_mf/master/upgrade.sh | sh" &
        
        # Remove and upgrade - Default Option
        sshpass -p $pass ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o ConnectTimeout=10 -o StrictHostKeyChecking=no $user@$ip "trigger_url  https://raw.githubusercontent.com/diegocanton/remove_ubnt_mf/master/desinfect_upgrade.sh | sh" &
done
