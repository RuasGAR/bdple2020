CREATE TRIGGER tr_update_date_pagamento 
ON NOTA_FISCAL
FOR UPDATE AS
BEGIN
    DECLARE @date DATETIME;
    DECLARE @new_value INTEGER;
    DECLARE @old_value INTEGER;
    DECLARE @id INT;
    
    SELECT @new_value = Nu_Valor_Total FROM inserted;
    SELECT @old_value = Nu_Valor_Total FROM deleted;
    SELECT @id = Cd_Nota_Fiscal FROM deleted;
    SET @date = getdate();  

    IF(@new_value != @old_value)
        UPDATE NOTA_FISCAL 
        SET Dt_Data_de_Emissao = @date,
            Dt_Data_de_Pagamento = DATEADD(day, 2, @date) -- Adiciona dois dias à data de pagamento
        WHERE Cd_Nota_Fiscal = @id;    
END

--Testes

/* SELECT Dt_Data_de_Pagamento, Dt_Data_de_Emissao, Nu_Valor_Total FROM NOTA_FISCAL WHERE Cd_Nota_Fiscal = 1;

UPDATE NOTA_FISCAL
SET Nu_Valor_Total = 39011
WHERE Cd_Nota_Fiscal = 1; */
