UPDATE "Banks"
SET expiry = '09/30'
WHERE name = 'yriy';

SELECT role, COUNT(*) AS user_count
FROM "Users"
WHERE role IN ('creator', 'customer')
GROUP BY role;
