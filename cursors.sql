use Trabalho_BD;
DECLARE @ID INT;

DECLARE cursor_product CURSOR
FOR SELECT 
        Cd_Produto
    FROM 
        PRODUTO;

OPEN cursor_product;

FETCH FROM cursor_product INTO @ID; 

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM cursor_product INTO @ID;
    PRINT @ID;
END

CLOSE cursor_product;

DEALLOCATE cursor_product;
GO