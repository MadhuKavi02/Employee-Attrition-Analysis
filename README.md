**Employee Performance & Attrition Analysis Dashboard**

**Project Overview**
               A company is losing good employees every year. This project analyzes why employees are leaving and helps the HR department take data-driven decisions to reduce attrition and retain talent.
              Using a complete data analytics pipeline — Python → SQL Server → Power BI — this project answers 11 key business questions about employee attrition across departments, salary ranges, age groups, job roles, and more.

 **Business Problem**
              "Which employees are leaving, why are they leaving, and what can the company do to retain them?"

**Dataset**
      Dataset Information
- Source: IBM HR Analytics Employee Attrition Dataset (Kaggle)  
- Total Records: 1,470 employees  
- Total Columns: 35 (reduced to 32 after cleaning)  
- Target Variable: Attrition (Yes = Left, No = Stayed)  
- Overall Attrition Rate: 16.12% (237 employees left)

**Tools & Technologies**
- Python (Pandas, Matplotlib, Seaborn): Used for data cleaning, exploratory data analysis (EDA), and visualization  
- SQL Server (T-SQL, SSMS): Used for storing data and performing analytical queries  
- Power BI Desktop: Used to build interactive dashboards and reports  
- Jupyter Notebook: Used as the development environment for Python analysis
  
 **Project Structure**
Employee_Attrition_Project/
│
├── Data/
│   └── HR-Employee-Attrition.csv
│
├── Python/
│   └── Employee Attrition.ipynb
│
├── SQL/
│   └── Employee Attrition.sql
│
├── PowerBI/
    └── Employee Attrition.pbix

 **Data Pipeline**
CSV File → Python (EDA & Cleaning) → SQL Server → Power BI Dashboard

 **Summary**
      Attrition is primarily driven by three factors — overtime work, low salary, and early career stage. Employees who work overtime are 3 times more likely to leave. Addressing these three areas will have the highest impact on reducing overall attrition.
      
**Project Workflow**

### Python — Data Cleaning & EDA
- Loaded dataset and performed exploratory data analysis  
- Handled missing values and removed irrelevant columns  
- Converted target variable (Attrition: Yes/No → 1/0)  
- Analyzed attrition across key factors like department, salary, age, and overtime  

### SQL — Data Analysis
- Wrote 11 business queries to analyze attrition patterns  
- Used GROUP BY, CASE WHEN, and CTEs for insights  
- Built a Risk Score model to identify high-risk employees  

### Power BI — Dashboard
- Created interactive dashboard with KPI metrics and visualizations  
- Included filters for dynamic analysis  
- Highlighted key business insights for decision-making
  
  <img width="1261" height="670" alt="image" src="https://github.com/user-attachments/assets/9f178340-d37b-4012-a76d-339f6e45477a" />

**Recommendations**

- Review and optimize overtime policy — especially in Sales department
- Implement salary revision for junior and early-career employees
- Improve onboarding experience for employees in first 2 years
- Monitor and proactively manage high-risk employees using Risk Score model
- Create career development programs for employees aged 18 to 25
- Introduce work-life balance initiatives across all departments

## Key Findings

- Overall Attrition: 16.12% (237 out of 1470 employees left)  
- Highest Risk Department: Sales (21% attrition rate)  
- Overtime Impact: 30% attrition for employees doing overtime vs 10% for non-overtime (3x higher risk)  
- Salary Impact: Employees who left had an average salary of Rs. 4,787, while those who stayed earned around Rs. 6,832  
- Age Factor: Employees aged 18–25 leave most frequently  
- Experience Factor: Employees with 0–2 years of experience show the highest attrition  
- Work-Life Balance: Employees with poor work-life balance have significantly higher attrition
  
Author

Madhumitha Mathivanan

madhumithamathi2002@gmail.com

LinkedIn : https://www.linkedin.com/in/madhumithamathi07
