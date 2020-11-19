--Criar uma coluna XML, inserir dados e logo depois consultá-los

-- ALTERAR CAMINHO DO DISCO!

-- Inserção

ALTER TABLE NOTA_FISCAL ADD Ds_XML XML;

INSERT INTO NOTA_FISCAL
VALUES(6,'NATUREZA','000','00','00000',0,'2007-05-08 12:35:29.123','Estamos aqui',1,1,
    (
        SELECT * FROM OPENROWSET(  
            BULK 'caminho',  
            SINGLE_BLOB) AS x
    )) 

-- Seleção
SELECT Ds_XML FROM NOTA_FISCAL WHERE Cd_Nota_Fiscal = 6; 

