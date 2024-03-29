USE [ControleEstoque]
GO
/****** Object:  StoredProcedure [dbo].[uspUsuarioValidar]    Script Date: 17/10/2015 01:13:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspUsuarioValidar]
	@Nome VARCHAR(50),
	@Senha VARCHAR(50)
AS
BEGIN
	DECLARE @idNivel int
	DECLARE @msg varchar(24)

	IF(NOT EXISTS(SELECT * FROM uvwUsuarioNivelAcesso AS AC WHERE AC.NOME = @Nome AND AC.SENHA = @Senha))
		BEGIN
			SET @msg = 'NOME OU SENHA INVALIDO'
			SELECT @msg AS Mensagem
		END
	ELSE
		BEGIN 
			SET @idNivel = (SELECT AC.idAcesso FROM uvwUsuarioNivelAcesso AS AC WHERE AC.NOME = @Nome AND AC.SENHA = @Senha)
			SELECT @idNivel AS NivelAcesso
		END
END