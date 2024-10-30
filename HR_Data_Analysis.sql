
### Business Questions  

-- How many employees are working at the company ?
-- What is the gender breakdown in the company ?
-- What are the different recruitment channels company is having ?
-- How many departments are there in the company ?
-- In how many regions, company has its existence ?
-- How many provinces company is having ?
-- What is the average tenure of employees existence at the company ?
-- What is the average performance rating achieved by the employees ?
-- What is the distribution of whether KPIs are meeting above 80 or not ?
-- At which province & region there is higher imbalance in gender, due to which overall result is getting affected ?
-- In which age group there is higher imbalance between male and female ?
-- Which department is having higher imbalance in terms of Gender ?
-- Through which recruitment channel, higher number of employees are getting hired ?
-- Which channel is contributing more towards higher gender imbalance ?
-- How many employees got more than average ratings in the previous year ?
-- What is the average number of trainings happening for each employees ?
-- Which department received the lowest average performance rating ?
-- How overall average performance rating is fluctuating across different departments and gender ?
-- Did male employees are getting less average training score than females across all departments ?
-- Did males attending less than 2 training session across all departments ?
-- How service length is impacting average performance rating ? 
-- What is the impact of average training score on Previous Year Rating ? 
-- What is the relationship between number of trainings and performance rating ?
-- What is the performance across different age groups in the previous year ?
-- How effective are recruitment channels in relation to performance ratings ?
-- How does the number of awards won vary across different departments ?


## KPIs-Based Analysis
-- How many employees are working at the company ?
SELECT COUNT(*) AS Employee_Count
FROM employees;

-- What is the gender breakdown in the company ?
SELECT Gender,
		COUNT(*) AS gender_count,
		COUNT(*) * 100 / (SELECT COUNT(*) FROM employees) AS percent
FROM employees
GROUP BY Gender
ORDER BY gender_count DESC;			

-- What are the different recruitment channels company is having ?
SELECT DISTINCT recruitment_channel
FROM employees;

-- How many departments are there in the company ?
SELECT COUNT(DISTINCT Dept_ID) AS dept_count
FROM departments;

-- In how many regions, company has its existence ?
SELECT COUNT(DISTINCT Region_ID) AS region_count
FROM regions;

-- How many provinces company is having ?
SELECT COUNT(DISTINCT Province_ID) AS province_count
FROM provinces;

-- What is the average tenure of employees existence at the company ?
SELECT ROUND(AVG(Service_Length)) AS Avg_tenure
FROM employees;

-- What is the average performance rating achieved by the employees ?
SELECT ROUND(AVG(Previous_Year_Rating),1) AS Avg_performance_rating
FROM employees;

-- What is the distribution of whether KPIs are meeting above 80 or not ?
SELECT KPIs_Met_Above_80,
		CONCAT(ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM employees)),'%') AS Percentage
FROM employees
GROUP BY KPIs_Met_Above_80;

## Synopsis of KPIs
# Total 15416 employees are working at the company where 70% are the male employee and 30% are the females. 
# Company is having total 9 departments, and having existence in 34 regions which comes under 4 provinces.  
# Employees are getting recruited through 3 channels and having 6 years of average service tenure at the company.
# Average performance rating of employees in the previous year is 3.4. 
# 64% of the employees are not meeting the KPI threshold of 80% whereas only 36% are having KPIs met above 80

## Gender diversity check

-- At which province & region there is higher imbalance in gender, due to which overall result is getting affected ?
SELECT p.Province_Name,
		CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Male' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Male_Percentage,
        CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Female' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Female_Percentage
FROM provinces AS p
JOIN employees AS e
ON p.province_ID = e.province_ID
GROUP BY p.Province_Name;

SELECT r.Region_Name,
		CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Male' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Male_Percentage,
        CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Female' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Female_Percentage
FROM regions AS r
JOIN employees AS e
ON r.Region_ID = e.Region_ID
GROUP BY r.Region_Name
ORDER BY Male_Percentage DESC;

-- In which age group there is higher imbalance between male and female ?
SELECT Age_Group,
	   CONCAT(ROUND(COUNT(CASE WHEN Gender = 'Male' THEN 1 END) * 100 / COUNT(Gender)),'%') AS Male_Percentage,
	   CONCAT(ROUND(COUNT(CASE WHEN Gender = 'Female' THEN 1 END) * 100 / COUNT(Gender)),'%') AS Female_Percentage
FROM employees
GROUP BY Age_Group;

-- Which department is having higher imbalance in terms of Gender ?
SELECT d.Dept_Name,
		CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Male' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Male_Percentage,
        CONCAT(ROUND(COUNT(CASE WHEN e.Gender = 'Female' THEN 1 END) * 100 / (SELECT COUNT(e.Gender))),'%') AS Female_Percentage
FROM Departments AS d
JOIN employees AS e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_Name
ORDER BY Male_Percentage DESC;

-- Through which recruitment channel, higher number of employees are getting hired ?
SELECT Recruitment_Channel,
		COUNT(*) AS emp_count,
        CONCAT(ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM employees)),'%') AS Percentage
FROM employees
GROUP BY Recruitment_Channel
ORDER BY emp_count DESC;

-- Which channel is contributing more towards higher gender imbalance ?
SELECT Recruitment_Channel,
		CONCAT(ROUND(COUNT(CASE WHEN Gender = 'Male' THEN 1 END) * 100 / COUNT(Gender)),'%') AS Male_Percentage,
        CONCAT(ROUND(COUNT(CASE WHEN Gender = 'Female' THEN 1 END) * 100 / COUNT(Gender)),'%') AS Female_Percentage
FROM employees
GROUP BY Recruitment_Channel;

## Synopsis of Gender Diversity Check
-- Province_4 is contributing higher towards imbalance with Male as 77% and rest female of 23%, followed by Province_3.
-- Region_34 has an imbalance with 92% male and 8% female, followed by Region_9 with 89% male and 11% female. Other regions like Region_29 and Region_33 also show high imbalance.
-- All age groups are having gender imbalance between male and female.
-- R&D Department has 95% male, while other departments also show imbalance. The Procurement Department, however, approaches balance with 55% male and 45% female.
-- Males are preferred in hiring across all channels, including sourcing, which should not be the case within the company itself.
-- Effective diversity strategies are needed to ensure gender balance across the company.
-- The company should target more female candidates to improve diversity. 
-- Recruiters & HR's should properly strategize their plans for effective hiring for maintaning diversity.
-- If incase Recruiters or other channels are unable to find the right fit among women's, then HR could consider women with career gaps or those seeking remote roles.
-- These adjustments can help the company achieve better gender diversity. 

## Performance Analysis

-- How many employees got more than average ratings in the previous year ?
SELECT COUNT(*) as emp_count,
		CONCAT(ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM employees)),'%') AS percentage
FROM employees
WHERE Previous_Year_Rating > (SELECT AVG(Previous_Year_Rating) FROM employees);

-- What is the average number of trainings happening for each employees ?
SELECT AVG(Training_Count) AS overall_avg
FROM employees;

-- Which department received the lowest average performance rating ?
SELECT d.Dept_Name,
	   ROUND(AVG(e.Previous_Year_Rating),1) AS avg_rating
FROM employees AS e
JOIN departments AS d
ON e.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name
ORDER BY avg_rating;

-- How overall average performance rating is fluctuating across different departments and gender ?
SELECT d.Dept_Name,
        ROUND(AVG(CASE WHEN e.Gender = 'Male' THEN e.Previous_Year_Rating END),1) AS Male_avg_rating,
        ROUND(AVG(CASE WHEN e.Gender = 'Female' THEN e.Previous_Year_Rating END),1) AS Female_avg_rating
FROM employees AS e
JOIN departments AS d
ON e.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name;

-- Did male employees are getting less average training score than females across all departments ?
SELECT d.Dept_Name,
        ROUND(AVG(CASE WHEN e.Gender = 'Male' THEN e.Avg_Training_Score END)) AS Male_overall_avg_training_score,
        ROUND(AVG(CASE WHEN e.Gender = 'Female' THEN e.Avg_Training_Score END)) AS Femle_overall_avg_training_score
FROM employees AS e
JOIN departments AS d
ON e.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name;

-- Did males attending less than 2 training session across all departments ?
SELECT d.Dept_Name,
        ROUND(COUNT(CASE WHEN e.Gender = 'Male' THEN e.Training_Count END)) AS Male_training_count,
        ROUND(COUNT(CASE WHEN e.Gender = 'Female' THEN e.Training_Count END)) AS Female_training_count
FROM employees AS e
JOIN departments AS d
ON e.Dept_ID = d.Dept_ID
WHERE e.training_count < 2
GROUP BY d.Dept_Name;

-- How service length is impacting average performance rating ? 
SELECT Service_Length,
		ROUND(AVG(Previous_Year_Rating),2) AS avg_rating
FROM employees
GROUP BY Service_Length;

-- What is the impact of average training score on Previous Year Rating ? 
SELECT Previous_Year_Rating,
		ROUND(AVG(Avg_Training_Score),1) AS avg_score
FROM employees
GROUP BY Previous_Year_Rating;

-- What is the relationship between number of trainings and performance rating ?
SELECT Training_Count,
	   ROUND(AVG(Previous_Year_Rating),2) AS avg_rating
FROM employees
GROUP BY Training_Count;

-- What is the performance across different age groups in the previous year ?
SELECT Age_Group,
		ROUND(AVG(Previous_Year_Rating),2) AS avg_rating
FROM employees
GROUP BY Age_Group;

-- How effective are recruitment channels in relation to performance ratings ?
SELECT Recruitment_Channel,
		ROUND(AVG(Previous_Year_Rating),1) AS avg_rating
FROM employees
GROUP BY Recruitment_Channel;

-- How does the number of awards won vary across different departments ?
SELECT d.Dept_Name,
	   COUNT(e.Awards_Won) AS awards_count
FROM Employees AS e
JOIN Departments AS d
ON e.Dept_ID = d.Dept_ID
WHERE e.Awards_Won = 'Yes'
GROUP BY d.Dept_Name
ORDER BY awards_count DESC;


## Synopsis of Performance Analysis
-- Only 44% of employees perform above average; the rest are average or below.
-- On an average 1.25, likely 1-2 trainings are happening for each employee. 
-- Operations, R&D, Finance, and HR are above the 3.4 average in terms of performance rating.
-- Sales & Marketing Dept is the worst performer in terms of previous year rating by 3.1 as average, followed by technology as second worst and procurement at third. 
-- If sales team itself are having bad performance then it would be a severe hit in the revenue as well, which would not be a good sign for the company.
-- Interestingly, across all the departments, females are performing good as compared to males.
-- Sales Dept is having 81% male employees and only 19% females still both are having 3.1 as average performance ratings.
-- Similarly, R&D department having 95% male employees and only 5% females but females are out performing them by 4.1 average rating and males got 3.7.
-- These scenarios are again indicating that gender diversity matters for the company for proper balance throughout.
-- Both male and females are getting equal average training score across all departments. 
-- Interestingly, males and female of all department is scoring equal overall average training score, but still differ in performance rating at work.
-- Highly possible to say, this could be result of not a proper implementation of trainings during work by males which leads to poor performance. 
-- Also possible that biasness might be there in the departments especially among males through their manager. A proper check by the management is required here.
-- Majority employees are just attending 1 training, which could be a factor for lower performance. 
-- Interestingly, Males from sales department are the highest, those are just attending 1 training. 
-- Hence it is possible to say, at least 2 trainings sales dept is needed to improve.
-- Performance improves with service length, with some dips; experienced employees generally perform better.
-- After 3 trainings (avg. 3.16), ratings dip at four (2.8) and beyond, suggesting three trainings as optimal.
-- This makes sense as more trainings would ultimately impact the working of the employees because of their pre-occupiedness in their training sessions only.
-- Performance increases with age, indicating experience contributes to better outcomes. 
-- Employees hired through references perform above average, those via sourcing are average, and those from other channels fall below average. 
-- The company can improve by implementing checks on all channels for quality hires. 
-- Despite the lowest performance ratings, Sales & Marketing received the most awards (100), while high-performing R&D received only 5. 
-- To maintain motivation, awards should be fairly distributed across all departments, not focused solely on Sales for revenue.

                 