// прочее
UPDATE "Banks"
SET expiry = '09/30'
WHERE name = 'yriy';

// подсчитать всех юзеров по ролям - 9 таска

SELECT role, COUNT(*) AS user_count
FROM "Users"
WHERE role IN ('creator', 'customer')
GROUP BY role;

// добавил всем кастомерам +10 на баланс = 10 таска

UPDATE "Users"
SET "balance" = "balance" + 10
WHERE "role" = 'customer';

// вывел баланс + кешбек кастомеров - 10 таска

SELECT
  "id",
  "firstName",
  "lastName",
  "displayName",
  "balance",
  ("balance" * 0.1 * COALESCE((SELECT COUNT(*) FROM "Contests" WHERE "userId" = "Users"."id" AND "createdAt" BETWEEN '2023-11-01' AND '2024-01-14'), 0)) AS "cashback"
FROM
  "Users"
WHERE
  "role" = 'customer';

// апдейт баланса (не выполнял) - 10 таска

UPDATE "Users"
SET "balance" = "balance" + ("balance" * 0.1 * COALESCE((SELECT COUNT(*) FROM "Contests" WHERE "userId" = "Users"."id" AND "createdAt" BETWEEN '2023-12-25' AND '2024-01-14'), 0));
WHERE "role" = 'customer';

// апдейт баланса топ3 creators на +10 долларов - 11 таска

UPDATE "Users"
SET "balance" = "balance" + 10
WHERE "id" IN (
  SELECT "id"
  FROM "Users"
  WHERE "role" = 'creator'
  ORDER BY "rating" DESC
  LIMIT 3
);



