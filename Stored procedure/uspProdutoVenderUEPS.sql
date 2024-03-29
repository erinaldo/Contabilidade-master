USE [ControleEstoque]
GO
/****** Object:  StoredProcedure [dbo].[uspProdutoVenderUEPS]    Script Date: 21/11/2015 15:06:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspProdutoVenderUEPS]
	@Desc AS VARCHAR(50),
	@Qtde AS INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			DECLARE
				@QtdeEstoque AS INT,
				@IdMov AS INT,
				@PrecoUnit AS DECIMAL(18,2),
				@DataEntrada AS DATETIME,
				@NumLote AS INT,
				@MaiorData AS DATETIME,
				@CustoMedio AS INT

				SET @CustoMedio = @Qtde

				SET @MaiorData = (SELECT MAX(E.DataEntrada) FROM tblEstoque AS E WHERE Descricao = @Desc)
				SET @NumLote = (SELECT E.NumLote FROM tblEstoque AS E WHERE DataEntrada = @MaiorData)
				SET @Desc = (SELECT E.Descricao FROM tblUEPS AS E WHERE NumLote = @NumLote AND idMovimentacao =1)
				SET @QtdeEstoque = (SELECT E.Qtde FROM tblUEPS AS E WHERE NumLote = @NumLote AND idMovimentacao = 1)				 
				SET @IdMov = (SELECT E.idMovimentacao FROM tblUEPS AS E WHERE NumLote = @NumLote AND idMovimentacao = 1)
				SET @PrecoUnit = (SELECT E.PrecoUnit FROM tblEstoque AS E WHERE NumLote = @NumLote)
				SET @DataEntrada = (SELECT E.DataEntrada FROM tblEstoque AS E WHERE NumLote = @NumLote)

				IF(@QtdeEstoque = 0)
				BEGIN
					RAISERROR('Produto zerado !',14,1);
				END

				WHILE @Qtde > 0
				BEGIN
					IF(@QtdeEstoque < @Qtde AND @QtdeEstoque > 0)
					BEGIN

						INSERT INTO tblUEPS
						(
							idMovimentacao,
							NumLote,
							Descricao,
							Qtde,
							PrecoUnit,
							DataEntrada,
							DataSaida,
							Subtotal,
							ICMS,
							Total
						)
						VALUES
						(
							2,
							@NumLote,
							@Desc,
							@QtdeEstoque,
							@PrecoUnit,
							@DataEntrada,
							GETDATE(),
							@QtdeEstoque * @PrecoUnit,
							10,
							(@Qtde * @PrecoUnit) * 1.1 
						)

						SET @Qtde = @Qtde - @QtdeEstoque
						SET @MaiorData = (SELECT MAX(E.DataEntrada) FROM tblEstoque AS E WHERE Descricao = @Desc AND DataEntrada < @MaiorData)
						SET @NumLote = (SELECT E.NumLote FROM tblEstoque AS E WHERE DataEntrada = @MaiorData)
						--SELECT @Qtde - @QtdeEstoque AS Retorno
					END
					ELSE

					IF(@QtdeEstoque >= @Qtde AND @QtdeEstoque > 0 AND @IdMov = 1)
					BEGIN
					
						INSERT INTO tblUEPS
						(
							idMovimentacao,
							NumLote,
							Descricao,
							Qtde,
							PrecoUnit,
							DataEntrada,
							DataSaida,
							Subtotal,
							ICMS,
							Total
						)
						VALUES
						(
							2,
							@NumLote,
							@Desc,
							@Qtde,
							@PrecoUnit,
							@DataEntrada,
							GETDATE(),
							@Qtde * @PrecoUnit,
							10,
							(@Qtde * @PrecoUnit) * 1.1 
						)

						SET @Qtde = 0
						--SELECT 0 AS Retorno
					END
				END

				EXEC uspProdutoCustoMedio @Desc, @CustoMedio

				SELECT 0 AS Retorno
				
		COMMIT TRAN
	END TRY
	BEGIN CATCH

		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno

	END CATCH
END