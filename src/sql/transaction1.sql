-- Транзакция 1:  Депозит на счет №1. Увеличьте баланс на счете №1 на 500. 
-- Добавьте запись в таблицу Transactions с типом "Deposit" и суммой 500 для счета №1.
BEGIN;
  UPDATE ACCOUNTS SET BALANCE = BALANCE + 500 WHERE ACCOUNTID = 1 ;
  INSERT INTO TRANSACTIONS(ACCOUNTID,TRANSACTIONTYPE,AMOUNT,TRANSACTIONDATE) VALUES(1,'Deposit',500,CURRENT_TIMESTAMP);
COMMIT;