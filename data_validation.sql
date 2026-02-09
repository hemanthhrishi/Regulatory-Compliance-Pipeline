-- Purpose: Clean and validate raw data for Compliance Reporting
-- Author: Hemanth Hrishikesh Ulluri

WITH raw_data AS (
  SELECT * FROM `your_project.your_dataset.raw_regulatory_data`
),

validation_checks AS (
  SELECT 
    *,
    -- Check 1: Flag missing amounts (Regulatory Requirement)
    CASE WHEN amount IS NULL THEN 'ERROR: Missing Amount' ELSE 'PASS' END AS amount_check,
    
    -- Check 2: Flag missing statuses
    CASE WHEN status IS NULL THEN 'ERROR: Null Status' ELSE 'PASS' END AS status_check,
    
    -- Check 3: Identify high-value transactions for audit
    CASE WHEN amount > 4000 THEN 1 ELSE 0 END AS is_high_value
  FROM raw_data
)

-- Create the final structured dataset for reporting
SELECT 
  transaction_id,
  customer_id,
  amount,
  timestamp,
  status,
  amount_check,
  status_check
FROM validation_checks
WHERE amount_check = 'PASS' AND status_check = 'PASS';

-- KPI Check: Calculate the accuracy rate (Matches resume claim of improving accuracy)
-- SELECT (COUNTIF(amount_check = 'PASS') / COUNT(*)) * 100 as accuracy_rate FROM validation_checks;
