-- Step 1: Aggregate monthly revenue
WITH MonthlyRevenue AS (
    SELECT 
        FORMAT(created_at, 'yyyy-MM') AS year_month,
        SUM(value) AS total_revenue
    FROM sf_transactions
    GROUP BY FORMAT(created_at, 'yyyy-MM')
),

-- Step 2: Calculate previous month's revenue using LAG
RevenueChange AS (
    SELECT 
        year_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY year_month) AS previous_revenue
    FROM MonthlyRevenue
)

-- Step 3: Calculate MoM percentage change
SELECT 
    year_month,
    ROUND(
        CASE 
            WHEN previous_revenue IS NULL THEN NULL
            ELSE ((total_revenue - previous_revenue) * 100.0 / previous_revenue)
        END, 2
    ) AS percentage_change
FROM RevenueChange
ORDER BY year_month;
