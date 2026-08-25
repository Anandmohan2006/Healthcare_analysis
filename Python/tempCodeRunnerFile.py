print("Shape:", patients.shape)

print("\nData Types:")
print(patients.dtypes)

print("\nMissing Values:")
print(patients.isnull().sum())

print("\nDuplicate Rows:")
print(patients.duplicated().sum())