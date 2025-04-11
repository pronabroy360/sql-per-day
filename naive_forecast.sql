WITH monthly_sums AS (
  -- Step 1: Sum the distance and monetary cost by month
  SELECT
    YEAR(request_date) AS year,
    MONTH(request_date) AS month,
    SUM(distance_to_travel) AS total_distance,
    SUM(monetary_cost) AS total_cost
  FROM
    uber_request_logs
  WHERE
    request_status = 'success'  -- Only considering successful requests
  GROUP BY
    YEAR(request_date),
    MONTH(request_date)
),
actual_values AS (
  -- Step 2: Calculate the actual 'distance per dollar' for each month
  SELECT
    year,
    month,
    total_distance / total_cost AS actual_value
  FROM
    monthly_sums
),
forecast_values AS (
  -- Step 3: Generate the forecast (using the previous month's actual value)
  SELECT
    year,
    month,
    LAG(actual_value) OVER (ORDER BY year, month) AS forecast_value
  FROM
    actual_values
)
-- Step 4: Calculate RMSE
SELECT
  ROUND(SQRT(AVG(POWER(actual_value - forecast_value, 2))), 2) AS RMSE
FROM
  actual_values
JOIN
  forecast_values
ON
  actual_values.year = forecast_values.year
  AND actual_values.month = forecast_values.month
WHERE
  forecast_value IS NOT NULL;  -- Exclude the first month as it has no forecast
