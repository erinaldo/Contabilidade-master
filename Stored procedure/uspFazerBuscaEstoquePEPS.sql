USE [ControleEstoque]
GO
/****** Object:  StoredProcedure [dbo].[uspFazerBuscaEstoquePEPS]    Script Date: 19/11/2015 11:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspFazerBuscaEstoquePEPS]
	@Parametro AS VARCHAR(10),
	@Coluna AS VARCHAR(50)
AS
BEGIN
	
	IF(@Coluna = 'Desc_Mov')
	BEGIN	
		SELECT
			Desc_Mov,
			NumLote,
			Descricao,
			Qtde,
			PrecoUnit,
			DataEntrada,
			DataSaida,
			Subtotal
		FROM
			uvwEstoquePEPSCarregar
		WHERE
			Desc_Mov LIKE '%'+@Parametro+'%' 
	END
	ELSE
	IF(@Coluna = 'NumLote')
	BEGIN	
		SELECT
			Desc_Mov,
			NumLote,
			Descricao,
			Qtde,
			PrecoUnit,
			DataEntrada,
			DataSaida,
			Subtotal
		FROM
			uvwEstoquePEPSCarregar
		WHERE
			NumLote LIKE '%'+@Parametro+'%' 
	END
	IF(@Coluna = 'Descricao')
	BEGIN	
		SELECT
			Desc_Mov,
			NumLote,
			Descricao,
			Qtde,
			PrecoUnit,
			DataEntrada,
			DataSaida,
			Subtotal
		FROM
			uvwEstoquePEPSCarregar
		WHERE
			Descricao LIKE '%'+@Parametro+'%' 
	END
END