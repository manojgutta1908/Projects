# 💼 SmartLoan: SQL-Driven Insights into Loan Performance and Customer Behavior

## 📌 Project Overview

SmartLoan is a structured SQL project that transforms a raw, redundant loan dataset into a fully normalized relational database. It optimizes performance using indexing and enables rich analytical insights into loan trends, customer behavior, and repayment patterns.

---

## 📂 Dataset

- **File Used**: `LoansData.csv`
- **Total Columns**: 40
- **Source**: Simulated loan applications and customer demographic data
- **Contains**:
  - Financial data (credit amount, loan annuity, income)
  - Demographic data (education, marital status, housing)
  - Application metadata (processing day/hour, ID tracking)
  - Credit scoring sources
  - Repayment history
  - Target feature: `Default` (optional use for ML classification)

### 📊 Original Dataset Schema

This is the flat structure of the dataset before normalization:

![Original Schema](images/Loans.jpg)

---

## 🧱 Normalized Database Schema

The dataset was normalized into multiple relational tables to reduce redundancy, improve reliability, and enhance performance. Here's the final ER diagram:

![Normalized ERD](images/Normalised.jpg)

### ✅ Main Tables

- `Customers`: Demographics and client information
- `Client_Income`: Income, work status, and employment
- `Cus_Properties`: Property and housing ownership
- `Cus_Loans`: Loan contract details and application info
- `CreditScores`: Score sources from credit bureaus
- `Payments`: Repayment data

### 🔁 Lookup Tables

- `Education`, `Marital_Status`, `Income_Type`, `Occupation`, `Organization_Type`, `House_Type`, `Loan_Contract`, `Accompany`

---

## 🛠️ SQL Features

### 🧮 Schema Scripts
- Full `CREATE TABLE` statements with primary and foreign key constraints
- Proper indexing on non-PK fields for performance

### 📥 ETL (Insert Logic)
- SQL-based `INSERT INTO ... SELECT ... JOIN` transformations from the raw `Loans` table
- Data validation via `IS NOT NULL` filters

### 📈 Analytical Queries
- Outstanding balance calculation
- Repayment trends across income types
- Customer ranking by loan amount
- Running totals using window functions

### 🧠 Stored Procedures
```sql
EXEC Loan_Summary @Credit_Amount = 100000, @Loan_Contract_Type = 'CL';
