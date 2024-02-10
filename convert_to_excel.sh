#!/bin/bash
 
# Read CSV file and convert to Excel with table formatting
python3 <<EOF
import pandas as pd
 
# Read CSV file
df = pd.read_csv('system_info.csv')
 
# Convert to Excel and save with table formatting
with pd.ExcelWriter('system_info.xlsx', engine='xlsxwriter') as writer:
    df.to_excel(writer, index=False, sheet_name='Sheet1')
    workbook = writer.book
    worksheet = writer.sheets['Sheet1']
    table_format = workbook.add_format({'border': 1})
    worksheet.add_table(0, 0, df.shape[0], df.shape[1] - 1, {'style': 'Table Style Medium 10', 'format': table_format})
EOF
