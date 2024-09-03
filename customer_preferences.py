# -*- coding: utf-8 -*-
"""
Created on Mon Aug 12 22:15:42 2024

@author: digui
"""

import sqlite3
import pandas as pd

# Load the first CSV file
file_path_1 = "dados/customer_preferences.csv"
customer_preferences = pd.read_csv(file_path_1)

# Load the second CSV file (for example, synthetic_customer_data.csv)
file_path_2 = "dados/synthetic_customer_data.csv"
synthetic_customer_data = pd.read_csv(file_path_2)

# Create an SQLite database (or connect to an existing one)
conn = sqlite3.connect('dados/my_database.db')

# Write the first DataFrame to a SQL table
customer_preferences.to_sql('customer_preferences', conn, if_exists='replace', index=False)

# Write the second DataFrame to a different SQL table
synthetic_customer_data.to_sql('synthetic_customer_data', conn, if_exists='replace', index=False)

# Save the database and close the connection
conn.close()

# File path for the SQLite database
db_file_path = 'dados/customer_data.db'
print(db_file_path)