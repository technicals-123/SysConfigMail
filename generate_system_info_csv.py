import subprocess
import csv
import socket
 
# Execute the Bash script and capture its output
bash_script_output = subprocess.run(['bash', 'config.sh'], capture_output=True, text=True)
 
# Parse the output of the Bash script
output_lines = bash_script_output.stdout.splitlines()
 
# Extract variable values from the output
user_id = output_lines[2].split('|')[1].strip()
group_id = output_lines[2].split('|')[2].strip()
home_directory = output_lines[2].split('|')[3].strip()
shell = output_lines[2].split('|')[4].strip()
disk_info = [line.strip().split('|') for line in output_lines[4:-2]]
network_info = [line.strip().split('|') for line in output_lines[-1:]]
 
# Create CSV file with tabular format
csv_file_path = "system_info.csv"
with open(csv_file_path, mode='w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['User ID', 'Group ID', 'Home Directory', 'Shell', 'Disk', 'Size', 'Free Space', 'Network Interface', 'Domain Name', 'IP Address'])
    writer.writerow([user_id, group_id, home_directory, shell, '', '', '', '', '', ''])
    for disk in disk_info:
        writer.writerow([user_id, group_id, home_directory, shell, *disk])
    for network in network_info:
        interface, ip_address = network[1].strip(), network[2].strip()
        try:
            domain_name = socket.gethostbyaddr(ip_address)[0]
        except socket.herror:
            domain_name = "N/A"
        writer.writerow([user_id, group_id, home_directory, shell, "N/A", "N/A", "N/A", interface, domain_name, ip_address])
 
print(f"CSV file '{csv_file_path}' has been generated successfully.")
