USE [ControleEstoque]
GO
/****** Object:  Trigger [dbo].[utrEstoqueVenda]    Script Date: 13/11/2015 22:44:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[utrEstoqueVenda]
ON [dbo].[tblEstoque]
AFTER UPDATE
AS
BEGIN
	DECLARE
		@NumLote AS INT,
		@Descricao AS VARCHAR(50),
		@QtdeInserida AS INT,
		@QtdeRetirada AS INT,
		@PrecoUnit AS DECIMAL(18,2),
		@DataEntrada AS DATETIME

	SELECT
		@NumLote = NumLote,
		@Descricao = Descricao,
		@QtdeInserida = Qtde,
		@PrecoUnit = PrecoUnit,
		@DataEntrada = DataEntrada
	FROM
		INSERTED

	SELECT
		@QtdeRetirada = Qtde
	FROM
		DELETED

	--INSERT INTO tblPEPS
	--(
	--	idMovimentacao,
	--	NumLote,
	--	Descricao,
	--	Qtde,
	--	PrecoUnit,
	--	DataEntrada,
	--	DataSaida,
	--	Subtotal
	--)
	--VALUES
	--(
	--	2,
	--	@NumLote,
	--	@Descricao,
	--	@QtdeRetirada - @QtdeInserida,
	--	@PrecoUnit,
	--	@DataEntrada,
	--	GETDATE(),
	--	(@QtdeRetirada - @QtdeInserida) * @PrecoUnit 
	--)
END