/* EDA in SQL */

Select * 
From ShoppingTrends.dbo.shopping_trends_updated

/* See the most popular items */ 
SELECT Item_Purchased, COUNT(*) AS num_purchases
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Item_Purchased
ORDER BY num_purchases DESC;

/* Sales analysis by category */ 

SELECT Category, SUM(Purchase_Amount_USD) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY category
ORDER BY total_sales DESC;

/* Sales analysis by location*/ 

SELECT Location, SUM(Purchase_Amount_USD) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Location
ORDER BY total_sales DESC;

/* Sales analysis by gender*/ 

SELECT Gender, SUM(Purchase_Amount_USD) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Gender
ORDER BY total_sales DESC;


/*Sales analysis by age range*/
select SUM(Purchase_Amount_USD) from shopping_trends_updated

ALTER TABLE shopping_trends_updated  ADD Purchase_Amount DECIMAL(10,2);

UPDATE shopping_trends_updated SET Purchase_Amount = Purchase_Amount_USD;

select Sum([Purchase_Amount]) from shopping_trends_updated

SELECT age_range, Sum([Purchase_Amount]) AS total_sales
FROM (
  SELECT
    CASE
      WHEN Age >= 18 AND Age < 25 THEN '18-24'
      WHEN Age >= 25 AND Age < 35 THEN '25-34'
      WHEN Age >= 35 AND Age < 45 THEN '35-44'
      WHEN Age >= 45 AND Age < 65 THEN '45-64'
      WHEN Age >= 65 THEN '65+'
    END AS age_range
  FROM ShoppingTrends.dbo.shopping_trends_updated
) AS age_ranges
GROUP BY age_range
ORDER BY total_sales DESC;

/*Sales analysis by rating*/

SELECT Review_rating, SUM([Purchase_Amount]) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Review_rating
ORDER BY Review_rating DESC;

/*Sales analysis by Subscription_Status*/

SELECT Subscription_Status, SUM([Purchase_Amount]) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Subscription_Status
ORDER BY total_sales DESC;

/*Sales analysis by shipping type*/

SELECT Shipping_Type, SUM([Purchase_Amount]) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY Shipping_Type
ORDER BY total_sales DESC;

/*Sales analysis by discount occurs*/

SELECT [Discount_Applied], SUM([Purchase_Amount]) AS total_sales
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY [Discount_Applied]
ORDER BY total_sales DESC;


/*Analyze customer lifetime value (CLV)*/

SELECT
  [Customer_ID],
  AVG([Purchase_Amount_USD]) AS average_purchase_amount,
  COUNT(*) AS purchase_frequency,
  0.2 AS churn_rate,
  (AVG([Purchase_Amount_USD]) * COUNT(*) / 0.2) AS CLV
FROM ShoppingTrends.dbo.shopping_trends_updated
GROUP BY [Customer_ID]
ORDER BY CLV DESC;
