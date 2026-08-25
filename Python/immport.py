import pandas as pd
import mysql.connector


import pandas as pd
import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="satyam@2006",
    database="healthcare"
)

print("Database connected successfully!")


patients = pd.read_sql("SELECT * FROM patients", connection)

print(patients.head())




print("Shape:", patients.shape)

print("\nData Types:")
print(patients.dtypes)

print("\nMissing Values:")
print(patients.isnull().sum())

print("\nDuplicate Rows:")
print(patients.duplicated().sum())