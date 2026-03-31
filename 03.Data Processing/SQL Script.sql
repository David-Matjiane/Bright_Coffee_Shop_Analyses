

--------------------------------------------------------------------------------
-------------------BRIGHT COFFEE SHOP ANALYSES----------------------------------
SELECT transaction_date,
----Converting Transection_Date and Transection_time  to userfriendly for,at
       DAYNAME(transaction_date) AS day_name,
       CASE 
            WHEN  DAYNAME(transaction_date) IN ('Sun','Sat') THEN 'weekend'
            ELSE 'weekday'
            END AS day_classification,
       DAYOFMONTH (transaction_date) AS day_of_month,
       MONTHNAME(transaction_date) AS month_name,
       DATE_FORMAT(transaction_time,'HH:mm:ss') AS purchase_time,
-----creating time buckets using DATE_FORMAT (we can't aliases name within the case statement)
          CASE
                WHEN DATE_FORMAT(transaction_time,'HH:mm:ss')  BETWEEN '00:00:00' AND '11:59:59' THEN '1.Morning'
                WHEN DATE_FORMAT(transaction_time,'HH:mm:ss')  BETWEEN '12:00:00' AND '16:59:59' THEN '2.Afternoon'
                ELSE '3.Evening'
          END AS time_buckets,
-----adding all Categorical Columns to the final table
       store_location,
       product_category,
       product_type,
       product_detail,
-----Performing count on id's
       COUNT (DISTINCT transaction_id) AS number_of_sales,
       COUNT (DISTINCT product_id) AS number_of_Products,
       COUNT (DISTINCT store_id) AS number_of_stores,
       SUM(transaction_qty*unit_price)AS revenue_per_day

FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`

GROUP BY 
         transaction_date,
         day_name,
         month_name,
         purchase_time,
         time_buckets,
         store_location,
         product_category,
         product_type,
         product_detail, 
         day_classification,
         time_buckets;
