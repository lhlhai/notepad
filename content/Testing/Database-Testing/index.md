---
title: "💾 Database Testing"
description: "Tài nguyên và snippets cho database testing, bao gồm SQL queries, validation techniques và best practices."
---

# 💾 Database Testing Resources

Chào mừng bạn đến với thư mục Database Testing - nơi cung cấp các tài nguyên, SQL snippets và kỹ thuật kiểm thử cơ sở dữ liệu.

## 📂 Nội dung chính

### [📜 SQL Snippets](./SQL-Snippets.md)
Bộ sưu tập các SQL queries thường dùng trong testing:
*   **Data Validation**: Kiểm tra tính toàn vẹn dữ liệu
*   **Data Migration**: Verify data sau khi migrate
*   **Performance Queries**: Identify slow queries
*   **Test Data Setup**: Tạo và cleanup test data

## 🔍 Database Testing Types

### 1. Structural Testing
*   Schema validation (tables, columns, indexes)
*   Constraint verification (PK, FK, unique, check)
*   Trigger and stored procedure testing

### 2. Functional Testing
*   CRUD operations verification
*   Business logic in stored procedures
*   Data integrity across transactions

### 3. Non-Functional Testing
*   Performance under load
*   Connection pooling
*   Backup and recovery

## 🛠️ Common Test Scenarios

| Scenario | SQL Pattern | Purpose |
|----------|-------------|---------|
| **Count Verification** | `SELECT COUNT(*) FROM table` | Verify record counts match source |
| **Data Comparison** | `EXCEPT` / `MINUS` | Find differences between tables |
| **Null Check** | `WHERE column IS NULL` | Find unexpected nulls |
| **Duplicate Detection** | `GROUP BY ... HAVING COUNT > 1` | Find duplicate records |
| **Referential Integrity** | `LEFT JOIN ... WHERE IS NULL` | Find orphaned records |

## 📊 Validation Techniques

### 1. Source to Target Validation
```sql
-- Compare row counts
SELECT 'Source' AS src, COUNT(*) FROM source_table
UNION ALL
SELECT 'Target', COUNT(*) FROM target_table;

-- Find missing records
SELECT * FROM source_table s
LEFT JOIN target_table t ON s.id = t.id
WHERE t.id IS NULL;
```

### 2. Data Transformation Validation
```sql
-- Verify calculated fields
SELECT 
    price,
    quantity,
    total_amount,
    CASE 
        WHEN total_amount = price * quantity THEN 'OK'
        ELSE 'MISMATCH'
    END AS validation
FROM orders;
```

### 3. Boundary Value Testing
```sql
-- Find values at boundaries
SELECT * FROM products 
WHERE price IN (0, 999999.99, -1);

-- Check date ranges
SELECT * FROM events 
WHERE event_date < '2020-01-01' 
   OR event_date > DATEADD(year, 5, GETDATE());
```

## ⚠️ Common Issues to Check

1. **Data Truncation**: String length exceeds column size
2. **Precision Loss**: Decimal places rounded incorrectly
3. **Character Encoding**: Special characters corrupted
4. **Timezone Issues**: DateTime conversion errors
5. **Constraint Violations**: FK, unique, check constraints

## 🔧 Tools & Utilities

*   **DBeaver**: Universal database tool
*   **SQL Server Management Studio**: For SQL Server
*   **pgAdmin**: For PostgreSQL
*   **MySQL Workbench**: For MySQL
*   **DataGrip**: JetBrains database IDE

## 📝 Best Practices

### DO ✅
*   Use transactions for test data setup/cleanup
*   Test with production-like data volumes
*   Verify indexes are used in queries
*   Document expected data states
*   Use parameterized queries to prevent SQL injection

### DON'T ❌
*   Never test on production without backup
*   Avoid hardcoded values in test scripts
*   Don't skip negative test cases
*   Never ignore warning messages
*   Don't forget to test rollback scenarios

## 🔗 Tài nguyên liên quan

*   [SQL Queries](../../Database/SQL-Queries.md) - Additional SQL examples
*   [SQL Samples](../../Database/sql_samples.sql) - Comprehensive SQL samples
*   [API Testing](../API/Cheatsheet.md) - API + DB integration testing

---

> 💡 **Pro Tip**: Luôn verify data ở cả 3 lớp: Application → API → Database. Bugs thường xuất hiện ở gaps giữa các layers!
