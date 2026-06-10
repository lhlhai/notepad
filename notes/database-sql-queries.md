# 🗄️ Database & SQL Queries

## 1. Oracle
### Get latest change SCN
```sql
SELECT MAX(ORA_ROWSCN) FROM your_table WHERE ...;
```

### Count tables/views by schema
```sql
-- Tables theo schema
SELECT COUNT(*) 
FROM all_tables 
WHERE owner = 'schema';

-- Views theo schema
SELECT COUNT(*) 
FROM all_views 
WHERE owner = 'schema';
```

## 2. SAP / HANA SQL
### Get Active Plant & Cost Center
```sql
SELECT SAP_PLANT_CODE, COST_CENTER 
FROM MARD_WERBI.V_GB_PLANT_COSTCENTER_ACTIVE 
WHERE ACTIVE_FLAG_PLANT = 'X' 
  AND ACTIVE_FLAG_CC = 'X' 
GROUP BY SAP_PLANT_CODE, COST_CENTER;
```