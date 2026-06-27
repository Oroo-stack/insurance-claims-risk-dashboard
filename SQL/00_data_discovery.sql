/* 
  Objective: Scan the system metadata to find table layouts and check row samples.
  Target: Identify column details and visual data patterns directly inside the warehouse.
*/

-- Step 1: Query system metadata to see column names, data types, and null rules
SELECT 
  table_name, 
  column_name, 
  data_type, 
  is_nullable
FROM 
  `insurance-claims-risk-dash.auto_insurance_claims.INFORMATION_SCHEMA.COLUMNS`
WHERE 
  table_name IN ('raw_auto_claims', 'raw_medical_claims')
ORDER BY 
  table_name, 
  ordinal_position;

-- Step 2: Extract a randomized row sample to inspect actual data layouts 
-- Using RAND() mixes up the data rows so we can catch hidden formatting errors
SELECT * 
FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims` 
ORDER BY RAND() 
LIMIT 10;
