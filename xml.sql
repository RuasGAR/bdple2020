--Criar uma coluna XML, inserir dados e logo depois consultá-los

-- ALTERAR CAMINHO DO DISCO!

-- Inserção

UPDATE NOTA_FISCAL
SET Ds_XML = (
    SELECT * FROM OPENROWSET(  
        BULK 'D:/home/ruas/Área de Trabalho/Faculdade/Banco de Dados/trabalhoBD/test_xml.xml',  
        SINGLE_BLOB) AS x
    ) 
WHERE Cd_Nota_Fiscal = 1;  

-- Seleção
SELECT Ds_XML FROM NOTA_FISCAL WHERE Cd_Nota_Fiscal = 1;

