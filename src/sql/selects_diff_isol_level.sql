-- Запросы с разными уровнями изоляции
-- Выполнялись построчно 
-- В другой сессии при этом частями отрабатывалиь скрипты из transaction2.sql
BEGIN TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 SELECT * FROM 	ACCOUNTS WHERE ACCOUNTID = 2;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2;
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2 FOR UPDATE;-- после commit в другой сессии выдавал "ERROR:  не удалось сериализовать доступ из-за параллельного изменения "
ROLLBACK;