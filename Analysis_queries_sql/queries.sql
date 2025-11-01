use bank;

select * from financial_loan_cleaned;

WITH CurrMonth AS (
    SELECT SUM(loan_amount) AS Curr
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 12
),
PrevMonth AS (
    SELECT SUM(loan_amount) AS Prev
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 11
)
SELECT 
    Curr AS December_Total_Funded,
    Prev AS November_Total_Funded,
    ((Curr - Prev) * 1.0 / NULLIF(Prev,0)) * 100 AS MoM_Percentage
FROM CurrMonth, PrevMonth;


WITH CurrMonth AS (
    SELECT SUM(loan_amount) AS Curr_Funded
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 12
),
PrevMonth AS (
    SELECT SUM(loan_amount) AS Prev_Funded
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 11
)
SELECT 
    Curr_Funded AS December_Funded_Amount,
    Prev_Funded AS November_Funded_Amount,
    ((Curr_Funded - Prev_Funded) * 1.0 / Prev_Funded) * 100 AS MoM_Percentage
FROM CurrMonth, PrevMonth;


WITH CurrMonth AS (
    SELECT SUM(total_payment) AS Curr_Received
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 12
),
PrevMonth AS (
    SELECT SUM(total_payment) AS Prev_Received
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 11
)
SELECT
    Curr_Received AS December_Total_Amount_Received,
    Prev_Received AS November_Total_Amount_Received,
    ((Curr_Received - Prev_Received) * 1.0 / Prev_Received) * 100 AS MoM_Percentage
FROM CurrMonth, PrevMonth;


SELECT
    loan_status,
    AVG(int_rate * 100) AS MTD_Avg_Interest_Rate,
    AVG(dti * 100) AS MTD_Avg_DTI
FROM financial_loan_cleaned
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;


WITH CurrMonth AS (
    SELECT 
        AVG(int_rate * 100) AS Curr_IntRate,
        AVG(dti * 100) AS Curr_DTI
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 12
),
PrevMonth AS (
    SELECT 
        AVG(int_rate * 100) AS Prev_IntRate,
        AVG(dti * 100) AS Prev_DTI
    FROM financial_loan_cleaned
    WHERE MONTH(issue_date) = 11
)
SELECT
    Curr_IntRate AS December_Avg_Interest_Rate,
    Prev_IntRate AS November_Avg_Interest_Rate,
    ((Curr_IntRate - Prev_IntRate) / Prev_IntRate) * 100 AS MoM_IntRate_Percentage,

    Curr_DTI AS December_Avg_DTI,
    Prev_DTI AS November_Avg_DTI,
    ((Curr_DTI - Prev_DTI) / Prev_DTI) * 100 AS MoM_DTI_Percentage
FROM CurrMonth, PrevMonth;


Loan Category = 
IF(
    'financial_loan_cleaned'[loan_status] IN {"Fully Paid", "Current"},
    "Good Loan",
    "Bad Loan"
)
Total Applications
Total Applications = COUNT(financial_loan_cleaned[id])


Good Loan Applications =
CALCULATE(
    [Total Applications],
    'financial_loan_cleaned'[Loan Category] = "Good Loan"
)

  
Bad Loan Applications =
CALCULATE(
    [Total Applications],
    'financial_loan_cleaned'[Loan Category] = "Bad Loan"
)


Total Funded Amount = SUM(financial_loan_cleaned[loan_amount])

  
Good Loan Funded Amount =
CALCULATE(
    [Total Funded Amount],
    'financial_loan_cleaned'[Loan Category] = "Good Loan"
)

  
Bad Loan Funded Amount =
CALCULATE(
    [Total Funded Amount],
    'financial_loan_cleaned'[Loan Category] = "Bad Loan"
)

  
Total Received Amount = SUM(financial_loan_cleaned[total_payment])

  
Good Loan Received Amount =
CALCULATE(
    [Total Received Amount],
    'financial_loan_cleaned'[Loan Category] = "Good Loan"
)

  
Bad Loan Received Amount =
CALCULATE(
    [Total Received Amount],
    'financial_loan_cleaned'[Loan Category] = "Bad Loan"
)


Good Loan % = 
DIVIDE([Good Loan Applications], [Total Applications], 0)


Bad Loan % =
DIVIDE([Bad Loan Applications], [Total Applications], 0)
