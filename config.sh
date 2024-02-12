#!/bin/bash
 
# Set variables
username="weblogic"
csv_file="system_info.csv"
 
# Retrieve system configuration information for the specified user
user_info=$(grep "^$username:" /etc/passwd)
 
# Extract relevant information
user_id=$(echo $user_info | cut -d: -f3)
group_id=$(echo $user_info | cut -d: -f4)
home_directory=$(echo $user_info | cut -d: -f6)
shell=$(echo $user_info | cut -d: -f7)
 
# Get disk usage and free disk space
disk_usage=$(df -h --output=source,size,avail | grep "$(df -h /home/$username | grep -o '^/[^ ]*')")

# Get network information
network_info=$(ip addr show | awk '/inet / {print $2}')
 
# Display information in tabular format
printf "+------------+-----------+-----------------+-------------+---------+-------+------------+------------------+-------------+--------------+\n"
printf "| User ID    | Group ID  | Home Directory  | Shell       | Disk    | Size  | Free Space | Network Interface| Domain Name | IP Address   |\n"
printf "+------------+-----------+-----------------+-------------+---------+-------+------------+------------------+-------------+--------------+\n"
printf "| %-10s | %-9s | %-15s | %-11s |" "$user_id" "$group_id" "$home_directory" "$shell"
 
echo "$disk_usage" | while read -r line; do
    disk=$(echo "$line" | awk '{print $1}')

    size=$(echo "$line" | awk '{print $2}')
   
    free=$(echo "$line" | awk '{print $3}')
    
    printf "%-8s | %-6s | %-10s |" "$disk" "$size" "$free"
done
 
echo "$network_info" | while read -r line; do
    interface=$(echo "$line" | awk -F: '{print $1}')
    ip_address=$(echo "$line" | awk -F/ '{print $1}')
    domain_name=$(nslookup "$ip_address" | awk '/name/ {print $4}')
    if [ -z "$domain_name" ]; then
        domain_name="N/A"
    fi
    printf "%-17s | %-12s | %-13s |\n" "$interface" "$domain_name" "$ip_address"
done
printf "+------------+-----------+-----------------+-------------+---------+-------+------------+------------------+-------------+--------------+\n"
 
# Create CSV file with tabular format
echo "User ID,Group ID,Home Directory,Shell,Disk,Size,Free Space,Network Interface,Domain Name,IP Address" > "$csv_file"
echo "$user_id,$group_id,$home_directory,$shell," >> "$csv_file"
echo "$disk_usage" | while read -r line; do
    disk=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')
    free=$(echo "$line" | awk '{print $3}')
    echo "$user_id,$group_id,$home_directory,$shell,$disk,$size,$free," >> "$csv_file"
done
echo "$network_info" | while read -r line; do
    interface=$(echo "$line" | awk -F: '{print $1}')
    ip_address=$(echo "$line" | awk -F/ '{print $1}')
    domain_name=$(nslookup "$ip_address" | awk '/name/ {print $4}')
    if [ -z "$domain_name" ]; then
        domain_name="N/A"
    fi
    echo "$user_id,$group_id,$home_directory,$shell,N/A,N/A,N/A,$interface,$domain_name,$ip_address" >> "$csv_file"
done
python turncsv.py "$user_id" "$group_id" "$home_directory" "$shell" "$disk_usage" "$network_info"
