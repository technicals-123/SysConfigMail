import sys
import pandas as pd
# Create dictionaries to store the command-line arguments
user_info_dict = {
    "user_id": sys.argv[1],
    "group_id": sys.argv[2],
    "home_directory": sys.argv[3],
    "shell": sys.argv[4],
  
}
disk_usage_str=sys.argv[5]
disk_usuage_list=disk_usage_str.split()
disk_usuage_dict={
 "disk":disk_usuage_list[0],
 "size":disk_usuage_list[1],
 "free_space":disk_usuage_list[2]
}
#converting to dataframe
# user_i
user_info_df=pd.DataFrame([user_info_dict])
disk_info_df=pd.DataFrame([disk_usuage_dict])
print(user_info_dict)
print(disk_usuage_dict)
print(user_info_df)
print(disk_info_df)

