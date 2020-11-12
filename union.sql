USE Trabalho_BD;

--INSERT INTO DUPLICATA
--VALUES (5,300,'2020-10-14 12:35:29.123',NULL);
--INSERT INTO DUPLICATA
--VALUES (5,300,'2020-12-11 12:35:29.123',NULL);

SELECT * from DUPLICATA
WHERE DATEDIFF(day,GETDATE(),Dt_Vencimento)<=30 and DATEDIFF(day,GETDATE(),Dt_Vencimento)>=0
UNION
SELECT * from DUPLICATA
WHERE (Dt_Pagamento is NULL) AND (DATEDIFF(day,Dt_Vencimento,GETDATE())<=30) AND (DATEDIFF(day,Dt_Vencimento,GETDATE())>=0); 