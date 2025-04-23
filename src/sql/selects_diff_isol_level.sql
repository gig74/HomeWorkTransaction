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
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2 FOR UPDATE;-- после commit в другой сессии выдавал "ERROR:  не удалось сериализовать доступ из-за параллельного изменения ". Обрывает транзакцию, надо делать COMMIT или ROLLBACK .
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- то же, что и REPEATABLE READ, но теоретически дополнительно без фантомных чтений(считывание довставленных записей подхолящих под условие) и других аномалий
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2;
 SELECT * FROM ACCOUNTS WHERE ACCOUNTID = 2 FOR UPDATE;-- после commit в другой сессии выдавал "ERROR:  текущая транзакция прервана, команды до конца блока транзакции игнорируются". Обрывает транзакцию, надо делать COMMIT или ROLLBACK .
ROLLBACK;

/* Никакой разницы при вставке в другой транзакции с закоммичиванием - вставленную запись не видит, видимые строки благополучно блокирует. 
   В документации PostgreSQL по REPEATABLE READ написано, что у них этот уровень уже не допускает фантомных чтений. 
   Другие аномалии не знаю как воспроизвести. */
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
 SELECT * FROM TRANSACTIONS WHERE ACCOUNTID = 2;
 SELECT * FROM TRANSACTIONS WHERE ACCOUNTID = 2 FOR UPDATE;
ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
 SELECT * FROM TRANSACTIONS WHERE ACCOUNTID = 2;
 SELECT * FROM TRANSACTIONS WHERE ACCOUNTID = 2 FOR UPDATE;
ROLLBACK;
/*КОНЕЦ: Никакой разницы при вставке в другой транзакции с закоммичиванием - вставленную запись не видит, видимые строки благополучно блокирует */

COMMIT;