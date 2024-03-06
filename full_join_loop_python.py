#a loop to iterate through a directory containing matrices of kmer rows and sample columns
#so as to full join them based on their sample type (i.e PD for progressive disease) 
#dependent on file nomenclature

import pandas as pd
import os

PD_path = '/your/PD/dir/here'
PRCR_path = '/your/PRCR/dir/here'

# Initialize an empty DataFrame for our final result
matrix_df = None

for directory in [PD_path, PRCR_path]:
    for filename in os.listdir(directory):
        if filename.endswith('.csv'):
            
            # Extract the base name part from the filename (e.g., 'SRR5088813' from 'SRR5088813_Matrix.csv')
            base_name = os.path.basename(filename).split('_')[0]

            # Construct the full file path
            file_path = os.path.join(directory, filename)

            # Read the CSV file
            df = pd.read_csv(file_path)

            # Merge with the result DataFrame
            if matrix_df is None:
                matrix_df = df
            else:
                matrix_df = pd.merge(matrix_df, df, on='kmer', how='outer')
                

#replace NA with 0's
matrix_df.fillna(0, inplace=True)

# Check the final DataFrame
matrix_df.head()

#print details on full joined matrix

print("matrix has " + str(len(matrix_df)) + " rows ")
print("Matrix has " + str(matrix_df.shape[1]) + " columns")

#write matrix to .csv

matrix_df.to_csv('/your/destination/dir/here/file.csv', index=False)
