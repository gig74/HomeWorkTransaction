BEGIN;
  DELETE FROM ACCOUNTS;
  ALTER SEQUENCE accounts_accountid_seq RESTART WITH 1;
  ALTER SEQUENCE transactions_transactionid_seq RESTART WITH 1;
  INSERT INTO ACCOUNTS(ACCOUNTNUMBER,BALANCE) VALUES('ACCONT_1', 0);
  INSERT INTO ACCOUNTS(ACCOUNTNUMBER,BALANCE) VALUES('ACCONT_2', 1000);
COMMIT;