#!/bin/bash

username="weblogic"

# Retrieve system configuration information for the specified user
user_info=$(grep "^$username:" /etc/passwd)

# Extract relevant information
user_id=$(echo $user_info | cut -d: -f3)
group_id=$(echo $user_info | cut -d: -f4)
home_directory=$(echo $user_info | cut -d: -f6)
shell=$(echo $user_info | cut -d: -f7)

# Get disk usage and free disk space
disk_usage=$(df -h --output=source,size | grep "$(df -h /home/$username | grep -o '^/[^ ]*')")
free_disk=$(df -h --output=avail | grep "$(df -h /home/$username | grep -o '^/[^ ]*')")

# Get network information
network_info=$(ip addr show | awk '/inet / {print $2}')

# Display information in tabular form
echo "System Configuration for User: $username"
echo "--------------------------------------------"
echo "| User ID | Group ID | Home Directory | Shell |"
echo "--------------------------------------------"
printf "| %-8s| %-9s| %-14s| %-10s|\n" "$user_id" "$group_id" "$home_directory" "$shell"
echo "--------------------------------------------"
echo "Disk Usage and Free Space:"
echo "--------------------------------------------"
echo "| Disk                  | Size | Free Space |"
echo "--------------------------------------------"
echo "$disk_usage" | while read -r line;
 do
    disk=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')
    free=$(df -h --output=avail "$disk" | tail -n 1)
    printf "| %-9s| %-9s| %-12s|\n" "$disk" "$size" "$free"
 done
echo "--------------------------------------------"
echo "Network Information (Domain names or 'N/A' for unavailable):"
echo "--------------------------------------------"
echo "| Network Interface | Domain Name | IP Address |"
echo "--------------------------------------------"
echo "$network_info" | while read -r line;
do
    interface=$(echo "$line" | awk -F: '{print $1}')
    ip_address=$(echo "$line" | awk -F/ '{print $1}')
    domain_name=$(nslookup "$ip_address" | awk '/name/ {print $4}')
    if [ -z "$domain_name" ]; then
        domain_name="N/A"
    fi
printf "| %-9s| %-9s| %-12s|\n" "$interface" "$domain_name" "$ip_address"
done

