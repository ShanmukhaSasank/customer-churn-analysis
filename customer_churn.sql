--Q1. What percentage of customers are churning?
SELECT ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer;

--Q2. How many customers have churned vs retained?
SELECT churn,COUNT(*) AS customer_count,ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM churn_customer
GROUP BY churn;

--Q3. Which tenure group has the highest churn rate?
SELECT tenure_group,COUNT(*) AS total_customers,ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY tenure_group
ORDER BY churn_rate_percentage DESC;

--Q4: Do customers with longer tenure churn less?
SELECT tenure_group, COUNT(*) AS total_customers, ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY tenure_group
ORDER BY tenure_group;

--Q5: Which contract type has the highest churn rate?
SELECT contract, COUNT(*) AS total_customers, ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

--Q6. Does payment method influence customer churn?
SELECT paymentmethod, COUNT(*) AS total_customers, ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY paymentmethod
ORDER BY churn_rate_percentage DESC;

--Q7. Are senior citizens more likely to churn?
SELECT seniorcitizen, COUNT(*) AS total_customers, ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY seniorcitizen
ORDER BY churn_rate_percentage DESC;

--Q8. How much total revenue is lost due to churn?
SELECT ROUND(SUM(totalcharges)::numeric, 2) AS total_revenue_lost
FROM churn_customer
WHERE churn = 'Yes';

--Q9. What is the average revenue per churned customer?
SELECT ROUND(AVG(totalcharges)::numeric, 2) AS avg_revenue_per_churned_customer
FROM churn_customer
WHERE churn = 'Yes';

--Q10. Are high-value customers churning at a significant rate?
SELECT customer_value,COUNT(*) AS total_customers,ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY customer_value
ORDER BY churn_rate_percentage DESC;

--Q11. Which customer segments represent the highest churn risk?
SELECT tenure_group,contract,paymentmethod,
COUNT(*) AS total_customers,ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY tenure_group, contract, paymentmethod
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;

--Q12. Which combination of factors leads to the highest churn?
SELECT tenure_group,contract,customer_value,
COUNT(*) AS total_customers,ROUND(AVG(churn_flag)::numeric * 100, 2) AS churn_rate_percentage
FROM churn_customer
GROUP BY tenure_group, contract, customer_value
HAVING COUNT(*) >= 50
ORDER BY churn_rate_percentage DESC;