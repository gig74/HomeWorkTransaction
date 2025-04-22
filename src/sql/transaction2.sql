-- Транзакция 2: Снятие средств со счета №2. Уменьшите баланс на счете №2 на 300.
-- Добавьте запись в таблицу Transactions с типом "Withdrawal" и суммой 300 для счета
BEGIN;
  UPDATE ACCOUNTS SET BALANCE = BALANCE - 300 WHERE ACCOUNTID = 2 ;
  INSERT INTO TRANSACTIONS(ACCOUNTID,TRANSACTIONTYPE,AMOUNT,TRANSACTIONDATE) VALUES(2,'Withdrawal',300,CURRENT_TIMESTAMP);
COMMIT;