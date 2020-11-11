CREATE TRIGGER tr_update_date_pagamento 
ON DUPLICATA
FOR UPDATE AS
BEGIN
    DECLARE @date DATETIME;
    DECLARE @new_value INTEGER;
    DECLARE @old_value INTEGER;
    DECLARE @id INTEGER;
    
    SELECT @new_value = Nm_valor FROM inserted;
    SELECT @old_value = Nm_valor FROM deleted;
    SELECT @id = Cd_Nota_Fiscal FROM deleted;
    SET @date = getdate();  

    IF(@new_value != @old_value)
        UPDATE DUPLICATA 
        SET Dt_Vencimento = DATEADD(day, 2, @date),
            Dt_Pagamento = DATEADD(day, 2, @date) -- Adiciona dois dias à data de pagamento
        WHERE Cd_Nota_Fiscal = @id;    
END

--Testes

/* SELECT Dt_Vencimento, Dt_Pagamento FROM DUPLICATA WHERE Cd_Nota_Fiscal = 4;

UPDATE DUPLICATA
SET Nm_valor = 1
WHERE Cd_Nota_Fiscal = 4;

SELECT Dt_Vencimento, Dt_Pagamento FROM DUPLICATA WHERE Cd_Nota_Fiscal = 4; */
