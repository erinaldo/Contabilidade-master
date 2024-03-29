USE [ControleEstoque]
GO
/****** Object:  Trigger [dbo].[utrEstoqueVendaTeste]    Script Date: 13/11/2015 16:52:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[utrEstoqueVendaTeste]
ON [dbo].[tblPEPS]
AFTER UPDATE
AS
BEGIN
	DECLARE
		@idMovimentacao AS INT,
		@NumLote AS INT,
		@Descricao AS VARCHAR(50),
		@QtdeAntes AS INT,
		@QtdeDepois AS INT,
		@PrecoUnit AS DECIMAL(18,2),
		@DataEntrada AS DATETIME

		SELECT
			@QtdeAntes = Qtde,
			@idMovimentacao = idMovimentacao,
			@NumLote = NumLote,
			@Descricao	= Descricao,
			@QtdeAntes = Qtde,
			@PrecoUnit = PrecoUnit, 
			@DataEntrada = DataEntrada
		FROM
			DELETED

		SELECT
		--	@idMovimentacao = idMovimentacao,
		--	@NumLote = NumLote,
		--	@Descricao	= Descricao,
		@QtdeDepois = Qtde
		--	@PrecoUnit = PrecoUnit, 
		--	@DataEntrada = DataEntrada
		FROM
			INSERTED


		INSERT INTO tblPEPS
		(
			idMovimentacao,
			NumLote,
			Descricao,
			Qtde,
			PrecoUnit,
			DataEntrada,
			DataSaida,
			Subtotal
		)
		VALUES
		(
			2,
			@NumLote,
			@Descricao,
			@QtdeAntes - @QtdeDepois,
			@PrecoUnit,
			@DataEntrada,
			GETDATE(),
			(@QtdeAntes - @QtdeDepois) * @PrecoUnit
		)
END
