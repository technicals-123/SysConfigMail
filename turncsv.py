import sys
 
# Create dictionaries to store the command-line arguments
user_info_dict = {
    "user_id": sys.argv[1],
    "group_id": sys.argv[2],
    "home_directory": sys.argv[3],
    "shell": sys.argv[4]
}
disk_usuage_list=sys.argv[5].split() 
disk_usage_dict = {
    "disk": disk_usuage_list[0],
    "size": disk_usuage_list[1],
    "free_space": disk_usuage_list[2]
}
 
# For network info, you may need to parse it further
# If network_info is a string, you can split it and assign it to the dictionary
network_info_list = sys.argv[8].split()
network_info_dict = {
    "interface": network_info_list[0],
    "domain_name": network_info_list[1],
    "ip_address": network_info_list[2]
}
 
# Now you have dictionaries containing the command-line arguments
print("User Info:", user_info_dict)
print("Disk Usage:", disk_usage_dict)
print("Network Info:", network_info_dict)

