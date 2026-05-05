-- 1. Overall attrition rate
select count(*) as Total_employees,
sum(Attrition) as Left_company_counts,
Round(sum(Attrition)*100.0/count(*),2) as Attrition_rate
from Employee_Attrition


--2. Department wise attrition

select Department,
count(*) as Total_emp,
sum(Attrition) as left_company,
Round(sum(Attrition)*100.0/count(*),2) as Attrition_rate
from Employee_Attrition
group by Department
order by Attrition_rate desc

--3. Overtime impact

SELECT
    OverTime,
    COUNT(*) AS Total,
    SUM(Attrition) AS Left_emp,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM Employee_Attrition
GROUP BY OverTime 

--4.Salary range vs attrition

select case when MonthlyIncome <3000 then 'Low'
when MonthlyIncome between 3000 and 7000 then 'Medium'
else 'High' end as Salary_range,
count(*) as total_emp,
sum(Attrition) as emp_left,
Round(sum(Attrition)*100.0/count(*) ,2) as Attrition_rate

from Employee_Attrition
group by case when MonthlyIncome <3000 then 'Low'
when MonthlyIncome between 3000 and 7000 then 'Medium'
else 'High' end
order by Attrition_rate desc

/*5. Age Analysis

Which age group leaves the most?
Are younger employees leaving more than older ones?*/
select case when Age <25 then '18-25' 
WHEN AGE BETWEEN 25 AND 35 THEN '25-35'
ELSE 'Above 35' END AS Age_group,count(*) as total_emp,
sum(Attrition) as emp_left,
Round(sum(Attrition)*100.0/count(*),2) as Attritionrate
from Employee_Attrition
group by case when Age <25 then '18-25' 
WHEN AGE BETWEEN 25 AND 35 THEN '25-35'
ELSE 'Above 35' END
order by Attritionrate desc


---6.Experience Analysis

/*Do employees with less experience leave more?
What is attrition rate by years at company?*/

SELECT
    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE 'Above 10 Years'
    END AS Experience_Group,
    COUNT(*) AS Total_Emp,
    SUM(Attrition) AS Emp_Left,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM Employee_Attrition
GROUP BY
    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE 'Above 10 Years'
    END
ORDER BY Attrition_Rate DESC

--7. Job Role Analysis

--Which job role has highest attrition?
select JobRole ,count(*) as total_emp,
sum(Attrition) as emp_left,
Round(sum(Attrition)*100.0/count(*),2) as Attritionrate
from Employee_Attrition
group by JobRole
order by Attritionrate desc

--8.Work Life Balance Analysis
--Does poor work life balance lead to more attrition?

SELECT
    CASE WorkLifeBalance
        WHEN 1 THEN '1 - Bad'
        WHEN 2 THEN '2 - Good'
        WHEN 3 THEN '3 - Better'
        WHEN 4 THEN '4 - Best'
    END AS WorkLife_Balance,
    COUNT(*) AS Total_Emp,
    SUM(Attrition) AS Emp_Left,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM Employee_Attrition
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance

--9.Which departments and overtime conditions have the highest employee attrition rates?”


SELECT
    Department,
    OverTime,
    COUNT(*) AS Total,
    SUM(Attrition) AS Left_Emp,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM Employee_Attrition
GROUP BY Department, OverTime
ORDER BY Attrition_Rate DESC

--10.Which current employees are at the highest risk of leaving the company?

 SELECT
    EmployeeNumber,
    Age,
    Department,
    MonthlyIncome,
    OverTime,
    YearsAtCompany,
    CASE
        WHEN OverTime = 'Yes' THEN 2 ELSE 0
    END +
    CASE
        WHEN MonthlyIncome < 3000 THEN 2
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 1
        ELSE 0
    END +
    CASE
        WHEN YearsAtCompany <= 2 THEN 2
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN 1
        ELSE 0
    END +
    CASE
        WHEN Age < 30 THEN 1 ELSE 0
    END AS Risk_Score,
    case 
    when (
    case when OverTime='Yes' then 2 else 0 end +
    case when MonthlyIncome <3000 THEN 2
         WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 1
         ELSE 0 END +
         CASE WHEN YearsAtCompany <=2 then 2
              when YearsAtCompany between 3 and 5 then 1
    else 0 end +
    case when Age <30 then 1 else 0 end
    ) >=5 then 'High Risk'
    when (
      case when OverTime='Yes' then 2 else 0 end +
 case when MonthlyIncome <3000 THEN 2
         WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 1
         ELSE 0 END +
         CASE WHEN YearsAtCompany <=2 then 2
              when YearsAtCompany between 3 and 5 then 1
    else 0 end +
    case when Age <30 then 1 else 0 end
    )>=3 then 'Medium Risk'
    else 'Low Risk'
    end as Risk_Label

FROM Employee_Attrition
where Attrition = 0
ORDER BY Risk_Score DESC

--11.Which departments are at high risk of employee attrition based on attrition rate and salary trends?

WITH DeptSummary AS (
    SELECT
        Department,
        COUNT(*) AS Total_Emp,
        SUM(Attrition) AS Left_Emp,
        ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS Attrition_Rate,
        ROUND(AVG(CAST(MonthlyIncome AS FLOAT)), 0) AS Avg_Salary
    FROM Employee_Attrition
    GROUP BY Department
)
SELECT *,
    CASE
        WHEN Attrition_Rate > 20 THEN 'HIGH RISK'
        WHEN Attrition_Rate BETWEEN 10 AND 20 THEN 'MEDIUM RISK'
        ELSE 'LOW RISK'
    END AS Risk_Level
FROM DeptSummary
ORDER BY Attrition_Rate DESC
