import sys
 
# Create dictionaries to store the command-line arguments
user_info_dict = {
    "user_id": sys.argv[1],
    "group_id": sys.argv[2],
    "home_directory": sys.argv[3],
    "shell": sys.argv[4],
  
}
disk_usage_str=sys.argv[5]

print(user_info_dict)
print(disk_usage_str)
