#!/bin/bash
 
# Use Python with pandas to convert CSV to Excel
python3 <<EOF
import pandas as pd
 
# Read CSV file
df = pd.read_csv('system_info.csv')
 
# Convert to Excel and save
df.to_excel('system_info.xlsx', index=False)
EOF
