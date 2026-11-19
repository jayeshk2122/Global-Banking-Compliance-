# US & UK Banking: Customer Onboarding & KYC Analysis (SQL)

## About This Project
This is a beginner-friendly SQL Server practice project that simulates how international retail banks in the **USA** and **UK** track new customers from initial application to KYC verification and bank account opening (USD and GBP).

## Project Files (Click to View SQL Code)
* **[01_database_setup.sql](01_database_setup.sql)** — Creates the `Applicants`, `KYC_Compliance`, and `Retail_Accounts` tables and inserts sample US/UK customer data.
* **[02_onboarding_kyc_queries.sql](02_onboarding_kyc_queries.sql)** — Contains all practical queries solving onboarding funnel, compliance audit, and data-cleaning questions.

## Tables in the Database
1. **Applicants:** Stores customer names, contact info, country (`USA` or `UK`), Tax IDs (SSN / National Insurance), application dates, and referral IDs.
2. **KYC_Compliance:** Tracks ID verification status (`Approved`, `Pending`, `Rejected`), AML risk scores, and review dates.
3. **Retail_Accounts:** Tracks active `Checking`, `Current`, and `High-Yield Savings` accounts along with currency (`USD` / `GBP`) and initial deposits.

## SQL Concepts Practiced
* **Basic & Advanced Joins (`INNER`, `LEFT`, `FULL OUTER`, `SELF`):** Tracked where applicants dropped off, found unmatched compliance records, and matched new users to the customers who referred them.
* **Set Operators (`INTERSECT`, `EXCEPT`):** Compared applicant IDs across tables to see who completed both KYC and account opening versus who dropped off.
* **String, Numeric & Date Functions (`TRIM`, `UPPER`, `RIGHT`, `ROUND`, `DATEDIFF`):** Cleaned messy names, masked sensitive Tax IDs, rounded risk scores, and calculated how many days KYC reviews took.
* **NULL Functions (`COALESCE`, `NULLIF`, `IS NOT NULL`):** Replaced missing contact info and statuses with readable labels and handled zero-balance accounts safely.
