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

// апдейт баланса - 10 таска

UPDATE "Users"
SET "balance" = "balance" + ("balance" * 0.1 * COALESCE((
  SELECT COUNT(*)
  FROM "Contests"
  WHERE "userId" = "Users"."id" AND "createdAt" BETWEEN '2023-12-25' AND '2024-01-14'
), 0))
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


// разработка чатов на sql - 8 таска

// Создание каталога и чатов внутри каждого каталога
CREATE TABLE "Catalog1" (
  id SERIAL PRIMARY KEY,
  "userId" INT NOT NULL,
  "catalogName" VARCHAR(255) NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY ("userId") REFERENCES "Users"(id)
);
DROP TABLE "Catalog1";

CREATE TABLE "CatalogChats1" (
  id SERIAL PRIMARY KEY,
  "catalogId" INT NOT NULL,
  "chatId" INT NOT NULL,
  CONSTRAINT fk_catalog FOREIGN KEY ("catalogId") REFERENCES "Catalog1"(id),
  CONSTRAINT fk_chat FOREIGN KEY ("chatId") REFERENCES "Conversation1"(id)
);
DROP TABLE "CatalogChats1";


// Создание конверсейшн
CREATE TABLE "Conversation1" (
  id SERIAL PRIMARY KEY,
  participants INT[] NOT NULL,
  "blackList" BOOLEAN[] NOT NULL,
  "favoriteList" BOOLEAN[] NOT NULL
);
DROP TABLE "Conversation1";

// Создание мессейджей
CREATE TABLE "Message1" (
  id SERIAL PRIMARY KEY,
  sender INT NOT NULL,
  body TEXT NOT NULL,
  "conversationId" INT NOT NULL,
  createdAt TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_sender FOREIGN KEY (sender) REFERENCES "Users"(id),
  CONSTRAINT fk_conversation FOREIGN KEY ("conversationId") REFERENCES "Conversation1"(id)
);
DROP TABLE "Message1";




