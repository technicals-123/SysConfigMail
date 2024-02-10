import pandas as pd
 
# Read CSV file
df = pd.read_csv('system_info.csv')
 
# Create Excel writer
writer = pd.ExcelWriter('system_info.xlsx', engine='xlsxwriter')
 
# Write data to Excel with formatting
df.to_excel(writer, index=False, sheet_name='Sheet1')
 
# Get the xlsxwriter workbook and worksheet objects
workbook = writer.book
worksheet = writer.sheets['Sheet1']
 
# Add border formatting to the whole table
border_format = workbook.add_format({'border': 1})
worksheet.conditional_format(0, 0, df.shape[0], df.shape[1] - 1,
                             {'type': 'no_blanks', 'format': border_format})
 
# Close the Pandas Excel writer and output the Excel file
writer.save()
