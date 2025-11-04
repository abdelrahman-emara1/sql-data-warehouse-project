# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

---

## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture: **Bronze**, **Silver**, and **Gold** layers:

![Data Architecture](docs/data_architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.  
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.  
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

---

## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a modern Data Warehouse using Medallion Architecture (Bronze, Silver, Gold).
2. **ETL Pipelines**: Extracting, transforming, and loading data from raw sources into the warehouse.
3. **Data Modeling**: Developing Fact and Dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports for business insights.

🎯 This repository is an excellent resource for anyone demonstrating skills in:
- SQL Development  
- Data Engineering  
- ETL Pipeline Development  
- Data Modeling  
- Data Analytics  

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

---

### ✅ BI & Reporting (Data Analysis)

#### **Objective**
Develop SQL analytical queries to generate insights about:
- Customer Behavior  
- Product Performance  
- Sales Trends  

For more details, see:  
📌 `docs/requirements.md`

---
## 📂 Repository Structure
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file showing ETL techniques
│   ├── data_architecture.drawio        # Main architecture diagram
│   ├── data_catalog.md                 # Dataset catalog + metadata
│   ├── data_flow.drawio                # Data flow diagram
│   ├── data_models.drawio              # Star schema model
│   ├── naming-conventions.md           # Naming rules for tables, columns, etc.
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Raw ingestion scripts
│   ├── silver/                         # Cleaning and standardizing data
│   ├── gold/                           # Fact/Dimension + analytics views
│
├── tests/                              # Test scripts for data quality
│
├── README.md                           # Project overview
├── LICENSE                             # MIT license
├── .gitignore                          # Ignored files config
└── requirements.txt                    # Dependencies


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
