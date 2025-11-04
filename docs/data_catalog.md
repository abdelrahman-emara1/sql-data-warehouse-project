# 📘 Gold Layer Data Catalog

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases.  
It consists of **dimension tables** and **fact tables** for business metrics.

---

## 1. `gold.dim_customers`

**Purpose:** Stores customer details enriched with demographic and geographic data.

### Columns

| Column Name      | Data Type       | Description |
|------------------|-----------------|-------------|
| `customer_key`   | INT             | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id`    | INT             | Unique numerical identifier assigned to each customer. |
| `customer_number`| NVARCHAR(50)    | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| `first_name`     | NVARCHAR(50)    | The customer's first name. |
| `last_name`      | NVARCHAR(50)    | The customer's last name or family name. |
| `country`        | NVARCHAR(50)    | Country of residence for the customer. |
| `marital_status` | NVARCHAR(50)    | Marital status (e.g., 'Married', 'Single'). |
| `gender`         | NVARCHAR(50)    | The customer's gender, cleaned from CRM/ERP. |
| `birthdate`      | DATE            | The customer's date of birth. |
| `create_date`    | DATETIME        | The date when the customer record was created in CRM. |

---

## 2. `gold.dim_products`

**Purpose:** Provides product master data, categories, and product attributes.

### Columns

| Column Name      | Data Type       | Description |
|------------------|-----------------|-------------|
| `product_key`    | INT             | Surrogate key uniquely identifying each product. |
| `product_id`     | NVARCHAR(50)    | Original product identifier from source systems. |
| `product_number` | NVARCHAR(50)    | Unique product code used in CRM/ERP. |
| `product_name`   | NVARCHAR(200)   | Name of the product. |
| `category_id`    | NVARCHAR(50)    | Identifier of the product’s category. |
| `category`       | NVARCHAR(100)   | Category name (e.g., Electronics). |
| `subcategory`    | NVARCHAR(100)   | Subcategory name (e.g., AC Units). |
| `maintenance`    | CHAR(1)         | Indicates whether the product requires maintenance (`Y`/`N`). |
| `product_cost`   | DECIMAL(18,2)   | Internal product cost. |
| `product_line`   | NVARCHAR(100)   | Product family or line. |
| `start_date`     | DATE            | Date when product became active. |

---

## 3. `gold.fact_sales`

**Purpose:** Stores sales transactions linked to customers and products for analytical reporting.

### Columns

| Column Name     | Data Type       | Description |
|-----------------|-----------------|-------------|
| `order_number`  | NVARCHAR(50)    | Sales order or invoice number. |
| `product_key`   | INT             | Foreign key referencing `dim_products`. |
| `customer_key`  | INT             | Foreign key referencing `dim_customers`. |
| `order_date`    | DATE            | Date when the order was placed. |
| `shipping_date` | DATE            | Date when the product shipped. |
| `due_date`      | DATE            | Date when payment is due. |
| `sales_amount`  | DECIMAL(18,2)   | Total value of the sales transaction. |
| `quantity`      | INT             | Number of units sold. |
| `price`         | DECIMAL(18,2)   | Unit price of the product. |

---

## 📌 How to Use
- Join `fact_sales` with `dim_customers` and `dim_products` using surrogate keys.
- Query directly for BI dashboards, reports, KPIs.

---

### ✅ Example Query
```sql
SELECT 
    cu.country,
    pr.category,
    SUM(f.sales_amount) AS total_sales,
    SUM(f.quantity) AS total_units
FROM gold.fact_sales f
JOIN gold.dim_customers cu ON f.customer_key = cu.customer_key
JOIN gold.dim_products pr ON f.product_key = pr.product_key
GROUP BY cu.country, pr.category;
