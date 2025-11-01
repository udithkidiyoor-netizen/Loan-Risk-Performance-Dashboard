# Load the dataset
import pandas as pd
data=pd.read_csv("C:/Users/Udith P Kidiyoor/Downloads/financial_loan_full.csv")
print(data.head())

# Check for missing values
print(data.isnull().sum())

# Handle missing values
# data=data.dropna()
#Loan applications are important individual records. Hence, we should not drop them.
# Just leave it as null, and handle in powerbi or sql

# Convert date columns to datetime
date_cols = [
    "issue_date",
    "last_credit_pull_date",
    "last_payment_date",
    "next_payment_date"
]

for col in date_cols:
    data[col] = pd.to_datetime(data[col], format="%d-%m-%Y", errors="coerce")

# Save the cleaned data to a new CSV file
data.to_csv("C:/Users/Udith P Kidiyoor/Downloads/financial_loan_cleaned.csv", index=False)