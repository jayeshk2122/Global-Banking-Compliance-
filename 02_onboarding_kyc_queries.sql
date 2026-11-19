USE Global_Banking_Onboarding;
GO

-- 1. BASIC JOINS: End-to-End Onboarding Funnel
SELECT a.applicant_id, a.full_name, a.country, k.kyc_status, r.account_type, r.currency
FROM Applicants a
LEFT JOIN KYC_Compliance k ON k.applicant_id = a.applicant_id
LEFT JOIN Retail_Accounts r ON r.applicant_id = a.applicant_id;

-- 2A. ADVANCED JOINS: Orphan KYC Record Audit (FULL OUTER JOIN)
SELECT a.applicant_id, a.full_name, k.kyc_id, k.kyc_status
FROM Applicants a
FULL OUTER JOIN KYC_Compliance k ON a.applicant_id = k.applicant_id;

-- 2B. ADVANCED JOINS: Referral Program Attribution (SELF JOIN)
SELECT 
    a.applicant_id, 
    a.full_name AS applicant_name, 
    a.country, 
    a.referrer_id, 
    r.currency, 
    ref.full_name AS referrer_name
FROM Applicants a 
INNER JOIN Retail_Accounts r ON r.applicant_id = a.applicant_id
INNER JOIN Applicants ref ON ref.applicant_id = a.referrer_id;

-- 3A. SET OPERATORS: Applicants Who Passed KYC AND Opened an Account (INTERSECT)
SELECT a.applicant_id, a.full_name
FROM Applicants a
JOIN KYC_Compliance k ON k.applicant_id = a.applicant_id
INTERSECT 
SELECT a.applicant_id, a.full_name
FROM Applicants a
JOIN Retail_Accounts r ON r.applicant_id = a.applicant_id;

-- 3B. SET OPERATORS: Applicants Without a Bank Account (EXCEPT)
SELECT a.applicant_id, a.full_name, a.country
FROM Applicants a
EXCEPT
SELECT a.applicant_id, a.full_name, a.country
FROM Applicants a
JOIN Retail_Accounts r ON r.applicant_id = a.applicant_id;

-- 4. STRING, NUMERIC & DATE FUNCTIONS: Data Cleaning & KYC Turnaround SLA
SELECT 
    UPPER(TRIM(a.full_name)) AS Full_Name, 
    RIGHT(a.tax_id, 3) AS Tax_Id_Masked, 
    ROUND(k.aml_risk_score, 1) AS Aml_Risk_Score, 
    DATEDIFF(DAY, a.applied_date, k.reviewed_date) AS Days_for_KYC_Review
FROM Applicants a 
JOIN KYC_Compliance k ON k.applicant_id = a.applicant_id
WHERE a.tax_id IS NOT NULL;

-- 5. NULL FUNCTIONS: Master Executive Report with COALESCE & NULLIF
SELECT 
    UPPER(TRIM(a.full_name)) AS Full_Name, 
    COALESCE(a.email, a.phone, 'No Contact Info') AS Primary_Contact, 
    COALESCE(k.kyc_status, 'Not Started') AS KYC_Stage, 
    COALESCE(ROUND(k.aml_risk_score, 1), 0.0) AS AML_Risk_Score, 
    NULLIF(r.initial_deposit, 0.00) AS Funded_Balance
FROM Applicants a
LEFT JOIN KYC_Compliance k ON k.applicant_id = a.applicant_id
LEFT JOIN Retail_Accounts r ON r.applicant_id = a.applicant_id;
