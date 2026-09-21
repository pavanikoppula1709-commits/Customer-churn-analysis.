# Customer-churn-analysis.
2. Which contract types, tenure bands, payment methods, and service combinations have the highest churn?
3. Which customers should be prioritized for retention outreach?
4. Which retention actions are most appropriate for each high-risk segment?
5. How can the company use churn-risk predictions to protect recurring revenue?

## Project structure

```text
customer-churn-analysis/
├── WA_Fn-UseC_-Telco-Customer-Churn.csv
├── customer churn analysis.ipynb
├── telco_sql_project.sql
├── customer churn analysis power bi.pbix
├── outputs/
│   ├── telco_churn_clean.csv
│   ├── telco_churn_mysql.csv
│   ├── high_risk_customer_retention_list.csv
│   ├── model_churn_drivers.csv
│   └── churn_prediction_model.pkl
└── visuals/
    ├── churn_distribution.png
    ├── churn_by_contract.png
    ├── churn_by_tenure.png
    ├── monthly_charges_by_churn.png
    └── confusion_matrix.png
```

## Tools used

- **Python:** pandas, NumPy, Matplotlib, Seaborn, scikit-learn, joblib
- **MySQL:** data storage, SQL-based churn analysis, customer segmentation
- **Power BI:** one-page churn and retention dashboard
- **Machine learning:** Logistic Regression classifier

## Python workflow

1. Load the Telco Customer Churn CSV file.
2. Convert `TotalCharges` to a numeric field and replace blank values with `0` for customers with zero tenure.
3. Create features including `ChurnFlag`, tenure bands, monthly-charge bands, churn probability, risk band, and recommended retention action.
4. Perform exploratory analysis by contract, tenure, payment method, Internet service, Tech Support, and Online Security.
5. Train and evaluate a Logistic Regression churn classifier.
6. Export cleaned data, churn drivers, the prediction model, and the high-risk customer retention list.

Install the Python dependencies:

```bash
pip install pandas numpy matplotlib seaborn scikit-learn joblib
```

Run the notebook from top to bottom:

```text
customer churn analysis.ipynb
```

## MySQL workflow

1. Run `telco_sql_project.sql` in MySQL Workbench.
2. Create the `telco_churn_analytics` database and `customer_churn` table.
3. Import `outputs/telco_churn_mysql.csv` into `customer_churn`.
4. Run the SQL queries to analyze churn by contract, tenure, payment method, services, revenue exposure, and retention priority.

Verify the import:

```sql
SELECT COUNT(*) AS total_customers
FROM customer_churn;
```

Expected result: `7043` customers.

## Power BI dashboard

Connect Power BI to the MySQL database `telco_churn_analytics` and load the `customer_churn` table.

The dashboard includes:

- KPI cards for total customers, churned customers, churn rate, monthly revenue, and churned revenue.
- Churn rate by contract type.
- Churn rate by tenure band.
- Churn rate by payment method.
- Churn rate by Internet service.
- A matrix showing churn by Tech Support and Online Security.
- A high-risk customer retention-priority table.

## Retention recommendations

- Offer annual-contract discounts to eligible month-to-month customers.
- Encourage electronic-check customers to enroll in automatic payment methods.
- Use a structured 30-, 60-, and 90-day onboarding journey for new customers.
- Offer Tech Support and Online Security bundles to high-risk customers, particularly Fiber Optic subscribers.
- Prioritize high-risk customers with high monthly charges because they represent the greatest recurring-revenue exposure.

## Dataset

The project uses the IBM Telco Customer Churn dataset. The data is a customer-level snapshot and does not contain dates or retention-campaign outcomes. Therefore, the analysis supports segmentation, churn-risk scoring, and prioritization, but does not measure monthly churn trends or campaign ROI.

## Author
**Pavana Laxmi Koppula**  
*Data Analyst Enthusiast*  
Mangalagiri, Andhra Pradesh, India  

* **Email:** pavanikoppula1709@gmail.com
* **GitHub:** [pavanikoppula1709](https://github.com/pavanikoppula1709)
