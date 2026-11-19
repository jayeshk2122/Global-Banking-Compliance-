-- US & UK Retail Banking Onboarding & KYC Database Setup

CREATE DATABASE Global_Banking_Onboarding;
GO

USE Global_Banking_Onboarding;
GO

DROP TABLE IF EXISTS Retail_Accounts;
DROP TABLE IF EXISTS KYC_Compliance;
DROP TABLE IF EXISTS Applicants;
GO

-- 1. Core Applicants Table
CREATE TABLE Applicants (
    applicant_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(25),
    country VARCHAR(20), -- 'USA' or 'UK'
    tax_id VARCHAR(20),  -- SSN (USA) or National Insurance Number (UK)
    applied_date DATE,
    referrer_id INT
);

-- 2. Compliance & KYC Table
CREATE TABLE KYC_Compliance (
    kyc_id INT PRIMARY KEY,
    applicant_id INT,
    id_document VARCHAR(30),
    kyc_status VARCHAR(20),
    aml_risk_score DECIMAL(5, 2),
    reviewed_date DATE
);

-- 3. Retail Bank Accounts Table
CREATE TABLE Retail_Accounts (
    account_id INT PRIMARY KEY,
    applicant_id INT,
    account_type VARCHAR(30),
    currency VARCHAR(5),
    initial_deposit DECIMAL(12, 2),
    account_status VARCHAR(20)
);
GO

-- Insert Sample US & UK Data
INSERT INTO Applicants (applicant_id, full_name, email, phone, country, tax_id, applied_date, referrer_id) VALUES
(101, '  james miller ', 'james.miller@usbank.com', '+1-212-555-0143', 'USA', '123-45-6789', '2026-01-08', NULL),
(102, 'EMILY CLARKE', 'emily.clarke@ukmail.co.uk', NULL, 'UK', 'QQ123456C', '2026-01-12', 101),
(103, 'Marcus Vance', NULL, '+1-415-555-0198', 'USA', '987-65-4321', '2026-01-19', 101),
(104, 'chloe bennett', 'chloe.b@ukmail.co.uk', '+44-20-7946-0921', 'UK', NULL, '2026-02-03', 102),
(105, 'David Brooks', 'david.brooks@usbank.com', NULL, 'USA', '456-78-9012', '2026-02-11', NULL),
(106, 'Oliver Wright', 'oliver.w@ukmail.co.uk', '+44-161-496-0311', 'UK', 'AB987654D', '2026-02-18', 104);

INSERT INTO KYC_Compliance (kyc_id, applicant_id, id_document, kyc_status, aml_risk_score, reviewed_date) VALUES
(501, 101, 'US Passport', 'Approved', 14.258, '2026-01-09'),
(502, 102, 'UK Driving Licence', 'Approved', 28.642, '2026-01-14'),
(503, 103, 'State ID', 'Rejected', 91.500, '2026-01-20'),
(504, 104, 'UK Passport', 'Pending', NULL, NULL),
(505, 105, 'US Passport', 'Approved', 19.875, '2026-02-12'),
(506, 999, 'UK Driving Licence', 'Approved', 11.000, '2026-02-15');

INSERT INTO Retail_Accounts (account_id, applicant_id, account_type, currency, initial_deposit, account_status) VALUES
(8001, 101, 'Checking', 'USD', 5000.00, 'Active'),
(8002, 102, 'Current', 'GBP', 0.00, 'Active'),
(8003, 105, 'High-Yield Savings', 'USD', 25000.75, 'Active');
GO
