[3:16 PM] Saumya Ranjan
import subprocess
import openpyxl
import socket
 
# Execute the Bash script and capture its output
bash_script_output = subprocess.Popen(['bash', 'config.sh'], stdout=subprocess.PIPE).communicate()[0].decode()
 
# Parse the output of the Bash script
output_lines = bash_script_output.splitlines()
 
# Extract variable values from the output
user_info_line = next(line for line in output_lines if line.startswith('| User ID'))
user_id = user_info_line.split('|')[2].strip()
group_id = user_info_line.split('|')[3].strip()
home_directory = user_info_line.split('|')[4].strip()
shell = user_info_line.split('|')[5].strip()
 
disk_info_lines = [line for line in output_lines if line.startswith('| /')]
disk_info = [[field.strip() for field in line.split('|')[1:]] for line in disk_info_lines]
 
try:
    network_info_line = next(line for line in output_lines if line.startswith('| eth'))
    network_info = [network_info_line.strip().split('|')]
except StopIteration:
    print("Network information not found in output.")
 
# Create Excel file with tabular format
excel_file_path = "system_info.xlsx"
wb = openpyxl.Workbook()
ws = wb.active
 
# Write headers
headers = ['User ID', 'Group ID', 'Home Directory', 'Shell', 'Disk', 'Size', 'Free Space', 'Network Interface', 'Domain Name', 'IP Address']
ws.append(headers)
 
# Write user information
user_info = [user_id, group_id, home_directory, shell, '', '', '', '', '', '']
ws.append(user_info)
 
# Write disk information
for disk in disk_info:
    ws.append([user_id, group_id, home_directory, shell] + disk)
 
# Write network information
try:
    for network in network_info:
        interface, ip_address = network[1].strip(), network[2].strip()
        try:
            domain_name = socket.gethostbyaddr(ip_address)[0]
        except socket.herror:
            domain_name = "N/A"
        ws.append([user_id, group_id, home_directory, shell, "N/A", "N/A", "N/A", interface, domain_name, ip_address])
except NameError:
    print("Skipping network information writing due to missing data.")
 
# Save Excel file
wb.save(filename=excel_file_path)
 
print("Excel file '{}' has been generated successfully.".format(excel_file_path))
