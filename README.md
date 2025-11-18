# 📊 End-to-End Sales Data Warehouse & Analytics Solution

This project is a complete end-to-end Data Warehouse and Analytics solution delivered in two main phases:

Phase 1 — Data Warehouse (SQL Server):
Data ingestion from CSV files into SQL Server, applying ETL transformations, data cleaning, data integration, and preparing business-ready data in the Gold Layer using Medallion Architecture.

Phase 2 — Business Intelligence (Power BI):
Developing a fully interactive dashboard in Power BI using the prepared Gold Layer data. This includes creating custom DAX measures, adjusting data types for accurate analysis, and generating insights on sales performance, customer behavior, and product performance.

---
## 🧱 Project Architecture

A complete pipeline built using **SQL Server**, following Medallion Architecture:

> **Bronze → Silver → Gold → BI Reporting**

![Architecture](docs/data_architecture.png)


---

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.  
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.  
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---


## 📖 Project Overview

### **Phase 1️⃣ — Data Warehouse (Data Engineering)**

#### 🎯 Goal  
Design and build a scalable analytical data warehouse to unify ERP & CRM sales data.

#### 🔧 Key Deliverables  
- **Data Ingestion** → Raw CSVs → SQL Server (Bronze)
- **Data Quality & Standardization** → Cleaned + Validated data (Silver)
- **Data Modeling** → Fact & Dimension tables in a star schema (Gold)
- **SQL Analytical Queries** → Business-ready insights
- **Documentation** → Data dictionary + naming conventions + ETL flows

#### 🧩 Skills Demonstrated  
✔ SQL Development  
✔ ETL Pipeline Engineering  
✔ Data Modeling  
✔ Data Quality Verification  
✔ Warehouse Architecture Design  

---

### **Phase 2️⃣ — BI & Reporting (Data Analytics)**

After preparing the Gold Layer, the data is visualized in **Power BI** with:

#### 🔍 Analytical Insights
- **Main KPI Page**
  - Revenue performance & YoY growth
  - Average order value
  - Revenue by channel & region

- **Customer Analysis Page**
  - Segmentation by spending behavior
  - Retention & repeat purchase metrics

- **Product Performance Page**
  - Top vs. low selling products
  - Profitability insights

#### 🧭 User Experience Features
- **Home Page** → Clear navigation hub
- **Search Page** → Search customers/products across all pages
- **Ask AI Page** → Natural-language Q&A for business queries

✔ Professional, consistent design  
✔ Business storytelling applied  
✔ Interactive experience for stakeholders  

---

## 🚀 Tools & Technologies

| Category | Tools |
|---------|------|
| Database & ETL | SQL Server Express, SSMS |
| Data Modeling | Star Schema, DrawIO |
| BI & Reporting | Power BI |
| Documentation | Notion, GitHub |
| Version Control | Git |

All technologies used are **free and accessible**.

---

## 🛠️ Important Links & Tools

Everything used here is **free** and publicly available:

- **[Datasets](datasets/):** CSV datasets used in the project  
- **[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads):** Lightweight SQL Server edition  
- **[SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16):** GUI to manage and query the database  
- **[GitHub](https://github.com/):** Code versioning and project hosting  
- **[DrawIO](https://www.drawio.com/):** Used for architecture, models, and ETL diagrams  
- **[Notion](https://www.notion.com/):** For project planning and documentation  
- **[Notion Project Steps](https://thankful-pangolin-2ca.notion.site/SQL-Data-Warehouse-Project-16ed041640ef80489667cfe2f380b269?pvs=4):** All project phases and tasks

---

## 🚀 Project Requirements

### ✅ Building the Data Warehouse (Data Engineering)

#### **Objective**
Build a modern data warehouse in SQL Server to consolidate sales data and enable analytical reporting.

#### **Specifications**
- **Data Sources**: Import data from two source systems (ERP & CRM) delivered in CSV format  
- **Data Quality**: Clean and standardize data in the Silver layer  
- **Integration**: Merge both sources into a unified analytical model  
- **Scope**: Latest dataset only (no historization)  
- **Documentation**: Provide clear data model and table descriptions

For more details, see:  
📌 `docs/dwh_docs/requirements.md`
---

### ✅ BI & Reporting (Data Analysis)

#### **Objective**
Develop SQL analytical queries to generate insights about:
- Customer Behavior  
- Product Performance  
- Sales Trends  

For more details, see:  
📌 `docs/analytics_dashboard`
---

## 🛡️ License

This project is licensed under the **MIT License**.  
You are free to use, modify, and share this project with proper attribution.

---

## 🌟 About Me

Hi! I'm **Abdelrahman Emara**, a **Data Analyst** aspiring to become a **Data Scientist**.  
My background is in **Telecommunication Engineering**, and I’m passionate about data pipelines, analytics, and transforming raw data into insights.

Let's connect! 👇

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](http://www.linkedin.com/in/abdelrahman-emara-274949263)
[![GitHub](https://img.shields.io/badge/GitHub-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/EmaraData)
[![Kaggle](https://img.shields.io/badge/Kaggle-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white)](https://www.kaggle.com/abdelrahmanemara19)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:abdelrahman.emara199@gmail.com)
