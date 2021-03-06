
-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [PRODUTO]
DROP TABLE IF EXISTS PESSOA_JURIDICA;--
DROP TABLE IF EXISTS PESSOA_FISICA;--
DROP TABLE IF EXISTS NOTA_PRODUTO;--
DROP TABLE IF EXISTS PRODUTO;--
DROP TABLE IF EXISTS TRANSPORTE;--
DROP TABLE IF EXISTS TRANSPORTADOR; --
DROP TABLE IF EXISTS DUPLICATA; --
DROP TABLE IF EXISTS NOTA_FISCAL;--
DROP TABLE IF EXISTS DESTINATARIO_REMETENTE;--
DROP TABLE IF EXISTS USUARIO; --
DROP TABLE IF EXISTS ENDERECO; --
DROP VIEW IF EXISTS CLIENTE_DUPLICATA_VENCIDA;

CREATE TABLE [PRODUTO]
(
 [Cd_Produto]   integer NOT NULL ,
 [DS_Descricao] varchar(280) NULL ,
 [Nm_Unid]      CHAR(100) NOT NULL ,
 [Nm_Valor]     integer NOT NULL ,


 CONSTRAINT [Cd_Produto] PRIMARY KEY ([Cd_Produto] ASC)
);
GO








-- ************************************** [ENDERECO]

CREATE TABLE [ENDERECO]
(
 [Cd_Endereco]    integer NOT NULL ,
 [Nu_Numero]      integer NULL ,
 [Nu_Complemento] char(100) NULL ,
 [Nu_CEP]         char(8) NULL ,


 CONSTRAINT [PK_ENDERECO] PRIMARY KEY NONCLUSTERED ([Cd_Endereco] ASC)
);
GO








-- ************************************** [USUARIO]

CREATE TABLE [USUARIO]
(
 [Cd_Usuario]  integer NOT NULL ,
 [Cd_Endereco] integer NOT NULL ,


 CONSTRAINT [PK_USUARIO] PRIMARY KEY NONCLUSTERED ([Cd_Usuario] ASC),
 CONSTRAINT [FK_82] FOREIGN KEY ([Cd_Endereco])  REFERENCES [ENDERECO]([Cd_Endereco])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_82] ON [USUARIO] 
 (
  [Cd_Endereco] ASC
 )

GO







-- ************************************** [TRANSPORTADOR]

CREATE TABLE [TRANSPORTADOR]
(
 [Ds_Marca]   varchar(30) NULL ,
 [Cd_Placa]   char(7) NULL ,
 [Ds_Especie] varchar(30) NULL ,
 [Cd_Numero]  integer NULL ,
 [Cd_Usuario] integer NOT NULL ,


 CONSTRAINT [PK_TRANSPORTADOR] PRIMARY KEY NONCLUSTERED ([Cd_Usuario] ASC),
 CONSTRAINT [FK_76] FOREIGN KEY ([Cd_Usuario])  REFERENCES [USUARIO]([Cd_Usuario])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_76] ON [TRANSPORTADOR] 
 (
  [Cd_Usuario] ASC
 )

GO







-- ************************************** [PESSOA_JURIDICA]

CREATE TABLE [PESSOA_JURIDICA]
(
 [Nu_CNPJ]         char(15) NULL ,
 [Nm_Razao_Social] char(255) NULL ,
 [Cd_Usuario]      integer NOT NULL ,


 CONSTRAINT [PK_PESSOA_JURIDICA] PRIMARY KEY NONCLUSTERED ([Cd_Usuario] ASC),
 CONSTRAINT [FK_70] FOREIGN KEY ([Cd_Usuario])  REFERENCES [USUARIO]([Cd_Usuario])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_70] ON [PESSOA_JURIDICA] 
 (
  [Cd_Usuario] ASC
 )

GO







-- ************************************** [PESSOA_FISICA]

CREATE TABLE [PESSOA_FISICA]
(
 [Nu_CPF]     char(11) NULL ,
 [Nm_Nome]    char(255) NULL ,
 [Cd_Usuario] integer NOT NULL ,


 CONSTRAINT [PK_PESSOA_FISICA] PRIMARY KEY NONCLUSTERED ([Cd_Usuario] ASC),
 CONSTRAINT [FK_67] FOREIGN KEY ([Cd_Usuario])  REFERENCES [USUARIO]([Cd_Usuario])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_67] ON [PESSOA_FISICA] 
 (
  [Cd_Usuario] ASC
 )

GO







-- ************************************** [DESTINATARIO_REMETENTE]

CREATE TABLE [DESTINATARIO_REMETENTE]
(
 [Nu_Fone_FAX]           char(100) NULL ,
 [Nu_Inscricao_Estadual] char(9) NULL ,
 [Cd_Usuario]            integer NOT NULL ,


 CONSTRAINT [PK_DESTINATARIO_REMETENTE] PRIMARY KEY NONCLUSTERED ([Cd_Usuario] ASC),
 CONSTRAINT [FK_73] FOREIGN KEY ([Cd_Usuario])  REFERENCES [USUARIO]([Cd_Usuario])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_73] ON [DESTINATARIO_REMETENTE] 
 (
  [Cd_Usuario] ASC
 )

GO







-- ************************************** [NOTA_FISCAL]

CREATE TABLE [NOTA_FISCAL]
(
 [Cd_Nota_Fiscal]        integer NOT NULL ,
 [Ds_Natureza_Operacao]  varchar(200) NULL ,
 [Nu_CFOP]               char(4) NULL ,
 [Nu_IEST]               char(14) NULL ,
 [Nu_Inscricao_Estadual] char(9) NULL ,
 [Ic_Saida_Entrada]      bit NULL ,
 [Dt_Data_de_Emissao]    datetime NULL ,
 [Ds_Dados_Adicionais]   varchar(max) NULL ,
 [Cd_Usuario]            integer NOT NULL ,
 [Cd_Remetente] integer NOT NULL ,

 CONSTRAINT [PK_NOTA_FISCAL] PRIMARY KEY NONCLUSTERED ([Cd_Nota_Fiscal] ASC),
 CONSTRAINT [FK_101] FOREIGN KEY ([Cd_Remetente])  REFERENCES [DESTINATARIO_REMETENTE]([Cd_Usuario]),
 CONSTRAINT [FK_85] FOREIGN KEY ([Cd_Usuario])  REFERENCES [USUARIO]([Cd_Usuario])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_101] ON [NOTA_FISCAL] 
 (
  [Cd_Usuario] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_85] ON [NOTA_FISCAL] 
 (
  [Cd_Usuario] ASC
 )

GO







-- ************************************** [TRANSPORTE]

CREATE TABLE [TRANSPORTE]
(
 [Cd_Nota_Fiscal]        integer NOT NULL ,
 [Dt_DATA_SAIDA_ENTRADA] datetime NULL ,
 [Nm_Frete_Conta]        integer NULL ,
 [Cd_Transportador]      integer NOT NULL ,

 CONSTRAINT [PK_TRANSPORTE] PRIMARY KEY NONCLUSTERED ([Cd_Nota_Fiscal] ASC),
 CONSTRAINT [FK_88] FOREIGN KEY ([Cd_Transportador])  REFERENCES [TRANSPORTADOR]([Cd_Usuario]),
 CONSTRAINT [FK_98] FOREIGN KEY ([Cd_Nota_Fiscal])  REFERENCES [NOTA_FISCAL]([Cd_Nota_Fiscal])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_88] ON [TRANSPORTE] 
 (
  [Cd_Transportador] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_98] ON [TRANSPORTE] 
 (
  [Cd_Nota_Fiscal] ASC
 )

GO







-- ************************************** [NOTA_PRODUTO]

CREATE TABLE [NOTA_PRODUTO]
(
 [Cd_Nota_Fiscal] integer NOT NULL ,
 [Cd_Produto]     integer NOT NULL ,
 [Cd_Sit_Trib]    char(2) NULL ,
 [PC_ICMS]        integer NULL ,
 [Ps_Liquido]     integer NULL ,
 [Ps_Bruto]       integer NULL ,


 CONSTRAINT [Cd_Nota_Fiscal] PRIMARY KEY NONCLUSTERED ([Cd_Nota_Fiscal] ASC, [Cd_Produto] ASC),
 CONSTRAINT [FK_91] FOREIGN KEY ([Cd_Nota_Fiscal])  REFERENCES [NOTA_FISCAL]([Cd_Nota_Fiscal]),
 CONSTRAINT [FK_95] FOREIGN KEY ([Cd_Produto])  REFERENCES [PRODUTO]([Cd_Produto])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_91] ON [NOTA_PRODUTO] 
 (
  [Cd_Nota_Fiscal] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_95] ON [NOTA_PRODUTO] 
 (
  [Cd_Produto] ASC
 )

GO



CREATE TABLE DUPLICATA (
    [Cd_Nota_Fiscal] integer NOT NULL ,
    Nm_valor integer NOT NULL,
    Dt_Vencimento DATETIME NOT NULL,
    Dt_Pagamento DATETIME NULL,
    PRIMARY KEY NONCLUSTERED (Cd_Nota_Fiscal ASC, Nm_valor ASC, Dt_Vencimento ASC),
    CONSTRAINT FK_DUPLICATA_NOTA_FISCAL FOREIGN KEY ([Cd_Nota_Fiscal])  REFERENCES [NOTA_FISCAL]([Cd_Nota_Fiscal])
);
GO

CREATE VIEW CLIENTE_DUPLICATA_VENCIDA
AS 
SELECT U.Cd_Usuario, U.Cd_Endereco
from USUARIO as U
JOIN NOTA_FISCAL AS NF ON NF.Cd_Usuario=U.Cd_Usuario JOIN DUPLICATA AS D ON NF.Cd_Nota_Fiscal=D.Cd_Nota_Fiscal
WHERE (D.Dt_Pagamento Is NULL) AND (D.Dt_Vencimento < GETDATE());
GO



