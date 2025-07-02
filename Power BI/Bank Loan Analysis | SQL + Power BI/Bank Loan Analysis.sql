Create database BankLoan;

use bankloan;
select * from financial_loan;

SELECT DATE(issue_date) AS issue_date
FROM financial_loan;

-- Total loan applications--
SELECT count(id) AS Total_Loan_Applications FROM financial_loan;
-- Month to Date Total loan applications--
SELECT count(id) AS MTD_Total_Loan_Applications FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;
-- Previous Month to Date Total loan applications--
SELECT count(id) AS PMTD_Total_Loan_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Funded applications--
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan;
-- Month to Date Total Funded applications--
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;
-- Previous Month to Date Total Funded applications--
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Total Amount Received--
SELECT SUM(total_payment) AS Total_Amount_received FROM financial_loan;
-- Month to Date Total Amount Received--
SELECT SUM(total_payment) AS MTD_Total_Amount_received FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;
-- Previous Month to Date Total Amount Received--
SELECT SUM(total_payment) AS PMTD_Total_Amount_received FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average Interest rate--
SELECT ROUND(AVG(int_rate), 5) *100 AS Avg_Interest_Rate FROM financial_loan;

-- MTD Average Interest --
SELECT ROUND(AVG(int_rate), 5) *100 AS MTD_Avg_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;
-- PMTD Average Interest --
SELECT ROUND(AVG(int_rate), 5)*100 AS PMTD_Avg_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Average DTI--
SELECT ROUND(AVG(dti),5) * 100 AS Avg_DTI FROM financial_loan;
-- MTD Average DTI--
SELECT ROUND(AVG(dti),5) * 100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;
-- PMTD Average DTI--
SELECT ROUND(AVG(dti),5) * 100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- % of Good Loan --
SELECT
	ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) *100)
    /
    COUNT(id), 
    2) AS Good_loan_percentage
FROM financial_loan;

-- Good Loan Applications--

SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount--
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Total Amount Received--
SELECT SUM(total_payment) AS Good_Loan_Amount_Received FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- % of Bad Loan--
SELECT
	ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) *100.0)
    /
    COUNT(id), 
    2) AS Bad_loan_percentage
FROM financial_loan;

-- Bad Loan Applicaions --
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount--
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received --
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Loan Status Grid View--

SELECT
		loan_status,
        COUNT(id) AS Total_Loan_applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
	FROM 
		financial_loan
    GROUP BY
		loan_status;
        
-- Loan Status Month to date grid view--
SELECT
	loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;
    
-- MONTHLY TREND--

SELECT
	MONTH(issue_date) AS Month_Number,
	MONTHNAME(issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY Month_Number,Month_Name
ORDER BY Month_Number;

-- Regional/State Analysis--
SELECT
	address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY address_state
ORDER BY Total_Funded_Amount DESC;

SELECT
	address_state,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC;

-- Loan Term Analysis--
SELECT
	term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY term
ORDER BY term;
  
-- Employee work experience--
SELECT
	emp_length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;

-- Loan Purpose Breakdown--
SELECT
	purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC;

-- Home Ownership analysis--
SELECT
	home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;

-- GRID View --
SELECT
	home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;
