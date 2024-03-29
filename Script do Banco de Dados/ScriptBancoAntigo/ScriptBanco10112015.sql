USE [master]
GO
/****** Object:  Database [ControleEstoque]    Script Date: 10/11/2015 03:51:27 ******/
CREATE DATABASE [ControleEstoque]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ControleEstoque', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ControleEstoque.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ControleEstoque_log', FILENAME = N'c:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ControleEstoque_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ControleEstoque] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ControleEstoque].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ControleEstoque] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ControleEstoque] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ControleEstoque] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ControleEstoque] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ControleEstoque] SET ARITHABORT OFF 
GO
ALTER DATABASE [ControleEstoque] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ControleEstoque] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ControleEstoque] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ControleEstoque] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ControleEstoque] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ControleEstoque] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ControleEstoque] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ControleEstoque] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ControleEstoque] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ControleEstoque] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ControleEstoque] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ControleEstoque] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ControleEstoque] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ControleEstoque] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ControleEstoque] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ControleEstoque] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ControleEstoque] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ControleEstoque] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ControleEstoque] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ControleEstoque] SET  MULTI_USER 
GO
ALTER DATABASE [ControleEstoque] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ControleEstoque] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ControleEstoque] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ControleEstoque] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ControleEstoque]
GO
/****** Object:  StoredProcedure [dbo].[uspCarregaProdutoAntigo]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCarregaProdutoAntigo]
	@Desc AS VARCHAR(50)
AS
BEGIN
	DECLARE
		@Menor_Data AS DATETIME,
		@QtdeDisponivel AS INT

	SELECT @Menor_Data = MIN(DATAENTRADA)  FROM tblEstoque WHERE Descricao = @Desc AND Qtde > 0

	SELECT @QtdeDisponivel = E.Qtde FROM tblEstoque AS E WHERE Descricao = @Desc AND DataEntrada = @Menor_Data

	SELECT
		*
	FROM
		tblEstoque AS E
	WHERE
		DataEntrada = @Menor_Data AND Qtde = @QtdeDisponivel
END
GO
/****** Object:  StoredProcedure [dbo].[uspCarregaProdutoNovo]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCarregaProdutoNovo]
	@Desc AS VARCHAR(50)
AS
BEGIN
	DECLARE
		@Maior_Data AS DATETIME,
		@QtdeDisponivel AS INT

	SELECT @Maior_Data = MAX(DataEntrada) FROM tblEstoque WHERE Descricao = @Desc AND Qtde > 0

	SELECT @QtdeDisponivel = E.Qtde FROM tblEstoque AS E WHERE Descricao = @Desc AND DataEntrada = @Maior_Data

	SELECT
		*
	FROM
		tblEstoque AS E
	WHERE
		DataEntrada = @Maior_Data AND Qtde = @QtdeDisponivel
END
GO
/****** Object:  StoredProcedure [dbo].[uspDescricaoCategoriaQtde]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDescricaoCategoriaQtde]
AS
BEGIN
	
	SELECT
		E.DescriçãoItem AS Descrição_Item,
		E.CategoriaItem AS Categoria_Item,
		E.DataEntrada,
		SUM(Qtde) AS Qtde_Disponivel, 
		(SUM(PrecoUnit) / COUNT(*)) AS Media_Preco
	FROM
		uvwEstoqueCarregar AS E
	GROUP BY
		DescriçãoItem,
		CategoriaItem,
		DataEntrada
END
--SELECT
--	E.Descricao,
--	T.Descricao,
--	SUM(E.Qtde),
--	(SUM(Qtde) / count(*)) as Media_Preço
--FROM
--	tblEstoque AS E
--JOIN
--	tblTipo AS T
--ON
--	E.idTipo = T.id
--WHERE
--	Qtde > 0
--GROUP BY 
--	E.Descricao,
--	T.Descricao
GO
/****** Object:  StoredProcedure [dbo].[uspEmailVerificar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEmailVerificar]
	@Email AS VARCHAR(50)
AS
BEGIN
	DECLARE @_email VARCHAR(50)
	DECLARE @Nome VARCHAR(50)
	DECLARE @Senha VARCHAR(50)
	DECLARE @Msg VARCHAR(23)

	IF(EXISTS(SELECT * FROM tblUsuario WHERE Email = @Email))
		BEGIN
			SET @_email = (SELECT EV.Email FROM uvwEmailValidar AS EV WHERE EV.Email = @Email)
			SET @Nome = (SELECT EV.Nome FROM uvwEmailValidar AS EV WHERE EV.Email = @Email)
			SET @Senha = (SELECT EV.Senha FROM uvwEmailValidar AS EV WHERE EV.Email = @Email)
			SELECT @_email AS EMAIL, @Nome NOME, @Senha AS SENHA
		END

	ELSE
		BEGIN
			SET @Msg = 'E-MAIL NÃO ENCONTRADO !'
			SELECT @Msg AS Retorno
		END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEstoqueCarregar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEstoqueCarregar]
AS
BEGIN
	SELECT * FROM uvwEstoqueCarregar
END
GO
/****** Object:  StoredProcedure [dbo].[uspFornecedorInserir]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspFornecedorInserir]
	@NomeFantasia AS VARCHAR(50),
	@Cnpj AS VARCHAR(14)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			IF(EXISTS(SELECT * FROM tblFornecedor WHERE Cnpj = @Cnpj))
				RAISERROR('Fornecedor já existe !',14,1);

			INSERT INTO tblFornecedor
			(
				NomeFantasia,
				Cnpj
			)
			VALUES
			(
				UPPER (@NomeFantasia),
				@Cnpj
			)

			SELECT @@IDENTITY AS Retorno

		COMMIT TRAN
	END TRY
	BEGIN CATCH

		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno
	
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspProdutoComprar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProdutoComprar]
	@idMovimentacao AS INT,
	@Descricao AS VARCHAR(50),
	@idTipo AS INT,
	@Qtde AS INT,
	@PrecoUnit AS DECIMAL(18,2),
	@idFornecedor AS INT
AS
BEGIN
	
	--Gerando um numero aleatorio para o NumLote
	DECLARE 
		@Random INT,
		@Upper INT,
		@Lower INT

	SET @Lower = 1
	SET @Upper = 999

	SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	BEGIN TRY
	
		BEGIN TRAN

			--VERIFICA SE O ID DA MOVIMENTAÇÃO ESTA CORRETO SENÃO ESTIVER OCORRE UM ERRO.
			IF(@idMovimentacao = 2 OR @idMovimentacao = 3 OR @idMovimentacao = 4)
				RAISERROR('O idMovimentação informado está incorreto !!!', 14, 1);
			ELSE
				INSERT INTO tblEstoque
				(
					idMovimentacao,
					NumLote,
					Descricao,
					idTipo,
					Qtde,
					PrecoUnit,
					DataEntrada,
					idFornecedor
				)
				VALUES
				(
					@idMovimentacao,
					@Random,
					UPPER(@Descricao),
					@idTipo,
					@Qtde,
					@PrecoUnit,
					GETDATE(),
					@idFornecedor
				)

				SELECT @@IDENTITY AS Retorno	
		COMMIT TRAN

	END TRY

	BEGIN CATCH
		
		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno;
	
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspProdutoVenderPEPS]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProdutoVenderPEPS]
	@NumLote AS INT,
	@Qtde AS INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			DECLARE
				@QtdeEstoque AS INT

				SET @QtdeEstoque = (SELECT E.Qtde FROM tblEstoque AS E WHERE NumLote = @NumLote)
				
				--SE A QUANTIDADE DO ESTOQUE FOR MENOR QUE A QUANTIDADE DE VENDA
				IF(@QtdeEstoque < @Qtde AND @QtdeEstoque > 0)
				BEGIN
					UPDATE tblEstoque
					SET		Qtde = Qtde - @QtdeEstoque
					WHERE	NumLote = @NumLote
					
					SELECT @Qtde - @QtdeEstoque AS Retorno
				END
				--SE A QUANTIDADE DO ESTOQUE FOR MAIOR OU IGUAL A QUANTIDADE DE VENDA	
				ELSE
				IF(@QtdeEstoque >= @Qtde)
				BEGIN	
					UPDATE	tblEstoque
					SET		Qtde = Qtde - @Qtde
					WHERE	NumLote = @NumLote

					SELECT 0 AS Retorno
				END
				
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		
		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspProdutoVenderUEPS]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProdutoVenderUEPS]
	@NumLote AS INT,
	@Qtde AS INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DECLARE
				@QtdeEstoque AS INT

				SET @QtdeEstoque = (SELECT E.Qtde FROM tblEstoque AS E WHERE NumLote = @NumLote)

				IF(@QtdeEstoque < @Qtde AND @QtdeEstoque > 0)
				BEGIN
					UPDATE	tblEstoque
					SET		Qtde = Qtde - @QtdeEstoque
					WHERE	NumLote = @NumLote

					SELECT @Qtde - @QtdeEstoque AS Retorno
				END
				ELSE
				IF(@QtdeEstoque >= @Qtde)
				BEGIN
					UPDATE	tblEstoque
					SET		Qtde = Qtde - @Qtde
					WHERE	NumLote = @NumLote

					SELECT 0 AS Retorno
				END
		COMMIT TRAN
	END TRY
	BEGIN CATCH

		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsuarioCadastrar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsuarioCadastrar]
	@Nome AS VARCHAR(50),
	@SobreNome AS VARCHAR(50),
	@DataNascimento AS DATE,
	@Email AS VARCHAR(50),
	@Senha AS VARCHAR(50),
	@idNivel AS INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN

			IF(EXISTS(SELECT * FROM tblUsuario WHERE Senha = @Senha))
				RAISERROR('Senha já existe', 14,1);
				
				INSERT INTO tblUsuario
				(
					Nome,
					SobreNome,
					DataNascimento,
					Email,
					Senha,
					idNivel
				)
				VALUES
				(
					UPPER(@Nome),
					UPPER(@SobreNome),
					@DataNascimento,
					@Email,
					@Senha,
					@idNivel
				)

				SELECT @@IDENTITY AS Retorno;

		COMMIT TRAN
	END TRY
	BEGIN CATCH

		ROLLBACK TRAN
		SELECT ERROR_MESSAGE() AS Retorno
	
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspUsuarioValidar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUsuarioValidar]
	@Nome VARCHAR(50),
	@Senha VARCHAR(50)
AS
BEGIN
	DECLARE @idNivel INT
	DECLARE @msg VARCHAR(24)

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
GO
/****** Object:  Table [dbo].[tblEstoque]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblEstoque](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idMovimentacao] [int] NOT NULL,
	[NumLote] [int] NOT NULL,
	[Descricao] [varchar](50) NOT NULL,
	[idTipo] [int] NOT NULL,
	[Qtde] [int] NOT NULL,
	[PrecoUnit] [decimal](18, 2) NOT NULL,
	[DataEntrada] [datetime] NOT NULL,
	[idFornecedor] [int] NOT NULL,
 CONSTRAINT [PK_tblEstoque] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFornecedor]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFornecedor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NomeFantasia] [varchar](50) NOT NULL,
	[Cnpj] [varchar](14) NOT NULL,
 CONSTRAINT [PK_tblFornecedor_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMovimentação]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMovimentação](
	[idMovimentacao] [int] NOT NULL,
	[Desc_Mov] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblMovimentação] PRIMARY KEY CLUSTERED 
(
	[idMovimentacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblNivelAcesso]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNivelAcesso](
	[idNivel] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tblNivelAcesso] PRIMARY KEY CLUSTERED 
(
	[idNivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPEPS]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPEPS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idMovimentacao] [int] NOT NULL,
	[NumLote] [int] NOT NULL,
	[Descricao] [varchar](50) NOT NULL,
	[Qtde] [int] NOT NULL,
	[PrecoUnit] [decimal](18, 2) NOT NULL,
	[DataEntrada] [smalldatetime] NULL,
	[DataSaida] [smalldatetime] NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblPEPS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTipo]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTipo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblTipo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUEPS]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUEPS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idMovimentacao] [int] NOT NULL,
	[Numlote] [int] NOT NULL,
	[Descricao] [varchar](50) NOT NULL,
	[Qtde] [int] NOT NULL,
	[PrecoUnit] [decimal](18, 2) NOT NULL,
	[DataEntrada] [smalldatetime] NULL,
	[DataSaida] [smalldatetime] NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblUEPS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUsuario]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUsuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[SobreNome] [varchar](50) NOT NULL,
	[DataNascimento] [date] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Senha] [varchar](50) NOT NULL,
	[idNivel] [int] NOT NULL,
 CONSTRAINT [PK_tblUsuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[uvwConsultarDescricaoCategoria]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[uvwConsultarDescricaoCategoria]

AS
	SELECT 
		E.Descricao AS Bebida,
		T.Descricao AS Categoria,
		E.PrecoUnit AS Preco,
		E.Qtde AS Quantidade
	FROM
		tblEstoque AS E
	JOIN
		tblTipo AS T
	ON
		E.idTipo = T.id


GO
/****** Object:  View [dbo].[uvwEmailValidar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uvwEmailValidar]
AS

	SELECT
		U.Nome,
		U.Senha,
		U.Email
	FROM
		tblUsuario AS U
GO
/****** Object:  View [dbo].[uvwEstoqueCarregar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uvwEstoqueCarregar]

AS
	SELECT 
		M.Desc_Mov,
		E.NumLote,
		E.Descricao AS DescriçãoItem,
		T.Descricao AS CategoriaItem,
		E.Qtde,
		E.PrecoUnit,
		E.DataEntrada,
		F.NomeFantasia
	FROM
		tblEstoque AS E
	JOIN
		tblMovimentação AS M
	ON
		E.idMovimentacao = M.idMovimentacao
	JOIN
		tblTipo AS T
	ON
		E.idTipo = T.id
	JOIN
		tblFornecedor AS F
	ON
		E.idFornecedor = F.id
GO
/****** Object:  View [dbo].[uvwEstoquePEPSCarregar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uvwEstoquePEPSCarregar]
AS
	SELECT
	M.Desc_Mov,
	P.NumLote,
	P.Descricao,
	P.Qtde,
	P.PrecoUnit,
	P.DataEntrada,
	P.DataSaida,
	P.Subtotal
FROM
	tblPEPS AS P
JOIN
	tblMovimentação AS M
ON
	P.idMovimentacao = M.idMovimentacao
GO
/****** Object:  View [dbo].[uvwEstoqueUEPSCarregar]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uvwEstoqueUEPSCarregar]
AS
	SELECT
		M.Desc_Mov,
		U.NumLote,
		U.Descricao,
		U.Qtde,
		U.PrecoUnit,
		U.DataEntrada,
		U.DataSaida,
		U.Subtotal
	FROM
		tblUEPS AS U
	JOIN
		tblMovimentação AS M
	ON
		U.idMovimentacao = M.idMovimentacao
GO
/****** Object:  View [dbo].[uvwUsuarioNivelAcesso]    Script Date: 10/11/2015 03:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[uvwUsuarioNivelAcesso]

AS
	SELECT 
		U.Nome AS NOME,
		U.Senha AS SENHA,
		U.Email AS EMAIL,
		U.idNivel AS idAcesso,
		NV.Descricao AS NIVELACESSO
	FROM 
		tblUsuario AS U
	JOIN
		tblNivelAcesso AS NV
	ON
		U.idNivel = NV.idNivel



GO
ALTER TABLE [dbo].[tblEstoque]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoque_tblFornecedor] FOREIGN KEY([idFornecedor])
REFERENCES [dbo].[tblFornecedor] ([id])
GO
ALTER TABLE [dbo].[tblEstoque] CHECK CONSTRAINT [FK_tblEstoque_tblFornecedor]
GO
ALTER TABLE [dbo].[tblEstoque]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoque_tblMovimentação] FOREIGN KEY([idMovimentacao])
REFERENCES [dbo].[tblMovimentação] ([idMovimentacao])
GO
ALTER TABLE [dbo].[tblEstoque] CHECK CONSTRAINT [FK_tblEstoque_tblMovimentação]
GO
ALTER TABLE [dbo].[tblEstoque]  WITH CHECK ADD  CONSTRAINT [FK_tblEstoque_tblTipo] FOREIGN KEY([idTipo])
REFERENCES [dbo].[tblTipo] ([id])
GO
ALTER TABLE [dbo].[tblEstoque] CHECK CONSTRAINT [FK_tblEstoque_tblTipo]
GO
ALTER TABLE [dbo].[tblPEPS]  WITH CHECK ADD  CONSTRAINT [FK_tblPEPS_tblMovimentação] FOREIGN KEY([idMovimentacao])
REFERENCES [dbo].[tblMovimentação] ([idMovimentacao])
GO
ALTER TABLE [dbo].[tblPEPS] CHECK CONSTRAINT [FK_tblPEPS_tblMovimentação]
GO
ALTER TABLE [dbo].[tblUEPS]  WITH CHECK ADD  CONSTRAINT [FK_tblUEPS_tblMovimentação] FOREIGN KEY([idMovimentacao])
REFERENCES [dbo].[tblMovimentação] ([idMovimentacao])
GO
ALTER TABLE [dbo].[tblUEPS] CHECK CONSTRAINT [FK_tblUEPS_tblMovimentação]
GO
ALTER TABLE [dbo].[tblUsuario]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuario_tblNivelAcesso] FOREIGN KEY([idNivel])
REFERENCES [dbo].[tblNivelAcesso] ([idNivel])
GO
ALTER TABLE [dbo].[tblUsuario] CHECK CONSTRAINT [FK_tblUsuario_tblNivelAcesso]
GO
USE [master]
GO
ALTER DATABASE [ControleEstoque] SET  READ_WRITE 
GO
