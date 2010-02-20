SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PRODUCTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PRODUCTO](
	[productoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](250) NULL,
	[descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_RGN_PRODUCTO_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_RGN_PRODUCTO_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_RGN_PRODUCTO_estado]  DEFAULT ('A'),
	[ucrea] [varchar](20) NULL CONSTRAINT [DF_RGN_PRODUCTO_ucrea]  DEFAULT ('SYSTEM'),
	[uupdate] [varchar](20) NULL CONSTRAINT [DF_RGN_PRODUCTO_uupdate]  DEFAULT ('SYSTEM')
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ATRIBUTOPOLIZA](
	[atributoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[condiciones] [varchar](1000) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroSelectAllByFilters]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TipoSiniestroSelectAllByFilters] 
(
@tiposiniestro varchar(500) = null,
@estado varchar(1),
@ramoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int
/*
	SELECT     dbo.RGN_RAMO.nombre, dbo.RGN_TIPOSINIESTRO.tipoSiniestroId, dbo.RGN_TIPOSINIESTRO.tipoSiniestro, 
                      dbo.RGN_TIPOSINIESTRO.descripcion, dbo.RGN_TIPOSINIESTRO.fcrea, dbo.RGN_TIPOSINIESTRO.fupdate, dbo.RGN_TIPOSINIESTRO.estado, 
                      dbo.RGN_TIPOSINIESTRO.ucrea, dbo.RGN_TIPOSINIESTRO.uupdate, dbo.RGN_TIPOSINIESTRO.ramoId
FROM         dbo.RGN_TIPOSINIESTRO LEFT OUTER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_TIPOSINIESTRO.ramoId = dbo.RGN_RAMO.ramoId
	
*/
	DECLARE @sqlSentencia nvarchar(4000)
	DECLARE @sqlCondicion nvarchar(4000)	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	set @sqlSentencia = 
		''SELECT     dbo.RGN_RAMO.nombre, dbo.RGN_TIPOSINIESTRO.tipoSiniestroId, dbo.RGN_TIPOSINIESTRO.tipoSiniestro, 
                      dbo.RGN_TIPOSINIESTRO.descripcion, dbo.RGN_TIPOSINIESTRO.fcrea, dbo.RGN_TIPOSINIESTRO.fupdate, dbo.RGN_TIPOSINIESTRO.estado, 
                      dbo.RGN_TIPOSINIESTRO.ucrea, dbo.RGN_TIPOSINIESTRO.uupdate, dbo.RGN_TIPOSINIESTRO.ramoId
FROM         dbo.RGN_TIPOSINIESTRO LEFT OUTER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_TIPOSINIESTRO.ramoId = dbo.RGN_RAMO.ramoId
			WHERE 1 = 1 
		''
	IF (@tiposiniestro <> ''(mark:empty)'')
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_TIPOSINIESTRO.tipoSiniestro like ''''%'' + @tiposiniestro + ''%'''' ) ''				
	end
	
	if (@estado <> ''T'') 
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_TIPOSINIESTRO.estado = '''''' + @estado + '''''' ) ''
	end
	
	if (@ramoId <> -1) 
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_TIPOSINIESTRO.ramoid = '' + convert(varchar,@ramoId) + '' ) ''
	end
	

	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion

	--print @sqlSentencia;	

	 exec (@sqlSentencia)

	
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TIPOSINIESTRO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TIPOSINIESTRO](
	[tipoSiniestroId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[tipoSiniestro] [varchar](500) NULL,
	[descripcion] [varchar](500) NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_RGN_TIPOSINIESTRO_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_RGN_TIPOSINIESTRO_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_RGN_TIPOSINIESTRO_estado]  DEFAULT ('A'),
	[ucrea] [varchar](20) NULL CONSTRAINT [DF_RGN_TIPOSINIESTRO_ucrea]  DEFAULT ('SYSTEM'),
	[uupdate] [varchar](20) NULL CONSTRAINT [DF_RGN_TIPOSINIESTRO_uupdate]  DEFAULT ('SYSTEM'),
	[ramoId] [numeric](8, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaEditorUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_PolizaEditorUpdate]
(
	@polizaId numeric(8,0),
	@contratante varchar(250) = NULL,
	@aseguradoId numeric(8,0),
	@asegurado varchar(250) =NULL,
	@aseguradora varchar(250) =NULL,
	@productoId numeric(8,0),
	@ramoId numeric(8,0),
	@coberturaId numeric(8,0),
	@finicio datetime = NULL,
	@ffin datetime = NULL,
	@numPoliza varchar(100) = NULL,
	@aseguradoraId numeric(8,0),
	@grupoEconomico varchar(250),
	@giroNegocio varchar (250),
	@nombreArchivo varchar

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int


	IF(@nombreArchivo ='''')
	BEGIN
		UPDATE RGN_POLIZA
		SET
			contratante = @contratante,
			aseguradoId = @aseguradoId,
			productoId = @productoId,
			ramoId = @ramoId,
			riesgoId = @coberturaId,
			finicio = @finicio,
			ffin = @ffin,
			numeroPoliza = @numPoliza,
			grupoEconomico =@grupoEconomico,
			giroNegocio= @giroNegocio
			
		WHERE
			polizaId = @polizaId AND
			aseguradoraId = @aseguradoraId


	END
	ELSE
	BEGIN
		UPDATE RGN_POLIZA
		SET
			contratante = @contratante,
			aseguradoId = @aseguradoId,
			productoId = @productoId,
			ramoId = @ramoId,
			riesgoId = @coberturaId,
			finicio = @finicio,
			ffin = @ffin,
			numeroPoliza = @numPoliza,
			grupoEconomico =@grupoEconomico,
			giroNegocio= @giroNegocio,
			archivo=@nombreArchivo
		WHERE
			polizaId = @polizaId AND
			aseguradoraId = @aseguradoraId


	END

	
/*	UPDATE ADM_ASEGURADO
	set
		grupoEconomico =@grupoEconomico,
		actividad= @giroNegocio
	WHERE personaId=@aseguradoId


	UPDATE ADM_PERSONA
	set persona=@asegurado
	WHERE personaId=@aseguradoId
*/
	SET @Err = @@Error


	RETURN @Err
END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaPdfSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_PolizaPdfSelect]
	@polizaId numeric(8, 0)
AS
	SET NOCOUNT ON;
	
	SELECT
	       RGN_POLIZA.archivo
	       
	FROM RGN_POLIZA

	WHERE (RGN_POLIZA.polizaId=@polizaId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_PERSONA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_PERSONA](
	[personaId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[creadorId] [numeric](8, 0) NULL,
	[contactodeId] [numeric](8, 0) NULL,
	[persona] [varchar](1000) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[nombre1] [varchar](250) NULL,
	[nombre2] [varchar](250) NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[apellido1] [varchar](250) NULL,
	[uupdate] [varchar](20) NULL,
	[apellido2] [varchar](250) NULL,
	[tpersonaid] [numeric](5, 0) NULL,
	[personajuridica] [varchar](1) NULL,
	[codigo] [varchar](20) NULL,
	[sexo] [varchar](1) NULL,
	[usuarioId] [numeric](8, 0) NULL,
	[email] [varchar](250) NULL,
 CONSTRAINT [PK_ADM_PERSONA] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SubAcceso]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SubAcceso]
	@aseguradoraId 	numeric,
	@brokerId 			numeric
AS

	/*
	SELECT 
					SYS_SUBACCESO.funcionalidadId,
					SYS_FUNCIONALIDAD.funcionalidad, 
					SYS_SUBACCESO.usuarioId,
					SYS_SUBACCESO.aseguradoraId,
					SYS_SUBACCESO.brokerId,
					CAST(0 AS bit) AS acceso
	FROM		SYS_SUBACCESO INNER JOIN
					SYS_FUNCIONALIDAD ON SYS_FUNCIONALIDAD.funcionalidadId = SYS_SUBACCESO.funcionalidadId 
	*/

	--/*
	-- TABLA TEMPORAL CON LOS ACCESOS DEL USUARIO
	CREATE TABLE  #SUBACCESO
	(	
		funcionalidadId numeric, 
		funcionalidad 	varchar(250),
		usuarioId 			numeric, 
		aseguradoraId 	numeric,
		brokerId 				numeric,
		acceso					bit
	)
	
	IF NOT @aseguradoraId IS NULL AND @brokerId IS NULL --Administrador RGEN
		BEGIN
			-- INSERCIÓN DE LAS FUNCIONALIDADES SETEABLES A UNA ASEGURADORA
			INSERT 	INTO #SUBACCESO
							(funcionalidadId, funcionalidad, acceso)
			SELECT 	SYS_FUNCIONALIDAD.funcionalidadId,
							SYS_FUNCIONALIDAD.funcionalidad,
							0 AS acceso 
			FROM		SYS_FUNCIONALIDAD
			WHERE		SYS_FUNCIONALIDAD.nivel = 2
			
			-- ACTUALIZACIÓN DE LOS PERMISOS HABILITADOS A LA ASEGURADORA
			UPDATE	#SUBACCESO
			SET 		#SUBACCESO.usuarioId = SYS_SUBACCESO.usuarioId,
							#SUBACCESO.aseguradoraId = SYS_SUBACCESO.aseguradoraId,
							#SUBACCESO.acceso = 1
			FROM 		#SUBACCESO INNER JOIN
							SYS_SUBACCESO ON SYS_SUBACCESO.funcionalidadId = #SUBACCESO.funcionalidadId AND
							SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND SYS_SUBACCESO.brokerId IS NULL
		END
	
	IF NOT @aseguradoraId IS NULL AND NOT @brokerId IS NULL  --Administrador Aseguradora
		BEGIN
			-- INSERCIÓN DE LAS FUNCIONALIDADES SETEABLES A UN BROKER EN RELACION A UNA ASEGURADORA
			INSERT 	INTO #SUBACCESO
							(funcionalidadId, funcionalidad, usuarioId, aseguradoraId, acceso)
			SELECT 
							SYS_SUBACCESO.funcionalidadId,
							SYS_FUNCIONALIDAD.funcionalidad, 
							SYS_SUBACCESO.usuarioId,
							SYS_SUBACCESO.aseguradoraId,
							0 AS acceso
			FROM		SYS_SUBACCESO INNER JOIN
							SYS_FUNCIONALIDAD ON SYS_FUNCIONALIDAD.funcionalidadId = SYS_SUBACCESO.funcionalidadId 
			WHERE		SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
							SYS_SUBACCESO.brokerId IS NULL
			
			-- ACTUALIZACIÓN DE LOS PERMISOS HABILITADOS AL BROKER
			UPDATE	#SUBACCESO
			SET 		#SUBACCESO.usuarioId = SYS_SUBACCESO.usuarioId,
							#SUBACCESO.brokerId = SYS_SUBACCESO.brokerId,
							#SUBACCESO.acceso = 1
			FROM		#SUBACCESO INNER JOIN
							SYS_SUBACCESO ON SYS_SUBACCESO.funcionalidadId = #SUBACCESO.funcionalidadId AND
							SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
							SYS_SUBACCESO.brokerId = @brokerId
		END
			
	SELECT * FROM #SUBACCESO
	--*/
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_CLIENTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_CLIENTE](
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[visibilidadInforme] [varchar](1) NULL,
	[notificarInformesNuevos] [varchar](1) NULL,
	[visibilidadBitacoras] [varchar](1) NULL,
	[visibilidadReserva] [varchar](1) NULL,
	[visibilidadPerdida] [varchar](1) NULL,
	[permitirmensajeria] [varchar](1) NULL,
	[codigoAseguradora] [varchar](100) NULL,
 CONSTRAINT [PK_ADM_CLIENTE] PRIMARY KEY NONCLUSTERED 
(
	[aseguradoraId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PRODUCTOXRAMO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PRODUCTOXRAMO](
	[productoId] [numeric](8, 0) NULL,
	[ramoId] [numeric](8, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_brokersAutoCompleteByPersonName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE
PROCEDURE [dbo].[sp_rgenx_brokersAutoCompleteByPersonName]
(
	@persona varchar(1000),
	@numItems numeric(8,0)
)
AS
SET NOCOUNT ON;

declare @sqlCommand varchar(1000)
/*
select persona, personaId 
FROM  ADM_PERSONA
*/

set @sqlCommand = ''SELECT top '' +  Convert(varchar,@numItems) + '' persona, personaId 
FROM         ADM_PERSONA
WHERE     (persona LIKE ''''''+ @persona + ''%'''') AND estado = ''''A'''' and (personaid in (select personaid from ADM_BROKER)) order by persona''

exec (@sqlCommand)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_EjecutivoAutoCompleteByNameAndCompany]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgenx_EjecutivoAutoCompleteByNameAndCompany]
(
	@persona varchar(1000),
	@aseguradoraId numeric(8,0),
	@numItems numeric(8,0)
)
AS
SET NOCOUNT ON;

declare @sqlCommand varchar(1000)
/*
select persona, personaId 
FROM  ADM_PERSONA*/

set @sqlCommand = ''SELECT top '' +  Convert(varchar,@numItems) + '' persona, personaId 
FROM         ADM_PERSONA
WHERE     (persona LIKE ''''''+ @persona + ''%'''') AND estado = ''''A'''' and (tpersonaId = 9) and creadorId = '' + Convert(varchar,@aseguradoraId) + '' order by persona''

exec (@sqlCommand)











' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_TDOCID]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_TDOCID](
	[tdocidId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[tdocid] [varchar](100) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_ADM_TDOCID] PRIMARY KEY NONCLUSTERED 
(
	[tdocidId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_TPERSONA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_TPERSONA](
	[tpersonaid] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[tpersona] [varchar](20) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_ADM_TPERSONA] PRIMARY KEY NONCLUSTERED 
(
	[tpersonaid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_documentosXriesgoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_documentosXriesgoSelect]
    (
      @ramoId numeric(8, 0),
      @solicitudDocumentosId numeric(8, 0),
      @nombre VARCHAR(1000) = null
    )
as 
--    if ( @ramoId <> -1 ) 
--        begin 
--
--            SELECT distinct
--                    dbo.RGN_REQUISITOS.requisitoId,
--                    dbo.RGN_REQUISITOS.nombre AS documento
--            FROM    dbo.RGN_REQUISITOS
--                    INNER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId
--            WHERE   ( dbo.RGN_REQUISITO_RAMO.ramoId = @ramoId ) AND [RGN_REQUISITOS].[estado]  = ''A''
--                    AND ( not dbo.RGN_REQUISITOS.requisitoId in (
--                          select    x.requisitoId
--                          from      dbo.RGN_AJUSTE_RGN_REQUERIMIENTO x
--                          where     x.solicitudDocumentosId = @solicitudDocumentosId )
--                        )
--            order by dbo.RGN_REQUISITOS.nombre
--
--        end
--    else 
--        begin
--            SELECT distinct
--                    dbo.RGN_REQUISITOS.requisitoId,
--                    dbo.RGN_REQUISITOS.nombre AS documento
--            FROM    dbo.RGN_REQUISITOS
--                    INNER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId
--			WHERE [RGN_REQUISITOS].[estado]  = ''A''
--            order by dbo.RGN_REQUISITOS.nombre
--
--
--        end

DECLARE @sqlSentence VARCHAR(4000)
DECLARE @sqlCondition VARCHAR(4000)


SET @sqlCondition = ''''
SET @sqlSentence = ''''

SET @sqlSentence = ''            SELECT distinct
                    dbo.RGN_REQUISITOS.requisitoId,
                    dbo.RGN_REQUISITOS.nombre AS documento
            FROM    dbo.RGN_REQUISITOS
                    INNER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId
			WHERE [RGN_REQUISITOS].[estado]  = ''''A'''' ''
			+ '' AND ( 
							not dbo.RGN_REQUISITOS.requisitoId in ( 
								select x.requisitoId
								from      dbo.RGN_AJUSTE_RGN_REQUERIMIENTO x
								where     x.solicitudDocumentosId = '' + Convert(varchar(20), @solicitudDocumentosId) + '' ) ) ''
           --order by dbo.RGN_REQUISITOS.nombre''

IF (@ramoId <> -1) 
BEGIN
	SET @sqlCondition = '' and dbo.RGN_REQUISITO_RAMO.ramoId = '' + Convert(varchar(20),@ramoId) 
END

IF (LEN(@nombre) > 0) 
BEGIN
	SET @sqlCondition = @sqlCondition + '' AND dbo.RGN_REQUISITOS.nombre like ''''%'' + @nombre + ''%'''' ''
END


SET @sqlSentence = @sqlSentence + '' '' + @sqlCondition + '' '' + ''order by dbo.RGN_REQUISITOS.nombre''

EXEC (@sqlSentence)

--[sp_rgen_documentosXriesgoSelect] 1, 648, ''''' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_TTELEFONO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_TTELEFONO](
	[ttelefonoid] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_ADM_TTELEFONO] PRIMARY KEY NONCLUSTERED 
(
	[ttelefonoid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_REQUISITOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_REQUISITOS](
	[requisitoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](1000) NULL,
	[descripcion] [varchar](1000) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UBIGEO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_UBIGEO](
	[ubigeoId] [varchar](6) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[uupdate] [varchar](20) NULL,
	[ucrea] [varchar](20) NULL,
	[ubigeo] [varchar](100) NULL,
 CONSTRAINT [PK_ADM_UBIGEO] PRIMARY KEY NONCLUSTERED 
(
	[ubigeoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rgn_temp_informebasicodelainspeccion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rgn_temp_informebasicodelainspeccion](
	[lugar] [varchar](100) NULL,
	[personas] [varchar](6000) NULL,
	[descripcion] [varchar](100) NULL,
	[ubigeoId] [varchar](20) NULL,
	[distrito] [varchar](500) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rgn_temp_informebasicogenerales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rgn_temp_informebasicogenerales](
	[contratante] [varchar](100) NULL,
	[asegurado] [varchar](100) NULL,
	[gironegocio] [varchar](100) NULL,
	[grupoeconomico] [varchar](100) NULL,
	[aseguradora] [varchar](50) NULL,
	[responsableaseguradora] [varchar](50) NULL,
	[broker] [varchar](50) NULL,
	[responsablebroker] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_datosgenerales_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_datosgenerales_update](
 @contratante varchar(1000),
 @asegurado varchar(100), 
 @gruponegocio varchar(8000), 
 @grupoeconomico varchar(8000), 
 @aseguradora varchar(1000), 
 @respaseguradora varchar(250), 
 @broker varchar(1000), 
 @respbroker varchar(250),
 @ajusteid numeric(8,0),
 @aseguradoid numeric(8,0),
 @aseguradoraid numeric(8,0),
 @brokerid numeric(8,0)
)
as

BEGIN
/*
update  dbo.ADM_ASEGURADO set  dbo.ADM_ASEGURADO.actividad=@GrupoNegocio,
				dbo.ADM_ASEGURADO.grupoEconomico=@Grupoeconomico
where   dbo.ADM_ASEGURADO.personaid=@aseguradoid
*/

update dbo.RGN_POLIZA set giroNegocio=@gruponegocio,
		    	  grupoEconomico=@grupoEconomico    
where  dbo.RGN_POLIZA.aseguradoId=@aseguradoid
 
END 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_verstamp006]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	This procedure returns the version number of the stored
**    procedures used by legacy versions of the Microsoft
**	Visual Database Tools.  Version is 7.0.00.
*/
CREATE  procedure [dbo].[dt_verstamp006]
as
	select 7000
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_verstamp007]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	This procedure returns the version number of the stored
**    procedures used by the the Microsoft Visual Database Tools.
**	Version is 7.0.05.
*/
CREATE  procedure [dbo].[dt_verstamp007]
as
	select 7005' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_displayoaerror]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  PROCEDURE [dbo].[dt_displayoaerror]
    @iObject int,
    @iresult int
as

set nocount on

declare @vchOutput      varchar(255)
declare @hr             int
declare @vchSource      varchar(255)
declare @vchDescription varchar(255)

    exec @hr = master.dbo.sp_OAGetErrorInfo @iObject, @vchSource OUT, @vchDescription OUT

    select @vchOutput = @vchSource + '': '' + @vchDescription
    raiserror (@vchOutput,16,-1)

    return

' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PARRAFO](
	[parrafoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](250) NULL,
	[parrafo] [varchar](1000) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[doInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE procedure [dbo].[doInsert] as 
exec sp_creaPersonaBroker ''A B CONSULTORES Y CORREDORES DE SEGUROS EIRL''
exec sp_creaPersonaBroker ''A C S L S.R.L. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''A M T PRODUCTORES DE SEGUROS''
exec sp_creaPersonaBroker ''ABAD CORNEJO, ALBERTO SEGUNDO ''
exec sp_creaPersonaBroker ''ABUGATTAS ABUSADA, NAGUIB ELIAS''
exec sp_creaPersonaBroker ''ACARO JURADO, JOSE OLMEDO''
exec sp_creaPersonaBroker ''ACCION COMUNITARIA CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''ACCION CONSULTORES Y CORRED DE SEGS S A''
exec sp_creaPersonaBroker ''ACKERMANN MENACHO, WILHEM ''
exec sp_creaPersonaBroker ''ACTIVO CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''ACUÑA VIDAL, MIGUEL HECTOR''
exec sp_creaPersonaBroker ''ACUY REATEGUI ROSA YOLANDA''
exec sp_creaPersonaBroker ''ADA KOECKLIN CORREDORES DE SEGUROS EIRL''
exec sp_creaPersonaBroker ''ADMINISTRACION DE RIESGOS S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ADMINISTRADORA AMERICANA SEGUROS CORREDORES DE SEG GRLES SRL''
exec sp_creaPersonaBroker ''ADRIANZEN FALCON, RAFAEL''
exec sp_creaPersonaBroker ''AESE ASOC SRL CONSULT Y CORR DE SEG''
exec sp_creaPersonaBroker ''AGENTES CORREDORES DE SEGUROS LAMBAYEQUE S.C.R''
exec sp_creaPersonaBroker ''AGENTES GENERALES S.A.''
exec sp_creaPersonaBroker ''AGESA ASESORES Y CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''AGUILAR BALLON, RENE GUSTAVO ''
exec sp_creaPersonaBroker ''AGUILAR GALARRETA, JUAN CARLOS''
exec sp_creaPersonaBroker ''AGUILAR STUMPF, ROGER OSWALDO''
exec sp_creaPersonaBroker ''AGUILAR ZAMBRANO, FRANCISCO ''
exec sp_creaPersonaBroker ''AGUIRRE POLO, WILDER EFREN''
exec sp_creaPersonaBroker ''ALBURQUERQUE CORDOBA, JOSE AUGUSTO''
exec sp_creaPersonaBroker ''ALBURQUERQUE LIÑAN, GUSTAVO''
exec sp_creaPersonaBroker ''ALBURQUERQUE LIÑAN, GUSTAVO MILTON ''
exec sp_creaPersonaBroker ''ALCANTARA BOCANEGRA, ESTUARDO IBAN ''
exec sp_creaPersonaBroker ''ALCANTARA MONSALVE, JORGE ALBERTO ''
exec sp_creaPersonaBroker ''ALCANTARA REAÑO, LUIS''
exec sp_creaPersonaBroker ''ALCEDO FLORES, AUGUSTO MARCOS''
exec sp_creaPersonaBroker ''ALCO CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''ALFRAM CONSULTORES S''
exec sp_creaPersonaBroker ''ALLEMANT Y ASOCIADOS CORREDORES DE SEGUROS S. C. R. L.''
exec sp_creaPersonaBroker ''ALMANDOZ CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''ALMANDOZ FALLA, JAVIER JESUS ''
exec sp_creaPersonaBroker ''ALMENARA DIAZ, FEDERICO FRANCISCO''
exec sp_creaPersonaBroker ''ALMERINI DE PORTOCARRE, PATRICIA ''
exec sp_creaPersonaBroker ''ALMERINI REPETTO, AQUILES JOSE''
exec sp_creaPersonaBroker ''ALMESTAR ZEVALLOS, JUAN ''
exec sp_creaPersonaBroker ''ALONSO MENDEZ, JAVIER EDUARDO''
exec sp_creaPersonaBroker ''ALONSO TORRES, CARLOS ENRIQUE''
exec sp_creaPersonaBroker ''ALPACA RUIZ, PEDRO ENRIQUE ''
exec sp_creaPersonaBroker ''ALPHA CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''ALSEGUR CORREDORES DE SEGUROS S. R. L.''
exec sp_creaPersonaBroker ''ALVA & ASOCIADOS ASESORES Y CORREDORES DE SEGUROS S.R.L.''
exec sp_creaPersonaBroker ''ALVA PRETELL, JOSE MANUEL''
exec sp_creaPersonaBroker ''ALVA SILVA-SANTISTEBAN, ELSA GLADYS''
exec sp_creaPersonaBroker ''ALVARADO CABRERA, CARLOS A''
exec sp_creaPersonaBroker ''ALVARADO CABRERA, JULIO CESAR''
exec sp_creaPersonaBroker ''ALVARADO PFLUCKER, GONZALO''
exec sp_creaPersonaBroker ''ALVAREZ ROSARIO, ANTONIO ''
exec sp_creaPersonaBroker ''ALVITES VILLANUEVA, SERGIO ''
exec sp_creaPersonaBroker ''ALZAMORA GONZALES, LIDIA ROSA ''
exec sp_creaPersonaBroker ''AMANZO FAURA, RAUL ALBERTO ''
exec sp_creaPersonaBroker ''AMAUTA CORREDORES DE SEGUROS GENERALES EIRL''
exec sp_creaPersonaBroker ''AMERICA CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''AMERICAN PROTECTION CORREDORES DE SEGUR.EIRL.''
exec sp_creaPersonaBroker ''AMES CONROY, ERICK PERCY''
exec sp_creaPersonaBroker ''AMES CONROY, JAIME ARTURO''
exec sp_creaPersonaBroker ''AMESQUITA ROSALES, NORMA ANTONIETA ''
exec sp_creaPersonaBroker ''AMOROS COBO, ANA MARIA ''
exec sp_creaPersonaBroker ''AMPUERO PEREZ, JOSE ANTONIO ''
exec sp_creaPersonaBroker ''ANALISTAS Y CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''ANCHAYA CAMPANELLA, SAMUEL''
exec sp_creaPersonaBroker ''ANDALUZ DE AMEGHINO, ISABEL''
exec sp_creaPersonaBroker ''ANDERSON CHACON, VICTOR''
exec sp_creaPersonaBroker ''ANDINA DE SERVICIOS S. R. LTDA.''
exec sp_creaPersonaBroker ''ANDRADE LEON, MIGUEL ANGEL ''
exec sp_creaPersonaBroker ''ANDRADE MODENESI, GONZALO EDUARDO''
exec sp_creaPersonaBroker ''ANDREU MORENO, HENRY JUAN ''
exec sp_creaPersonaBroker ''ANGAMOS CORREDORES DE SEGUROS S. R. LTDA.''
exec sp_creaPersonaBroker ''ANGOBALDO TORRES-MALAGA, MIGUEL GUILLERMO ''
exec sp_creaPersonaBroker ''ANGULO ALCANTARA, CARLOS ''
exec sp_creaPersonaBroker ''ANGULO RIEDNER, RICARDO JESUS''
exec sp_creaPersonaBroker ''ANGULO VEGA, JORGE LUIS''
exec sp_creaPersonaBroker ''ANGULO VEGA, JORGE LUIS ''
exec sp_creaPersonaBroker ''ANICAMA FLORES, FELIX VICTOR''
exec sp_creaPersonaBroker ''ANSHIN S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''AQUIJE CASTILLO, RENEE MARGARITA ''
exec sp_creaPersonaBroker ''AQUIJE OROSCO, FLORISA HERMILA''
exec sp_creaPersonaBroker ''ARALCO Y ASOC.S.A.C. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ARAMBURU NORIEGA , ANDRES ABELARDO ''
exec sp_creaPersonaBroker ''ARBULU ALVA, MIGUEL RAUL''
exec sp_creaPersonaBroker ''ARCE MAZZI, GUILLERMO BENJAMIN''
exec sp_creaPersonaBroker ''ARELLANO JARA, JOSE MIGUEL''
exec sp_creaPersonaBroker ''AREVALO NAVARRO, CARLOS R. ''
exec sp_creaPersonaBroker ''AREVALO PAREDES, CESAR AUGUSTO''
exec sp_creaPersonaBroker ''AREVALO PEDREROS, JULIO ALBERTO ''
exec sp_creaPersonaBroker ''AREVALO VENEGAS, LUIS MIGUEL ''
exec sp_creaPersonaBroker ''ARGOS S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ARIANSEN ALLEMANT, ARTURO''
exec sp_creaPersonaBroker ''ARIAS GALECIO L, LUIS ABELARDO''
exec sp_creaPersonaBroker ''ARIAS SOBRINO CARLOS NOLASCO''
exec sp_creaPersonaBroker ''ARIAS Y ARIAS CORREDORES DE SEGUROS EIRL''
exec sp_creaPersonaBroker ''ARIAS ZORRILLA, AIDA LUZ''
exec sp_creaPersonaBroker ''ARREDONDO DEL SOLAR, KELIN''
exec sp_creaPersonaBroker ''ARRUNATEGUI UGARTE, ESTHER MILAGROS''
exec sp_creaPersonaBroker ''ARSA PRODUCTORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''ARTETA & ASOCIADOS CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''ARTETA CLAROS, JORGE ALBERTO''
exec sp_creaPersonaBroker ''ASCENZO VEGA, CLAUDIA ''
exec sp_creaPersonaBroker ''ASENCIOS SUAREZ, JESUS RENATO ''
exec sp_creaPersonaBroker ''ASES BROCKERS CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''ASESORES S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ASESORES Y CORRED.DE SEGUROS DEL ORIENTE''
exec sp_creaPersonaBroker ''ASESORES Y CORREDORES DE SEGURO ROLANDO''
exec sp_creaPersonaBroker ''ASESORES Y CORREDORES DE SEGUROS DEL NORTE SCR''
exec sp_creaPersonaBroker ''ASESORES Y PRODUCTORES JV & G CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''ASIAMERICA CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''ASIN BARANDIARAN, CARLOS ALBERTO ''
exec sp_creaPersonaBroker ''ASMAT RODRIGUEZ, JORGE ALFONSO''
exec sp_creaPersonaBroker ''ASOC NAC DEL TRANSP TERRESTRE DE CARGA''
exec sp_creaPersonaBroker ''ASPINWALL RUIZ, ZENAIDA''
exec sp_creaPersonaBroker ''ASSICURANZA ASESORES Y CORREDORES DE SEGUROS S A C''
exec sp_creaPersonaBroker ''ASTETE VASQUEZ, ALDO ARMANDO''
exec sp_creaPersonaBroker ''ATENCIO ARQUE, ALEX''
exec sp_creaPersonaBroker ''ATESA CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''ATKINS LERGGIOS, JUAN ROBERTO ''
exec sp_creaPersonaBroker ''ATUNCAR PACHAS, CESAR''
exec sp_creaPersonaBroker ''AUBRAS Y ASOCIADOS SA ASESORES Y CORR DE SEG''
exec sp_creaPersonaBroker ''AUSTRAL CORREDORES DE SEGUROS S A C''
exec sp_creaPersonaBroker ''AVALOS ALVA, MANUEL''
exec sp_creaPersonaBroker ''AVILA LATORRE, CLEVER JHONNY ''
exec sp_creaPersonaBroker ''AYANZ MORALES, ARTURO RAFAEL ''
exec sp_creaPersonaBroker ''AYESTA DE LA PIEDRA, JOSE GABRIEL''
exec sp_creaPersonaBroker ''AYMAR YANSS, GEORGE''
exec sp_creaPersonaBroker ''AYMAR YANSS, RUBEN EMILIO''
exec sp_creaPersonaBroker ''AYULO ASOCIADOS CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''B & F INTERNACIONAL SAC CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''BACA ARBAÑIL, PEDRO LUIS''
exec sp_creaPersonaBroker ''BACIGALUPO ALVA, DANIEL MARTIN ''
exec sp_creaPersonaBroker ''BADO GUERRERO, CORINA MARISELLA''
exec sp_creaPersonaBroker ''BAHAMONDE CALLE, ZOILA ELIZABETH ''
exec sp_creaPersonaBroker ''BALARIN RAMIREZ, MARIA ALICIA ''
exec sp_creaPersonaBroker ''BALDUCCI & BALDUCCI CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''BALDUCCI FOSCHI, ALBERTO''
exec sp_creaPersonaBroker ''BALUARTE LAPEYRE, PEDRO JOSE''
exec sp_creaPersonaBroker ''BAMONDE GALLOSO, CESAR AUGUSTO''
exec sp_creaPersonaBroker ''BAPROSA CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''BARBARAN VASQUEZ, MANUEL AUGUSTO''
exec sp_creaPersonaBroker ''BARLETTA LEON, HUGO BERNABE ''
exec sp_creaPersonaBroker ''BARRENECHEA SALGADO, SABINO ''
exec sp_creaPersonaBroker ''BARRERA FERNANDEZ, MARIA DEL ROSARIO''
exec sp_creaPersonaBroker ''BARRIGA BARBA, ORLANDO''
exec sp_creaPersonaBroker ''BARRON DE ACARO, ELSA LUCIA''
exec sp_creaPersonaBroker ''BARTHELMESS CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''BARZOLA BARRIENTOS, AUGUSTO ''
exec sp_creaPersonaBroker ''BARZOLA QUISPE, MARINO LUIS''
exec sp_creaPersonaBroker ''BAUDTS HEINSEN, EDWIN JOSE''
exec sp_creaPersonaBroker ''BAZAN PINILLOS, JULIO CESAR ''
exec sp_creaPersonaBroker ''BAZO FLORES, ALEJANDRO RUBEN ''
exec sp_creaPersonaBroker ''BECERRA ARTETA, DANIEL ALFREDO''
exec sp_creaPersonaBroker ''BECERRA ARTETA, JAIME FERNANDO''
exec sp_creaPersonaBroker ''BECERRA BROKERS S.R.L. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''BEINGOLEA NUGENT, CARLOS ENRIQUE''
exec sp_creaPersonaBroker ''BELLO LAMAS, LUIS ALFREDO MARIO''
exec sp_creaPersonaBroker ''BENAVIDES CALDAS, CARMEN CONSUELO''
exec sp_creaPersonaBroker ''BENAVIDES CASTILLO, JORGE DOMINGO ''
exec sp_creaPersonaBroker ''BENAVIDES GALLEGOS, FERNANDO''
exec sp_creaPersonaBroker ''BENAVIDES MIRANDA, MARIA ISABEL ''
exec sp_creaPersonaBroker ''BENITO MURATTA, RAUL JESUS ''
exec sp_creaPersonaBroker ''BERNAL LINARES, VICTOR MANUEL ''
exec sp_creaPersonaBroker ''BERNUY ALFEREZ, LUIS TOMAS ''
exec sp_creaPersonaBroker ''BETETTA GUERRERO, CARLOS RICARDO''
exec sp_creaPersonaBroker ''BIANCHI BURGA, GIANNINA''
exec sp_creaPersonaBroker ''BIANCHI BURGA, GIANNINA MARIA DEL C.''
exec sp_creaPersonaBroker ''BLAS OLIVAS, MIRIAM''
exec sp_creaPersonaBroker ''BOCANEGRA CASTRO, CARLOS UBALDO ''
exec sp_creaPersonaBroker ''BOGGIO ARRIETA, SERGIO ENRIQUE ''
exec sp_creaPersonaBroker ''BORIA RUBIO, JAIME ''
exec sp_creaPersonaBroker ''BOURONCLE PERALTA, JAVIER''
exec sp_creaPersonaBroker ''BRACONCE S.R.L.''
exec sp_creaPersonaBroker ''BRAVO DELGADO, HILARIO JUAN''
exec sp_creaPersonaBroker ''BRAVO MOYA, HUGO ROBERTO''
exec sp_creaPersonaBroker ''BRICEÑO ARATA, GASTON ANTONIO ''
exec sp_creaPersonaBroker ''BRICEÑO CABIESES, GASTON ANTONIO ''
exec sp_creaPersonaBroker ''BRICEÑO DELGADO, JOSE LUIS''
exec sp_creaPersonaBroker ''BRICEÑO NUÑEZ, JOSE LUIS ''
exec sp_creaPersonaBroker ''BRITANIA S.R.L.CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''BROKERS DE SEGUROS PERUANOS''
exec sp_creaPersonaBroker ''BRUZZO SUITO, JUAN ENRIQUE ''
exec sp_creaPersonaBroker ''BUSTAMANTE FERNANDEZ DE CORDOVA, MONICA ''
exec sp_creaPersonaBroker ''BUSTAMANTE NICHOLSON JOSE ALEJANDRO OCTAVIO''
exec sp_creaPersonaBroker ''BUSTAMANTE SANCHEZ, GABRIEL ''
exec sp_creaPersonaBroker ''BUTTERMAN CLEMENS, PETRA''
exec sp_creaPersonaBroker ''BUTTERMAN CLEMENS, PETRA''
exec sp_creaPersonaBroker ''BUTTERMAN CLEMENS, PETRA ''
exec sp_creaPersonaBroker ''C & C ASESORES Y CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''CABALLERO ULLOA, JUAN LORGIO ''
exec sp_creaPersonaBroker ''CABANILLAS POMIANO, HECTOR ABDON''
exec sp_creaPersonaBroker ''CABIESES COLMENARES, ERNESTO''
exec sp_creaPersonaBroker ''CABRERA FUENTES DE SAMAME, ANA MARIA CECILIA''
exec sp_creaPersonaBroker ''CABRERA GONZALES, ARTURO MARTIN''
exec sp_creaPersonaBroker ''CACERES ROQUE, JOSE RAYMUNDO''
exec sp_creaPersonaBroker ''CALDERON CARVAJAL, CARLOS ENRIQUE ''
exec sp_creaPersonaBroker ''CALDERON DE ADRIANZEN, MILKA SUSANA ''
exec sp_creaPersonaBroker ''CALLE CORDOVA, JOSE OVIEDO''
exec sp_creaPersonaBroker ''CALLSEGUROS CORREDORES DE SEGUROS ASESORES Y CONSULTORES''
exec sp_creaPersonaBroker ''CAMACHO ALVARADO, MANUEL NATIVIDAD ''
exec sp_creaPersonaBroker ''CAMACHO GONZALES DEL VALLE, MANUEL EMILIO''
exec sp_creaPersonaBroker ''CAMPOS BENDEZU, URBANO''
exec sp_creaPersonaBroker ''CAMPOS GUANILO, HEBERT DAN ''
exec sp_creaPersonaBroker ''CANDELA ORE, LUIS ANIBAL''
exec sp_creaPersonaBroker ''CANO ORTEGA, FERNANDO JESUS''
exec sp_creaPersonaBroker ''CARBAJAL CESPEDES, JULIO RENATO ''
exec sp_creaPersonaBroker ''CARDENAS LA MADRID, ADA VIRGINIA''
exec sp_creaPersonaBroker ''CARDENAS LA MADRID, JOSE EDUARDO''
exec sp_creaPersonaBroker ''CARDENAS MENDOZA, VITAL MIGUEL ''
exec sp_creaPersonaBroker ''CARDENAS OBREGON, ALEJANDRO''
exec sp_creaPersonaBroker ''CARDENAS PEÑA CARLOS''
exec sp_creaPersonaBroker ''CARLOS HUMBERTO VASQUEZ RAMOS E.I.R.L''
exec sp_creaPersonaBroker ''CARNERO AVALOS, DIEGO ALEJANDRO ''
exec sp_creaPersonaBroker ''CARNERO RODRIGUEZ, JUANA''
exec sp_creaPersonaBroker ''CARPIO NEYRA, JUAN PABLO''
exec sp_creaPersonaBroker ''CARPIO TIRADO Y ASOCIADOS S R LTDA''
exec sp_creaPersonaBroker ''CARRASCO USURIN, VICTOR MANUEL''
exec sp_creaPersonaBroker ''CARRETERO MAZZARRI, RENÉE MERCEDES ''
exec sp_creaPersonaBroker ''CARRILLO & CIA ASESORES Y CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''CARRILLO MARTINEZ, JULIO SOLANO ''
exec sp_creaPersonaBroker ''CARRILLO RAMOS, GINO''
exec sp_creaPersonaBroker ''CASALINO CASALINO, GUSTAVO JESUS''
exec sp_creaPersonaBroker ''CASANA CHAVEZ, TORIBIO ESTEBAN''
exec sp_creaPersonaBroker ''CASANOVA CABRERA, MIGUEL GUILLERMO''
exec sp_creaPersonaBroker ''CASAS AQUIJE, CESAR ''
exec sp_creaPersonaBroker ''CASTAÑEDA CASTRO, FRECTOR''
exec sp_creaPersonaBroker ''CASTAÑEDA CERNA, LUIS ANTONIO''
exec sp_creaPersonaBroker ''CASTAÑEDA DE BATTISTINI,LUZ HAYDEE''
exec sp_creaPersonaBroker ''CASTAÑEDA VISCONDE, MARCO ANTONIO''
exec sp_creaPersonaBroker ''CASTELLANO SARDON, ABEL ''
exec sp_creaPersonaBroker ''CASTELLARES GALVEZ, JESUS''
exec sp_creaPersonaBroker ''CASTILLO ALVAREZ, ALAN DENNIS GONZALO''
exec sp_creaPersonaBroker ''CASTILLO CARPELLA, ARMANDO M.''
exec sp_creaPersonaBroker ''CASTILLO RODRIGUEZ, ROBERTO ''
exec sp_creaPersonaBroker ''CASTRO CASTRO, ELIZABETH''
exec sp_creaPersonaBroker ''CASTRO CUBA, PEDRO DANIEL''
exec sp_creaPersonaBroker ''CASTRO DELGADO, LUIS ERNESTO ''
exec sp_creaPersonaBroker ''CASTRO RONDON, RUFINO MAXIMO''
exec sp_creaPersonaBroker ''CASTRO SIFUENTES, EDUARDO JULIO ''
exec sp_creaPersonaBroker ''CAVERO EGUSQUIZA RALLI, REBECA''
exec sp_creaPersonaBroker ''CAVERO EGUSQUIZA SAAVEDRA, MIGUEL''
exec sp_creaPersonaBroker ''CCATAMAYO SALVATIERRA, WILFREDO MARIO''
exec sp_creaPersonaBroker ''CERCADO MERINO, DORIS ''
exec sp_creaPersonaBroker ''CERNA SILVA, PEDRO''
exec sp_creaPersonaBroker ''CERPA AMADO, HELARF EDGARD NORBERTO''
exec sp_creaPersonaBroker ''CERVANTES & ASOCIADOS ASESORES Y CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''CERVANTES SALAZAR, WILFREDO ''
exec sp_creaPersonaBroker ''CEVALLOS ASENJO, MIGUEL LEONARDO''
exec sp_creaPersonaBroker ''CHACON RAMIREZ, GLORIA PAULA''
exec sp_creaPersonaBroker ''CHAN WAIY S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''CHANG CARRILLO, ISAAC ''
exec sp_creaPersonaBroker ''CHASKI CORREDORES DE SEGUROS GENERALES S. R. L.''
exec sp_creaPersonaBroker ''CHAUCA FLORES, FEDERICO''
exec sp_creaPersonaBroker ''CHAVEZ CERVANTES, ANGEL MELESIO ''
exec sp_creaPersonaBroker ''CHAVEZ GOYZUETA OSCAR DAVID''
exec sp_creaPersonaBroker ''CHAVEZ MORA, MARIA DEL PILAR ''
exec sp_creaPersonaBroker ''CHAVEZ QUINTANA, JUAN CARLOS''
exec sp_creaPersonaBroker ''CHAVEZ-ALCORTA LUQUE, JORGE FERNANDO''
exec sp_creaPersonaBroker ''CHELNOKOVA, SVETLANA''
exec sp_creaPersonaBroker ''CHESSA ARANA, MARINA LUCRECIA''
exec sp_creaPersonaBroker ''CHICHIZOLA GARCIA, LUIS ALFIERI ''
exec sp_creaPersonaBroker ''CHICHIZOLA Y ASOCIADOS S A CORREDORES''
exec sp_creaPersonaBroker ''CHIU CASTRO, FELIPE GUSTAVO''
exec sp_creaPersonaBroker ''CHOCANO DELGADO, JORGE RAUL''
exec sp_creaPersonaBroker ''CHUMBE DEL AGUILA, HORACIO''
exec sp_creaPersonaBroker ''CHUMPITAZ VERANO, GREGORIO ARTURO''
exec sp_creaPersonaBroker ''CISNEROS ESCOBAR, JUAN''
exec sp_creaPersonaBroker ''CISNEROS GOMEZ, GUSTAVO ADOLFO ''
exec sp_creaPersonaBroker ''COBERTURAS INTEGRALES CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''COLLANTES SESSAREGO, DORA ROCIO ''
exec sp_creaPersonaBroker ''COLLAZOS GARCIA, LUIS ALBERTO''
exec sp_creaPersonaBroker ''COLOMA GUZMAN, JAVIER''
exec sp_creaPersonaBroker ''CONCHA GOICOCHEA, BELLSYE VICTORIA ''
exec sp_creaPersonaBroker ''CONCHA GOICOCHEA, CARLOS PAUL''
exec sp_creaPersonaBroker ''CONCHA SISNIEGAS, CESAR ALFREDO''
exec sp_creaPersonaBroker ''CONCHA-FERNANDEZ VELARDE, FRANCISCO''
exec sp_creaPersonaBroker ''CONROY VILDOZO, RAUL FERNANDO''
exec sp_creaPersonaBroker ''CONSEJEROS Y CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''CONSEJEROS Y CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''CONSORCIO VIDA ASESORES Y CORRED DE SEGUROS SAC''
exec sp_creaPersonaBroker ''CONSORCIO VIDA ASESORES Y CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''CONSULTORES Y CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''CONTACTO CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''CONTINENTAL DEL PERU S. A.''
exec sp_creaPersonaBroker ''CONTINENTE ASESORES Y CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''CONTRERAS FUENTES, CARLOS ''
exec sp_creaPersonaBroker ''CONTROL DE RIESGOS S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''CONZA BLANCO, MIRIAM MERCEDES''
exec sp_creaPersonaBroker ''COPAIRA HURTADO GILDA''
exec sp_creaPersonaBroker ''COQUIS ARCELLES, ENRIQUE''
exec sp_creaPersonaBroker ''CORCUERA CARRERA, JORGE HERNAN ''
exec sp_creaPersonaBroker ''CORDERO RODRIGUEZ, OSCAR AUGUSTO ''
exec sp_creaPersonaBroker ''CORDOVA AQUIJE, CAROLINA ELIZABETH ''
exec sp_creaPersonaBroker ''CORDOVA CARRANZA, GABRIEL''
exec sp_creaPersonaBroker ''CORDOVA PALACIOS, JOSE FELIX ''
exec sp_creaPersonaBroker ''CORDOVA PATIÑO, TEODORO LESMES''
exec sp_creaPersonaBroker ''CORDOVA ZAPATA, HECTOR PEDRO''
exec sp_creaPersonaBroker ''CORDOVES GARCIA, MARTHA''
exec sp_creaPersonaBroker ''CORIAT ALVAN, HERMAN FERNANDO''
exec sp_creaPersonaBroker ''CORIAT ALVAN, HERMAN FERNANDO''
exec sp_creaPersonaBroker ''CORIAT, FERNANDO''
exec sp_creaPersonaBroker ''CORNEJO CAMPOS, FERNANDO ''
exec sp_creaPersonaBroker ''CORNEJO MENESES, FERNANDO ANTONIO''
exec sp_creaPersonaBroker ''CORNEJO MIGONE DANILO SANDOR''
exec sp_creaPersonaBroker ''CORNEJO ZEA, JOSE FRANCISCO ''
exec sp_creaPersonaBroker ''CORNO YORI, FRANCO ''
exec sp_creaPersonaBroker ''CORNOCK MARQUINA, NANCY ELIZABETH''
exec sp_creaPersonaBroker ''CORPORACION ASESORA DE SEGUROS SA''
exec sp_creaPersonaBroker ''CORPORATIVA DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''CORRALES BARRERA, OSCAR LUIS J.''
exec sp_creaPersonaBroker ''CORREDORA DE SEGUROS SANTANDER CENTRAL H''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS AQUILES LAOS S. R. L.''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS BRACAMONTE RUIZ REMY S. C. R. L.''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS H.HIDALGO Y CIA.S.''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS MONTERRICO SCRL''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS MUNDO ASESORES S.R.L.''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS MUNDO ASESORES S.R.L.''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS SANTA CRUZ S.R.LTD''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS TORINO S A''
exec sp_creaPersonaBroker ''CORREDORES DE SEGUROS VIP S.A.C.''
exec sp_creaPersonaBroker ''CORROCHANO MORAL, NESTOR GERARDO ''
exec sp_creaPersonaBroker ''CORROCHANO VILLALOBOS, NESTOR''
exec sp_creaPersonaBroker ''CORTAZAR BALTA, HELBA GRACIELA ''
exec sp_creaPersonaBroker ''CORTEGANA GOMEZ, MARIETTA ''
exec sp_creaPersonaBroker ''CORTEZ BARRENECHEA DAVID''
exec sp_creaPersonaBroker ''COSEGUR S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''COSTA BAUER, ALFREDO LUIS ANTONIO MARTIN''
exec sp_creaPersonaBroker ''COSTA PEREZ, CESAR FERNANDO''
exec sp_creaPersonaBroker ''COSTA REBATA, CATALINA''
exec sp_creaPersonaBroker ''COTTLE CROSBY, WILLIAM''
exec sp_creaPersonaBroker ''CREDISEGUROS SAC CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''CRISOSTOMO FERMIN, VICTOR''
exec sp_creaPersonaBroker ''CROVETTO MORENO DE MAQUILON, TERESA ''
exec sp_creaPersonaBroker ''CRUZ QUIROZ Y ASOC CORRED DE SEGUROS SRL''
exec sp_creaPersonaBroker ''CRUZ QUIROZ, CARLOS ALEJANDRO ''
exec sp_creaPersonaBroker ''CRUZ VERA, JOSE ALEJANDRO ''
exec sp_creaPersonaBroker ''CUBA SUAREZ, JORGE JAVIER''
exec sp_creaPersonaBroker ''CUBAS TENA, FERNANDO GUSTAVO''
exec sp_creaPersonaBroker ''CUENCA VELASCO, LUIS ALBERTO''
exec sp_creaPersonaBroker ''CUEVA CANALES, ALDO FERNANDO ''
exec sp_creaPersonaBroker ''CUEVA CANALES, ALDO FERNANDO ''
exec sp_creaPersonaBroker ''D & SC S.A.C. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''D`ACUNHA DELBOY, JORGE IVAN''
exec sp_creaPersonaBroker ''DACUNHA FIGUEROA, JAVIER ARMANDO''
exec sp_creaPersonaBroker ''DAI ICHI CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''DAMMERT REBAGLIATI, CARLOS RAUL ''
exec sp_creaPersonaBroker ''DANESSI ALVAREZ, FRANCO JULIO''
exec sp_creaPersonaBroker ''DANRESA CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''DAVID RAZZETO, MARIO EMILIO''
exec sp_creaPersonaBroker ''DAVILA ALCALDE, ENRIQUE''
exec sp_creaPersonaBroker ''DAVILA ALCALDE, OCTAVIO ENRIQUE''
exec sp_creaPersonaBroker ''DAVILA BELLIDO, VICTOR AMILCAR''
exec sp_creaPersonaBroker ''DAVILA RODRIGUEZ, EDWIN ''
exec sp_creaPersonaBroker ''DAVIS VELIS, JAIME DANIEL''
exec sp_creaPersonaBroker ''DE CASTRO OCAMPO, VICTOR RAUL ''
exec sp_creaPersonaBroker ''DE FLORIO & LOREDO SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''DE GAIA CORREDORES DE SEGUROS E. I. R. L.''
exec sp_creaPersonaBroker ''DE LA COLINA VILANOVA, NAPOLEON ''
exec sp_creaPersonaBroker ''DE LA PUENTE BAZO, LIZANDRO JORGE ''
exec sp_creaPersonaBroker ''DE LA PUENTE FARFAN, OSCAR HUGO''
exec sp_creaPersonaBroker ''DE LA PUENTE QUESADA, JOSE RAFAEL ''
exec sp_creaPersonaBroker ''DE MARZO ARATA, MIGUEL ANGEL ''
exec sp_creaPersonaBroker ''DE MARZO Y ASOCIADOS S.A.C. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''DE NORIEGA MORALES RICARDO FEDERICO''
exec sp_creaPersonaBroker ''DE VINATEA MUÑOZ, JOSE GABRIEL ''
exec sp_creaPersonaBroker ''DEGOLLAR LANTERON, MARIA DEL PILAR''
exec sp_creaPersonaBroker ''DEL AGUILA SCHUTT, CARLOS''
exec sp_creaPersonaBroker ''DEL AGUILA Y ASOCIADOS ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''DEL CAMPO FERNANDEZ DE CORDOVA, LUIS ALFREDO''
exec sp_creaPersonaBroker ''DEL CASTILLO CABALLERO, JAIME RAUL''
exec sp_creaPersonaBroker ''DEL CASTILLO PEREZ, OSCAR JAVIER ''
exec sp_creaPersonaBroker ''DEL CASTILLO TORRES, MANUEL''
exec sp_creaPersonaBroker ''DEL RIO MURILLO, JULIO C.''
exec sp_creaPersonaBroker ''DELGADO CARRETEROS, WILLY ERNESTO''
exec sp_creaPersonaBroker ''DELGADO CORRALES, ARTURO LORENZO ANTOLIN''
exec sp_creaPersonaBroker ''DELGADO CORRALES, PERCY RAUL ''
exec sp_creaPersonaBroker ''DELGADO CORRALES, SAMUEL DAVID ''
exec sp_creaPersonaBroker ''DELGADO DELGADO, LUIS AUGUSTO''
exec sp_creaPersonaBroker ''DELGADO DIAZ, JUAN ''
exec sp_creaPersonaBroker ''DELGADO GONZALES, CARLOS MARTIN''
exec sp_creaPersonaBroker ''DELGADO LUCCHESI, JORGE ERNESTO ''
exec sp_creaPersonaBroker ''DELGADO-VIVANCO LIMACO, ADRIAN EDMUNDO''
exec sp_creaPersonaBroker ''DELPHOS CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''DELTA CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''DESCALZI ARANA, VICTOR MANUEL ''
exec sp_creaPersonaBroker ''DESEGUR E.I.R.L. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''DESMAISON DE RAVAGO, ALEJANDRO ''
exec sp_creaPersonaBroker ''DETEC SA ASESORES Y CORREDORES DE SEGURO''
exec sp_creaPersonaBroker ''DI PAOLO FERRARINI, RENZO AMEDEO GILBERTO ''
exec sp_creaPersonaBroker ''DIAS LEFRANC, HUGO ''
exec sp_creaPersonaBroker ''DIAZ SALAS, JUAN ''
exec sp_creaPersonaBroker ''DIAZ VILLAFANE, ROSARIO ADRIANA''
exec sp_creaPersonaBroker ''DIAZ Y ASOC CORREDOR.ASESOR.DE SGROS SRL''
exec sp_creaPersonaBroker ''DIEZ CANSECO STRUQUE, FEDERICO ''
exec sp_creaPersonaBroker ''DIOSES FARFAN, ARNALDO ''
exec sp_creaPersonaBroker ''DIOSES VIGO, ARNALDO ANTONIO''
exec sp_creaPersonaBroker ''DIRECTOS (AREQUIPA)''
exec sp_creaPersonaBroker ''DONAYRE BARRIOS, ATILIO MARIO''
exec sp_creaPersonaBroker ''DONGO SORIA CHAMPIN, JOSE MIGUEL''
exec sp_creaPersonaBroker ''ECHEANDIA TUDELA, CESAR EMILIO''
exec sp_creaPersonaBroker ''ECHECOPAR KOECHLIN, GERARDO ARTURO''
exec sp_creaPersonaBroker ''ECHEGARAY DE LORA, MARIA TERESA''
exec sp_creaPersonaBroker ''ECHEVARRIA OLAZABAL, LUIS EDUARDO ''
exec sp_creaPersonaBroker ''ECHEVARRIA PAZOS, ROXANA ''
exec sp_creaPersonaBroker ''ECHEVARRIA VICTORIO, JAIME ''
exec sp_creaPersonaBroker ''EDMUNDO ALBERTO ARTOLA POLO Y LA BORDA''
exec sp_creaPersonaBroker ''EDWARDS GARDELLA, CARLOS DOMENICO''
exec sp_creaPersonaBroker ''EL ALAMO SRL PRODUCTORES DE SEGUROS''
exec sp_creaPersonaBroker ''EL DORADO CORREDORES DE SEGUROS E. I. R. L.''
exec sp_creaPersonaBroker ''EL PILAR ASESORES Y CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''ELEANA CASTILLO E. I. R. L. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ELESPURU PEZO, ULISES ''
exec sp_creaPersonaBroker ''ELIAS PLAZA, GERMAN FELIX''
exec sp_creaPersonaBroker ''ELMER LUIS TAY CORREDORES DE SEGUROS S.R.L.''
exec sp_creaPersonaBroker ''ELMO BATANERO CESPEDES''
exec sp_creaPersonaBroker ''ENDIMO AGTES CORREDORES DE SEGUROS S R L''
exec sp_creaPersonaBroker ''ENLACE ASESORES Y CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''ESCOBAR FERNANDEZ, VICTOR RAUL''
exec sp_creaPersonaBroker ''ESPEJO MENDOZA, JULIO ELIER ''
exec sp_creaPersonaBroker ''ESPEJO SOLORZANO, JOSE M''
exec sp_creaPersonaBroker ''ESPINOSA FRENCH, JOSE ENRIQUE''
exec sp_creaPersonaBroker ''ESPINOSA SAAVEDRA, RICARDO ALBERTO''
exec sp_creaPersonaBroker ''ESPINOZA CASTAÑEDA, PEDRO JUSTO''
exec sp_creaPersonaBroker ''ESPINOZA SAAVEDRA, RICARDO''
exec sp_creaPersonaBroker ''ESQUECHE GONZALES, MANUEL ANTONIO ''
exec sp_creaPersonaBroker ''ESQUERRE ROJAS, VICTOR MANUEL ''
exec sp_creaPersonaBroker ''ESTRADA CORDOVA, DANNY GUSTAVO ''
exec sp_creaPersonaBroker ''ESTRADA SEDAMANO, YONY''
exec sp_creaPersonaBroker ''EUROMUNDO CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''F & F DARUICH CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''F NAGARO G Y ASOC CORREDORES DE SEGUROS GENERALES''
exec sp_creaPersonaBroker ''F RODA & ASOCIADOS SA COOREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''F.R.Y ASOCIADOS SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''F.REYES Y CIA.CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''FABIO CARMEN SALMON E I R L''
exec sp_creaPersonaBroker ''FAJARDO KAPPELER, CARMEN ''
exec sp_creaPersonaBroker ''FALCON CUMAPA, RICARDO BENITO''
exec sp_creaPersonaBroker ''FALLA NAVARRO OSCAR REYNALDO''
exec sp_creaPersonaBroker ''FAMEN S. A. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''FARFAN PINO, JOSE FRANCISCO ''
exec sp_creaPersonaBroker ''FAZ ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''FBA CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''FELDMUTH CANOVAS, HARRIET''
exec sp_creaPersonaBroker ''FELIX RUFINO CALLAN RAMOS''
exec sp_creaPersonaBroker ''FERNANDEZ BAUTISTA, VICTOR''
exec sp_creaPersonaBroker ''FERNANDEZ DIAZ, PABLO''
exec sp_creaPersonaBroker ''FERNANDEZ RODRIGUEZ, GIUSSEPE ALI ''
exec sp_creaPersonaBroker ''FERNANDEZ RODRIGUEZ, HUADIA MICAELA''
exec sp_creaPersonaBroker ''FERNANDEZ VERA, GALO GERARDO''
exec sp_creaPersonaBroker ''FERNANDEZ, MARIA CLEMENTINA ''
exec sp_creaPersonaBroker ''FIGUEROA ARTEAGA, RUBEN''
exec sp_creaPersonaBroker ''FIGUEROA COSIO, ROLANDO ERNESTO''
exec sp_creaPersonaBroker ''FIGUEROA LLANOS, TEOBALDO MAX''
exec sp_creaPersonaBroker ''FISHER Y CIA S.A. CORRED. DE SEGUROS''
exec sp_creaPersonaBroker ''FISHER, JUAN CARLOS''
exec sp_creaPersonaBroker ''FLORES ATENCIO, JESSICA''
exec sp_creaPersonaBroker ''FLOREZ JOSE CARLOS (JC CORREDORES)''
exec sp_creaPersonaBroker ''FONSECA BARRIOS, ADOLFO''
exec sp_creaPersonaBroker ''FORT & ROJAS CORREDORES DE SEGUROS S A C''
exec sp_creaPersonaBroker ''FORT VALDEZ, AUGUSTO ''
exec sp_creaPersonaBroker ''FRANCIA DE CALLIRGOS, LEONARDA GRIMALDINA ''
exec sp_creaPersonaBroker ''FRANCO CERDAN, FELIPE AUGUSTO''
exec sp_creaPersonaBroker ''FRANCO FRANCO, JULIA MERCEDES ''
exec sp_creaPersonaBroker ''FREIRE SARRIA, MIGUEL ANGEL''
exec sp_creaPersonaBroker ''FREIRE SARRIA, RAFAEL AUGUSTO ''
exec sp_creaPersonaBroker ''FRIAS ROBLES, JUSTO ANTONIO ''
exec sp_creaPersonaBroker ''FRISANCHO GUADALUPE, EDWIN MARCO''
exec sp_creaPersonaBroker ''FRITZ DIAZ, OSCAR JORGE''
exec sp_creaPersonaBroker ''FULLSEGUROS CORREDORES DE SEGUROS E. I. R. L.''
exec sp_creaPersonaBroker ''FUNES BAILON, CARLOS NICANOR ''
exec sp_creaPersonaBroker ''G ARTURO ALVAREZ CALDERON''
exec sp_creaPersonaBroker ''G. MENDIZABAL & ASOC ASES Y CORRED DE SEG SAC''
exec sp_creaPersonaBroker ''GABEL CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''GAGLIUFFI ALLEMANT, JUAN JOSE''
exec sp_creaPersonaBroker ''GALARZA CUBA, BENJAMIN ''
exec sp_creaPersonaBroker ''GALDOS & ASOCIADOS E I R L CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''GALLASTEGUI DE CHAVEZ, MARTHA IRENE''
exec sp_creaPersonaBroker ''GALVEZ FERRER, CARLOS ALBERTO''
exec sp_creaPersonaBroker ''GAP ASOCIADOS S.A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''GARAY NALVARTE, GENY ROSARIO''
exec sp_creaPersonaBroker ''GARCIA CORDOVA, LUIS ENRIQUE ''
exec sp_creaPersonaBroker ''GARCIA CORTES, ORLANDO H.''
exec sp_creaPersonaBroker ''GARCIA CORTEZ, ORLANDO HUMBERTO ''
exec sp_creaPersonaBroker ''GARCIA CRUZATT, JOSE ANTONIO''
exec sp_creaPersonaBroker ''GARCIA HERRERA, AMPARO''
exec sp_creaPersonaBroker ''GARCIA PALACIOS, JOSE LUIS ''
exec sp_creaPersonaBroker ''GARCIA SEBASTIANI, RICHARD WILFREDO''
exec sp_creaPersonaBroker ''GARCILASO DE LA VEGA FERNANDEZ, JORGE AMADEO ''
exec sp_creaPersonaBroker ''GARRIDO-LECCA ITURBE, GERARDO''
exec sp_creaPersonaBroker ''GASTELO ESCURRA, RICARDO HUMBERTO''
exec sp_creaPersonaBroker ''GAVILANO ALBARRACIN, JULIO CESAR ''
exec sp_creaPersonaBroker ''GENG ASESORES Y CORREDORES DE SEGUROS E.I.R.L.''
exec sp_creaPersonaBroker ''GERENCIA DE RIESGOS ASESORES Y CORREDORES DE SEGURS S R LTDA''
exec sp_creaPersonaBroker ''GERSHMAN WERTHEIMER JOSE EMILIO''
exec sp_creaPersonaBroker ''GERVASI PEREZ, ROLANDO A''
exec sp_creaPersonaBroker ''GIANNONI MULLER, EDUARDO VICTOR''
exec sp_creaPersonaBroker ''GINOCCHIO LEON, MARIO''
exec sp_creaPersonaBroker ''GIRALDO LARA, LUIS ''
exec sp_creaPersonaBroker ''GLOBAL CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''GOACHET RIOS, FERNANDO JULIO ''
exec sp_creaPersonaBroker ''GOICOCHEA DE CAVA, ANA ''
exec sp_creaPersonaBroker ''GOMEZ CABRERA, MARY''
exec sp_creaPersonaBroker ''GOMEZ ESPINOSA, NESTOR ENRIQUE''
exec sp_creaPersonaBroker ''GOMEZ HIDALGO, JORGE WASHINGTON ''
exec sp_creaPersonaBroker ''GOMEZ VELASQUEZ PLAZA, RAUL''
exec sp_creaPersonaBroker ''GOMEZ-SANCHEZ GANOZA, EVARISTO''
exec sp_creaPersonaBroker ''GONZALES DALY MARROU, RICARDO''
exec sp_creaPersonaBroker ''GONZALES DEL VALLE CAB, JORGE LUIS ''
exec sp_creaPersonaBroker ''GONZALES DEL VALLE CABRERA, RICARDO''
exec sp_creaPersonaBroker ''GONZALES JIMENEZ, RENE ALFREDO''
exec sp_creaPersonaBroker ''GONZALES VIGIL PINILLOS Y ASOC.S.A.CORR.''
exec sp_creaPersonaBroker ''GONZALES VILLALOBOS, NELLY NOEMI ''
exec sp_creaPersonaBroker ''GONZALEZ DE NUÑEZ DEL PRADO, DORA INES ''
exec sp_creaPersonaBroker ''GONZALEZ MENDOZA, FEDERICO EDGARDO''
exec sp_creaPersonaBroker ''GONZALEZ MENDOZA, FEDERICO EDGARDO''
exec sp_creaPersonaBroker ''GONZALEZ NEUMANN, ROLANDO ''
exec sp_creaPersonaBroker ''GONZALEZ RUIZ, LUIS RICARDO''
exec sp_creaPersonaBroker ''GONZALO REY DE CASTRO CORR SEG EIRLTDA''
exec sp_creaPersonaBroker ''GRANA ACUNA, SANTIAGO ''
exec sp_creaPersonaBroker ''GRAÑA Y ASOC. CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''GRANADOS SOYER, DOMINGO LEONCIO''
exec sp_creaPersonaBroker ''GRANADOS YUPANQUI, JESUS''
exec sp_creaPersonaBroker ''GRATTA GRANADOS, ALDO ALFREDO''
exec sp_creaPersonaBroker ''GRAY & ASOCIADOS ASESORES Y CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''GRELLAUD DE GONZALEZ, DORA ESTHER''
exec sp_creaPersonaBroker ''GROSS Y ASOCIADOS ASESORES Y CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''GRUPALL DE SEGUROS S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''GRUPO PRADO CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''GUERRERO COLAN, MIRTHA ANGELICA''
exec sp_creaPersonaBroker ''GUERRERO DE LUNA, CARLOS A ''
exec sp_creaPersonaBroker ''GUERRERO FLORES, LUIS ''
exec sp_creaPersonaBroker ''GUERRERO NUÑEZ, AUGUSTO''
exec sp_creaPersonaBroker ''GUERRERO''''S E.I.R.L. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''GUEVARA POLO, JAIME ALBERTO''
exec sp_creaPersonaBroker ''GUIBERT RIOS, HUMBERTO MARTIN ''
exec sp_creaPersonaBroker ''GUIVOVICH FERREYROS, JOSE A ''
exec sp_creaPersonaBroker ''DELGADO FERNANDEZ, GUSTAVO MARTIN ''
exec sp_creaPersonaBroker ''GUTIERREZ GALVEZ, JULIO CESAR''
exec sp_creaPersonaBroker ''H RONDON DE ANGOBALDO DAFNE''
exec sp_creaPersonaBroker ''H.P.& ASOCIADOS CONSULTORES Y CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''HACHA CONTRERAS, JULIO ANTONIO ''
exec sp_creaPersonaBroker ''HALTENHOF RIZO-PATRON, KAREN MARIE''
exec sp_creaPersonaBroker ''HARMAC S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''HARTEN Y ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''HECVE S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''HEREDIA BOCANEGRA, HECTOR MANUEL''
exec sp_creaPersonaBroker ''HERMES ASESORES Y CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''HERNAN MARTIN MANCHEGO ADRIAN''
exec sp_creaPersonaBroker ''HERNANDEZ ASESORES Y CORREDORES DE SEGUROS SA-HERSEG''
exec sp_creaPersonaBroker ''HERRERA ALVAREZ, FABIO''
exec sp_creaPersonaBroker ''HERRERA GAMARRA, DANTE EDUARDO''
exec sp_creaPersonaBroker ''HIADCA CORREDORES DE SEGUROS S.R.LTDA''
exec sp_creaPersonaBroker ''HIDALGO BAZO, LAURA VERONICA''
exec sp_creaPersonaBroker ''HIDALGO BAZO, MIRYAN JESUS ''
exec sp_creaPersonaBroker ''HIDALGO CHAVEZ, JUAN MANUEL''
exec sp_creaPersonaBroker ''HILFREICH DEL PIELAGO, CARLOS ALBERTO''
exec sp_creaPersonaBroker ''HOLGUIN CHAVEZ, LUIS ALBERTO''
exec sp_creaPersonaBroker ''HORNA RODRIGUEZ, VICTOR RAUL''
exec sp_creaPersonaBroker ''HUACHILLO VILLACORTA, BERTHA CRISTINA''
exec sp_creaPersonaBroker ''HUAMAN MARTINEZ, JULIO ''
exec sp_creaPersonaBroker ''HUAMAN SALAZAR EDER''
exec sp_creaPersonaBroker ''HUARICAPCHA DURAND, EDGARDO JORGE ''
exec sp_creaPersonaBroker ''HUERTA SANCHEZ, ALFREDO TOMAS''
exec sp_creaPersonaBroker ''HUERTAS VERA, PEDRO ENRIQUE''
exec sp_creaPersonaBroker ''HUGO DIAS L ASESOR Y CORREDOR DE SEG EIRL''
exec sp_creaPersonaBroker ''HUGO MINAYA ROSALES E. I. R. L.''
exec sp_creaPersonaBroker ''HURTADO HUAMAN, JUAN ''
exec sp_creaPersonaBroker ''IBARBURU LEON, SILVIA REBECA''
exec sp_creaPersonaBroker ''IBERICO BASAURI, DEMETRIO ENRIQUE ''
exec sp_creaPersonaBroker ''ICAZA DE ESPINOZA, VICTORIA ''
exec sp_creaPersonaBroker ''ILLICH FUSTER, EUGENIO ERIK''
exec sp_creaPersonaBroker ''INNOVA GROUP ASESORES Y CORREDORES DE SEGUROS EIRLTDA.''
exec sp_creaPersonaBroker ''INSURANCE BROKERS GROUP''
exec sp_creaPersonaBroker ''INTERANDINA DE SEGUROS S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''IPANAQUE AREVALO, JAVIER ''
exec sp_creaPersonaBroker ''ITAL SEGUROS SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''J E ZOLEZZI CORREDORES DE SEGUROS E I R L''
exec sp_creaPersonaBroker ''J&M ASOCIADOS CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''J.B.CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''J.C. FISHER TUDELA CORREDORES DE SEGUROS E.I.R.L.''
exec sp_creaPersonaBroker ''J.M.ROTALDE & ASOCIADOS S.A.C. COR-SEGU-''
exec sp_creaPersonaBroker ''JAHNSEN LECCA, ERIK MARTIN''
exec sp_creaPersonaBroker ''JARA AMPUERO, ELIANA ROCIO''
exec sp_creaPersonaBroker ''JARA BOLOÑA, ALFONSO NICANOR ''
exec sp_creaPersonaBroker ''JARA MINUCHE, MARITZA''
exec sp_creaPersonaBroker ''JARAMILLO VARGAS, LUIS ALBERTO''
exec sp_creaPersonaBroker ''JC CORREDORES DE SEGUROS E. I. R. L.''
exec sp_creaPersonaBroker ''JEF ASESORES Y CONSULTORES S. A. C.''
exec sp_creaPersonaBroker ''WILLIS CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''WILLIS CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''WILLIS CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''JIMENO MORA, MAXIMILIANA ANGELICA ''
exec sp_creaPersonaBroker ''JORDAN-RABI ASOCIADOS S.A. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''JORGE R LLOSA BARBER EIRL''
exec sp_creaPersonaBroker ''JUAN HIDALGO CHAVEZ E I R L CORRE SEGURO''
exec sp_creaPersonaBroker ''JUNGBLUTH MUÑOZ, EDGAR H.''
exec sp_creaPersonaBroker ''JURGENS CARBAJAL, EDUARDO ''
exec sp_creaPersonaBroker ''JUSCAMAITA MEDINA, HENRY RAUL ''
exec sp_creaPersonaBroker ''JVC & ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''KOC BECERRA JUAN OSCAR''
exec sp_creaPersonaBroker ''KOSMOS AG. CORREDORES DE SEGS. S.A.''
exec sp_creaPersonaBroker ''KUKURELO ROSENTHAL, JUAN CARLOS''
exec sp_creaPersonaBroker ''LA GUADALUPANA, AGTS SEGUROS''
exec sp_creaPersonaBroker ''LA MOTIVACION S. A.''
exec sp_creaPersonaBroker ''LA PREVISORA ASES.Y CORRE.DE SEGUROS S.A''
exec sp_creaPersonaBroker ''LA PROFESIONAL S.R.LTDA''
exec sp_creaPersonaBroker ''LA PROTECTORA CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''LA ROSA ARREDONDO, ANDRES ''
exec sp_creaPersonaBroker ''LA ROSA URIBE, ALEJANDRO NICANOR ''
exec sp_creaPersonaBroker ''LA UNION CORREDORES DE SEGUROS S A C''
exec sp_creaPersonaBroker ''LABARTHE CARRANZA, CARLOS JAVIER''
exec sp_creaPersonaBroker ''LADERA ORTIZ, JESUS ANGEL''
exec sp_creaPersonaBroker ''LAGOS MAR, BRUNO''
exec sp_creaPersonaBroker ''LANCHO RAMOS, CARLOS FERNANDO''
exec sp_creaPersonaBroker ''LANDA RIVERA, JOSE VITALIANO ''
exec sp_creaPersonaBroker ''LARA HERRERA, CESAR AUGUSTO''
exec sp_creaPersonaBroker ''LATIN AMERICA S. A. C. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''LATINOAMERICANA PRODUCT DE SEG''
exec sp_creaPersonaBroker ''LAVADO SOTELO, ROGER EPIFANIO ''
exec sp_creaPersonaBroker ''LAVALLE SEMINARIO, SILVIA PATRICIA ''
exec sp_creaPersonaBroker ''LAVINA PEREZ, JORGE ALFREDO ''
exec sp_creaPersonaBroker ''LAYSECA VARELA, JOSE MANUEL''
exec sp_creaPersonaBroker ''LAZO BEGAZO ALVARO ROBERTO''
exec sp_creaPersonaBroker ''LAZO MAC, JORGE GUILLERMO ''
exec sp_creaPersonaBroker ''LENGUA CABRERA, JORGE ''
exec sp_creaPersonaBroker ''LEON ESPANTOSO, EUGENIO MARIA SERGIO''
exec sp_creaPersonaBroker ''LEON ROCHA, CESAR ANDRES''
exec sp_creaPersonaBroker ''LERNER SEGUROS EIRL CORREDORES DE SEGURO''
exec sp_creaPersonaBroker ''LEVI ASOCIADOS S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''LEYTON LUNA, SEGUNDO JUSTO ''
exec sp_creaPersonaBroker ''LINARES LINARES, JOSE MARIA ''
exec sp_creaPersonaBroker ''LINARES VARILLAS, JESUS SALVADOR''
exec sp_creaPersonaBroker ''LINCH SONDER, WASHINGTON ''
exec sp_creaPersonaBroker ''LINCOLN PERUANA CORREDORES DE SEGUROS SR''
exec sp_creaPersonaBroker ''LLAQUE CALDERON, GILBERTO MARIO''
exec sp_creaPersonaBroker ''LLAZA LOAYZA, RONALD ENRIQUE ''
exec sp_creaPersonaBroker ''LLONTOP VIDAL, JAIME FERNANDO''
exec sp_creaPersonaBroker ''LLOSA BARBER, JORGE RICARDO''
exec sp_creaPersonaBroker ''LOBATON GUTIERREZ, MARIO ALBERTO''
exec sp_creaPersonaBroker ''LOBATON SANCHEZ, JOSE LUIS''
exec sp_creaPersonaBroker ''LOC ELSENSOHN, JORGE ''
exec sp_creaPersonaBroker ''LOECHLE SINTY, MARIEBKE ''
exec sp_creaPersonaBroker ''LOPEZ CHANG, GUSTAVO ALBERTO''
exec sp_creaPersonaBroker ''LOPEZ COLON, FERNANDO''
exec sp_creaPersonaBroker ''LOPEZ IBAÑEZ, ALFREDO ''
exec sp_creaPersonaBroker ''LOPEZ IBAÑEZ, ALFREDO ''
exec sp_creaPersonaBroker ''LOPEZ LEGENDRE, CLARISA''
exec sp_creaPersonaBroker ''LOPEZ VIDEIRA, ALFREDO ORLANDO ''
exec sp_creaPersonaBroker ''LORENZETTI MURILLO, MARIA CARMEN''
exec sp_creaPersonaBroker ''LUIS BECERRA E HIJOS CORRED.DE SEG.S.A.''
exec sp_creaPersonaBroker ''LUNA SANTOS, ANGEL ONZARI ''
exec sp_creaPersonaBroker ''LUY LOO, CARLOS''
exec sp_creaPersonaBroker ''MABAMA NUE, ELIAS AURELIO ''
exec sp_creaPersonaBroker ''MAC & ASOCIADOS S. R. L.''
exec sp_creaPersonaBroker ''MACEDO FERNANDEZ, CLAUDIA CECILIA''
exec sp_creaPersonaBroker ''MACEDO NIETO, CARLOS ''
exec sp_creaPersonaBroker ''MACHLER ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MACHUCA BARRIENTOS, ISMAEL''
exec sp_creaPersonaBroker ''MAGAM CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''MAGUINA VARGAS, JHENY FLORLINDA''
exec sp_creaPersonaBroker ''MALAGA AGUERO, LUIS ENRIQUE''
exec sp_creaPersonaBroker ''MALDONADO MOLINA, VICTOR HUGO''
exec sp_creaPersonaBroker ''MALPARTIDA NAVARRO, OSCAR JESUS ''
exec sp_creaPersonaBroker ''MANRIQUE BOTTGER, DIYEE MILAGROS''
exec sp_creaPersonaBroker ''MANRIQUE MALAGA, ADALID''
exec sp_creaPersonaBroker ''MANRIQUE VALDEZ,GUISELLA GABRIELA ''
exec sp_creaPersonaBroker ''MANTILLA VARGAS, SEGUNDO JAVIER''
exec sp_creaPersonaBroker ''MARANZANA ORREGO, EDUARDO ANTENOR''
exec sp_creaPersonaBroker ''MARCE Y ASOCIADOS S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MARCOS SOLIS, GONZALO ESTEBAN''
exec sp_creaPersonaBroker ''MARIACA CHOQUE, WILLIAM''
exec sp_creaPersonaBroker ''MARIATEGUI HEATH CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''MARIMON Y ASOCIADOS SA CORREDORES DE SEG''
exec sp_creaPersonaBroker ''MARIN TUANAMA, SIMON ''
exec sp_creaPersonaBroker ''MARIO BORDA SBOTO CORREDOR DE SEGUROS EIRL''
exec sp_creaPersonaBroker ''MARROQUIN CANALES, HUGO ''
exec sp_creaPersonaBroker ''MARSH PERU S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MARSH PERU S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MARTELL VALLEJOS, PEDRO''
exec sp_creaPersonaBroker ''MARTHANS ASOCIADOS SRL CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MARTINEZ ZEGARRA, DALIA''
exec sp_creaPersonaBroker ''MAS R. DE VILLA, ROSA''
exec sp_creaPersonaBroker ''MASIAS QUIROGA, AURELIO GUILLERMO''
exec sp_creaPersonaBroker ''MASIAS, AURELIO''
exec sp_creaPersonaBroker ''MATSUMURA KATAYAMA, CESAR AUGUSTO''
exec sp_creaPersonaBroker ''MAURI HARO, MARIA ROSA''
exec sp_creaPersonaBroker ''MAZUELOS ZAVALA, CARMEN ''
exec sp_creaPersonaBroker ''MAZZINI EGOAVIL, DIONEL RIGOBERTO ''
exec sp_creaPersonaBroker ''MEJIA ANTONIO, CLEMENTE MARIO ''
exec sp_creaPersonaBroker ''MEJIA BAZAN, WALTER MERCEDES''
exec sp_creaPersonaBroker ''MEJIA RODRIGUEZ, MIGUEL ANGEL''
exec sp_creaPersonaBroker ''MELCHOR INFANTES, RONALD''
exec sp_creaPersonaBroker ''MELCHOR SOLIS, SABINO CLEMENTE ''
exec sp_creaPersonaBroker ''MELENDEZ & ASOCIADOS CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''MELZI ASOCIADOS S.A.C. CORRED.DE SEGUROS''
exec sp_creaPersonaBroker ''MELZI GARDELLA, HERNANI ''
exec sp_creaPersonaBroker ''MENDEZ LEON, CARLOS MANUEL ''
exec sp_creaPersonaBroker ''MENDO MECHAN, MIRIAN DEL PILAR''
exec sp_creaPersonaBroker ''MENDOZA GONZALES, PEDRO ENRIQUE ''
exec sp_creaPersonaBroker ''MENDOZA PRADO, CARLOS ARTURO''
exec sp_creaPersonaBroker ''MENDOZA TENEMAS, RAFAEL ARTURO''
exec sp_creaPersonaBroker ''MERCADO ANDINO SERVICIO DE ASESORAMIENTO SA ASESORES Y CORRE''
exec sp_creaPersonaBroker ''MESONES SERREPE, CARLOS DENNIS ''
exec sp_creaPersonaBroker ''METROPOLITANA CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''MEY MACCAGNO, LESLIE ORLANDO ''
exec sp_creaPersonaBroker ''MEZA CAMPANA, JOSE ENRIQUE''
exec sp_creaPersonaBroker ''MEZA RICCI, OSCAR ALBERTO ''
exec sp_creaPersonaBroker ''MEZA VILLENA, LUIS CESAR ''
exec sp_creaPersonaBroker ''MEZA VILLENA, VICTOR MIGUEL''
exec sp_creaPersonaBroker ''MIFFLIN CASTILLO, JACQUELINE MARTINA ''
exec sp_creaPersonaBroker ''MIGESA CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''MIGOTTO CABRERA, ELIZABETH PAOLA ''
exec sp_creaPersonaBroker ''MILENIUM CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''MINAYA BROKERS SRL CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MIRANDA MARINI, NAZARIO ''
exec sp_creaPersonaBroker ''MN & ASOCIADOS ASESORES Y CORREDORES SEGURO S. A.''
exec sp_creaPersonaBroker ''MOHR MILLA, MAXIMILIANO ORLANDO ''
exec sp_creaPersonaBroker ''MOLINA SALAS, ROSANA JACINTA ''
exec sp_creaPersonaBroker ''MOLINA SUAREZ, JULIO ALFREDO''
exec sp_creaPersonaBroker ''MONT LAY, WILFREDO SAMUEL''
exec sp_creaPersonaBroker ''MONT Y ASOCIADOS CORREDORES DE SEGUROS (DE BAJA-NELLA ANDUJA''
exec sp_creaPersonaBroker ''MONTALVO CHERO, ANDRES''
exec sp_creaPersonaBroker ''MONTEAGUDO SANTISTEBAN, FEDERICO ''
exec sp_creaPersonaBroker ''MONTENEGRO & MONT S R LTDA ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MONTENEGRO CHAVEZ, JORGE ''
exec sp_creaPersonaBroker ''MONTENEGRO POEMAPE, CARLOS VICTOR''
exec sp_creaPersonaBroker ''MONTOYA LOPEZ, APOLINAR ESTUARDO ''
exec sp_creaPersonaBroker ''MONTOYA WEILL, JAIME ALEJANDRO ''
exec sp_creaPersonaBroker ''MORA MIRANDA, PERCY JESUS''
exec sp_creaPersonaBroker ''MORALES PURIZAGA, GERMAN EDUARDO''
exec sp_creaPersonaBroker ''MORALES UBILLUS, LUIS FELIPE''
exec sp_creaPersonaBroker ''MORALES YABAR, ROSARIO AURISTELA ''
exec sp_creaPersonaBroker ''MORÁN CAMONES, ALEJANDRO JOSÉ ''
exec sp_creaPersonaBroker ''MORANTE ESPINOZA, MANUEL ADRIAN ''
exec sp_creaPersonaBroker ''MORENO CORREDORES DE SEGUROS S R LTDA''
exec sp_creaPersonaBroker ''MORENO GARCIA , RAMON ''
exec sp_creaPersonaBroker ''MORI HIDALGO, ROBINSON''
exec sp_creaPersonaBroker ''MORY DE DE LA CADENA, NANCY ''
exec sp_creaPersonaBroker ''MOSCOLL LOZADA, ALDO ARTURO ''
exec sp_creaPersonaBroker ''MOSCOSO AREVALO, CARMEN PETRONILA''
exec sp_creaPersonaBroker ''MOSCOSO CARRASCO, ENRIQUE FERNANDO''
exec sp_creaPersonaBroker ''MOSCOSO LOPEZ, GUSTAVO ALONSO''
exec sp_creaPersonaBroker ''MUJICA GRIPPA, FRANCISCO DAVID''
exec sp_creaPersonaBroker ''MULTISEGUROS S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''MUÑIZ GUTIERREZ, JAVIER VICTOR''
exec sp_creaPersonaBroker ''MUÑOZ COUTO, WALTER NELSON ''
exec sp_creaPersonaBroker ''MURAKAMI MUNEMURA, GABY KIMI ''
exec sp_creaPersonaBroker ''NAGATOME NAGATOME, JUAN''
exec sp_creaPersonaBroker ''NAPOLEON J DE LA COLINA SRL ASES Y CORRED DE SEGUROS''
exec sp_creaPersonaBroker ''NARVAEZ URIBE GUSTAVO JESUS''
exec sp_creaPersonaBroker ''NARVARTE DELGADO, FERNANDO ''
exec sp_creaPersonaBroker ''NAYLAM PRODUCTORES DE SEGUROS SRLTDA LIQ''
exec sp_creaPersonaBroker ''NELLY NOEMI GONZALES VILLALOBOS E I R L (N.G.V)''
exec sp_creaPersonaBroker ''NERIO RACCHUMI, EDUARDO ''
exec sp_creaPersonaBroker ''NIETO GALVAN, OSCAR RAUL''
exec sp_creaPersonaBroker ''ÑIQUE AGREDA DE MIRANDA, MIRELLA ESTHER ''
exec sp_creaPersonaBroker ''NOMBERA CASTRO, VICTOR ENRIQUE ''
exec sp_creaPersonaBroker ''NOR PERUANA CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''NORIEGA CERDAN, JORGE SANTIAGO''
exec sp_creaPersonaBroker ''NOVACK SOLINKA MOLINERO NANO''
exec sp_creaPersonaBroker ''NOVOA ARRUE MARCO ANTONIO ''
exec sp_creaPersonaBroker ''NOVOA CASTRO, RAFAEL GUILLERMO''
exec sp_creaPersonaBroker ''NOYA PORTELA, HECTOR ANDRES''
exec sp_creaPersonaBroker ''NUÑEZ CARAZAS, CARMEN NORMA ''
exec sp_creaPersonaBroker ''NUÑEZ CHAVARRY, MODESTO FRANCISCO''
exec sp_creaPersonaBroker ''NUÑEZ MALPARTIDA, CESAR MARTIN''
exec sp_creaPersonaBroker ''NUÑEZ MALPARTIDA, ROMULO ''
exec sp_creaPersonaBroker ''NUÑEZ MELGAR AYLLON, JORGE FERNANDO''
exec sp_creaPersonaBroker ''NUÑEZ RODRIGUEZ, GONZALO ''
exec sp_creaPersonaBroker ''NUSSER DAMMERT, ADOLFO E.''
exec sp_creaPersonaBroker ''OBANDO SANGUINETTI, LUIS MARCOS''
exec sp_creaPersonaBroker ''OBREGON RIBBECK, FELIPE''
exec sp_creaPersonaBroker ''OCHOA MACEDO, HECTOR ENRIQUE''
exec sp_creaPersonaBroker ''OJEDA Y CIA AGENTES CORRED DE SEG S R L''
exec sp_creaPersonaBroker ''OLARESCU ASESORES Y CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''OLIVA DE RUEDA, CECILIA''
exec sp_creaPersonaBroker ''OLIVARES & ASOC.S.A.ASES.Y CORRE.DE SEG.''
exec sp_creaPersonaBroker ''OLIVARES ROMERO, JOSE JULIAN ''
exec sp_creaPersonaBroker ''OLORTEGUI BARTRA, JULIO HERNANDO ''
exec sp_creaPersonaBroker ''OLORTEGUI YOMONA, HILDEBRANDO''
exec sp_creaPersonaBroker ''OMEGA S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''OMERLAG ASESORES Y CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''OPERACIONES Y SEGUROS S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ORDOÑEZ ROJAS, ANGELITA PILAR ''
exec sp_creaPersonaBroker ''ORELLANA LA TORRE JULIO ROBERTO''
exec sp_creaPersonaBroker ''ORGANIZACION BAMBAREN ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ORMEÑO CAYCHO, VICTOR JULIO''
exec sp_creaPersonaBroker ''OROZCO MARTELL, CARLOS FRANCISCO''
exec sp_creaPersonaBroker ''ORPAS CORREDORES DE SEGUROS S R LTDA''
exec sp_creaPersonaBroker ''ORTEGA NOVELLA EFRAIN FERNANDO''
exec sp_creaPersonaBroker ''ORTIZ GONZALEZ, JOSE ANTONIO''
exec sp_creaPersonaBroker ''OTA KANASHIRO, ELIO CESAR''
exec sp_creaPersonaBroker ''OTERO MENDIZABAL, JOSE ORLANDO''
exec sp_creaPersonaBroker ''OTERO NAVARRO ASOCIADOS CORREDORES DE SEGUROS S.R.L.''
exec sp_creaPersonaBroker ''OTERO SALCEDO, RICARDO ZENON''
exec sp_creaPersonaBroker ''OTES - TALARA''
exec sp_creaPersonaBroker ''OTES S.A. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''OVIEDO SALAS GUSTAVO RAUL''
exec sp_creaPersonaBroker ''OVIEDO SALAS, MANUEL ANTONIO''
exec sp_creaPersonaBroker ''OVIEDO SALAZAR, BENJAMIN ''
exec sp_creaPersonaBroker ''PACCHIONI ALFARO, GRACCO DARCCO CARLO ''
exec sp_creaPersonaBroker ''PACCHIONI VALDEZ AGENTES ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''PACCHIONI VALDEZ, ALAN FELIPE''
exec sp_creaPersonaBroker ''PACHAS PAZOS, MIGUEL ENRIQUE''
exec sp_creaPersonaBroker ''PACHECO I ALOSILLA VIRGINIO REINALDO''
exec sp_creaPersonaBroker ''PACHECO SERINA, JAVIER EDUARDO ''
exec sp_creaPersonaBroker ''PADILLA PASSUNI, JAIME''
exec sp_creaPersonaBroker ''PAICO MORALES, CESAR ENRIQUE ''
exec sp_creaPersonaBroker ''PAJARES GUTIERREZ, JUAN ANTONIO MARTIN''
exec sp_creaPersonaBroker ''PALACIOS DE JORDAN, CARMEN GRACIELA ''
exec sp_creaPersonaBroker ''PALACIOS SALZAZAR, HERBERT MARTIN''
exec sp_creaPersonaBroker ''PALMA REYES, ROSARIO AURORA''
exec sp_creaPersonaBroker ''PALOMINO BECERRA, MANUEL ENRIQUE ''
exec sp_creaPersonaBroker ''PALOMINO ROJAS, CARMEN MARINA''
exec sp_creaPersonaBroker ''PALOMINO VICENTE, RUTH JANET ''
exec sp_creaPersonaBroker ''PANAY LAOS, ADOLFO BAUDILIO''
exec sp_creaPersonaBroker ''PANICHI PARDAVE, BRUNO MARTIN''
exec sp_creaPersonaBroker ''PANTA NUÑEZ DEL PRADO, FLOR DE AZUCENA''
exec sp_creaPersonaBroker ''PARDO FIGUEROA GARCIA, HORACIO RICARDO ''
exec sp_creaPersonaBroker ''PARDO FIGUEROA OSORES, CESAR EMILIO''
exec sp_creaPersonaBroker ''PARDO FIGUEROA Y ASOCIADOS SA''
exec sp_creaPersonaBroker ''PARDO-FIGUEROA GARCIA, HORACIO RICARDO ''
exec sp_creaPersonaBroker ''PAREDES GARCIA, MANUEL JAVIER ''
exec sp_creaPersonaBroker ''PARODI TRECE, AUGUSTO MARTIN''
exec sp_creaPersonaBroker ''PASSALACQUA SOTO, CARLOS ANTONIO''
exec sp_creaPersonaBroker ''PASTOR CHAVEZ, MANUEL ALEJANDRO''
exec sp_creaPersonaBroker ''PATIÑO PIMENTEL, CARLOS ANTONIO ''
exec sp_creaPersonaBroker ''PAZ CAPPELLETTI, LUIS ANGEL''
exec sp_creaPersonaBroker ''PAZ SOLDAN IZARNOTEGUI, LUIS EDMUNDO''
exec sp_creaPersonaBroker ''PEDREROS CARRANZA, ALFREDO ''
exec sp_creaPersonaBroker ''PEDRO ENRIQUE HUERTAS VERA E I R L''
exec sp_creaPersonaBroker ''PEÑA DEGREGORI, LUIS GUILLERMO''
exec sp_creaPersonaBroker ''PEÑA VELIT, ALVARO CAYETANO''
exec sp_creaPersonaBroker ''PENACHI BARTUREN, ISRAEL''
exec sp_creaPersonaBroker ''PENELAS-RONSO MENDEZ, ARTURO MARTIN ''
exec sp_creaPersonaBroker ''PENNY BIDEGARAY, RICHARD JUAN''
exec sp_creaPersonaBroker ''PERALES BOTTERI S.A.(PEBOSA) AG.CORR.SEG''
exec sp_creaPersonaBroker ''PERALTA FONTIS, JOSE LUIS''
exec sp_creaPersonaBroker ''PERALTA GOMEZ, DIANA DORIS''
exec sp_creaPersonaBroker ''PEREA DE ZARAYASI, ELSA GRACIELA ''
exec sp_creaPersonaBroker ''PEREIRA TERRONES, SONIA TEODELINDA ''
exec sp_creaPersonaBroker ''PEREYRA PACHECO, RICARDO ''
exec sp_creaPersonaBroker ''PEREYRA RAMIREZ, AUGUSTO ''
exec sp_creaPersonaBroker ''PEREYRA TERRONES, SONIA ''
exec sp_creaPersonaBroker ''PEREZ ALBELA CASTRILLON, LUIS DANTE''
exec sp_creaPersonaBroker ''PEREZ CALLE, RICARDO ANIBAL''
exec sp_creaPersonaBroker ''PEREZ LEZCANO, IVAN ALONSO ''
exec sp_creaPersonaBroker ''PEREZ PADILLA, OSCAR''
exec sp_creaPersonaBroker ''PEREZ SUAREZ, HUMBERTO ''
exec sp_creaPersonaBroker ''PEREZ-ROSAS FERREIRA, ALFONSO ''
exec sp_creaPersonaBroker ''PERLA PORRAS, EMILIO''
exec sp_creaPersonaBroker ''PERSICO RENGIFO, YVAN ''
exec sp_creaPersonaBroker ''PERSONAS CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''PERU SEGURO ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''PEZO PATIÑO, HILARIO WILBERT ''
exec sp_creaPersonaBroker ''PIMENTEL RUIZ, MARCO A ''
exec sp_creaPersonaBroker ''PINEDO BADURELES, JUAN ENRIQUE ''
exec sp_creaPersonaBroker ''PINILLOS GIANNONI, ANTONIO BERNARDO JUAN''
exec sp_creaPersonaBroker ''PITA REYNA, FRANCISCO NEPALTI''
exec sp_creaPersonaBroker ''PIZARRO ALMARZA, ALEJANDRO GALVARINO''
exec sp_creaPersonaBroker ''PLATH RAMOS, LUIS PATRICK''
exec sp_creaPersonaBroker ''PLEYADE PERU CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''POLANCO BARRIOS, SANTIAGO''
exec sp_creaPersonaBroker ''POLISEGUROS S.A. ASESORES Y CORREDORES D''
exec sp_creaPersonaBroker ''POOL Y ASOCIADOS S.A. CORRED. DE SEGUROS''
exec sp_creaPersonaBroker ''PORTUONDO LANDEO, PAUL PABLO ''
exec sp_creaPersonaBroker ''PORTUONDO MATOS, ALFONSO ALEJANDRO''
exec sp_creaPersonaBroker ''PRADA RUIZ, MARTHA IRAIDA ''
exec sp_creaPersonaBroker ''PRADO & ASOCIADOS CORRED Y ASES DE SEG''
exec sp_creaPersonaBroker ''PRADO VALVERDE, CARLOS LORENZO ''
exec sp_creaPersonaBroker ''PREMIUM S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''PRIANO SOBERON, ATILIO FELIX''
exec sp_creaPersonaBroker ''PRIMERA CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''PRO PAREDES, JUSTO DANIEL''
exec sp_creaPersonaBroker ''PROAÑO SCOTTO, LUIS ALBERTO ''
exec sp_creaPersonaBroker ''PROCHAZKA DEMARINI, CARMEN CLEMENCIA ''
exec sp_creaPersonaBroker ''PROCYON S A CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''PRODUCTORES DE SEGUROS MENDOZA SRL PROSE''
exec sp_creaPersonaBroker ''PROFESIONALES EN SEGUROS S.A. C. EN S.''
exec sp_creaPersonaBroker ''PROGRESS S. A. C. CONSULTORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''PROMOTORA ANDINA CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''PROMOTORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''PRORENTA S. A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''PROTTO ZAVALA, FIORELLA VIVIANA''
exec sp_creaPersonaBroker ''PROVISEG CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''PULGAR ALBERTI, ELIANA ANGELICA ''
exec sp_creaPersonaBroker ''QUATTRINI BURGA-CISNERO, JULIO ''
exec sp_creaPersonaBroker ''QUEROL DE ARANA, ELIZABETH ''
exec sp_creaPersonaBroker ''QUIJADA ARIAS JOSE LUIS''
exec sp_creaPersonaBroker ''QUIJANDRIA CHUTON, CESAR HUMBERTO''
exec sp_creaPersonaBroker ''QUIJANO ASOCIADOS SRL AG PROD DE SEGS''
exec sp_creaPersonaBroker ''QUINECHE LA ROSA, RAUL ENRIQUE''
exec sp_creaPersonaBroker ''QUINTANILLA GIBAJA, MARIA DEL CARMEN''
exec sp_creaPersonaBroker ''QUIROZ ARROSPIDE, HECTOR JESUS''
exec sp_creaPersonaBroker ''QUIROZ PAULET, CESAR AUGUSTO ''
exec sp_creaPersonaBroker ''QUIROZ RIOS, REBECA PATRICIA''
exec sp_creaPersonaBroker ''R & S WONG S A PRODUCTORES DE SEGUROS''
exec sp_creaPersonaBroker ''R.ECHEVARRIA S.R.LTDA.-CORRED.DE SEGUROS''
exec sp_creaPersonaBroker ''RABI DOCARMO, RUBEN JESUS ''
exec sp_creaPersonaBroker ''RACHUMI IBARCENA S.A.C.CORREDORES DE SEG UROS''
exec sp_creaPersonaBroker ''RACHUMI IBARCENA, CESAR AUGUSTO ''
exec sp_creaPersonaBroker ''RAFAEL VELARDE VACA EIRL CORREDORES SEGUROS''
exec sp_creaPersonaBroker ''RAMIREZ BARDALEZ, GERMAN ''
exec sp_creaPersonaBroker ''RAMIREZ Y CASTILLO SAC CORRED DE SEGUROS''
exec sp_creaPersonaBroker ''RAMIREZ Y CASTILO, HUGO ''
exec sp_creaPersonaBroker ''RAMON ARISTIDES QUISPE MORALES''
exec sp_creaPersonaBroker ''RAMOS ROMERO, COSME ''
exec sp_creaPersonaBroker ''RAMOS SALINAS, CARLOS MANUEL''
exec sp_creaPersonaBroker ''RAMOS SOTO, ELVA ''
exec sp_creaPersonaBroker ''RAUL RUIZ DE SOMOCURCIO QUEVEDO''
exec sp_creaPersonaBroker ''RAZURI RAZURI, CARLOS EDUARDO''
exec sp_creaPersonaBroker ''RAZZETO M.DE VERMEJO, LUCRECIA MICAELA ''
exec sp_creaPersonaBroker ''REFULIO FLORES, HAMILTON ''
exec sp_creaPersonaBroker ''REHDER Y ASOCIADOS SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''REISS LABRAÑA MARILEA DANIELA LOLA''
exec sp_creaPersonaBroker ''REISS Y ASOC AGTS DE SEG SCRL''
exec sp_creaPersonaBroker ''RENGIFO LOPEZ, ROBERT LUIS ''
exec sp_creaPersonaBroker ''RENTA VITAL CORREDORES DE SEGUROS S.C.R.LTDA.''
exec sp_creaPersonaBroker ''RENTA VITAL CORREDORES DE SEGUROS S.C.R.LTDA.''
exec sp_creaPersonaBroker ''RENTA VITAL CORREDORES DE SEGUROS S.C.R.LTDA.''
exec sp_creaPersonaBroker ''RENTERIA PIEROLA, VICTOR HUGO ''
exec sp_creaPersonaBroker ''REQUENA LAGORIO, JOSE AUGUSTO''
exec sp_creaPersonaBroker ''REQUENA Y ASOC CORREDORES SEGUROS EIRL''
exec sp_creaPersonaBroker ''REY DE LA CUBA, RAFAEL ENRIQUE''
exec sp_creaPersonaBroker ''REY RECAVARREN, ALVARO FELIPE ''
exec sp_creaPersonaBroker ''REYES ESCARATE, MANUEL R. ''
exec sp_creaPersonaBroker ''REYNA SANCHEZ AIZCORBE, GUSTAVO''
exec sp_creaPersonaBroker ''RIESGO TRANSFERIDO SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''RIESGOS Y SEGUROS S.A.C CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''RIGLOS OLORTEGUI MILAGROS OLGA''
exec sp_creaPersonaBroker ''RIOJA FLORES, ARTURO ''
exec sp_creaPersonaBroker ''RIOS PAZ, JUAN NICANOR''
exec sp_creaPersonaBroker ''RIOS RODRIGUEZ, LUIS F. ''
exec sp_creaPersonaBroker ''RIOS SUAREZ, VICTOR SANTIAGO''
exec sp_creaPersonaBroker ''RIOS VERA-TUDELA, JOSE RAUL''
exec sp_creaPersonaBroker ''RIOS VERA-TUDELA, JUAN PABLO''
exec sp_creaPersonaBroker ''RIOS ZAMORANO JENNIFER ISABEL''
exec sp_creaPersonaBroker ''RISK ASESORES Y CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''RIVERA BRAVO, MARIO RAUL''
exec sp_creaPersonaBroker ''RIVERA QUISPE, ALEJANDRO''
exec sp_creaPersonaBroker ''RIVERA SALAZAR, JUDITH ARELIZA ''
exec sp_creaPersonaBroker ''RIZO PATRON LARRABURE, HUGO LUIS''
exec sp_creaPersonaBroker ''RIZO PATRON, QUINTANA DIEGO''
exec sp_creaPersonaBroker ''ROARPE CORREDORES DE SEGUROS S.A.C.''
exec sp_creaPersonaBroker ''ROAS ESCOBAR, OSCAR JULIO ''
exec sp_creaPersonaBroker ''ROBBIANO DAVIS CORREDORES DE SEGUROS S.A''
exec sp_creaPersonaBroker ''ROBLES GUZMAN PATRICIA NOEMI''
exec sp_creaPersonaBroker ''RODEL SCR LTDA''
exec sp_creaPersonaBroker ''RODRIGO CARPIO-TIRADO, RICARDO ''
exec sp_creaPersonaBroker ''RODRIGUEZ CALDAS, LUIS ARTURO''
exec sp_creaPersonaBroker ''RODRIGUEZ CHEREQUE, HERMINIA LEONOR''
exec sp_creaPersonaBroker ''RODRIGUEZ CHEREQUE, HERMINIA LEONOR''
exec sp_creaPersonaBroker ''RODRIGUEZ GALVEZ, URSULA ESTELA''
exec sp_creaPersonaBroker ''RODRIGUEZ MENESES, MARIA EUGENIA''
exec sp_creaPersonaBroker ''RODRIGUEZ SALAZAR, VICTOR HUGO ''
exec sp_creaPersonaBroker ''RODRIGUEZ VARGAS, DIEGO ANTONIO''
exec sp_creaPersonaBroker ''RODRIGUEZ VELEZ, ALDO MOISES ''
exec sp_creaPersonaBroker ''RODRIGUEZ-ARNAIZ GHIBELLINI, JOSE ''
exec sp_creaPersonaBroker ''ROJAS MANAY E.I.R.L.''
exec sp_creaPersonaBroker ''ROJAS MANAY, JUANA CRISALIDA ''
exec sp_creaPersonaBroker ''ROJAS MANAY, SEGUNDO HECTOR''
exec sp_creaPersonaBroker ''ROJAS TEJADA, WILLIAM ERNESTO ''
exec sp_creaPersonaBroker ''ROJAS VALDERRAMA, JOSE EDUARDO ''
exec sp_creaPersonaBroker ''ROJAS VALDIZAN, ABEL JONAS''
exec sp_creaPersonaBroker ''ROJAS VALENCIA, RICARDO ARTURO ''
exec sp_creaPersonaBroker ''ROLLET PAREJA, JOSE AURELIO ''
exec sp_creaPersonaBroker ''ROMACO S. A. C. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''ROMERO ARTEAGA, CARLOS EDUARDO''
exec sp_creaPersonaBroker ''ROMERO FERNANDEZ, GERARDO EDMUNDO ''
exec sp_creaPersonaBroker ''RONDON BARDON, FELIPE ADEMAR ''
exec sp_creaPersonaBroker ''RONDON RONDON, DAFNE HELENA''
exec sp_creaPersonaBroker ''ROSAS OCHOA, JOSE LUIS''
exec sp_creaPersonaBroker ''RUBIO OYAGUE, JAIME MIGUEL''
exec sp_creaPersonaBroker ''RUEDA ARAGON, CARLOS ALBERTO''
exec sp_creaPersonaBroker ''RUEDA DANCOURT, JOSE ALFREDO''
exec sp_creaPersonaBroker ''RUIZ DE SOMOCURCIO QUEVEDO RAUL CARLOS A''
exec sp_creaPersonaBroker ''RUIZ GARCIA, ULISES''
exec sp_creaPersonaBroker ''RUIZ RAMIREZ, WILLIAM ROBERT ''
exec sp_creaPersonaBroker ''RUSKA Y ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''RUTH AMELIA MARROQUIN DE ALEDO''
exec sp_creaPersonaBroker ''SAAVEDRA GARCIA, GILMER ''
exec sp_creaPersonaBroker ''SAAVEDRA, WERLINGTON''
exec sp_creaPersonaBroker ''SACO GOYZUETA, ALBERTO JAIME''
exec sp_creaPersonaBroker ''SADELCO SEGUROS GENERALES E.I.R.L.''
exec sp_creaPersonaBroker ''SAENZ MELGAR, ELSA MARISA ''
exec sp_creaPersonaBroker ''SALAS MELLA, ERNESTO GERMAN ''
exec sp_creaPersonaBroker ''SALAZAR CASTRO, FRANCISCO''
exec sp_creaPersonaBroker ''SALAZAR VERGARA CESAR AUGUSTO''
exec sp_creaPersonaBroker ''SALAZAR VINUEZA, EUGENIO ALEJANDRO''
exec sp_creaPersonaBroker ''SALCEDO CASASOLA, FREDDY SANTIAGO''
exec sp_creaPersonaBroker ''SALES GOMEZ, JOSE ''
exec sp_creaPersonaBroker ''SALINAS CORNEJO, FABIO ANTONIO ''
exec sp_creaPersonaBroker ''SALINAS DURAN, JAVIER ALFREDO''
exec sp_creaPersonaBroker ''SALINAS FERNANDEZ DAVILA, CARMEN ''
exec sp_creaPersonaBroker ''SALINAS PRADO, FRANCISCO ''
exec sp_creaPersonaBroker ''SALINAS PRADO, RUFFO NATALIO ''
exec sp_creaPersonaBroker ''SALINAS PRODUCT DE SEGUROS ASO''
exec sp_creaPersonaBroker ''SALMON & ASOCIADOS CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SALMON RODRIGUEZ, LUIS ROBERTO ''
exec sp_creaPersonaBroker ''SAM CHOU DE CHANG, SIU MEI''
exec sp_creaPersonaBroker ''SANCHEZ BELLIDO, AURELIO NICOLAS ''
exec sp_creaPersonaBroker ''SANCHEZ DE VAN OORDT, ZOILA''
exec sp_creaPersonaBroker ''SANCHEZ FALLA, JAVIER PEDRO''
exec sp_creaPersonaBroker ''SANCHEZ LEIVA CARLOS ANTONIO''
exec sp_creaPersonaBroker ''SANCHEZ LEON, ENRIQUE ''
exec sp_creaPersonaBroker ''SANCHEZ TALAVERA, JAIME ANDRES''
exec sp_creaPersonaBroker ''SANCHEZ Y ASOCIADOS S.R.L. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SANEZ ALCALDE, JUAN OSWALDO''
exec sp_creaPersonaBroker ''SANTILLAN MOSQUERA, AMALIA MARTINA''
exec sp_creaPersonaBroker ''SANTOLALLA GRACEY DE VASQUEZ, MARITZA AUGUSTA ROXANA''
exec sp_creaPersonaBroker ''SANTOS ASOCIADOS ASESORES Y CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''SARMIENTO CHAUCA, ALBERTO YGNACIO''
exec sp_creaPersonaBroker ''SCERPELLA PORTH, JUAN ENRIQUE ''
exec sp_creaPersonaBroker ''SCOTTINI MELENDEZ, EZIO ULIO ROMANO''
exec sp_creaPersonaBroker ''SEDAN BUTRON, SARA ESTHER ''
exec sp_creaPersonaBroker ''SEGUMAR S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SEGUNDO LEYTON LUNA ASES. Y CORRED. DE SEG.''
exec sp_creaPersonaBroker ''SEGURA ORLANDINI, VICTOR EDUARDO''
exec sp_creaPersonaBroker ''SEGURA RUBIROS, BILLY''
exec sp_creaPersonaBroker ''SEGURESGO S.A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SEGURISSIMO CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''SEGURNET S.A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SEGUROS ASOC CORRED DE SEG SA''
exec sp_creaPersonaBroker ''SEGUROS BUSTAMANTE CORREDORES SEGURO SRL''
exec sp_creaPersonaBroker ''SEGUROS GENERALES SA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SEGUROS MERCANTILES S. A.''
exec sp_creaPersonaBroker ''SEGUROS TECNICOS S. A. C. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SEGURSA S.A. ASESORES Y CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SELVANDES PERUANA SRL CORRED.DE SEGUROS''
exec sp_creaPersonaBroker ''SEMINO LUJAN, GERY ORLANDO ''
exec sp_creaPersonaBroker ''SEMINO MENDEZ, ANDRES ORLANDO ''
exec sp_creaPersonaBroker ''SERRA SUITO, GUILLERMO FERNANDO ''
exec sp_creaPersonaBroker ''SERTZEN MATHEWS, MARCOS ALFREDO''
exec sp_creaPersonaBroker ''SERTZEN ZAPATA, JUAN JOSE''
exec sp_creaPersonaBroker ''SERV.ANA AURORA SAC CORREDORES D SEGUROS''
exec sp_creaPersonaBroker ''SERVAN ROCHA RIGOBERTO''
exec sp_creaPersonaBroker ''SERVAN ROCHA, RIGOBERTO ''
exec sp_creaPersonaBroker ''SERVI S.A. CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SERVIPERU ASESORES Y CORREDORES DE SEGUR''
exec sp_creaPersonaBroker ''SERVISEGUROS S R LTDA CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''SERVS.PROFESIONALES S.A.C. ASESORES Y CORRED.''
exec sp_creaPersonaBroker ''SEVIL CITOLER, MARIA CARMEN ''
exec sp_creaPersonaBroker ''SIFUENTES OLAECHEA, LUIS ENRIQUE''
exec sp_creaPersonaBroker ''SIFUENTES PALACIOS CECILIA''
exec sp_creaPersonaBroker ''SIFUENTES PALACIOS, JAVIER GONZALO E. ''
exec sp_creaPersonaBroker ''SILVA PARRA, JORGE ANGEL''
exec sp_creaPersonaBroker ''SILVA-SANTISTEBAN BENZA, MARIELA''
exec sp_creaPersonaBroker ''SIÑA ESPINOZA, MAXIMILIANO OCTAVIO ''
exec sp_creaPersonaBroker ''SIU IGLESIAS, DORA''
exec sp_creaPersonaBroker ''SOBREVILLA TALAVERA, CARLOS ROBERTO''
exec sp_creaPersonaBroker ''SOLARI MINAYA, RAUL FERNANDO''
exec sp_creaPersonaBroker ''SOLARI VELIT DE TEAS, LILIANA''
exec sp_creaPersonaBroker ''SOLIS MORALES, EVA LUCERO ''
exec sp_creaPersonaBroker ''SORIA RIVERA, LUIS''
exec sp_creaPersonaBroker ''SORIANO PADILLA, NINA ROSALIA ''
exec sp_creaPersonaBroker ''SOSA CACERES, JUAN EDUARDO ''
exec sp_creaPersonaBroker ''SOTIL PONCE DE LEON, HECTOR''
exec sp_creaPersonaBroker ''SOTO HIDALGO, HERNAN ''
exec sp_creaPersonaBroker ''STAGNARO GAMIO, MARIA DEL CARMEN''
exec sp_creaPersonaBroker ''STERN CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''STEWART DEL CASTILLO, JAMES ''
exec sp_creaPersonaBroker ''STEWART, FREIRE & ASOCIADOS S.A.C. CORRED.DE SEGUROS''
exec sp_creaPersonaBroker ''STORNAIUOLO BOLANOS, JESUS''
exec sp_creaPersonaBroker ''STREULI HERENCIA, ROBERTO ''
exec sp_creaPersonaBroker ''SUAREZ ESTELA, ANTONINO''
exec sp_creaPersonaBroker ''SUSCRIPTORES Y CORREDORES DE SEGUROS SRL''
exec sp_creaPersonaBroker ''TABOADA MORETTI, CARMEN ALVA''
exec sp_creaPersonaBroker ''TAFUR YNGA, GLADIS PETITA''
exec sp_creaPersonaBroker ''TALAVERA BALLON, ALVARO''
exec sp_creaPersonaBroker ''TALAVERA DE RIVERA, MARIA DEL CARMEN ''
exec sp_creaPersonaBroker ''TALAVERA NUÑEZ, ANGEL ALBERTO''
exec sp_creaPersonaBroker ''TALLEDO PALACIOS, JOSE URBANO ''
exec sp_creaPersonaBroker ''TAMARIZ ADRIANZEN, WALTER''
exec sp_creaPersonaBroker ''TAMARIZ IDIAQUEZ, CARLOS ELISEO ''
exec sp_creaPersonaBroker ''TAPIA MANDUJANO, FIORELLA MARIELLA''
exec sp_creaPersonaBroker ''TECNICOS ESPECIALISTAS ASESORES Y CORREDORES DE SEGUROS S. A. ''
exec sp_creaPersonaBroker ''TEJADA ANGULO, JOSE MANUEL''
exec sp_creaPersonaBroker ''TEJADA MEZA, LUIS FERNANDO ''
exec sp_creaPersonaBroker ''TEVES ESPINOZA, MONICA VIOLETA''
exec sp_creaPersonaBroker ''TIJERO Y PAYET CORREDORES DE SEGUROS S.A''
exec sp_creaPersonaBroker ''TINEO RAMOS, ISABEL ''
exec sp_creaPersonaBroker ''TIPACTI HERNANDEZ, NORMA MARGOT''
exec sp_creaPersonaBroker ''TOLEDO ENRIQUEZ, DIEGO GODOFREDO''
exec sp_creaPersonaBroker ''TORERO AGUIRRE, MARTIN EDUARDO''
exec sp_creaPersonaBroker ''TORI FLORES, LUIS ROBERTO ''
exec sp_creaPersonaBroker ''TORO AGÜERO, WILIAM ''
exec sp_creaPersonaBroker ''TORRE URIZAR ASOCIADOS S. A. CORREDORES SEGUROS''
exec sp_creaPersonaBroker ''TORRES CARCOVICH, JORGE LUIS''
exec sp_creaPersonaBroker ''TORRES CAVA, ALFREDO FELIPE ''
exec sp_creaPersonaBroker ''TORRES CHAVEZ, VICTOR HUMBERTO ''
exec sp_creaPersonaBroker ''TORRES CRIOLLO, EDITH KAROL''
exec sp_creaPersonaBroker ''TORRES CRIOLLO, MARIA TERESA''
exec sp_creaPersonaBroker ''TORRES KONG, RODOLFO ROBERTO''
exec sp_creaPersonaBroker ''TORRES RODRIGUEZ, TOMAS RAMIRO ''
exec sp_creaPersonaBroker ''TORRES ROMAN, ALDO JAVIER''
exec sp_creaPersonaBroker ''TORRES VARGAS, EVENECER ''
exec sp_creaPersonaBroker ''TORRES VILLANUEVA, ANTONIO ''
exec sp_creaPersonaBroker ''TOSO STAGI, ALFREDO''
exec sp_creaPersonaBroker ''TOVAR GOMEZ, RUBEN JOSE''
exec sp_creaPersonaBroker ''TRANSAMERICA CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''TRANSPERUANA CORREDORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''TRISTAN VALDIVIA, BENJAMIN''
exec sp_creaPersonaBroker ''TRUST CORREDORES DE SEGUROS S. C. R. LTDA.''
exec sp_creaPersonaBroker ''TUESTA MONTES DE OCA, JUAN ISAAC''
exec sp_creaPersonaBroker ''UBILLUS CORTEZ, JORGE LUIS''
exec sp_creaPersonaBroker ''UBILLUS CORTEZ, MARIA LUISA''
exec sp_creaPersonaBroker ''UCCELLI & ASOCIADOS S A CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''UCCELLI ROMERO, GUSTAVO''
exec sp_creaPersonaBroker ''UGARTE AYALA, FRANKLIN (NO USAR) ''
exec sp_creaPersonaBroker ''UGARTE AYALA, FRANKLIN CLEMENTE''
exec sp_creaPersonaBroker ''UGARTE AZABACHE, EDWIN FERNANDO''
exec sp_creaPersonaBroker ''UGARTE ESPINOZA, JAVIER ''
exec sp_creaPersonaBroker ''UGARTE ESTRADA, ALBERTO''
exec sp_creaPersonaBroker ''UGARTE SANTOS, CARLOS ALBERTO''
exec sp_creaPersonaBroker ''UGARTE SANTOS, CARLOS ENRIQUE''
exec sp_creaPersonaBroker ''UGAZ ALEGRE, CARLOS ALBERTO''
exec sp_creaPersonaBroker ''ULFE ZAPATA, RAUL AURELIO''
exec sp_creaPersonaBroker ''UMBRELLA ASESORES Y CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''UNIDAD TECNICA S.A. ASES. Y CORR. DE SEG''
exec sp_creaPersonaBroker ''UNISEGUROS CORREDORES DE SEGUROS S.A.''
exec sp_creaPersonaBroker ''UNIVERSAL CORREDORES DE SEGUROS S. A.''
exec sp_creaPersonaBroker ''UNTIVEROS CONTRERAS, MARIA ANTONIA''
exec sp_creaPersonaBroker ''URBINA DE BERNARDIS, VERONICA''
exec sp_creaPersonaBroker ''URIBE LOPEZ, NINA OLENKA ''
exec sp_creaPersonaBroker ''URRUTIA VIDAL, JULIO ANTONIO ''
exec sp_creaPersonaBroker ''VAJDA CHAVEZ, ESTEBAN ''
exec sp_creaPersonaBroker ''VALDERRAMA MARES, JORGE ALBERTO ''
exec sp_creaPersonaBroker ''VALDEZ CORNEJO, PABLO ''
exec sp_creaPersonaBroker ''VALDIVIA MONTERO, CARMEN PATRICIA''
exec sp_creaPersonaBroker ''VALDIVIA RODRIGUEZ, JULIO MAURICIO ''
exec sp_creaPersonaBroker ''VALDIVIA VALDIVIA, GRIMALDO VICTOR ''
exec sp_creaPersonaBroker ''VALENCIA DE LA RIVA, MANUEL''
exec sp_creaPersonaBroker ''VALENCIA ROSAS, JUAN SILVIO ''
exec sp_creaPersonaBroker ''VALENZUELA CHADWICK, MARION''
exec sp_creaPersonaBroker ''VALIENTE DE SALDARRIAGA, VIOLETA''
exec sp_creaPersonaBroker ''VALLE LINT, LUIS NICOLAS''
exec sp_creaPersonaBroker ''VALLE LINT, LUIS NICOLAS ''
exec sp_creaPersonaBroker ''VALLEJOS GASTELO, JAIME ANTONIO''
exec sp_creaPersonaBroker ''VAN GINHOVEN HOLDER, JOHAN ''
exec sp_creaPersonaBroker ''VAREA DURAND, UBALDO CARLOS ''
exec sp_creaPersonaBroker ''VARGAS MASIAS, JAIME ALBERTO ''
exec sp_creaPersonaBroker ''VARGAS NORIEGA, ANDRES RAMON''
exec sp_creaPersonaBroker ''VARGAS PLASENCIA HILDA VIOLETA''
exec sp_creaPersonaBroker ''VARGAS QUINO, CARMEN MARITZA''
exec sp_creaPersonaBroker ''VARGAS RIVERA, LUIS RICARDO''
exec sp_creaPersonaBroker ''VARGAS VILLANES, GABRIELA BEATRIZ ''
exec sp_creaPersonaBroker ''VARIAS LEON , JOSE DOMINGO DARIO ''
exec sp_creaPersonaBroker ''VASQUEZ & ASOC EIRL CORREDORES DE SEGUR''
exec sp_creaPersonaBroker ''VASQUEZ DE OSMA, WILMER FRANCISCO ''
exec sp_creaPersonaBroker ''VASQUEZ MEDINA, FRANCISCO NAPOLEON''
exec sp_creaPersonaBroker ''VASQUEZ PEZO, MIGUEL ''
exec sp_creaPersonaBroker ''VASQUEZ PINEDO, CYNTHIA''
exec sp_creaPersonaBroker ''VASQUEZ PINEDO, PEDRO ''
exec sp_creaPersonaBroker ''VASQUEZ RAMOS, TANIA PATRICIA''
exec sp_creaPersonaBroker ''VASQUEZ URRUNAGA, OSCAR JAVIER''
exec sp_creaPersonaBroker ''VEGA BUENDIA, ZULEMA ''
exec sp_creaPersonaBroker ''VEGA LANDA, SEBASTIAN OSWALDO''
exec sp_creaPersonaBroker ''VEGA ROJAS, LUIS ERNESTO''
exec sp_creaPersonaBroker ''VEGAS VIZARRAGA, JAVIER GUSTAVO''
exec sp_creaPersonaBroker ''VELARDE CUADROS, ADALITH''
exec sp_creaPersonaBroker ''VELARDE NEGRON, JAVIER LUIS ''
exec sp_creaPersonaBroker ''VELASCO CALISAYA, DEMETRIO ''
exec sp_creaPersonaBroker ''VELASCO DE LA RIVA, VICTOR EDUARDO ''
exec sp_creaPersonaBroker ''VELASCO FERNANDEZ, FRANCISCO JAVIER ''
exec sp_creaPersonaBroker ''VELASCO VASQUEZ, ROBERTO''
exec sp_creaPersonaBroker ''VELASQUEZ ALAYO, CESAR ABEL ''
exec sp_creaPersonaBroker ''VELASQUEZ CUETO, JOSE ANTONIO ANIBAL ''
exec sp_creaPersonaBroker ''VELASQUEZ VELASQUEZ, LUIS JOSE ANTONIO''
exec sp_creaPersonaBroker ''VELEZ - VAUPEL & ASOCIADOS S.A. ASESORES Y CORREDORES DE SEGUROS ''
exec sp_creaPersonaBroker ''VELEZ BELSUZARRI, VIVIAN GABRIELA''
exec sp_creaPersonaBroker ''VENTO FIGUEROA, JOSE DEL CARMEN ''
exec sp_creaPersonaBroker ''VENTO SAYAN, SARA''
exec sp_creaPersonaBroker ''VERA LORA, MIGUEL AUGUSTO ''
exec sp_creaPersonaBroker ''VERANSA CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''VERGANI CHAVEZ, MARIA OLGA A. ''
exec sp_creaPersonaBroker ''VERGARA RASILLA, ANABELLA JESUS ''
exec sp_creaPersonaBroker ''VERMEJO RAZZETO, GUILLERMO LUIS ''
exec sp_creaPersonaBroker ''VERTIZ VERGARA, MANUEL ''
exec sp_creaPersonaBroker ''VERTIZ VERGARA, MANUEL ANTONIO''
exec sp_creaPersonaBroker ''VIACAVA VARGAS, HUMBERTO JUAN''
exec sp_creaPersonaBroker ''VICKY S R L CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''VIDAL & VIDAL CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''VIDAL INTI ASES. Y CORRED. DE SEGUROS SA''
exec sp_creaPersonaBroker ''VIDAL INTI ASES. Y CORRED. DE SEGUROS SA''
exec sp_creaPersonaBroker ''VIDAL INTI ASES. Y CORRED. DE SEGUROS SA''
exec sp_creaPersonaBroker ''VIDARTE GARCIA, DINA ANA MARIA''
exec sp_creaPersonaBroker ''VIDAURRAZAGA RISCO, JOSE LUIS ''
exec sp_creaPersonaBroker ''VILDOSO ZUMAETA, LUIS ''
exec sp_creaPersonaBroker ''VILLAFUERTE MEDINA, FERNANDO''
exec sp_creaPersonaBroker ''VILLAGRA VALENCIA, GUILLERMO''
exec sp_creaPersonaBroker ''VILLAIZAN NAVARRO, JUAN ''
exec sp_creaPersonaBroker ''VILLALOBOS ARCA, RICARDO ''
exec sp_creaPersonaBroker ''VILLANUEVA MENDIOLA, HIPOLITO ARTURO''
exec sp_creaPersonaBroker ''VILLANUEVA MEZA, NELLY PATRICIA ''
exec sp_creaPersonaBroker ''VILLANUEVA MILLA, HIPOLITO ''
exec sp_creaPersonaBroker ''VILLAVICENCIO LOMPARTE, RICARDO JUAN ''
exec sp_creaPersonaBroker ''VILLEGAS NIETO, EMILIO ARTEMIO''
exec sp_creaPersonaBroker ''VILLEGAS NIETO, VICTOR''
exec sp_creaPersonaBroker ''VILLEGAS TEJADA JUAN RAUL''
exec sp_creaPersonaBroker ''VILLENA RUEDA, FEDERICO ''
exec sp_creaPersonaBroker ''VINATEA MARINI, ABEL DARIO ''
exec sp_creaPersonaBroker ''VINATEA MARINI, ENRIQUE ELFRI ''
exec sp_creaPersonaBroker ''VISION CORREDORES DE SEGUROS S. A. C.''
exec sp_creaPersonaBroker ''VIVAS ASESORES Y CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''VIVIANA VELEZ O. CORREDORES DE SEGUROS E.I.R.L.''
exec sp_creaPersonaBroker ''VIZARRETA CUETO, ALEJANDRO ''
exec sp_creaPersonaBroker ''W Y S ASOCIADOS CORREDORES DE SEGUROS SA''
exec sp_creaPersonaBroker ''WHITTEMBURY SABLICH, CELSO''
exec sp_creaPersonaBroker ''WILIAM TORO A.CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''WITT S.A., CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''WONG PALOMINO, JOSE MANUEL''
exec sp_creaPersonaBroker ''WONG VASQUEZ, DANIEL RICARDO''
exec sp_creaPersonaBroker ''WOODMAN CONSULTORES Y CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''WOODMAN ROJAS, FERNANDO JOSE''
exec sp_creaPersonaBroker ''WURST VERGARA, GABRIEL ''
exec sp_creaPersonaBroker ''YAIPEN LLONTOP, HENRRY STALIN ''
exec sp_creaPersonaBroker ''YATACO ALFARO, JULIO CESAR''
exec sp_creaPersonaBroker ''YATACO MATTA, MARTHA LEONOR''
exec sp_creaPersonaBroker ''YATACO ROSAS, FELIPE ''
exec sp_creaPersonaBroker ''YLLATOPA PALOMINO, JORGE ESTEBAN ''
exec sp_creaPersonaBroker ''Z.SALAZAR E. I. R. LTDA.''
exec sp_creaPersonaBroker ''ZAMALLOA FERNANDEZ BACA, GUIDO ''
exec sp_creaPersonaBroker ''ZAPATA BARRIGA, SANTIAGO ALBERTO ''
exec sp_creaPersonaBroker ''ZAPATA SABOGAL, ROSA''
exec sp_creaPersonaBroker ''ZAPATA TEMOCHE, RAMONA LEONOR ''
exec sp_creaPersonaBroker ''ZAVALA CAVASSA, RAUL''
exec sp_creaPersonaBroker ''ZAVALETA RAMOS, MARIA ANGELICA ''
exec sp_creaPersonaBroker ''ZIRENA PEREYRA, GLORIA ''
exec sp_creaPersonaBroker ''ZOLEZZI, JORGE ERNESTO''
exec sp_creaPersonaBroker ''ZOLLNER ALMONTE, JAVIER ALFREDO''
exec sp_creaPersonaBroker ''ZUAZO DEL AGUILA, JESUS SERAFIN''
exec sp_creaPersonaBroker ''ZUBIRIA AMOROS, JUAN ENRIQUE''
exec sp_creaPersonaBroker ''ZUBIRIA JUSTO, DAVID MARTIN''
exec sp_creaPersonaBroker ''ZUÑIGA SANUDO, GUSTAVO MANUEL ''
exec sp_creaPersonaBroker ''ASTONITAS SANCHEZ, MAGNA''
exec sp_creaPersonaBroker ''ARANA QUEROL, MIGUEL RENZO''
exec sp_creaPersonaBroker ''E.G.A. EMPRESARIAL S A C''
exec sp_creaPersonaBroker ''CORIAT GONZALES, YSSAC''
exec sp_creaPersonaBroker ''LA ROSA INJOQUE, DIEGO''
exec sp_creaPersonaBroker ''CALLE ARTEAGA, MIRTHA GENOVEVA''
exec sp_creaPersonaBroker ''CHICO PULIDO, EDMUNDO''
exec sp_creaPersonaBroker ''CUZCANO RIVERA, ARNULFO ARNALDO''
exec sp_creaPersonaBroker ''COPAJA MELENDEZ, JAVIER DESIDERIO''
exec sp_creaPersonaBroker ''ULFE LINARES, RAUL''
exec sp_creaPersonaBroker ''ENALVA PRODUCTORES DE SEGUROS S A''
exec sp_creaPersonaBroker ''LA PROVIDENCIA ASESORES Y CORRED.DE SEGS.''
exec sp_creaPersonaBroker ''DE FLORIO RAMIREZ, MARIO PEDRO''
exec sp_creaPersonaBroker ''PELLANNE LUNA, VICTOR ANDRES''
exec sp_creaPersonaBroker ''GARCIA & BAZALAR CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''PRIALE MAQUINA, MARCOS RAFAEL''
exec sp_creaPersonaBroker ''DIANA PERALTA GOMEZ ASESORES & CORREDORES DE SEGUROS SRL.''
exec sp_creaPersonaBroker ''PAZOS BATTISTINI, FERNANDO''
exec sp_creaPersonaBroker ''BALLON ZEGARRA-BALLON, MANUEL EDUARDO''
exec sp_creaPersonaBroker ''JAST CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''PINTO VICTORIO, LUSI ALBERTO''
exec sp_creaPersonaBroker ''PINTO CASTRO, CELIA''
exec sp_creaPersonaBroker ''CHURA PACOMPIA, GUILLERMO HUGO''
exec sp_creaPersonaBroker ''PIAGGIO PELOSI, RENZO HUGO''
exec sp_creaPersonaBroker ''BARDALES CANAZAS, LUIS ALBERTO''
exec sp_creaPersonaBroker ''VILLACORTA MEDINA, EDGARD WILMAR''
exec sp_creaPersonaBroker ''GOTUZZO BALTA, MARIO GUSTAVO''
exec sp_creaPersonaBroker ''FERRO ARIAS, RICARDO EUGENIO''
exec sp_creaPersonaBroker ''SANABRIA SOLARI, MIGUEL ULISES''
exec sp_creaPersonaBroker ''RIOS VERA-TUDELA CORREDORES DE SEGUROS SAC''
exec sp_creaPersonaBroker ''HERNANDEZ ALVARADO, LUIS EDUARDO''
exec sp_creaPersonaBroker ''MINAYA ROSALES, MANUEL''
exec sp_creaPersonaBroker ''LAGOS LLUQUE, ANGEL''
exec sp_creaPersonaBroker ''APU ASESORES & CORREDORES DE SEGUROS UNIDOS SRL''
exec sp_creaPersonaBroker ''SALAZAR ROMERO, JORGE''
exec sp_creaPersonaBroker ''ACTIVA SAC CORREDORES DE SEGUROS''
exec sp_creaPersonaBroker ''TELLO DE GODINEZ, ELBA''
exec sp_creaPersonaBroker ''TAGLE ROJAS, YANIRE GINA''
exec sp_creaPersonaBroker ''SALAZAR RANGEL, MARTHA YSABEL''
exec sp_creaPersonaBroker ''ALEGRE GIRALDO, MARCO ANTONIO''
exec sp_creaPersonaBroker ''VASQUEZ PINEDO, GISELA PATRICIA''
exec sp_creaPersonaBroker ''ARONI CALDERON, MARINO ROBERTO''






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_PolizaListaFiltros2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgn_PolizaListaFiltros2] 

(
	@asegurado varchar(50) = null,
	@Idcia	varchar (8) = null,
	@numpoliza varchar(20) = null
	
)
AS



DECLARE @sqlSentencia nvarchar(4000)
DECLARE @sqlCondicion nvarchar(4000)
	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	SET NOCOUNT ON;
	
	SET @sqlSentencia = ''   

	SELECT DISTINCT 
                      RGN_POLIZA.polizaId,
		      ISNULL(ADM_PERSONA_3.persona,'''''''') AS Asegurado, 
                      ADM_PERSONA_2.persona AS Aseguradora, 
                      RGN_POLIZA.numeroPoliza, 
                      RGN_RAMO.nombre AS Ramo, 
		      RGN_RIESGO_COBERTURA.nombre AS Cobertura,
		      RGN_PRODUCTO.nombre AS Producto
	


	FROM     dbo.RGN_POLIZA 
		 LEFT OUTER JOIN dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId 
		 LEFT OUTER JOIN dbo.RGN_RIESGO_COBERTURA ON dbo.RGN_POLIZA.riesgoId = dbo.RGN_RIESGO_COBERTURA.riesgoId
	         LEFT OUTER JOIN dbo.RGN_PRODUCTO ON dbo.RGN_POLIZA.productoId = dbo.RGN_PRODUCTO.productoId
                 LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_2 ON dbo.RGN_POLIZA.aseguradoraId = ADM_PERSONA_2.personaId 
                 LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_3 ON dbo.RGN_POLIZA.aseguradoId = ADM_PERSONA_3.personaId 

	WHERE RGN_POLIZA.sistema = ''''N'''' ''
	       
	IF (LEN(@asegurado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ADM_PERSONA_3.persona  like ''''%'' + @asegurado + ''%'''' ) ''				
	end
	
	IF (@Idcia > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( ADM_PERSONA_2.personaId ='' +   @Idcia + '' ) ''				
	end
	
	IF (LEN(@numpoliza) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( RGN_POLIZA.numeroPoliza like ''''%'' + @numpoliza + ''%'''' ) ''				
	end



	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion
	exec (@sqlSentencia)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_PARAMETRO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_PARAMETRO](
	[parametroid] [int] IDENTITY(1,1) NOT NULL,
	[tipoParametro] [varchar](50) NULL,
	[NombreParametro] [varchar](250) NULL,
	[valorParametro] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_ADM_PARAMETRO] PRIMARY KEY NONCLUSTERED 
(
	[parametroid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'ADM_PARAMETRO', N'COLUMN',N'tipoParametro'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Correo | String | Numerico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ADM_PARAMETRO', @level2type=N'COLUMN',@level2name=N'tipoParametro'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ProductoSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ProductoSelectAll] 
    (
      @nombre VARCHAR(250) = null
    )
as 
    BEGIN	
    
        DECLARE @sqlSentence VARCHAR(4000)
        DECLARE @sqlWhere VARCHAR(4000)
		
		SET @sqlWhere = ''''
        SET @sqlSentence = ''	
        SELECT  productoId,
                [nombre],
                descripcion,
                fcrea,
                fupdate,
                estado,
                ucrea,
                uupdate
        FROM    RGN_PRODUCTO
        where   estado <> ''''I'''' ''
        
        if ( LEN(@nombre) > 0 ) 
            BEGIN
                set @sqlWhere = '' AND [RGN_PRODUCTO].[nombre] LIKE ''''%''
                    + @nombre + ''%''''''
            END 
	
        SET @sqlSentence = @sqlSentence + '' '' + @sqlWhere
        exec (@sqlSentence )
    end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_companiasAutoCompleteByPersonName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgenx_companiasAutoCompleteByPersonName] 
(
	@persona varchar(1000)
)
AS
SET NOCOUNT ON;

declare @sqlCommand varchar(1000)

/*select persona, personaId 
FROM  ADM_PERSONA
*/

set @sqlCommand = ''

SELECT persona, personaId 
FROM         ADM_PERSONA
WHERE     (persona LIKE ''''''+ @persona + ''%'''') AND estado = ''''A'''' 
       AND (
             (personaid in (select personaid from ADM_BROKER)) 
              or (personaid in (select aseguradoraid from ADM_CLIENTE))
            ) 
order by persona''

exec (@sqlCommand)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_vcsenabled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_vcsenabled]

as

set nocount on

declare @iObjectId int
select @iObjectId = 0

declare @VSSGUID varchar(100)
select @VSSGUID = ''SQLVersionControl.VCS_SQL''

    declare @iReturn int
    exec @iReturn = master.dbo.sp_OAalter  @VSSGUID, @iObjectId OUT
    if @iReturn <> 0 raiserror('''', 16, -1) /* Can''t Load Helper DLLC */
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_documentosXRiesgoListaFiltro]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_documentosXRiesgoListaFiltro]
    (
      @ramoId numeric(8, 0) = -1,
      @nombre VARCHAR(250) = null 
    )
as 
    DECLARE @sqlSentencia VARCHAR(4000)
    DECLARE @sqlCondicion VARCHAR(4000)
    declare @sqlJoin Varchar(4000)

    SET @sqlSentencia = ''''
    SET @sqlCondicion = ''''
    set @sqlJoin = ''''
	
    SET NOCOUNT ON ;	

    SET @sqlSentencia = ''   	
	 SELECT distinct
        dbo.RGN_REQUISITOS.requisitoId,
        dbo.RGN_REQUISITOS.nombre AS documento
     FROM    dbo.RGN_REQUISITOS ''
     
    IF ( @ramoId <> -1 ) 
        BEGIN		
            set @sqlJoin = '' INNER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId ''
        END
    ELSE 
        BEGIN
            SET @sqlJoin = ''''
        END
				     
    SET @sqlCondicion = ''where dbo.RGN_REQUISITOS.estado = ''''A''''  '' 
          
          
          
          /*(dbo.RGN_REQUISITO_RAMO.ramoId = @ramoId )
                    and dbo.RGN_REQUISITOS.estado = ''''A''''
            order by documento
	
	
    where 1 = 1 ''*/
    IF ( @ramoId <> -1 ) 
        BEGIN
            SET @sqlCondicion = @sqlCondicion
                + '' AND RGN_REQUISITO_RAMO.ramoId = ''
                + CONVERT(VARCHAR(20), @ramoId)
        END
    IF ( LEN(@nombre) > 0 ) 
        BEGIN
          
            set @sqlCondicion = @sqlCondicion
                + '' AND (RGN_REQUISITOS.nombre like''''%'' + @nombre + ''%'''' ) ''				
        end

    set @sqlSentencia = @sqlSentencia + '' '' + @sqlJoin + '' '' + @sqlCondicion
	
	
			
    exec ( @sqlSentencia )
	--PRINT(@sqlSentencia)








--[sp_rgen_documentosXRiesgoListaFiltro] 6, ''''








--    if ( @ramoId <> -1 ) 
--        begin 
--
--            SELECT distinct
--                    dbo.RGN_REQUISITOS.requisitoId,
--                    dbo.RGN_REQUISITOS.nombre AS documento
--            FROM    dbo.RGN_REQUISITOS
--                    INNER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId
--            WHERE   ( dbo.RGN_REQUISITO_RAMO.ramoId = @ramoId )
--                    and dbo.RGN_REQUISITOS.estado = ''A''
--            order by documento
--
--	  
--
--        end
--
--    else 
--        begin
--            SELECT DISTINCT
--                    dbo.RGN_REQUISITOS.requisitoId,
--                    dbo.RGN_REQUISITOS.nombre AS documento
--            FROM    dbo.RGN_REQUISITOS
--                    LEFT OUTER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_REQUISITOS.requisitoId = dbo.RGN_REQUISITO_RAMO.requisitoId
--            WHERE   ( dbo.RGN_REQUISITOS.estado = ''A'' )
--            ORDER BY documento
--	      
--        end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteListaSelectAjustadorNull]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AjusteListaSelectAjustadorNull]
AS
	SET NOCOUNT ON;
SELECT     Asegurado, siniestro, fsiniestro, NroDias, Aseguradora, numAjustePASA, NumeroAjuste, numeroPoliza, Ramo, Reserva, Status, Dias, 
                      observaciones, Ajustador, Broker, ajusteId, siniestroid, ajustadorId, brokerId, aseguradoId, ramoId, Contactoaseguradora, tajusteid
FROM         ListaAjuste
WHERE     (ajustadorId IS NULL)' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TINFORME]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TINFORME](
	[tinformeId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](250) NULL,
	[descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TIPOACTIVIDAD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TIPOACTIVIDAD](
	[tipoActividadId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[TipoActividad] [varchar](100) NULL,
	[Descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_RGN_TIPOACTIVIDAD_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_RGN_TIPOACTIVIDAD_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_RGN_TIPOACTIVIDAD_estado]  DEFAULT ('A'),
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BienAfectadoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE    PROCEDURE [dbo].[sp_rgen_BienAfectadoInsert]
(
	@bienAfectadoId numeric(8,0) = NULL output,
	@ajusteId numeric(8,0),
	@item text = NULL,
	@descripcion text = NULL,
	@localDelBien varchar(100)=NULL,
	@montorep numeric(14,2) = NULL,
	@montosoles numeric(14,2) = NULL,
	@monedaId numeric(8,0),
	@tipoCambio numeric(14,2) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO RGN_BIENAFECTADO
	(
		ajusteId,
		item,
		descripcion,
		montorep,
		montosoles,
		monedaId,
		tipoCambio,
		localDelBien
	)
	VALUES
	(
		@ajusteId,
		@item,
		@descripcion,
		@montorep,
		@montosoles,
		@monedaId,
		@tipoCambio,
		@localDelBien
	)

	SET @Err = @@Error

	SELECT @bienAfectadoId = SCOPE_IDENTITY()

	RETURN @Err
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_MONEDA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_MONEDA](
	[monedaId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NULL,
	[simbolo] [varchar](5) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_ADM_MONEDA] PRIMARY KEY NONCLUSTERED 
(
	[monedaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_UsuarioLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_Rgn_UsuarioLista]
(
	@persona 		varchar(1000),
	@rolId 			numeric,
	@estado 		varchar(1),
	@tipoUsuario  varchar(100),
	@companiaId numeric(5,0)
)
AS

	DECLARE @sqlSentencia nvarchar(4000)
	DECLARE @sqlCondicion nvarchar(4000)
	
	SET @sqlSentencia = '''';
	SET @sqlCondicion = '''';


	SET NOCOUNT ON;
 

	SET @sqlSentencia = ''
	SELECT     ADM_PERSONA.personaId, ADM_PERSONA.tpersonaId, UPPER(ADM_PERSONA.persona) AS persona, SYS_USUARIO.usuarioId, SYS_USUARIO.usuario as usuario, 
                      SYS_USUARIO.clave, (CASE SYS_USUARIO.estado WHEN ''''A'''' THEN ''''ACTIVO'''' WHEN ''''I'''' THEN ''''INACTIVO'''' END) AS estado, SYS_ROL.rol, SYS_USUARIO.fcrea
	FROM         ADM_PERSONA INNER JOIN
	                      SYS_USUARIO ON ADM_PERSONA.usuarioId = SYS_USUARIO.usuarioId left Outer JOIN
	                      SYS_ROLUSUARIO ON SYS_USUARIO.usuarioId = SYS_ROLUSUARIO.usuarioId AND 
	                      SYS_USUARIO.usuarioId = SYS_ROLUSUARIO.usuarioId left Outer JOIN
	                      SYS_ROL ON SYS_ROLUSUARIO.rolId = SYS_ROL.rolId AND SYS_ROLUSUARIO.rolId = SYS_ROL.rolId
	''

	SET @sqlCondicion = '' WHERE (1 = 1) ''

	IF not(@persona is NULL)
	begin
		set @sqlCondicion = @sqlCondicion + 
				'' AND (ADM_PERSONA.persona LIKE ''''%'' + @persona + ''%'''' ) ''
	end
	--
	IF not(@estado is NULL)
	begin
		set @sqlCondicion = @sqlCondicion + 
				'' AND (SYS_USUARIO.estado = ''''''+@estado+'''''') ''
	end
	--
	IF not(@rolId is NULL)
	begin
		set @sqlCondicion = @sqlCondicion + 
				'' AND (SYS_ROLUSUARIO.rolId = ''''''+convert(varchar,@rolId)+'''''') ''
	end
	--
	IF not(@companiaId is NULL)
	begin
		set @sqlCondicion = @sqlCondicion + 
				'' AND (SYS_Usuario.companiaId = ''''''+convert(varchar,@companiaId)+'''''') ''
	end

	--	
	/**
	
	ojo que en este punto hay acople con la aplicación, no se puede cambiar los tipos de usuario sin hacer el cambio correspondiente aqui
    	
	**/

	if (@tipoUsuario=''Broker'')
		set @sqlCondicion = @sqlCondicion + '' and SYS_ROL.rol=''''EjecutivoBroker''''''

	if (@tipoUsuario=''Aseguradora'')
		set @sqlCondicion = @sqlCondicion + '' and SYS_ROL.rol=''''EjecutivoCiaSeguros'''''';

	if (@tipoUsuario=''Administrador'')
		set @sqlCondicion = @sqlCondicion + '' and (SYS_ROL.rol=''''Ajustador'''' or SYS_ROL.rol=''''Asistente'''' or SYS_ROL.rol=''''AdminCiaSeguros'''' or SYS_ROL.rol=''''AdminBroker'''')'';


	SET @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion + '' ORDER BY SYS_USUARIO.fcrea''
	--PRINT @sqlSentencia
	EXEC sp_executesql  @sqlSentencia






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BienAfectadoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE   PROCEDURE [dbo].[sp_rgen_BienAfectadoUpdate]
(
	@bienAfectadoId numeric(8,0),
	@ajusteId numeric(8,0),
	@item text = NULL,
	@descripcion text = NULL,
	@montorep numeric(14,2) = NULL,
	@montosoles numeric(14,2) = NULL,
	@monedaId numeric(8,0),
	@tipoCambio numeric(14,2) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [RGN_BIENAFECTADO]
	SET
		[item] = @item,
		[descripcion] = @descripcion,
		[montorep] = @montorep,
		[montosoles] = @montosoles,
		[monedaId] = @monedaId,
		[tipoCambio] = @tipoCambio
	WHERE
		[bienAfectadoId] = @bienAfectadoId
	AND	[ajusteId] = @ajusteId


	SET @Err = @@Error


	RETURN @Err
END



' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_APP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_APP](
	[usuario] [varchar](20) NULL,
	[appId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[app] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_ROL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_ROL](
	[usuario] [varchar](20) NULL,
	[rolId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[rol] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_USUARIO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_USUARIO](
	[usuarioId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[fcrea] [datetime] NULL,
	[usuario] [varchar](20) NULL,
	[fupdate] [datetime] NULL,
	[clave] [varchar](20) NULL,
	[numerocnx] [numeric](3, 0) NULL,
	[estado] [varchar](1) NULL,
	[aseguradoraid] [numeric](8, 0) NULL,
	[brokerId] [numeric](8, 0) NULL,
	[companiaId] [numeric](9, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_POLIZAS_ASOCIADAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_POLIZAS_ASOCIADAS](
	[polizaId] [numeric](18, 0) NOT NULL,
	[numPoliza] [varchar](100) NULL,
	[asegurado] [varchar](1000) NULL,
	[aseguradora] [varchar](1000) NULL,
	[cobertura] [varchar](100) NULL,
	[ajusteId] [numeric](18, 0) NULL,
	[ramo] [varchar](100) NULL,
	[producto] [varchar](100) NULL,
 CONSTRAINT [PK_RGN_POLIZAS_ASOCIADAS] PRIMARY KEY CLUSTERED 
(
	[polizaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TIPOAJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TIPOAJUSTE](
	[tajusteid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[tajuste] [varchar](100) NULL,
	[descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOAJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ESTADOAJUSTE](
	[estadoajusteid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[estadoajuste] [varchar](100) NULL,
	[descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[codigo] [numeric](18, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_RAMO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_RAMO](
	[ramoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](250) NULL,
	[descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_RGN_RAMO_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_RGN_RAMO_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_RGN_RAMO_estado]  DEFAULT ('A'),
	[ucrea] [varchar](20) NULL CONSTRAINT [DF_RGN_RAMO_ucrea]  DEFAULT ('SYSTEM'),
	[uupdate] [varchar](20) NULL CONSTRAINT [DF_RGN_RAMO_uupdate]  DEFAULT ('SYSTEM'),
	[productoId] [numeric](8, 0) NULL,
 CONSTRAINT [PK_RGN_RAMO] PRIMARY KEY NONCLUSTERED 
(
	[ramoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaAsegurado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaAsegurado]
(
	@aseguradoid numeric(8,0),
	@numeroPoliza nvarchar(100),
	@aseguradoraId numeric (8,0) 
)

AS	
	SET NOCOUNT ON;
	
	set @numeroPoliza = isnull(@numeroPoliza,'''');


		if (LEN (@numeroPoliza)> 0 ) 
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and 
			aseguradoraid =@aseguradoraid
			and aseguradoid =@aseguradoid
			and numeroPoliza like ''%''+@numeroPoliza+''%'';
		end
		else
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and aseguradoraid = @aseguradoraid
			and aseguradoid =@aseguradoid;
		end


	SET NOCOUNT Off;


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TIPOCOMUNICACION]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TIPOCOMUNICACION](
	[tcomunicacionId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NULL,
	[Descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaInsert]
(
	@polizaId numeric(8,0) = NULL output,
	@productoId numeric(8,0),
	@ramoId numeric(8,0),
	@riesgoId numeric(8,0),
	@finicio datetime = NULL,
	@ffin datetime = NULL,
	@numeroPoliza varchar(100) = NULL,
	@aseguradoraId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [RGN_POLIZA]
	(
		[productoId],
		[ramoId],
		[riesgoId],
		[finicio],
		[ffin],
		[estado],
		[numeroPoliza],
		[aseguradoraId]
	)
	VALUES
	(
		@productoId,
		@ramoId,
		@riesgoId,
		@finicio,
		@ffin,
		''A'',
		@numeroPoliza,
		@aseguradoraId
	)

	SET @Err = @@Error

	SELECT @polizaId = SCOPE_IDENTITY()

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_TIPOCONTACTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_TIPOCONTACTO](
	[tipoContactoId] [int] IDENTITY(1,1) NOT NULL,
	[TIpoContacto] [varchar](100) NULL,
	[Descripcion] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaLista]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[polizaId],
		[productoId],
		[ramoId],
		[riesgoId],
		[finicio],
		[ffin],
		[estado],
		[numeroPoliza],
		[aseguradoraId]
	FROM [RGN_POLIZA]

	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaListaById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_PolizaListaById]
(
	@asegurado nvarchar(500),
	@numeroPoliza nvarchar(100),
	@aseguradoraId numeric (8,0) 
)

AS	
	SET NOCOUNT ON;
	
/*SELECT     ADM_PERSONA_1.persona AS aseguradora, dbo.RGN_POLIZA.polizaId, dbo.RGN_POLIZA.numeroPoliza, dbo.RGN_POLIZA.contratante, 
                      ADM_PERSONA_2.persona AS Asegurado, ADM_PERSONA_2.personaId AS AseguradoId, dbo.RGN_POLIZA.aseguradoraId, dbo.RGN_POLIZA.estado, 
                      dbo.RGN_RAMO.nombre AS ramoafectado, dbo.RGN_POLIZA.productoId, dbo.RGN_POLIZA.ramoId
FROM         dbo.RGN_POLIZA INNER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId LEFT OUTER JOIN
                      dbo.ADM_PERSONA AS ADM_PERSONA_1 ON dbo.RGN_POLIZA.aseguradoraId = ADM_PERSONA_1.personaId LEFT OUTER JOIN
                      dbo.ADM_PERSONA AS ADM_PERSONA_2 ON dbo.RGN_POLIZA.aseguradoId = ADM_PERSONA_2.personaId
*/
	set @asegurado = isnull(@asegurado ,'''');
	set @numeroPoliza = isnull(@numeroPoliza,'''');

	if (LEN (@asegurado)> 0) 
	begin
		if (LEN (@numeroPoliza)> 0 ) 
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and aseguradoraid = 
			+ Convert(varchar(10),@aseguradoraid)  
			and asegurado like ''%''+@asegurado+''%'' 
			and numeroPoliza like ''%''+@numeroPoliza+''%'';
		end
		else
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and aseguradoraid = 
			+ Convert(varchar(10),@aseguradoraid)  
			and asegurado like ''%''+@asegurado+''%'';
		end
	end
	else
	begin
		if (LEN (@numeroPoliza)> 0 ) 
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and aseguradoraid = 
			+ Convert(varchar(10),@aseguradoraid)  
			and numeroPoliza like ''%''+@numeroPoliza+''%'';
		end
		else
		begin
			select * from vi_rgn_listaPolizasFiltro  
			where estado = ''A'' and aseguradoraid = 
			+ Convert(varchar(10),@aseguradoraid); 
		end
	end

	SET NOCOUNT Off;





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaSelectById]
(
	@polizaId numeric(8,0),
	@aseguradoraId numeric(8,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[polizaId],
		[contratante],
		[beneficiario],
		[aseguradoId],
		[productoId],
		[ramoId],
		[riesgoId],
		[finicio],
		[ffin],
		[estado],
		[numeroPoliza],
		[aseguradoraId]
	FROM [RGN_POLIZA]
	WHERE
		([polizaId] = @polizaId) AND
		([aseguradoraId] = @aseguradoraId)

	SET @Err = @@Error

	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaUpdate]
(
	@polizaId numeric(8,0),
	@contratante varchar(250) = NULL,
	@beneficiario varchar(1000) = NULL,
	@aseguradoId numeric(8,0),
	@productoId numeric(8,0),
	@ramoId numeric(8,0),
	@riesgoId numeric(8,0),
	@finicio datetime = NULL,
	@ffin datetime = NULL,
	@estado char(1) = NULL,
	@numeroPoliza varchar(100) = NULL,
	@aseguradoraId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [RGN_POLIZA]
	SET
		[contratante] = @contratante,
		[beneficiario] = @beneficiario,
		[aseguradoId] = @aseguradoId,
		[productoId] = @productoId,
		[ramoId] = @ramoId,
		[riesgoId] = @riesgoId,
		[finicio] = @finicio,
		[ffin] = @ffin,
		[estado] = @estado,
		[numeroPoliza] = @numeroPoliza
	WHERE
		[polizaId] = @polizaId
	AND	[aseguradoraId] = @aseguradoraId


	SET @Err = @@Error


	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_estadistica_general]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--sp_rgen_estadistica_general ''SUM'',''SINIESTRO'',''200601'',''200612'', -1
CREATE PROCEDURE [dbo].[sp_rgen_estadistica_general](@criterio1 varchar(20), --se refiere a la operacion
																						 @criterio2 varchar(20), --se refiere al quiebre
																						 @fini  varchar(6), --periodo de inicio
																						 @ffin   varchar(6), --periodo de finalizacion
																						 @companiaId numeric(8,0)=NULL
																						)
AS

set nocount on


declare @sqlA nvarchar(500)
declare @sqlOper nvarchar(1000)
declare @sqlOper2 nvarchar(1000)
declare @sqlFinal nvarchar(4000)



create table #salida (
	descripcion varchar(400) null,
	cantidad numeric(18,2) null,
	total numeric(18,2) null,
	porcentajecant numeric(18,2) null,
	reserva 	numeric(18,2) null,
	totalreserva 	numeric(18,2) null,
  porcentajereserva 	numeric(18,2) null
)

set @sqlA = ''insert into #salida (cantidad,descripcion,reserva) select ''

if (@criterio1 = ''SUM'')
begin

	set @sqlOper = '' sum(cantidad) as cantidad ''
	set @sqlOper2 = '' sum(reserva) as reserva ''
end

if (@criterio1 = ''AVG'')
begin
		set @sqlOper = '' AVG(cantidad) as cantidad ''
    set @sqlOper2 = '' avg(reserva) as reserva ''

end
ELSE
BEGIN
		set @sqlOper = '' SUM(cantidad) as cantidad ''
	  set @sqlOper2 = '' sum(reserva) as reserva ''
END


if (@criterio2 = ''SINIESTRO'')
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '' , tipoSiniestro as descripcion, '' + @sqlOper2 + '' from vReporteEstadisticaTotales where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
  if ((@companiaId is not null) and (@companiaId <>-1))
		begin
        set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by tipoSiniestro''
END

if (@criterio2 = ''PRODUCTO'')
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '', producto as descripcion , '' + @sqlOper2 + '' from vReporteEstadisticaTotales where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
	if ((@companiaId is not null) and (@companiaId <>-1))
		begin
				set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by producto ''
END

if (@criterio2 = ''RAMO'' )
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '' , ramo as descripcion, '' + @sqlOper2 + '' from vReporteEstadisticaTotales  where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
	if ((@companiaId is not null) and (@companiaId <>-1))
		begin
				set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by ramo''
END

if (@criterio2 = ''COBERTURA'' )
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '', cobertura as descripcion, '' + @sqlOper2 + '' from vReporteEstadisticaTotales  where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
	if ((@companiaId is not null) and (@companiaId <>-1))
		begin
				set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by cobertura''
END

if (@criterio2 = ''BROKER'' )
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '', broker as descripcion, '' + @sqlOper2 + '' from vReporteEstadisticaTotales  where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
	if ((@companiaId is not null) and (@companiaId <>-1))
		begin
				set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by broker''
END
   
if (@criterio2 = ''AJUSTADOR'' )
BEGIN
	set @sqlFinal = @sqlA + @sqlOper + '', ajustador as descripcion, '' + @sqlOper2 + '' from vReporteEstadisticaTotales  where Periodo between  '''''' + @fini  + ''''''  and  '''''' + @ffin  + ''''''''
	if ((@companiaId is not null) and (@companiaId <>-1))
		begin
				set @sqlFinal = @sqlFinal + '' and aseguradoraId ='' + Convert(varchar(400),@companiaId) + '' or brokerId= ''+ Convert(varchar(400),@companiaId) 
		end
	set @sqlFinal = @sqlFinal + '' group by ajustador''
END


PRINT @sqlFinal

exec (@sqlFinal)

update #salida set  total = (select sum(cantidad) from  #salida)

update #salida set  total = 1 where total =0

update #salida set  porcentajecant = cantidad/total*100

update #salida set  totalreserva = (select sum(reserva) from  #salida)

update #salida set  totalreserva = 1 where totalreserva =0

update #salida set  porcentajereserva = reserva/totalreserva*100



select * from  #salida



set nocount off
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_UbigeoLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_UbigeoLista] (
	@name varchar(100)
)
AS
	SELECT     D.distrito +''-''+P.provincia+ ''-''+ DD.departamento AS ubigeo, 
	   dd.departamentoid+p.provinciaid+d.distritoid as ubigeoId
FROM         vi_DistritoCombo D,
                     vi_DepartamentoCombo DD,
                     vi_ProvinciaCombo p
where (D.DISTRITO LIKE @name+''%'') 
AND (P.provinciaid = D.provinciaId) 
and (DD.departamentoid = P.departamentoid) 
and(D.departamentoid = P.departamentoid)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_TRACE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_TRACE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[value] [varchar](4000) NULL,
 CONSTRAINT [PK_SYS_TRACE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registroPolizaRapidoNuevo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_registroPolizaRapidoNuevo](
  @aseguradoraid numeric(8,0),
  @numeroPoliza varchar(100),
  @aseguradoid numeric(8,0),
  @contratante varchar(250),
  @GirodeNegocio varchar(250),
  @GrupoEconomico varchar(250),
  @FechaInicio datetime, 
  @FechaFin datetime,
  @Productoid numeric(8,0),
  @ramoid numeric(8,0),
  @cobertura numeric(8,0),
  @usuario varchar(100),
  @ajusteId numeric (8,0),
  @archivo varchar(100)
)
as

BEGIN  
   insert into RGN_POLIZA(aseguradoraid,aseguradoid, productoid, ramoid, riesgoid,finicio,ffin, numeroPoliza,archivo,fcrea,estado,ucrea)
   values (@aseguradoraid, @aseguradoid, @productoid, @ramoid, @cobertura, @FechaInicio, @Fechafin, @numeroPoliza,isnull(@archivo,''''), getdate(), ''A'',isnull(@usuario,''usuario'')) 	

--INSERTANDO EN TABLA POLIZA_AJUSTE

    DECLARE @polizaId numeric(8,0);
    SET @polizaId= scope_Identity();
/*

    insert into RGN_POLIZA_AJUSTE
    (
	aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate

    )
    
    values (
    	@aseguradoraid,
 	@polizaId,
        @ajusteId,
        ''A'',
	getdate(),
	getdate(),
	isnull(@usuario,''usuario''),
	isnull(@usuario,''usuario'')
    )
*/ 
END ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_Ramo_GetByRamo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[proc_Ramo_GetByRamo] 
    (
      @Ramo VARCHAR(250) = NULL
    )
AS 
    BEGIN
        DECLARE @sqlSentence VARCHAR(4000)
        DECLARE @sqlCondition VARCHAR(4000)
		
        SET @sqlCondition = ''''
			
        SET @sqlSentence = ''
        SELECT [descripcion],
		   [estado],
		   [fcrea],
		   [fupdate],
		   [nombre],
		   [productoId],
		   [ramoId],
		   [ucrea],
		   [uupdate]  
		FROM [RGN_RAMO] where estado = ''''A'''' ''
	
		IF (LEN(@Ramo) > 0) 
		BEGIN
			SET @sqlCondition = '' AND nombre like ''''%'' + @Ramo + ''%''''''					
		END	
		
		SET @sqlSentence = @sqlSentence + '' '' + @sqlCondition
		--print(@sqlSentence)
		EXEC (@sqlSentence)
		
    END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tprueba]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tprueba](
	[descripcion] [varchar](400) NULL,
	[cantidad] [numeric](18, 2) NULL,
	[total] [numeric](18, 2) NULL,
	[porcentajecant] [numeric](18, 2) NULL,
	[reserva] [numeric](18, 2) NULL,
	[totalreserva] [numeric](18, 2) NULL,
	[porcentajereserva] [numeric](18, 2) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_estadistica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_estadistica] (@pfini as datetime,@pffin as datetime)
as

set nocount on

select 	Periodo,count(*) as cantidad,ramoId,
	isnull(ramo,''(no especificado)'') as ramo,
	productoId,
	isnull(producto,''(no especificado)'') as producto,
	riesgoId,
	isnull(cobertura,''(no especificado)'') as cobertura,
	tipoSiniestroId,
	isnull(tipoSiniestro,''(no especificado)'') as tipoSiniestro,
	sum(isnull(reserva,0)) as reserva,
	sum(isnull(TotalIndenmizacion,0)) as TotalIndenmizacion,
	AseguradoraId,
	isnull(Aseguradora,''(no especificada)'') as Aseguradora,
	AseguradoId,
	isnull(Asegurado,''(no especificado)'') as Asegurado,BrokerId,
	isnull(Broker,''(no especificado)'') as Broker,AjustadorId,Ajustador
 from vReporteAjuste
 where fsiniestro between @pfini and @pffin
 group by Periodo,ramoId,ramo,productoId,producto,riesgoId,cobertura,tipoSiniestroId,tipoSiniestro,AseguradoraId,Aseguradora,AseguradoId,Asegurado,BrokerId,Broker,AjustadorId,Ajustador

set nocount off

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rgn_temp_informebasicofechas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rgn_temp_informebasicofechas](
	[fechaaviso] [datetime] NULL,
	[quien] [varchar](50) NULL,
	[via] [varchar](50) NULL,
	[fechacoordinacion] [datetime] NULL,
	[con1] [varchar](250) NULL,
	[fechainspeccion] [datetime] NULL,
	[con2] [varchar](250) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CLAUSULAS_COMUNES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CLAUSULAS_COMUNES](
	[ClausulaId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Contenido] [varchar](1000) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[ucrea] [varchar](25) NULL,
	[uupdate] [varchar](25) NULL,
	[ramoId] [numeric](18, 0) NULL,
	[archivo] [image] NULL,
	[nombreArchivo] [varchar](255) NULL,
 CONSTRAINT [PK_RGN_CLAUSULAS_COMUNES] PRIMARY KEY CLUSTERED 
(
	[ClausulaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_REQUISITO_RAMO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_REQUISITO_RAMO](
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[requisitoId] [numeric](8, 0) NOT NULL,
	[ramoId] [numeric](8, 0) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_DocumentosTipoSiniestroId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_DocumentosTipoSiniestroId]
(
	@tiposiniestroId numeric(8, 0)
	
)
AS
	SET NOCOUNT ON;


	if (@tiposiniestroId = -1) 
	begin
		SELECT distinct    RGN_REQUISITOS.requisitoId,
		   RGN_REQUISITOS.nombre,
		   RGN_REQUISITOS.descripcion


		FROM	RGN_TIPOSINIESTRO_RGN_REQUISITO,
		RGN_REQUISITOS       

		WHERE     
		   (RGN_REQUISITOS.requisitoId = RGN_TIPOSINIESTRO_RGN_REQUISITO.requisitoId)and		   
		   (RGN_TIPOSINIESTRO_RGN_REQUISITO.estado=''A'')	  
			
	end
	else 
	begin
		SELECT distinct    RGN_REQUISITOS.requisitoId,
	   RGN_REQUISITOS.nombre,
	   RGN_REQUISITOS.descripcion


FROM	RGN_TIPOSINIESTRO_RGN_REQUISITO,
	RGN_REQUISITOS       

WHERE     
	   (RGN_REQUISITOS.requisitoId = RGN_TIPOSINIESTRO_RGN_REQUISITO.requisitoId)and
	   (RGN_TIPOSINIESTRO_RGN_REQUISITO.tipoSiniestroId=@tiposiniestroId)and
	   (RGN_TIPOSINIESTRO_RGN_REQUISITO.estado=''A'')	  
	
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CoberturaSelectAllByFilters]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_CoberturaSelectAllByFilters] 
(
@cobertura varchar(500) = null,
@estado varchar(1),
@ramoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int
/*
	SELECT     dbo.RGN_RIESGO_COBERTURA.riesgoId, dbo.RGN_RIESGO_COBERTURA.nombre, dbo.RGN_RIESGO_COBERTURA.descripcion, 
                      dbo.RGN_RIESGO_COBERTURA.fcrea, dbo.RGN_RIESGO_COBERTURA.fupdate, dbo.RGN_RIESGO_COBERTURA.estado, 
                      dbo.RGN_RIESGO_COBERTURA.ucrea, dbo.RGN_RIESGO_COBERTURA.uupdate, dbo.RGN_RIESGO_COBERTURA.ramoid, 
                      dbo.RGN_RAMO.nombre AS ramo
FROM         dbo.RGN_RIESGO_COBERTURA LEFT OUTER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_RIESGO_COBERTURA.ramoid = dbo.RGN_RAMO.ramoid
	
*/
	DECLARE @sqlSentencia nvarchar(4000)
	DECLARE @sqlCondicion nvarchar(4000)	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	set @sqlSentencia = 
		''SELECT     dbo.RGN_RIESGO_COBERTURA.riesgoId, dbo.RGN_RIESGO_COBERTURA.nombre, dbo.RGN_RIESGO_COBERTURA.descripcion, 
                      dbo.RGN_RIESGO_COBERTURA.fcrea, dbo.RGN_RIESGO_COBERTURA.fupdate, dbo.RGN_RIESGO_COBERTURA.estado, 
                      dbo.RGN_RIESGO_COBERTURA.ucrea, dbo.RGN_RIESGO_COBERTURA.uupdate, dbo.RGN_RIESGO_COBERTURA.ramoid, 
                      dbo.RGN_RAMO.nombre AS ramo
FROM         dbo.RGN_RIESGO_COBERTURA LEFT OUTER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_RIESGO_COBERTURA.ramoid = dbo.RGN_RAMO.ramoid
			WHERE 1 = 1 
		''
	IF (@cobertura is not null)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_RIESGO_COBERTURA.nombre like ''''%'' + @cobertura + ''%'''' ) ''				
	end
	
	if (@estado <> ''T'') 
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_RIESGO_COBERTURA.estado = '''''' + @estado + '''''' ) ''
	end
	
	if (@ramoId <> -1) 
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_RIESGO_COBERTURA.ramoid = '' + convert(varchar,@ramoId) + '' ) ''
	end
	

	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion

	--print @sqlSentencia;	

	 exec (@sqlSentencia)

	
END





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registro_caso_ajuste_ajustador]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








CREATE    procedure [dbo].[sp_rgen_registro_caso_ajuste_ajustador](
@numeroAjuste varchar(20) output,
@quiennotifico varchar(250),
@nombrenotificante varchar(250),

/*
--@quienConfirmo varchar(250),
@NombreQuienConfirma varchar(250),
@mediodeconfirmacionId numeric(5,0),
@@fconfirmacion datetime,
*/

@descripcionsiniestro varchar(250),
@tiposiniestro varchar(100),
@fsiniestro datetime,
@ubigeoid varchar(6),
@lugarsiniestro varchar(250),
@referenciaubicacionsiniestro varchar(250),
@faviso datetime,
@referenciaconasegurado varchar(250),
@mediodenotificacionid numeric(5,0),
@brokerid numeric(5,0),
@numerosiniestrocia varchar(100),
@polizaid numeric(5,0),
@aseguradoraid numeric(5,0),
@ejecutivocia varchar(250),
@telefonocia varchar(20),
@emailcia varchar(250),
@contactobroker varchar(250),
@telefonobroker varchar(20),
@emailbroker varchar(250),
@contactoasegurado varchar(250),
@telefonoasegurado varchar(20),
@emailasegurado varchar(250)
)
as

declare @siniestro varchar(100)

set @siniestro = @nombrenotificante + ''-'' + @lugarsiniestro

--inserto en la tabla de siniestro
insert into RGN_SINIESTRO (
siniestro,
descripcion,
tiposiniestro,
fsiniestro,
lugarsiniestro,
referenciaubicacionsiniestro,
ubigeoid)
values
(
@siniestro,
@descripcionsiniestro,
@tiposiniestro,
@fsiniestro,
@lugarsiniestro,
@referenciaubicacionsiniestro,
@ubigeoid
)

--obtengo el id del siniestro que acabo de meter
declare @siniestroid numeric(5,0)
set @siniestroid = scope_identity()

--inserto los datos necesarios en la tabla ajuste
insert into rgn_ajuste
(
tAjusteId,
quiennotifico,
nombredelnotificante,
faviso,

/*
NombreQuienConfirma,
fconfirmacion,
medioconfirmacionId,
*/
referenciaconasegurado,
mediodenotificacionid,
siniestroid,
brokerid,
numerosiniestrocia
)
values
(
1,
@quiennotifico,
@nombrenotificante,
@faviso,
/*
@NombreQuienConfirma,
@fconfirmacion,
@medioconfirmacionId,
*/
@referenciaconasegurado,
@mediodenotificacionid,
@siniestroid,
@brokerid,
@numerosiniestrocia
)

declare @ajusteid numeric(5,0)
set @ajusteid = scope_identity()
set @numeroAjuste = ''PA - ''+ convert(varchar(20),DATEPART(year,getdate()),103)+'' - ''+ cast(@ajusteId as varchar(20))


-- ponemos el estado del ajuste iniciado...
insert into 
RGN_ESTADOSAJUSTE(FechaDeCambio,AjusteId,estadoAjusteId) 
values (getDate(),@ajusteid,1)


update rgn_ajuste 
set numAjustePASA = @numeroAjuste
where ajusteId = @ajusteId


insert into rgn_poliza_ajuste
(
polizaid,
aseguradoraid,
ajusteid,
numsiniestro
)
values
(
@polizaid,
@aseguradoraid,
@ajusteid,
@numerosiniestrocia
)

declare @tcontactoaseguradora int
declare @tcontactobroker int
declare @tcontactoasegurado int
select @tcontactoaseguradora = tipocontactoid from rgn_tipocontacto where tipocontacto like ''Asegurador%''
select @tcontactobroker = tipocontactoid from rgn_tipocontacto where tipocontacto like ''Brok%''
select @tcontactoasegurado = tipocontactoid from rgn_tipocontacto where tipocontacto = ''Asegurado''

--inserto contacto para la compañia
insert into rgn_contactos_ajuste
(
ajusteid,
tipocontactoid,
nombrecontacto,
telefonocontacto,
emailcontacto
)
values
(
@ajusteid,
@tcontactoaseguradora,
@ejecutivocia,
@telefonocia,
@emailcia
)

--inserto para contacto broker
insert into rgn_contactos_ajuste
(
ajusteid,
tipocontactoid,
nombrecontacto,
telefonocontacto,
emailcontacto
)
values
(
@ajusteid,
@tcontactobroker,
@contactobroker,
@telefonobroker,
@emailbroker
)

--inserto contacto para asegurado
insert into rgn_contactos_ajuste
(
ajusteid,
tipocontactoid,
nombrecontacto,
telefonocontacto,
emailcontacto
)
values
(
@ajusteid,
@tcontactoasegurado,
@contactoasegurado,
@telefonoasegurado,
@emailasegurado
)



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasComunesSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--sp_rgen_ClausulasComunesSelect null,1
CREATE PROCEDURE [dbo].[sp_rgen_ClausulasComunesSelect]
(
	@nombre varchar(50) ,
	@IdRamo varchar(10) 
)
AS

	DECLARE @sqlSentencia nvarchar(4000)
	DECLARE @sqlCondicion nvarchar(4000)
		
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	SET NOCOUNT ON;
	
	
	
	SET @sqlSentencia = ''

	SELECT DISTINCT 

					RGN_CLAUSULAS_COMUNES.nombre,
					RGN_CLAUSULAS_COMUNES.contenido,
					RGN_CLAUSULAS_COMUNES.clausulaId,
					RGN_RAMO.nombre as Ramo

	FROM 		RGN_CLAUSULAS_COMUNES, 
					RGN_RAMO
	WHERE
					RGN_CLAUSULAS_COMUNES.ramoid= RGN_RAMO.ramoid ''
	       
	IF (LEN(@nombre) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (RGN_CLAUSULAS_COMUNES.nombre like ''''%'' + @nombre + ''%'''' ) ''				
	end
	
	IF (@IdRamo > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( RGN_CLAUSULAS_COMUNES.ramoId ='' +   @IdRamo + '' ) ''				
	end
	
	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion
	exec (@sqlSentencia)

	' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AjustesporAsegurado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AjustesporAsegurado] 
as
begin
	declare @total decimal

select @total = count(*) from ListaAjuste

select isNull(Asegurado,''--''), round((count(*) / @total),4) from LISTAAJUSTE  
group by Asegurado


end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_RIESGO_COBERTURA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_RIESGO_COBERTURA](
	[riesgoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](500) NULL,
	[descripcion] [varchar](500) NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_RGN_RIESGO_COBERTURA_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_RGN_RIESGO_COBERTURA_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_RGN_RIESGO_COBERTURA_estado]  DEFAULT ('A'),
	[ucrea] [varchar](20) NULL CONSTRAINT [DF_RGN_RIESGO_COBERTURA_ucrea]  DEFAULT ('SYSTEM'),
	[uupdate] [varchar](20) NULL CONSTRAINT [DF_RGN_RIESGO_COBERTURA_uupdate]  DEFAULT ('SYSTEM'),
	[ramoid] [numeric](8, 0) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_PolizaListaFiltros]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgn_PolizaListaFiltros] 

(
	@asegurado varchar(50) ,
	@Idcia	varchar(10) ,
	@numpoliza varchar(20) 
	
)
AS


DECLARE @sqlSentencia nvarchar(4000)
DECLARE @sqlCondicion nvarchar(4000)
	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	SET NOCOUNT ON;

	
	SET @sqlSentencia = ''   

	SELECT DISTINCT 
                      RGN_POLIZA.polizaId,
					  RGN_POLIZA.finicio,
					  RGN_POLIZA.ffin,
		      ISNULL(ADM_PERSONA_3.persona,'''''''') AS Asegurado, 
                      ADM_PERSONA_2.persona AS Aseguradora, 
                      RGN_POLIZA.numeroPoliza, 
                      RGN_RAMO.nombre AS Ramo, 
		      RGN_RIESGO_COBERTURA.nombre AS Cobertura,
		      RGN_PRODUCTO.nombre AS Producto
	


	FROM     dbo.RGN_POLIZA 
		 LEFT OUTER JOIN dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId 
		 LEFT OUTER JOIN dbo.RGN_RIESGO_COBERTURA ON dbo.RGN_POLIZA.riesgoId = dbo.RGN_RIESGO_COBERTURA.riesgoId
	         LEFT OUTER JOIN dbo.RGN_PRODUCTO ON dbo.RGN_POLIZA.productoId = dbo.RGN_PRODUCTO.productoId
                 LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_2 ON dbo.RGN_POLIZA.aseguradoraId = ADM_PERSONA_2.personaId 
                 LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_3 ON dbo.RGN_POLIZA.aseguradoId = ADM_PERSONA_3.personaId 

	WHERE RGN_POLIZA.sistema = ''''N'''' ''
	       
	IF (LEN(@asegurado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ADM_PERSONA_3.persona  like ''''%'' + @asegurado + ''%'''' ) ''				
	end
	
	IF (@Idcia > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( ADM_PERSONA_2.personaId ='' +   @Idcia + '' ) ''				
	end
	
	IF (LEN(@numpoliza) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( RGN_POLIZA.numeroPoliza like ''''%'' + @numpoliza + ''%'''' ) ''				
	end



	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion
	exec (@sqlSentencia)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_POLIZA](
	[polizaId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[contratante] [varchar](250) NULL,
	[beneficiario] [varchar](1000) NULL,
	[aseguradoId] [numeric](8, 0) NULL,
	[productoId] [numeric](8, 0) NULL,
	[ramoId] [numeric](8, 0) NULL,
	[riesgoId] [numeric](8, 0) NULL,
	[finicio] [datetime] NULL,
	[ffin] [datetime] NULL,
	[numeroPoliza] [varchar](100) NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[archivo] [varchar](100) NULL,
	[sistema] [varchar](1) NULL CONSTRAINT [DF_RGN_POLIZA_sistema]  DEFAULT ('N'),
	[giroNegocio] [varchar](8000) NULL,
	[grupoEconomico] [varchar](8000) NULL,
	[materiaAsegurada] [text] NULL,
	[localAsegurado] [text] NULL,
	[seccion] [text] NULL,
 CONSTRAINT [PK_RGN_POLIZA] PRIMARY KEY NONCLUSTERED 
(
	[polizaId] ASC,
	[aseguradoraId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE](
	[atributoId] [numeric](8, 0) NOT NULL,
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_SINIESTRO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_SINIESTRO](
	[siniestroid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[siniestro] [varchar](100) NULL,
	[descripcion] [varchar](250) NULL,
	[fsiniestro] [datetime] NULL,
	[lugarSiniestro] [varchar](250) NULL,
	[referenciaUbicacionSiniestro] [varchar](250) NULL,
	[ubigeoId] [varchar](6) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[tipoSiniestroId] [numeric](8, 0) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_ACCESO](
	[usuario] [varchar](20) NULL CONSTRAINT [DF_SYS_ACCESO_usuario]  DEFAULT ('SYSTEM'),
	[fcrea] [datetime] NULL CONSTRAINT [DF_SYS_ACCESO_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_SYS_ACCESO_fupdate]  DEFAULT (getdate()),
	[rolId] [numeric](5, 0) NOT NULL,
	[estado] [varchar](1) NULL CONSTRAINT [DF_SYS_ACCESO_estado]  DEFAULT ('A'),
	[funcionalidadId] [numeric](5, 0) NOT NULL,
	[moduloId] [numeric](5, 0) NOT NULL,
	[appId] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_SUBACCESO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_SUBACCESO](
	[funcionalidadId] [numeric](5, 0) NOT NULL,
	[moduloId] [numeric](5, 0) NOT NULL,
	[appId] [numeric](5, 0) NOT NULL,
	[usuarioId] [numeric](8, 0) NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[brokerId] [numeric](8, 0) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AJUSTADOR]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_AJUSTADOR](
	[personaId] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_ADM_AJUSTADOR] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_ASEGURADO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_ASEGURADO](
	[personaId] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_ADM_ASEGURADO] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_BROKER]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_BROKER](
	[personaId] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_ADM_BROKER] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_DIRECCIONPERSONA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_DIRECCIONPERSONA](
	[personaId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[direccion] [varchar](100) NULL,
	[fupdate] [datetime] NULL,
	[referencia] [varchar](20) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[estado] [varchar](1) NULL,
	[direccionpersonaId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[ubigeoId] [varchar](6) NULL,
 CONSTRAINT [PK_ADM_DIRECCIONPERSONA] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_DOCID]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_DOCID](
	[personaId] [numeric](8, 0) NOT NULL,
	[docid] [varchar](20) NULL,
	[docidid] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[tdocidId] [numeric](5, 0) NOT NULL,
	[ucrea] [varchar](20) NULL,
	[principal] [varchar](1) NULL,
	[uupdate] [varchar](20) NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_ADM_DOCID] PRIMARY KEY NONCLUSTERED 
(
	[personaId] ASC,
	[docidid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_TELEFONOXPERSONA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_TELEFONOXPERSONA](
	[telefonoId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](20) NULL,
	[fcrea] [datetime] NULL,
	[telefono] [varchar](20) NULL,
	[fupdate] [datetime] NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[ttelefonoid] [numeric](5, 0) NOT NULL,
	[personaId] [numeric](8, 0) NOT NULL,
	[estado] [varchar](1) NULL,
 CONSTRAINT [PK_ADM_TELEFONOXPERSONA] PRIMARY KEY NONCLUSTERED 
(
	[telefonoId] ASC,
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_EJECUTIVOSINIESTROS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_EJECUTIVOSINIESTROS](
	[personaId] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_ADM_EJECUTIVOSINIESTROS_1] PRIMARY KEY CLUSTERED 
(
	[personaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_AJUSTE](
	[ajusteId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[quienNotifico] [varchar](250) NULL,
	[NombreDelNotificante] [varchar](250) NULL,
	[faviso] [datetime] NULL,
	[referenciaConAsegurado] [varchar](250) NULL,
	[descripcionRiesgo] [text] NULL,
	[brokerId] [numeric](8, 0) NULL,
	[observaciones] [varchar](2500) NULL,
	[ajustadorId] [numeric](8, 0) NULL,
	[numAjustePASA] [varchar](30) NULL,
	[numAjusteAseguradora] [varchar](20) NULL,
	[tajusteid] [numeric](8, 0) NOT NULL,
	[causasiniestro] [text] NULL,
	[detalleocurrencia] [text] NULL,
	[situacionajuste] [text] NULL,
	[verificaciongarantias] [text] NULL,
	[siniestrosanteriores] [text] NULL,
	[salvamentoyrecupero] [text] NULL,
	[recomendaciones] [text] NULL,
	[siniestroid] [numeric](8, 0) NULL,
	[fultimocambio] [datetime] NULL,
	[numeroSiniestroBroker] [varchar](100) NULL,
	[NombreQuienConfirma] [varchar](250) NULL,
	[FechayHoraConfirmacion] [datetime] NULL,
	[numeroSiniestroCia] [varchar](100) NULL,
	[investigaciones] [text] NULL,
	[TotalDeducible] [numeric](14, 2) NULL,
	[TotalIndenmizacion] [numeric](14, 2) NULL,
	[TotalPerdida] [numeric](18, 0) NULL,
	[medioDeNotificacionId] [numeric](8, 0) NULL,
	[medioConfirmacion] [numeric](8, 0) NULL,
	[cargoConfirmante] [varchar](250) NULL,
	[validado] [varchar](1) NULL,
	[opinionAjustador] [text] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](2) NULL,
	[ucrea] [varchar](100) NULL,
	[uupdate] [varchar](100) NULL,
	[situacionAjustelistados] [text] NULL,
	[liquidado] [varchar](1) NULL,
	[fechaHoraProgramacion] [datetime] NULL,
	[fCargoInformeFinal] [datetime] NULL,
	[rechazado] [bit] NULL,
	[ejecutivoSiniestrosId] [numeric](8, 0) NULL,
	[descripcionLugarSiniestro] [text] NULL,
	[descripcionBienesAfectados] [text] NULL,
	[antecedentes] [text] NULL,
	[descripcionReclamo] [text] NULL,
	[descripcionReserva] [text] NULL,
	[notas] [text] NULL,
	[enviarCopiaPoliza] [tinyint] NULL,
	[enviarNumSiniestro] [tinyint] NULL,
 CONSTRAINT [PK_RGN_AJUSTE] PRIMARY KEY NONCLUSTERED 
(
	[ajusteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'RGN_AJUSTE', N'COLUMN',N'estado'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'indicador para el borrado lógico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RGN_AJUSTE', @level2type=N'COLUMN',@level2name=N'estado'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'RGN_AJUSTE', N'COLUMN',N'situacionAjustelistados'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Este campo sirve para colocar las observaciones que van al listado de ajustes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RGN_AJUSTE', @level2type=N'COLUMN',@level2name=N'situacionAjustelistados'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'RGN_AJUSTE', N'COLUMN',N'liquidado'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'indica si ya fue cancelado por la aseguradora' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RGN_AJUSTE', @level2type=N'COLUMN',@level2name=N'liquidado'
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_ASEGURADO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PARRAFO_ASEGURADO](
	[parrafoId] [numeric](8, 0) NOT NULL,
	[personaId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA_AJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_POLIZA_AJUSTE](
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[NumSiniestro] [varchar](100) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_RGN_POLIZA_AJUSTE] PRIMARY KEY NONCLUSTERED 
(
	[polizaId] ASC,
	[aseguradoraId] ASC,
	[ajusteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CLAUSULAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CLAUSULAS](
	[clausulasId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[contenido] [varchar](1000) NULL,
	[nombre] [varchar](100) NULL,
	[polizaId] [numeric](8, 0) NULL,
	[aseguradoraId] [numeric](8, 0) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ITEMASEGURADO](
	[itemAseguradosId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[nombreItem] [text] NULL,
	[concepto] [varchar](50) NULL,
	[montoAsegurado] [numeric](14, 2) NULL,
	[montoSoles] [numeric](14, 2) NULL,
	[concepto2] [varchar](50) NULL,
	[montoAsegurado2] [numeric](18, 0) NULL,
	[montoSoles2] [numeric](18, 0) NULL,
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[localItem] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[nroItem] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CONFIGURACIONXASEGURADORA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CONFIGURACIONXASEGURADORA](
	[configuracionid] [numeric](9, 0) IDENTITY(1,1) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[diasIB] [decimal](18, 0) NULL,
	[diasIP] [decimal](18, 0) NULL,
	[diasIC] [decimal](18, 0) NULL,
	[diasIFR] [decimal](18, 0) NULL,
 CONSTRAINT [PK_RGN_CONFIGURACIONXASEGURADORA] PRIMARY KEY CLUSTERED 
(
	[configuracionid] ASC,
	[aseguradoraId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO](
	[requisitoId] [numeric](8, 0) NOT NULL,
	[FechaEntrega] [datetime] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[solicitudDocumentosId] [numeric](8, 0) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_RGN_AJUSTE_RGN_REQUERIMIENTO] PRIMARY KEY NONCLUSTERED 
(
	[requisitoId] ASC,
	[solicitudDocumentosId] ASC,
	[ajusteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PERDIDA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PERDIDA](
	[estimadoPerdidaId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[montoPerdida] [numeric](14, 2) NULL,
	[montoPerdidaSoles] [numeric](14, 2) NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[Fecha] [datetime] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_RESERVA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_RESERVA](
	[reservaId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[monto] [numeric](14, 2) NULL,
	[montosoles] [numeric](14, 2) NULL,
	[descripcion] [varchar](250) NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[fecha] [datetime] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_INFORMACIONRELEVANTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_INFORMACIONRELEVANTE](
	[informacionId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](250) NULL,
	[contenido] [varchar](1000) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO_AJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE](
	[itemAseguradosId] [numeric](8, 0) NOT NULL,
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOSAJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ESTADOSAJUSTE](
	[FechaDeCambio] [datetime] NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[estadoajusteid] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_EQUIPO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_EQUIPO](
	[equipoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[NombrePersona] [varchar](500) NULL,
	[Especialidad] [varchar](500) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_GASTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_GASTO](
	[ajusteId] [numeric](8, 0) NOT NULL,
	[gastoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[concepto] [varchar](250) NULL,
	[monto] [numeric](14, 2) NULL,
	[montosoles] [numeric](14, 2) NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[fechaGasto] [datetime] NULL,
	[descripcion] [varchar](250) NULL,
	[numDoc] [varchar](50) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[giradoa] [varchar](500) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_SOLICITUDDOCUMENTOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS](
	[solicitudDocumentosId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[numeroSolicitud] [varchar](100) NULL,
	[Fecha] [datetime] NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[enreferencia] [varchar](250) NULL,
	[tipo] [varchar](20) NULL,
	[para] [varchar](1000) NULL,
 CONSTRAINT [PK_RGN_SOLICITUDDOCUMENTOS] PRIMARY KEY NONCLUSTERED 
(
	[solicitudDocumentosId] ASC,
	[ajusteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_SECCIONESAJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_SECCIONESAJUSTE](
	[seccionId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[seccionPadreId] [numeric](8, 0) NULL,
	[TituloSeccion] [varchar](250) NULL,
	[SubtituloSeccion] [varchar](250) NULL,
	[ContenidoSeccion] [text] NULL,
	[nivel] [char](1) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[visible] [bit] NULL,
	[KeyName] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ANEXO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ANEXO](
	[archivoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[nombrearchivo] [varchar](255) NULL,
	[descripcion] [varchar](250) NULL,
	[fechaRegistro] [datetime] NULL,
	[archivoFisico] [image] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[mostrarEnInformes] [bit] NULL,
	[imagen] [bit] NULL,
	[imagenthumb] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_COMUNICACION]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_COMUNICACION](
	[comunicacionid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[nombreArchivo] [varchar](100) NULL,
	[fechaRegistro] [datetime] NULL,
	[tcomunicacionId] [numeric](8, 0) NOT NULL,
	[asunto] [varchar](100) NULL,
	[archivoFisico] [image] NULL,
	[cuerpoCorreo] [varchar](1000) NULL,
	[Emisor] [varchar](250) NULL,
	[Receptor] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_CLAUSULAS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_AJUSTE_CLAUSULAS](
	[ajusteId] [numeric](8, 0) NOT NULL,
	[clausulasId] [numeric](8, 0) NOT NULL,
	[polizaId] [numeric](8, 0) NOT NULL,
	[aseguradoraId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ADELANTO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ADELANTO](
	[adelantoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[motivo] [varchar](250) NULL,
	[monto] [numeric](14, 2) NULL,
	[aprobado] [varchar](5) NULL,
	[montosoles] [numeric](14, 2) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_RECLAMO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_RECLAMO](
	[reclamoid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[monto] [numeric](14, 2) NULL,
	[montoSoles] [numeric](14, 2) NULL,
	[tipoCambio] [numeric](14, 3) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[fecha] [datetime] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CONVENIOAJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CONVENIOAJUSTE](
	[ajusteId] [numeric](8, 0) NOT NULL,
	[totalDeducible] [numeric](18, 2) NULL,
	[totalIndemnizacion] [numeric](18, 2) NULL,
	[totalPerdida] [numeric](18, 2) NULL,
	[montoIndemnizacion] [varchar](100) NULL,
	[representante] [varchar](100) NULL,
	[fconvenio] [datetime] NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[fenvioAsegurado] [datetime] NULL,
	[fenvioBroker] [datetime] NULL,
	[fenvioAseguradora] [datetime] NULL,
	[monedaId] [numeric](8, 0) NULL,
 CONSTRAINT [PK_RGN_CONVENIOAJUSTE] PRIMARY KEY CLUSTERED 
(
	[ajusteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_BIENAFECTADO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_BIENAFECTADO](
	[bienAfectadoId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[item] [text] NULL,
	[descripcion] [text] NULL,
	[montorep] [numeric](14, 2) NULL,
	[montosoles] [numeric](14, 2) NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[tipoCambio] [numeric](14, 2) NULL,
	[LocalDelBien] [varchar](255) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_INFORME]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_INFORME](
	[informeId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[tinformeId] [numeric](8, 0) NOT NULL,
	[fecha] [datetime] NULL,
	[ruta] [varchar](250) NULL,
	[descripcion] [varchar](250) NULL,
	[nombre] [varchar](1000) NULL,
	[numero] [varchar](20) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
	[estadoValidacion] [bit] NULL,
	[observado] [bit] NULL,
	[enviadoA] [varchar](1000) NULL,
	[fechaEnvio] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_ACTIVIDAD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_ACTIVIDAD](
	[actividadId] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[FechaHoraCoordinacion] [datetime] NULL,
	[lugarDeReunion] [varchar](250) NULL,
	[referencia] [varchar](250) NULL,
	[personaContacto] [varchar](250) NULL,
	[CargoPersonaContacto] [varchar](250) NULL,
	[FechaHoraReunion] [datetime] NULL,
	[descripcion] [varchar](1000) NULL,
	[ubigeoId] [varchar](6) NULL,
	[telefonoPersonaContacto] [varchar](20) NULL,
	[PersonaEntrevistada] [varchar](1000) NULL,
	[tipoActividadId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL,
 CONSTRAINT [PK_RGN_ACTIVIDAD] PRIMARY KEY NONCLUSTERED 
(
	[actividadId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CONTACTOS_AJUSTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CONTACTOS_AJUSTE](
	[contactoid] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[tipoContactoId] [int] NOT NULL,
	[nombreContacto] [varchar](250) NULL,
	[ajusteId] [numeric](8, 0) NOT NULL,
	[cargoContacto] [varchar](250) NULL,
	[TelefonoContacto] [varchar](20) NULL,
	[emailContacto] [varchar](250) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_RIESGO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_PARRAFO_RIESGO](
	[parrafoId] [numeric](8, 0) NOT NULL,
	[riesgoId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_TIPOCAMBIO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADM_TIPOCAMBIO](
	[tipoCambioId] [datetime] NOT NULL,
	[monedaId] [numeric](8, 0) NOT NULL,
	[factor] [numeric](14, 2) NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MODULO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_MODULO](
	[usuario] [varchar](20) NULL,
	[fcrea] [datetime] NULL,
	[moduloId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[fupdate] [datetime] NULL,
	[modulo] [varchar](250) NULL,
	[estado] [varchar](1) NULL,
	[appId] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_FUNCIONALIDAD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_FUNCIONALIDAD](
	[usuario] [varchar](20) NULL CONSTRAINT [DF_SYS_FUNCIONALIDAD_usuario]  DEFAULT (2),
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[funcionalidadId] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[estado] [varchar](1) NULL,
	[funcionalidad] [varchar](250) NULL,
	[codigo] [varchar](50) NULL,
	[moduloId] [numeric](5, 0) NOT NULL,
	[appId] [numeric](5, 0) NOT NULL,
	[nivel] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_ROLUSUARIO](
	[usuario] [varchar](20) NULL,
	[rolId] [numeric](5, 0) NOT NULL,
	[fcrea] [datetime] NULL CONSTRAINT [DF_SYS_ROLUSUARIO_fcrea]  DEFAULT (getdate()),
	[fupdate] [datetime] NULL CONSTRAINT [DF_SYS_ROLUSUARIO_fupdate]  DEFAULT (getdate()),
	[estado] [varchar](1) NULL CONSTRAINT [DF_SYS_ROLUSUARIO_estado]  DEFAULT ('A'),
	[usuarioId] [numeric](8, 0) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RGN_CONDICIONES]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RGN_CONDICIONES](
	[condicionadoid] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[nombre] [varchar](250) NULL,
	[contenido] [image] NULL,
	[ramoId] [numeric](8, 0) NOT NULL,
	[fcrea] [datetime] NULL,
	[fupdate] [datetime] NULL,
	[estado] [varchar](1) NULL,
	[ucrea] [varchar](20) NULL,
	[uupdate] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoDeleteX]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoDeleteX]
(	
	@productoid numeric(8,0),
	@uupdate varchar(20)
)
AS
	SET NOCOUNT OFF;
UPDATE [RGN_PRODUCTO] 

SET 	[estado] = ''I'',
	[uupdate] = @uupdate,
	[fupdate] = getDate()

where	productoid = @productoid
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ProductoInsertX]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ProductoInsertX](
	@productoId numeric(8,0) output,
	@nombre varchar(255),
	@descripcion varchar(500),
	@ucrea varchar(20)
)
as

INSERT INTO 
	RGN_PRODUCTO
        (nombre, descripcion, fcrea, ucrea,fupdate,uupdate,estado)
VALUES  (@nombre,@descripcion, getDate(), @ucrea,getDate(),@ucrea,''A'' )

set @productoId = scope_identity()
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoUpdateX]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoUpdateX]
(	
	@productoid numeric(8,0),
	@nombre varchar(250),
	@descripcion varchar(500),
	@uupdate varchar(20)
)
AS
	SET NOCOUNT OFF;
UPDATE [RGN_PRODUCTO] 
SET 	[nombre] = @nombre, 
	[descripcion] =  @descripcion,	
	[fupdate] = getDate(), 	  
	[uupdate] = @uupdate

where	productoid = @productoid

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoSelect]

AS
	SET NOCOUNT ON;
SELECT productoId, nombre, descripcion, fcrea, fupdate, estado, ucrea, uupdate FROM RGN_PRODUCTO where estado = ''A''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_polizaEditorSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_polizaEditorSelect]
(
	@polizaid numeric(8,0)
)

as


declare @contratante varchar(250)
declare @asegurado varchar(250)
declare @aseguradora varchar(250)
declare @aseguradoid numeric(8,0)
declare @aseguradoraid numeric(8,0)
declare @numPoliza varchar(100)
declare @productoid numeric(8,0)
declare @ramoid numeric(8,0)
declare @coberturaid numeric(8,0)
declare @grupoEconomico varchar(250)
declare @giroNegocio varchar (250)
declare @ffin datetime
declare @finicio datetime


BEGIN

set @contratante=(select contratante from RGN_POLIZA where polizaid=@polizaid)

SELECT @productoid=dbo.RGN_POLIZA.productoid
FROM   dbo.RGN_POLIZA INNER JOIN
       dbo.RGN_PRODUCTO ON dbo.RGN_POLIZA.productoId = dbo.RGN_PRODUCTO.productoId
       where dbo.RGN_POLIZA.polizaid=@polizaid

SELECT  @ramoid=dbo.RGN_POLIZA.ramoid
FROM    dbo.RGN_POLIZA INNER JOIN
        dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId
where dbo.RGN_POLIZA.polizaid=@polizaid

SELECT   @coberturaid=dbo.RGN_POLIZA.riesgoid
FROM      dbo.RGN_POLIZA INNER JOIN
          dbo.RGN_RIESGO_COBERTURA ON dbo.RGN_POLIZA.riesgoId = dbo.RGN_RIESGO_COBERTURA.riesgoId
where dbo.RGN_POLIZA.polizaid=@polizaid

select @aseguradoid=aseguradoid, 
       @aseguradoraid=aseguradoraid, 
       @numPoliza=numeroPoliza,
       @ffin=ffin,
       @finicio=finicio,
       @grupoEconomico=grupoEconomico,
       @giroNegocio=giroNegocio 
from RGN_POLIZA
where polizaid=@polizaid

select @asegurado=persona
from ADM_PERSONA
where personaid=@aseguradoid

/*Ivan 30/05/2006

select @grupoEconomico=grupoEconomico,
       @giroNegocio=actividad
from ADM_ASEGURADO
where personaid=@aseguradoid
*/
select @aseguradora=persona
from ADM_PERSONA
where personaid=@aseguradoraid

select isnull(@contratante,''--'') as contratante,
       isnull(@asegurado,''--'') as asegurado,
       isnull(@aseguradora,''--'') as aseguradora,
       isnull(@numPoliza,''--'')as numPoliza,
       isnull(@grupoEconomico,''--'')as grupoEconomico,
       isnull(@giroNegocio,''--'')as giroNegocio,
       isnull(@finicio,'''')as finicio,
       isnull(@ffin,'''')as ffin,
       @polizaid as polizaid,
       @productoid as productoid,
       @ramoid as ramoid,
       @coberturaid as coberturaid,
       @aseguradoid as aseguradoid,
       @aseguradoraid as aseguradoraid
END

--exec  sp_rgen_polizaEditorSelect 70












' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoDelete]
(	
	@productoid numeric(8,0)	
)
AS
	SET NOCOUNT OFF;
UPDATE [RGN_PRODUCTO] 
SET 	[estado] = ''I''
where	productoid = @productoid

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoUpdate]
(	
	@productoid numeric(8,0),
	@nombre varchar(250),
	@descripcion varchar(250),
	@fupdate datetime,		
	@uupdate varchar(20)
)
AS
	SET NOCOUNT OFF;
UPDATE [RGN_PRODUCTO] 
SET 	[nombre] = @nombre, 
	[descripcion] =  @descripcion,	
	[fupdate] = @fupdate, 	  
	[uupdate] = @uupdate

where	productoid = @productoid
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE
 PROCEDURE [dbo].[sp_rgen_productoInsert]
    (
      @nombre varchar(250),
      @descripcion varchar(250),
      @fcrea datetime,
      @ucrea varchar(20)
    )
AS 
    SET NOCOUNT OFF ;
    INSERT  INTO [RGN_PRODUCTO]
            (
              [nombre],
              [descripcion],
              [fcrea],
              [fupdate],
              [estado],
              [ucrea],
              [uupdate]
            )
    VALUES  (
              @nombre,
              @descripcion,
              @fcrea,
              @fcrea,
              ''A'',
              @ucrea,
              @ucrea
            )


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_productoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_productoSelectById]
(
	@productoId numeric
)
AS
	SET NOCOUNT ON;
SELECT productoId, nombre, descripcion, fcrea, fupdate, estado, ucrea, uupdate FROM RGN_PRODUCTO
where productoId = @productoId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delapoliza_cabecera]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delapoliza_cabecera](@ajusteid int)
as

	DECLARE @numero varchar(500), @numeroPoliza varchar(100)
	SET @numero = ''''

	DECLARE numeroCursor CURSOR FOR
	SELECT	RGN_POLIZA.numeroPoliza
	FROM		RGN_POLIZA INNER JOIN
					RGN_POLIZA_AJUSTE ON RGN_POLIZA_AJUSTE.polizaId = RGN_POLIZA.polizaId INNER JOIN
					RGN_AJUSTE ON RGN_AJUSTE.ajusteId = RGN_POLIZA_AJUSTE.ajusteId
	WHERE		RGN_AJUSTE.ajusteId = @ajusteid


	OPEN numeroCursor
	FETCH NEXT FROM numeroCursor INTO @numeroPoliza
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  SET @numero = @numero + @numeroPoliza + '', ''
		
		FETCH NEXT FROM numeroCursor INTO @numeroPoliza
	END
	
	CLOSE numeroCursor
	DEALLOCATE numeroCursor

	IF @numero <> '''' BEGIN	SET @numero = LEFT(@numero, LEN(@numero) - 1) END

	SELECT   TOP 1  
		RGN_PRODUCTO.nombre AS PRODUCTO, 
		RGN_RAMO.nombre AS RAMO, 
		@numero AS numero, 
		convert(varchar(10),
		convert(char,RGN_POLIZA.finicio,103)) + '' al '' + convert(varchar(10),
		convert(char,RGN_POLIZA.ffin,103)) as vigencia,
		RGN_RIESGO_COBERTURA.nombre as  cobertura
	FROM	RGN_AJUSTE INNER JOIN
        RGN_POLIZA_AJUSTE ON RGN_AJUSTE.ajusteId = RGN_POLIZA_AJUSTE.ajusteId INNER JOIN
        RGN_POLIZA ON RGN_POLIZA_AJUSTE.polizaId = RGN_POLIZA.polizaId AND 
        RGN_POLIZA_AJUSTE.aseguradoraId = RGN_POLIZA.aseguradoraId INNER JOIN
        RGN_PRODUCTO ON RGN_POLIZA.productoId = RGN_PRODUCTO.productoId INNER JOIN
        RGN_RAMO ON RGN_POLIZA.ramoId = RGN_RAMO.ramoId INNER JOIN
        RGN_RIESGO_COBERTURA ON RGN_POLIZA.riesgoId = RGN_RIESGO_COBERTURA.riesgoId
	WHERE RGN_AJUSTE.ajusteid = @ajusteid
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ProductoCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_ProductoCombo]
AS
	SET NOCOUNT ON;
SELECT     rgn_producto.productoid, rgn_Producto.descripcion
FROM         rgn_producto
WHERE RGN_PRODUCTO.estado=''A''
ORDER BY RGN_PRODUCTO.descripcion asc
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_polizaPrincipalRimac]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--exec sp_rgen_polizaPrincipalRimac 2533

CREATE PROCEDURE [dbo].[sp_rgen_polizaPrincipalRimac](@ajusteid numeric(8,0))
as

BEGIN

SELECT  dbo.RGN_POLIZA.polizaId,
			dbo.RGN_POLIZA.numeroPoliza, 
			dbo.RGN_RAMO.nombre AS ramo, 
			dbo.RGN_PRODUCTO.nombre AS producto, 
			dbo.RGN_RIESGO_COBERTURA.nombre AS cobertura, 
			dbo.RGN_POLIZA.finicio, 
			dbo.RGN_POLIZA.ffin, 
			dbo.RGN_POLIZA_AJUSTE.ajusteId, 
			dbo.ADM_PERSONA.persona

FROM         dbo.RGN_PRODUCTO INNER JOIN
          dbo.RGN_POLIZA_AJUSTE INNER JOIN
          dbo.RGN_RIESGO_COBERTURA INNER JOIN
          dbo.RGN_POLIZA ON dbo.RGN_RIESGO_COBERTURA.riesgoId = dbo.RGN_POLIZA.riesgoId AND 
          dbo.RGN_RIESGO_COBERTURA.riesgoId = dbo.RGN_POLIZA.riesgoId INNER JOIN
          dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId AND dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId ON 
          dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
          dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId AND 
          dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId ON dbo.RGN_PRODUCTO.productoId = dbo.RGN_POLIZA.productoId AND 
          dbo.RGN_PRODUCTO.productoId = dbo.RGN_POLIZA.productoId INNER JOIN
          dbo.ADM_CLIENTE ON dbo.RGN_POLIZA.aseguradoraId = dbo.ADM_CLIENTE.aseguradoraId AND 
          dbo.RGN_POLIZA.aseguradoraId = dbo.ADM_CLIENTE.aseguradoraId INNER JOIN
          dbo.ADM_PERSONA ON dbo.ADM_CLIENTE.aseguradoraId = dbo.ADM_PERSONA.personaId
where ajusteid = @ajusteId
order by 1


END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AtributosPolizaInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[sp_rgen_AtributosPolizaInsert]
(
	@atributoId numeric(8,0) = NULL output,
	@polizaId numeric(8,0),
	@condiciones varchar(1000) = NULL,
	@usuario varchar(100)=NULL

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	DECLARE @aseguradoraId numeric (8,0)

	select @aseguradoraId=aseguradoraId
	From RGN_POLIZA
	WHERE RGN_POLIZA.polizaid=@polizaId

	INSERT
	INTO [RGN_ATRIBUTOPOLIZA]
	(
		[polizaId],
		[aseguradoraId],
		[condiciones],
		[fcrea],
		[fupdate],
		[ucrea],
		[uupdate],
		[estado]
		
	)
	VALUES
	(
		@polizaId,
		@aseguradoraId,
		@condiciones,
		getdate(),
		getdate(),
		@usuario,
		@usuario,
		''A''
		

	)

	SET @Err = @@Error

	SELECT @atributoId = SCOPE_IDENTITY()

	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_AtributosPolizaDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_Rgen_AtributosPolizaDelete]
(
	@atributoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_ATRIBUTOPOLIZA_AJUSTE]
	WHERE [RGN_ATRIBUTOPOLIZA_AJUSTE].atributoId=@atributoId

	DELETE
	FROM [RGN_ATRIBUTOPOLIZA]
	WHERE
		[atributoId] = @atributoId
	SET @Err = @@Error

	RETURN @Err
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_PolizaDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE  PROCEDURE [dbo].[sp_Rgen_PolizaDelete] 
(
	@polizaId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	SELECT * FROM RGN_POLIZA_AJUSTE
	WHERE polizaId = @polizaId

	IF (@@ROWCOUNT = 0)
	
	BEGIN
		
		delete 
		from RGN_ITEMASEGURADO_AJUSTE 
		where polizaId = @polizaId

		DELETE 
		FROM RGN_ITEMASEGURADO
		WHERE polizaId = @polizaId

		delete 
		from RGN_AJUSTE_CLAUSULAS
		where polizaId = @polizaId
		DELETE 

		FROM RGN_CLAUSULAS
		WHERE polizaId = @polizaId

		DELETE 
		FROM RGN_ATRIBUTOPOLIZA
		WHERE polizaId = @polizaId

		DELETE
		FROM RGN_POLIZA
		WHERE polizaId = @polizaId 			
		
		
	END
	else 
	begin
	
		raiserror(''CASOSEXISTS'', 16,1);
		return;
	end

	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_deducibles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_informebasico_deducibles](@ajusteid int)
as

SELECT DISTINCT RGN_ATRIBUTOPOLIZA.condiciones
FROM         RGN_ATRIBUTOPOLIZA_AJUSTE INNER JOIN
                      RGN_ATRIBUTOPOLIZA ON 
                      RGN_ATRIBUTOPOLIZA_AJUSTE.atributoId = RGN_ATRIBUTOPOLIZA.atributoId AND 
                      RGN_ATRIBUTOPOLIZA_AJUSTE.polizaId = RGN_ATRIBUTOPOLIZA.polizaId AND 
                      RGN_ATRIBUTOPOLIZA_AJUSTE.aseguradoraId = RGN_ATRIBUTOPOLIZA.aseguradoraId INNER JOIN
                      RGN_ITEMASEGURADO ON 
                      RGN_ATRIBUTOPOLIZA_AJUSTE.polizaId = RGN_ITEMASEGURADO.polizaId
WHERE     (RGN_ATRIBUTOPOLIZA_AJUSTE.ajusteId = @ajusteid)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AtributoPolizaSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_AtributoPolizaSelectById]
(
	@polizaId numeric(8,0),
	@ajusteId numeric(8,0)=null	
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int
	
	if(@ajusteId is not null)
	
	BEGIN

		SELECT
			[atributoId],
			[polizaId],
			[aseguradoraId],
			[condiciones],
			[FLAGExiste] = 
				case isnull((select x.polizaId 
					from [RGN_ATRIBUTOPOLIZA_AJUSTE] x
					where x.atributoId = [RGN_ATRIBUTOPOLIZA].atributoId and
						  x.polizaId = [RGN_ATRIBUTOPOLIZA].polizaId and
						  x.aseguradoraId = [RGN_ATRIBUTOPOLIZA].aseguradoraId and
						  x.ajusteId= @ajusteId
				),-1) when -1 then 1 else 0 end
			
		FROM [RGN_ATRIBUTOPOLIZA]
		WHERE
			
			([polizaId] = @polizaId)AND
			([estado]=''A'')
	
	END
	ELSE
		BEGIN
			SELECT
			[atributoId],
			[polizaId],
			[aseguradoraId],
			[condiciones],
			1 as FLAGExiste
				
			
			FROM [RGN_ATRIBUTOPOLIZA]
			WHERE
				
				([polizaId] = @polizaId)AND
				([estado]=''A'')
		END

	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgnx_selectTipoSiniestroByRamoId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgnx_selectTipoSiniestroByRamoId](@ramoId numeric(8,0) = null) 
as

if @ramoid <> -1
SELECT tipoSiniestroId, tipoSiniestro, ramoId
FROM dbo.RGN_TIPOSINIESTRO
WHERE (estado <> ''I'') and ramoId = @ramoId 
ORDER BY tipoSiniestro asc
else 
SELECT tipoSiniestroId, tipoSiniestro, ramoId
FROM dbo.RGN_TIPOSINIESTRO
WHERE (estado <> ''I'') 
ORDER BY tipoSiniestro asc' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[sp_rgen_TipoSiniestroInsert]
(
	@tipoSiniestro varchar(250),
	@descripcion varchar(250),
	@ucrea varchar(20),
	@ramoid numeric(8,0)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [RGN_TIPOSINIESTRO] 
(	
	tipoSiniestro,
	descripcion,
	fcrea,
	fupdate,
	ucrea,
	uupdate,
	estado,
	ramoid
) 
VALUES 
(
	@tipoSiniestro,
	@descripcion,
	getDate(),
	getDate(),
	@ucrea,
	@ucrea,
	''A'',
	@ramoid
)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TipoSiniestroUpdate]
(
	@tipoSiniestroId numeric(8, 0),
	@tipoSiniestro varchar(250),
	@descripcion varchar(250),
	@ramoId numeric(8,0),
	@uupdate varchar(20)
)
AS
	SET NOCOUNT OFF;

UPDATE RGN_TIPOSINIESTRO 
SET tipoSiniestro = @tipoSiniestro, 
	descripcion = @descripcion,
	fupdate =getdate(),
	uupdate = @uupdate,
	ramoid = @ramoId
WHERE ( tipoSiniestroId=@tipoSiniestroId);
	' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[sp_rgen_TipoSiniestroSelect]
AS 
    SET NOCOUNT ON ;
    SELECT  dbo.RGN_TIPOSINIESTRO.tipoSiniestroId,
            dbo.RGN_TIPOSINIESTRO.tipoSiniestro,
            dbo.RGN_TIPOSINIESTRO.descripcion,
            dbo.RGN_TIPOSINIESTRO.fcrea,
            dbo.RGN_TIPOSINIESTRO.fupdate,
            dbo.RGN_TIPOSINIESTRO.estado,
            dbo.RGN_TIPOSINIESTRO.ucrea,
            dbo.RGN_TIPOSINIESTRO.uupdate,
            dbo.RGN_TIPOSINIESTRO.ramoId,
            dbo.RGN_RAMO.nombre
    FROM    dbo.RGN_TIPOSINIESTRO
            LEFT OUTER JOIN dbo.RGN_RAMO ON dbo.RGN_TIPOSINIESTRO.ramoId = dbo.RGN_RAMO.ramoId
    WHERE   RGN_TIPOSINIESTRO.estado = ''A''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TipoSiniestroSelectById]
(
	@tipoSiniestroId numeric(8,0)
)

	

AS
	SET NOCOUNT ON;
SELECT    * 
	           
FROM   	RGN_TIPOSINIESTRO

WHERE  	estado = ''A'' And tiposiniestroId=@tiposiniestroId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TipoSiniestroDelete]
(
	@tipoSiniestroId numeric (8,0)
 	
)
AS
	SET NOCOUNT OFF;
DELETE FROM  RGN_TIPOSINIESTRO WHERE (tipoSiniestroId = @tipoSiniestroId)



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delaocurrencia_cabecera]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  procedure [dbo].[sp_rgen_informebasico_delaocurrencia_cabecera] ( @ajusteid int )
    
as 
    SELECT  RGN_TIPOSINIESTRO.tipoSiniestro,
            RGN_SINIESTRO.fsiniestro AS fechasiniestro,
            RGN_SINIESTRO.lugarSiniestro,
            RGN_AJUSTE.detalleocurrencia,
            RGN_AJUSTE.causasiniestro,
            RGN_AJUSTE.investigaciones
    FROM    RGN_SINIESTRO
            INNER JOIN RGN_AJUSTE ON RGN_SINIESTRO.siniestroid = RGN_AJUSTE.siniestroid
            INNER JOIN RGN_TIPOSINIESTRO ON RGN_TIPOSINIESTRO.tipoSiniestroId = RGN_SINIESTRO.tipoSiniestroId
    WHERE   ( RGN_AJUSTE.ajusteId = @ajusteid )






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoSiniestroCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TipoSiniestroCombo]
AS
	SET NOCOUNT ON;
SELECT     tipoSiniestroId, tipoSiniestro, descripcion, fcrea, fupdate, estado, ucrea, uupdate
FROM         RGN_TIPOSINIESTRO
WHERE     (estado = ''A'')
order by tipoSiniestro asc ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_getAccesoAFuncionalidades]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_getAccesoAFuncionalidades] ( @rolID numeric(8,0)) 
AS
BEGIN

	SELECT  SYS_FUNCIONALIDAD.codigo, SYS_FUNCIONALIDAD.funcionalidadId
	FROM		SYS_ACCESO INNER JOIN
          SYS_FUNCIONALIDAD ON SYS_ACCESO.funcionalidadId = SYS_FUNCIONALIDAD.funcionalidadId
	WHERE   SYS_ACCESO.rolId = @rolId
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_tieneFuncionalidad_SegundoNivel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_tieneFuncionalidad_SegundoNivel](
@aseguradoraId decimal(18,0),
@codigo varchar(100)
)
as

select SYS_SUBACCESO.funcionalidadId, SYS_FUNCIONALIDAD.codigo from SYS_SUBACCESO join SYS_FUNCIONALIDAD on SYS_SUBACCESO.funcionalidadId = SYS_FUNCIONALIDAD.funcionalidadId
where aseguradoraId = @aseguradoraId and brokerId is null and SYS_FUNCIONALIDAD.codigo = @codigo
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_tieneFuncionalidad_SegundoNivel_Broker]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_tieneFuncionalidad_SegundoNivel_Broker](
@aseguradoraId decimal(18,0),
@codigo varchar(100),
@brokerId decimal(18,0)
)
as

select SYS_SUBACCESO.funcionalidadId, SYS_FUNCIONALIDAD.codigo from SYS_SUBACCESO join SYS_FUNCIONALIDAD on SYS_SUBACCESO.funcionalidadId = SYS_FUNCIONALIDAD.funcionalidadId
where aseguradoraId = @aseguradoraId and brokerId = @brokerId and SYS_FUNCIONALIDAD.codigo = @codigo
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SubAccesoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SubAccesoInsert] 
(
	@funcionalidadId	numeric,
	@aseguradoraId 		numeric,
	@brokerId					numeric,
	@acceso						bit,
	@uupdate					varchar(20)
)
AS
BEGIN

	IF @acceso = 1
		BEGIN
			IF @brokerId IS NULL OR @brokerId = -1
				BEGIN 
					SET @brokerId = NULL
	
					UPDATE	SYS_SUBACCESO
					SET			SYS_SUBACCESO.fupdate = GETDATE(),
									SYS_SUBACCESO.uupdate = @uupdate
					WHERE		SYS_SUBACCESO.funcionalidadId = @funcionalidadId AND
									SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
									SYS_SUBACCESO.brokerId IS NULL
				END
			ELSE			
				UPDATE	SYS_SUBACCESO
				SET			SYS_SUBACCESO.fupdate = GETDATE(),
								SYS_SUBACCESO.uupdate = @uupdate
				WHERE		SYS_SUBACCESO.funcionalidadId = @funcionalidadId AND
								SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
								SYS_SUBACCESO.brokerId = @brokerId

			IF @@ROWCOUNT = 0
				BEGIN 
					INSERT 	INTO	SYS_SUBACCESO
									(funcionalidadId, moduloId, appId, aseguradoraId, brokerId, fcrea, fupdate, ucrea, uupdate)
					SELECT	
									SYS_FUNCIONALIDAD.funcionalidadId,
									SYS_FUNCIONALIDAD.moduloId,
									SYS_FUNCIONALIDAD.appId,
									@aseguradoraId,
									@brokerId,
									GETDATE(),
									GETDATE(),
									@uupdate,
									@uupdate
					FROM		SYS_FUNCIONALIDAD
					WHERE		SYS_FUNCIONALIDAD.funcionalidadId = @funcionalidadId
				END
		END
	ELSE
		BEGIN
			IF @brokerId IS NULL OR @brokerId = -1
				BEGIN 
					DELETE 	FROM SYS_SUBACCESO
					WHERE		SYS_SUBACCESO.funcionalidadId = @funcionalidadId AND
									SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
									SYS_SUBACCESO.brokerId IS NULL

					IF @@ROWCOUNT > 0
						DELETE 	FROM SYS_SUBACCESO
						WHERE		SYS_SUBACCESO.funcionalidadId = @funcionalidadId AND
										SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
										SYS_SUBACCESO.brokerId IS NOT NULL

				END
			ELSE
					DELETE 	FROM SYS_SUBACCESO
					WHERE		SYS_SUBACCESO.funcionalidadId = @funcionalidadId AND
									SYS_SUBACCESO.aseguradoraId = @aseguradoraId AND
									SYS_SUBACCESO.brokerId = @brokerId
		END

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[borraPersona]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[borraPersona](@personaId numeric(8,0)) as

delete from ADM_TELEFONOXPERSONA where personaid = @personaId

delete from ADM_DOCID where personaid  = @personaId

delete from  ADM_DIRECCIONPERSONA where personaid = @personaId

delete from ADM_PERSONA where personaid = @personaId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PersonaDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_PersonaDelete]
(	
	@personaId numeric (8,0),
	@uupdate varchar(20)
)
AS

declare @aux_estado varchar(1)


select @aux_estado = estado from ADM_PERSONA where (personaId=@personaId)

if (@aux_estado = ''I'') 
begin
	UPDATE ADM_PERSONA 
	SET estado=''A'',
	 uupdate = @uupdate
	WHERE personaId=@personaId	
end
else 
begin
	UPDATE ADM_PERSONA 
	SET estado=''I'',
	 uupdate = @uupdate
	WHERE personaId=@personaId
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_aseguradoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_aseguradoUpdate]
(
	@PrimerNombre varchar(250)=NULL,
	@SegundoNombre varchar(250)=NULL,
	@ApellidoPaterno varchar (250)=NULL,
	@ApellidoMaterno varchar (250)=NULL,
	@ucrea varchar(20) = NULL,
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0),
	@chkPersonaJuridica bit =NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''


	
 update ADM_PERSONA
	set persona=dbo.quitaespacios(isnull(@Primernombre + '' '','''')+isNull(@SegundoNombre + '' '','''')+isNull(@ApellidoPaterno + '' '','''')+isNull(@ApellidoMaterno,'''')),
	    nombre1=dbo.quitaespacios(@PrimerNombre),
	    nombre2=dbo.quitaespacios(@SegundoNombre),
	    apellido1=dbo.quitaespacios(@ApellidoPaterno),
	    apellido2=dbo.quitaespacios(@ApellidoMaterno),
	    tpersonaid=3,
	    uupdate=@ucrea,
	    estado=''A'',
            fupdate=getDate(),
	    personajuridica=@personajuridica
		
	where personaId=@personaId
	
	
declare @contador numeric

	if 	not(@TFIJO is null) 
		begin

			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=1)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFIJO,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=1)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFIJO,
					getDate(),
					getDate(),
					1
				
				)
			end
		end


	if 	not(@TFAX is null) 
		begin
			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=3)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFAX,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=3)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFAX,
					getDate(),
					getDate(),
					3			
					)
			end		
		end




	if 	not(@direccion is null) 
		begin
			select @contador=count(*) from ADM_DIRECCIONPERSONA
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DIRECCIONPERSONA
					SET direccion=@direccion,
					    ubigeoId=@ubigeoId,
					    fupdate=getdate()
				WHERE (personaID=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DIRECCIONPERSONA
				(
					personaId,
					direccion,
					fcrea,
					fupdate,
			--		tdireccionid,
					ubigeoId
				)
				VALUES
				(
					@personaId,
					@direccion,
					getDate(),
					getDate(),
			--		1,
					@ubigeoId
				);
			end
		end
	
	if 	not(@docid is null) 
		begin
			select @contador=count(*) from ADM_DOCID
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DOCID
					SET docid=@docid,
					    tdocidid=@tdocidId,
					    fupdate=getdate()
				WHERE (personaId=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DOCID
				(
					personaId,
					docid,
					fcrea,
					fupdate,
					tdocidid,
					principal,
					estado
				)
				VALUES
				(
					@personaId,
					@docid,
					getDate(),
					getDate(),
					@tdocidId,
					''S'',
					''A''
				);
			end

		end
	
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_brokerUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_brokerUpdate]
(
	@persona varchar(1000)=NULL,
	@ucrea varchar(20) = NULL,
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0),
	@chkPersonaJuridica bit =NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''


	
 update ADM_PERSONA
	set persona=@persona,
	    tpersonaid=1,
	    uupdate=@ucrea,
	    estado=''A'',
            fupdate=getDate(),
	    personajuridica=@personajuridica
		
	where personaId=@personaId
	
	
declare @contador numeric

	if 	not(@TFIJO is null) 
		begin

			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=1)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFIJO,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=1)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFIJO,
					getDate(),
					getDate(),
					1
				
				)
			end
		end


	if 	not(@TFAX is null) 
		begin
			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=3)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFAX,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=3)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFAX,
					getDate(),
					getDate(),
					3			
					)
			end		
		end




	if 	not(@direccion is null) 
		begin
			select @contador=count(*) from ADM_DIRECCIONPERSONA
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DIRECCIONPERSONA
					SET direccion=@direccion,
					    ubigeoId=@ubigeoId,
					    fupdate=getdate()
				WHERE (personaID=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DIRECCIONPERSONA
				(
					personaId,
					direccion,
					fcrea,
					fupdate,
			--		tdireccionid,
					ubigeoId
				)
				VALUES
				(
					@personaId,
					@direccion,
					getDate(),
					getDate(),
			--		1,
					@ubigeoId
				);
			end
		end
	
	if 	not(@docid is null) 
		begin
			select @contador=count(*) from ADM_DOCID
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DOCID
					SET docid=@docid,
					    tdocidid=@tdocidId,
					    fupdate=getdate()
				WHERE (personaId=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DOCID
				(
					personaId,
					docid,
					fcrea,
					fupdate,
					tdocidid,
					principal,
					estado
				)
				VALUES
				(
					@personaId,
					@docid,
					getDate(),
					getDate(),
					@tdocidId,
					''S'',
					''A''
				);
			end

		end
	
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_aseguradoraUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_aseguradoraUpdate]
(
	@persona varchar(1000)=NULL,
	@ucrea varchar(20) = NULL,
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0),
	@chkPersonaJuridica bit =NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''


	
 update ADM_PERSONA
	set persona=@persona,
	    tpersonaid=2,
	    uupdate=@ucrea,
	    estado=''A'',
            fupdate=getDate(),
	    personajuridica=@personajuridica
		
	where personaId=@personaId
	
	
declare @contador numeric

	if 	not(@TFIJO is null) 
		begin

			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=1)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFIJO,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=1)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFIJO,
					getDate(),
					getDate(),
					1
				
				)
			end
		end


	if 	not(@TFAX is null) 
		begin
			select @contador=count(*) from ADM_TELEFONOXPERSONA
			where (personaId=@personaId) and (ttelefonoId=3)

			if (@contador>=1)
			begin
				UPDATE ADM_TELEFONOXPERSONA
					SET telefono=@TFAX,
					    fupdate=getdate()
				WHERE (personaID=@personaId)and(ttelefonoId=3)
			end
			else
			begin
				INSERT INTO ADM_TELEFONOXPERSONA
				(
					
					personaId,
					telefono,
					fcrea,
					fupdate,
					ttelefonoId		
				)
					VALUES
				(
					@personaId,
					@TFAX,
					getDate(),
					getDate(),
					3			
					)
			end		
		end




	if 	not(@direccion is null) 
		begin
			select @contador=count(*) from ADM_DIRECCIONPERSONA
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DIRECCIONPERSONA
					SET direccion=@direccion,
					    ubigeoId=@ubigeoId,
					    fupdate=getdate()
				WHERE (personaID=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DIRECCIONPERSONA
				(
					personaId,
					direccion,
					fcrea,
					fupdate,
			--		tdireccionid,
					ubigeoId
				)
				VALUES
				(
					@personaId,
					@direccion,
					getDate(),
					getDate(),
			--		1,
					@ubigeoId
				);
			end
		end
	
	if 	not(@docid is null) 
		begin
			select @contador=count(*) from ADM_DOCID
			where (personaId=@personaId)

			if (@contador>=1)
			begin
				UPDATE ADM_DOCID
					SET docid=@docid,
					    tdocidid=@tdocidId,
					    fupdate=getdate()
				WHERE (personaId=@personaId)
			end
			
			else
			begin

				INSERT INTO ADM_DOCID
				(
					personaId,
					docid,
					fcrea,
					fupdate,
					tdocidid,
					principal,
					estado
				)
				VALUES
				(
					@personaId,
					@docid,
					getDate(),
					getDate(),
					@tdocidId,
					''S'',
					''A''
				);
			end

		end
	
	
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--sp_rgen_BrokerInsert ''Adolfo Mesones'',''system'',null,null,null,null,1,''40843570'',null,1

CREATE PROCEDURE [dbo].[sp_rgen_BrokerInsert]
(
	@persona varchar(1000)=NULL,
	@ucrea varchar(20) = NULL,
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0) output,
	@chkPersonaJuridica bit =NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''

		
	INSERT
	INTO ADM_PERSONA
	(
		persona,
		ucrea,
		tpersonaid,
		uupdate,
		fcrea,
		estado,
		fupdate,
		personajuridica
		
	)
	VALUES
	(
		
		@persona,
		@ucrea,
		1,
		@ucrea,
		getDate(),
		''A'',
		getDate(),
		@personajuridica
	)

	

	set @personaId = SCOPE_IDENTITY()

	INSERT INTO ADM_BROKER
	(
		personaId
	)
	VALUES
	(
		@personaId
	)

	if 	not(@TFIJO is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFIJO,
			getDate(),
			getDate(),
			1
		
		)
		end


	if 	not(@TFAX is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFAX,
			getDate(),
			getDate(),
			3			
			)

		end

	if 	not(@direccion is null) 
		begin
			INSERT INTO ADM_DIRECCIONPERSONA
		(
				personaId,
				direccion,
				fcrea,
				fupdate,
		--		tdireccionid,
				ubigeoId
			)
			VALUES
			(
				@personaId,
				@direccion,
				getDate(),
				getDate(),
		--		1,
				@ubigeoId
			);
		end
	
	if 	not(@docid is null) 
		begin
			INSERT INTO ADM_DOCID
			(
				personaId,
				docid,
				fcrea,
				fupdate,
				tdocidid,
				principal,
				estado
			)
			VALUES
			(
				@personaId,
				@docid,
				getDate(),
				getDate(),
				@tdocidId,
				''S'',
				''A''
			);

		end
	
	
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoInsert]
(
	@PrimerNombre varchar(250)=NULL,
	@SegundoNombre varchar(250)=NULL,
	@ApellidoPaterno varchar(250)=NULL,
	@ApellidoMaterno varchar(250)=NULL,
	@ucrea varchar(20),
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0) output,
	@chkPersonaJuridica bit =NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''

		
	
	INSERT INTO ADM_PERSONA(
		persona, 
		nombre1,
		nombre2, 
		apellido1, 
		apellido2, 
		estado, 
		fcrea, 
		tpersonaid, 
		personajuridica,
		ucrea)
     	VALUES(
      		dbo.quitaespacios(isnull(@Primernombre + '' '','''')+isNull(@SegundoNombre + '' '','''')+isNull(@ApellidoPaterno + '' '','''')+isNull(@ApellidoMaterno,'''')),
      		dbo.quitaespacios(@PrimerNombre),
	        dbo.quitaespacios(@SegundoNombre), 
      		dbo.quitaespacios(@ApellidoPaterno),
      		dbo.quitaespacios(@ApellidoMaterno),
      		''A'',
      		getdate(),
      		''3'', --tipo asegurado
      		@personajuridica,
		@ucrea

    	) 	

	set @personaId = SCOPE_IDENTITY()

	INSERT INTO dbo.ADM_ASEGURADO
	(
		personaId
	)
	VALUES
	(
		@personaId
	)

	if 	not(@TFIJO is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFIJO,
			getDate(),
			getDate(),
			1
		
		)
		end


	if 	not(@TFAX is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFAX,
			getDate(),
			getDate(),
			3			
			)

		end

	if 	not(@direccion is null) 
		begin
			INSERT INTO ADM_DIRECCIONPERSONA
		(
				personaId,
				direccion,
				fcrea,
				fupdate,
		--		tdireccionid,
				ubigeoId
			)
			VALUES
			(
				@personaId,
				@direccion,
				getDate(),
				getDate(),
		--		1,
				@ubigeoId
			);
		end
	
	if 	not(@docid is null) 
		begin
			INSERT INTO ADM_DOCID
			(
				personaId,
				docid,
				fcrea,
				fupdate,
				tdocidid,
				principal,
				estado
			)
			VALUES
			(
				@personaId,
				@docid,
				getDate(),
				getDate(),
				@tdocidId,
				''S'',
				''A''
			);

		end
	
	
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correoPersonaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correoPersonaUpdate](@personaId numeric(8,0), @email varchar(250)) as
UPDATE [ADM_PERSONA]
   SET [email] = @email
 WHERE personaId = @personaId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameEmailAjustador]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameEmailAjustador]
(
	@ajustadorId numeric
)
AS
	SET NOCOUNT ON;
SELECT     email
FROM         ADM_PERSONA
WHERE     (personaId = @ajustadorId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correoPersonaSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correoPersonaSelect](@personaId numeric(8,0)) as

SELECT [personaId],
		[persona]      
      ,[email]
  FROM [rgenx].[dbo].[ADM_PERSONA]
where personaId = @personaId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CiaCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_CiaCombo]

AS
	SET NOCOUNT OFF;
	
	SELECT     
		ADM_PERSONA.persona,
		ADM_PERSONA.personaid
		
	FROM	ADM_CLIENTE
				LEFT JOIN ADM_PERSONA ON ADM_PERSONA.personaId = ADM_CLIENTE.aseguradoraId
				
	WHERE ADM_PERSONA.estado =''A'' 
	ORDER BY ADM_PERSONA.persona ASC


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_generales]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE  PROCEDURE [dbo].[sp_rgen_informebasico_generales](@ajusteid int)
as

--declare @ajusteid int
--set @ajusteid = 1
declare @polizaid int

SELECT     @polizaid = MIN(polizaId) --AS poliza
FROM         RGN_POLIZA_AJUSTE
WHERE     (ajusteId = @ajusteid)

declare @contratante varchar(100)
declare @asegurado varchar(100)
declare @gironegocio varchar(100)
declare @grupoeconomico varchar(100)

SELECT     @contratante = RGN_POLIZA.contratante, 
	   @gironegocio = RGN_POLIZA.gironegocio,
	   @grupoeconomico = RGN_POLIZA.grupoeconomico,
       @asegurado   = ADM_PERSONA.persona 

FROM  RGN_POLIZA INNER JOIN
      ADM_ASEGURADO ON RGN_POLIZA.aseguradoId = ADM_ASEGURADO.personaId INNER JOIN
      ADM_PERSONA ON ADM_ASEGURADO.personaId = ADM_PERSONA.personaId CROSS JOIN RGN_AJUSTE

where     RGN_POLIZA.polizaId = @polizaid
GROUP BY RGN_POLIZA.contratante, ADM_PERSONA.persona, RGN_POLIZA.giroNegocio, 
         RGN_POLIZA.grupoEconomico


declare @aseguradora varchar(50)
declare @responsableaseguradora varchar(50)

SELECT top 1    @aseguradora = ADM_PERSONA.persona
           
FROM         RGN_POLIZA INNER JOIN
              ADM_CLIENTE ON RGN_POLIZA.aseguradoraId = ADM_CLIENTE.aseguradoraId INNER JOIN
              ADM_PERSONA ON ADM_CLIENTE.aseguradoraId = ADM_PERSONA.personaId INNER JOIN
              RGN_POLIZA_AJUSTE ON RGN_POLIZA.polizaId = RGN_POLIZA_AJUSTE.polizaId AND 
              RGN_POLIZA.aseguradoraId = RGN_POLIZA_AJUSTE.aseguradoraId INNER JOIN
              RGN_AJUSTE ON RGN_POLIZA_AJUSTE.ajusteId = RGN_AJUSTE.ajusteId
              
WHERE     (RGN_POLIZA.polizaId = @polizaid)

select @responsableaseguradora=nombreContacto from RGN_CONTACTOS_AJUSTE where ajusteId=@ajusteId and tipocontactoId=1

declare @broker varchar(50)
declare @responsablebroker varchar(50)


-- IG(10/07/2008) Estoy reemplazando esta info por un problema

/*SELECT     @broker = ADM_PERSONA.persona
          
FROM         ADM_PERSONA INNER JOIN
              ADM_BROKER ON ADM_PERSONA.personaId = ADM_BROKER.personaId INNER JOIN
              RGN_AJUSTE ON ADM_BROKER.personaId = RGN_AJUSTE.brokerId INNER JOIN
              RGN_POLIZA INNER JOIN
              RGN_POLIZA_AJUSTE ON RGN_POLIZA.polizaId = RGN_POLIZA_AJUSTE.polizaId AND 
              RGN_POLIZA.aseguradoraId = RGN_POLIZA_AJUSTE.aseguradoraId ON 
              RGN_AJUSTE.ajusteId = RGN_POLIZA_AJUSTE.ajusteId
              
WHERE     (RGN_POLIZA.polizaId = @polizaid)*/

SELECT    @broker = ADM_PERSONA.persona
          
FROM         ADM_PERSONA INNER JOIN
              ADM_BROKER ON ADM_PERSONA.personaId = ADM_BROKER.personaId INNER JOIN
              RGN_AJUSTE ON ADM_BROKER.personaId = RGN_AJUSTE.brokerId 
              
WHERE     (RGN_AJUSTE.ajusteId = @ajusteid)


select @responsablebroker=nombreContacto from RGN_CONTACTOS_AJUSTE where ajusteId=@ajusteId and tipocontactoId=2

/*if exists (select * from dbo.sysobjects where name=''informebasicogenerales'' and xtype=''U'')
drop table informebasicogenerales*/

/*create table rgn_temp_informebasicogenerales(
contratante varchar(100),
asegurado varchar(100),
gironegocio varchar(100),
grupoeconomico varchar(100),
aseguradora varchar(50),
responsableaseguradora varchar(50),
broker varchar(50),
responsablebroker varchar(50),
)*/

delete from rgn_temp_informebasicogenerales

insert into rgn_temp_informebasicogenerales(contratante,asegurado,gironegocio,grupoeconomico,aseguradora,responsableaseguradora,broker,responsablebroker)
values (@contratante,@asegurado,@gironegocio,@grupoeconomico,@aseguradora,@responsableaseguradora,@broker,@responsablebroker)

select * from rgn_temp_informebasicogenerales



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerListabyName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_BrokerListabyName] (
	@name varchar(100)
)
AS
	SELECT P.persona AS brokerName, 
	       P.personaId AS brokerId     
FROM   ADM_PERSONA P,ADM_BROKER B
where (P.persona LIKE @name+''%'') AND 
      (P.personaId=B.personaId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_BrokerCombo]
AS
	SET NOCOUNT ON;
	

 SELECT     
		ADM_PERSONA.persona,
		ADM_PERSONA.personaid
		
	FROM	ADM_BROKER
				LEFT JOIN ADM_PERSONA ON ADM_PERSONA.personaId = ADM_BROKER.personaId
				
	 
	ORDER BY ADM_PERSONA.persona ASC' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[insertar_broker]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[insertar_broker] (
	@nombre varchar(500),
	@tipo numeric(8,0)
) as

insert into adm_persona(persona,nombre1,tpersonaid) 
values (@nombre,@nombre,@tipo)

declare @l_uid numeric(8,0)

set @l_uid = scope_identity()

insert into adm_broker (personaid) 
values (@l_uid)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_UsuarioInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE   PROCEDURE [dbo].[sp_Rgn_UsuarioInsert]
(
	@nombre1 		varchar(250),
	@apellido1 		varchar(250),
	@apellido2 		varchar(250),
	@telefono		varchar(20),
	@docId			varchar(100),
	@tdocidId		int,
	@rolId			int,
	@usuario		varchar(20),
	@clave			varchar(20),
	@estado			varchar(1),
	@creadorId 		numeric(8,0),
	@companiaId		numeric(5,0)
)
AS
	DECLARE @usuarioId 		int
	DECLARE @personaId 		int
	DECLARE @Error 			int
	DECLARE @nombre  		varchar(200);
	DECLARE @fechaActual 		datetime;
	DECLARE @tpersonaId  		int;
	DECLARE @rolIdAseguradora 	int;

	IF (@rolId=1) --ajustador
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''AJUSTADOR''
	IF (@rolId=3) --Cia Aseguradora
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''COMPAÑÍA DE SEGUROS'';
	IF (@rolId=4) --Ejecutivo cia de seguros
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''EJECUTIVOCIASEGUROS'';
	IF (@rolId=5) --Broker
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''BROKER'';
	IF (@rolId=8) --Ejecutivo Broker
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''EJECUTIVOBROKER'';
	IF (@rolId=10) --Asistente
		Select @tpersonaId=tpersonaId from ADM_TPERSONA WHERE UPPER(tpersona)=''ASISTENTE'';

	
	SET @fechaActual = GETDATE();
	SET @nombre = @nombre1;

		if 	not(@apellido1 is null) 
		begin
			SET @nombre = @nombre+'' ''+@apellido1;
		end
	
		if 	not(@apellido2 is null) 
		begin
			SET @nombre = @nombre+'' ''+@apellido2;
		end

		
	BEGIN TRAN
		SET NOCOUNT OFF;
		
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		INSERT INTO SYS_USUARIO
			(
	 		usuario,
			clave,
			fcrea,
			fupdate,
			estado,
			companiaId
			)
		VALUES 	(
			@usuario, 
			@clave, 
			@fechaActual,
			@fechaActual,
			@estado,
			@companiaId
			)
	
		SET @usuarioId = scope_identity()
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		INSERT INTO ADM_PERSONA 
			(
			persona,
		 	nombre1, 
			apellido1, 
			apellido2, 
			tpersonaId,
			usuarioId,
			fcrea,
			fupdate,
			estado,
			creadorId
			)
		VALUES	(
			@nombre,
			@nombre1, 
			@apellido1, 
			@apellido2,
			@tpersonaId, 
			@usuarioId,
			@fechaActual,
			@fechaActual,
			@estado,
			@creadorId
			)
	
		SET @personaId = scope_identity()
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		INSERT 	INTO SYS_ROLUSUARIO
			(
			rolId,
			usuarioId,
			fcrea,
			fupdate
			)
		VALUES	(
			@rolId,
			@usuarioId,
			@fechaActual,
			@fechaActual
			)
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		INSERT 	INTO ADM_DOCID 
			(
			personaId,
			tdocidId,
			docid,
			fcrea,
			fupdate
			)
		VALUES	(
			@personaId,
			@tdocidId,
			@docid,
			@fechaActual,
			@fechaActual
			)
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		if (not(@telefono is null))
		begin
			DELETE 	FROM ADM_TELEFONOxPERSONA
			WHERE 	(personaId = @personaId);
		
			INSERT 	INTO ADM_TELEFONOxPERSONA (
				personaId,
				ttelefonoId, --telefono de su casa
				telefono,
				fcrea,
				fupdate
				)
			VALUES	(
				@personaId,
				1,
				@telefono,
				@fechaActual,
				@fechaActual
				)
		end
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		
		IF (@rolId = 1) --AJUSTADOR
			INSERT INTO ADM_AJUSTADOR
				(personaId)
			VALUES
				(@personaId)
--		IF (@rolId = 3) --Cia Aseguradora
--		begin
--			INSERT INTO ADM_CLIENTE(
--				aseguradoraId,
--				visibilidadInforme,
--				notificarInformesNuevos,
--				visibilidadBitacoras,
--				visibilidadReserva,
--				visibilidadPerdida,
	--			permitirmensajeria
--			)
--			VALUES (
--				@personaId,
--				''s'',
--				''s'',
--				''s'',
--				''s'',
--				''s'',
--				''s''			
--			)

--			-----------------------------------
--			SET @Error=@@ERROR
--			IF (@Error<>0) GOTO TratarError
--			-----------------------------------

--			INSERT INTO RGN_POLIZA (
--				numeroPoliza,
--				aseguradoraId,
--				sistema
--			)
--			VALUES (
--				''Especificar Póliza'',
--				@personaId,
--				''S''
--			)
--			-----------------------------------
			SET @Error=@@ERROR
			IF (@Error<>0) GOTO TratarError
			-----------------------------------

--		end
	
	COMMIT TRAN
	
	TratarError:
	If (@@Error<>0)
		BEGIN
		PRINT ''No se pudo realizar el registro''
		--Se lo comunicamos al usuario y deshacemos la transacción
		--todo volverá a estar como si nada hubiera ocurrido
		ROLLBACK TRAN
		END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameCompaniaNombre]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameCompaniaNombre]
(
	@personaId numeric
)
AS
	SET NOCOUNT ON;
SELECT     persona
FROM         ADM_PERSONA
WHERE     (personaId = @personaId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameCompaniaUsuario]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameCompaniaUsuario]
(
	@personaId numeric
)
AS
	SET NOCOUNT ON;
SELECT     companiaId
FROM      SYS_USUARIO,ADM_PERSONA
WHERE     (SYS_USUARIO.usuarioId = ADM_PERSONA.usuarioId)AND
	  (ADM_PERSONA.personaId=@personaId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjustadorCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_AjustadorCombo]

AS
	SET NOCOUNT OFF;
	
	SELECT     
		ADM_PERSONA.persona,
		ADM_PERSONA.personaid
		
	FROM	ADM_ajustador
				LEFT JOIN ADM_PERSONA ON ADM_PERSONA.personaId = ADM_ajustador.personaId
				
	WHERE ADM_PERSONA.estado =''A'' 
	ORDER BY ADM_PERSONA.fcrea DESC' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_brokersAutoComplete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_brokersAutoComplete]
(
	@persona varchar(1000)
)
AS
	SET NOCOUNT ON;
SELECT     persona, personaId
FROM         ADM_PERSONA
WHERE     (persona LIKE ''%'' + @persona + ''%'') AND (personaid in (select personaid from ADM_BROKER))
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_UsuarioUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_Rgn_UsuarioUpdate]
(
	@usuarioId 	int,
	@personaId 	int,
	@nombre1 	varchar(250),
	@apellido1 	varchar(250),
	@apellido2 	varchar(250),
	@telefono	varchar(20),
	@docId		varchar(100),
	@tdocidId	int,
	@rolId		int,
	@usuario	varchar(20),
	@clave		varchar(20),
	@estado		varchar(1),
	@creadorId		int,
	@companiaId	numeric(5,0),
	@nombreCompania varchar(1000)
)
AS

	DECLARE @Error int
	DECLARE @nombre  		varchar(200);
	DECLARE @fechaActual 	datetime;	
	declare @tpersonaId int;

	select @tpersonaId= tpersonaId 
	from ADM_TPERSONA WHERE tpersona in (select rol from SYS_ROL where rolId=@rolId)

	SET @fechaActual = GETDATE();
	SET @nombre = @nombre1;

		if 	not(@apellido1 is null) 
		begin
			SET @nombre = @nombre+'' ''+@apellido1;
		end
	
		if 	not(@apellido2 is null) 
		begin
			SET @nombre = @nombre+'' ''+@apellido2;
		end

	BEGIN TRAN
		SET NOCOUNT OFF;
		
		-----------------------------------
		UPDATE 	ADM_PERSONA 
		SET persona		= @nombre,	
			nombre1 	= @nombre1, 
			apellido1 	= @apellido1, 
			apellido2 	= @apellido2, 
			tpersonaId	= @tpersonaId,
			fupdate		= @fechaActual,
			uupdate		= @usuario,
			estado 		= @estado,
			creadorId	= @creadorId 
		WHERE 	(personaId = @personaId);
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		UPDATE 	SYS_USUARIO
		SET 	usuario 	= @usuario, 
			clave 		= @clave, 
			fupdate		= @fechaActual,
			estado 		= @estado,
			companiaId      = @companiaId 
		WHERE 	(usuarioId = @usuarioId);
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		DELETE 	FROM SYS_ROLUSUARIO
		WHERE	(usuarioId = @usuarioId);
	
		INSERT 	INTO SYS_ROLUSUARIO
			(rolId,
			usuarioId)
		VALUES	(@rolId,
			@usuarioId)
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		DELETE 	FROM ADM_DOCID
		WHERE	(personaId = @personaId);
	
		INSERT 	INTO ADM_DOCID (
			personaId,
			tdocidId,
			docid
			)
		VALUES	(
			@personaId,
			@tdocidId,
			@docid
			)
		-----------------------------------
		SET @Error=@@ERROR
		IF (@Error<>0) GOTO TratarError
		-----------------------------------
		DELETE 	FROM ADM_TELEFONOxPERSONA
		WHERE 	(personaId = @personaId);
	
		INSERT 	INTO ADM_TELEFONOxPERSONA (
			personaId,
			ttelefonoId, --telefono de su casa
			telefono
			)
		VALUES	(
			@personaId,
			1,
			@telefono
			)
		-----------------------------------
	
	COMMIT TRAN
	
	TratarError:
	If (@@Error<>0)
		BEGIN
		PRINT ''No se pudo realizar el registro''
		--Se lo comunicamos al usuario y deshacemos la transacción
		--todo volverá a estar como si nada hubiera ocurrido
		ROLLBACK TRAN
		END
	



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_creaPersonaBroker]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_creaPersonaBroker](@persona varchar (1000))
as
begin

insert into adm_persona(persona,personaid) 
values (@persona,1)

declare @last numeric(8,0)
set @last = scope_identity();

insert into 
	adm_broker(personaid) 
values 
	(@last)



end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_UsuarioEditor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_Rgn_UsuarioEditor] 
(
	@usuarioId int
)
AS
	SET NOCOUNT ON;
	
	SELECT 	TOP 1 
		SYS_USUARIO.usuarioId,
		ADM_PERSONA.personaId,
		ADM_PERSONA.nombre1,
		ADM_PERSONA.apellido1, 
		ADM_PERSONA.apellido2, 
		ADM_TELEFONOXPERSONA.telefono,
		isNull(ADM_DOCID.docId,'''') as docId,
		isNull(ADM_DOCID.tdocidId,1) as tdocidId,
		SYS_ROL.rolId,
  		SYS_USUARIO.usuario, 
		SYS_USUARIO.clave, 
		SYS_USUARIO.estado,
		SYS_USUARIO.companiaId,
		(select persona FROM ADM_PERSONA where personaId=SYS_USUARIO.companiaId)AS nombreCompania

	FROM	SYS_USUARIO     
		INNER JOIN ADM_PERSONA ON ADM_PERSONA.usuarioId = SYS_USUARIO.usuarioId
		LEFT OUTER JOIN SYS_ROLUSUARIO ON SYS_ROLUSUARIO.usuarioId = SYS_USUARIO.usuarioId
		LEFT OUTER JOIN SYS_ROL ON SYS_ROL.rolId = SYS_ROLUSUARIO.rolId
		LEFT OUTER JOIN ADM_TELEFONOxPERSONA ON ADM_TELEFONOxPERSONA.personaId = ADM_PERSONA.personaId
		LEFT OUTER JOIN ADM_DOCID ON ADM_DOCID.personaId = ADM_PERSONA.personaId
	WHERE	(SYS_USUARIO.usuarioId = @usuarioId) --AND
	--	( (ADM_TELEFONOPERSONA.telefonoId = 1) OR (ADM_TELEFONOPERSONA.telefonoId is NULL) ) --AND--Solo el primer telefono
	--	( (ADM_TELEFONOPERSONA.ttelefonoId = 1) OR (ADM_TELEFONOPERSONA.ttelefonoId is null) ) --telefono de casa

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoraInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoraInsert]
(
	@persona varchar(1000)=NULL,
	@ucrea varchar(20) = NULL,
	@TFIJO varchar(20)=NULL,
	@TFAX varchar(20)=NULL,
	@direccion varchar(500),
	@ubigeoId varchar(20),
	@tdocidId numeric(5,0),
	@docid varchar(20),
	@personaId numeric(5,0) output,
	@chkPersonaJuridica bit =NULL
)

AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @personaJuridica varchar(1)
	if @chkPersonaJuridica=1 
	begin
		set @personaJuridica=''S''
	end
	else set @personaJuridica=''N''

		
	INSERT
	INTO ADM_PERSONA
	(
		persona,
		ucrea,
		tpersonaid,
		uupdate,
		fcrea,
		estado,
		fupdate,
		personajuridica
		
	)
	VALUES
	(
		
		@persona,
		@ucrea,
		2,
		@ucrea,
		getDate(),
		''A'',
		getDate(),
		@personajuridica
	)

	

	set @personaId = SCOPE_IDENTITY()

	INSERT INTO ADM_CLIENTE
	(
		aseguradoraId
	)
	VALUES
	(
		@personaId
	)

	if 	not(@TFIJO is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFIJO,
			getDate(),
			getDate(),
			1
		
		)
		end


	if 	not(@TFAX is null) 
		begin
			INSERT INTO ADM_TELEFONOXPERSONA
		(
			
			personaId,
			telefono,
			fcrea,
			fupdate,
			ttelefonoId		
		)
			VALUES
		(
			@personaId,
			@TFAX,
			getDate(),
			getDate(),
			3			
			)

		end

	if 	not(@direccion is null) 
		begin
			INSERT INTO ADM_DIRECCIONPERSONA
		(
				personaId,
				direccion,
				fcrea,
				fupdate,
		--		tdireccionid,
				ubigeoId
			)
			VALUES
			(
				@personaId,
				@direccion,
				getDate(),
				getDate(),
		--		1,
				@ubigeoId
			);
		end
	
	if 	not(@docid is null) 
		begin
			INSERT INTO ADM_DOCID
			(
				personaId,
				docid,
				fcrea,
				fupdate,
				tdocidid,
				principal,
				estado
			)
			VALUES
			(
				@personaId,
				@docid,
				getDate(),
				getDate(),
				@tdocidId,
				''S'',
				''A''
			);

		end

	insert into dbo.RGN_POLIZA (
		numeroPoliza,
		sistema,
		aseguradoraId,
		ucrea,
		fcrea)
	values (''Especificar Póliza'',
		''S'',
		@personaId,
		@ucrea,
		getDate())

     Insert Into RGN_CONFIGURACIONXASEGURADORA 
      (
		aseguradoraid,
		diasIB,
		diasIP,
		diasIC,
        diasIFR
       ) 
      values
      (
		@personaId,
        10,
        10,
        10,
		10
	  )
	
END
 

 ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_usuarioByPersonaId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_usuarioByPersonaId](
@personaId numeric(8,0)
)
as

SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.SYS_USUARIO.usuario, dbo.SYS_USUARIO.clave AS contrasena
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.SYS_USUARIO ON dbo.ADM_PERSONA.usuarioId = dbo.SYS_USUARIO.usuarioId
WHERE     (dbo.ADM_PERSONA.personaId = @personaId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_asocia_usuario_a_persona]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_asocia_usuario_a_persona]
(
	@personaId numeric (8,0)=NULL,			
	@usuario varchar(250)=NULL,
	@contrasena varchar (250)=NULL,
	@rolId numeric(8,0)
	
)
AS

declare @usuarioId numeric (8,0)

declare @contador numeric(8,0)

select @contador = count(*) from (
	SELECT    dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.SYS_USUARIO.usuario, dbo.SYS_USUARIO.clave AS contrasena
	FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                     dbo.SYS_USUARIO ON dbo.ADM_PERSONA.usuarioId = dbo.SYS_USUARIO.usuarioId 
	Where  dbo.SYS_USUARIO.usuario = @usuario and dbo.ADM_PERSONA.personaId <> @personaId
	) as A
declare @userId numeric(8,0)
select @userId = usuarioId from ADM_PERSONA where personaId = @personaId


if (@contador = 0) 
begin
	if (@userId is null)
	begin
	INSERT INTO SYS_USUARIO
	(
		usuario,
		clave,
		
		fcrea,
		fupdate,
		estado	
	)
	VALUES 	
	(
		@usuario, 
		@contrasena, 
		getdate(),
		getdate(),
		''A'' 
	)	

	SET @usuarioId = scope_identity()
	
	insert into SYS_ROLUSUARIO (rolId,usuarioId,fcrea,fupdate,estado)
	values (@rolId,@usuarioId,getDate(),getDate(),''A'')
 

	UPDATE ADM_PERSONA set usuarioId=@usuarioId
	WHERE personaId=@personaId
	
	end
	else	
	begin
		update SYS_USUARIO
		set usuario = @usuario,
		    clave = @contrasena,
		    fupdate = getDate()
		where usuarioId = @userId
	end
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_rgen_Ajuste_Total_Rapido_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--sp_helptext sp_rgen_Ajuste_Total_Select

CREATE PROCEDURE [dbo].[proc_rgen_Ajuste_Total_Rapido_Select]
(@ajusteid numeric(8,0))

AS
BEGIN

	declare @quienNotifico varchar(250)
	declare @NombreDelNotificante varchar(250)
 	declare @faviso datetime
	declare @medioDeNotificacionId numeric(8,0) 

	declare @NombreQuienConfirma varchar(250) 
	declare @FechayHoraConfirmacion datetime 
	declare @medioConfirmacionId numeric(8,0)
	declare @cargoconfirmante varchar(250) 

	declare @aseguradoraid numeric(8,0)
	declare @nombreresponsable varchar(250)
	declare @telefonoresponsable varchar(20)
	declare @emailresponsable varchar(250)

	declare @brokerId numeric(8,0)
	declare @nombreresponsableBroker varchar(250)
	declare @telefonoresponsableBroker varchar(20)
	declare @emailresponsableBroker varchar(250)
	declare @numeroSiniestroCia varchar(100)
	declare @numeroSiniestroBroker varchar(100)

	declare @fsiniestro datetime
	declare @lugarsiniestro varchar(250)
	declare @ubigeoid varchar(6)	
	declare @tiposiniestro_id numeric(8,0)
	declare @nombreresponsableSiniestro varchar(250)
	declare @telefonoresponsableSiniestro varchar(20)
	declare @emailresponsableSiniestro varchar(250)
	declare @descripcion varchar(250)

	declare @usuario varchar(100)
	declare @polizaid numeric(8,0)

	declare @ajustadorid numeric(8,0)
	declare @FechaHoraCoordinacion datetime 
	declare @FechaHoraProgramacion datetime 
	declare @FechaHoraReunion datetime
	declare @ubigeoidInspeccion varchar(6)
    declare @personacontacto varchar(250)
	declare @tajusteid numeric(8,0)
	declare @lugarDeReunion varchar(250) 
	declare @referencia varchar(250)
	declare @telefonoPersonaContacto varchar(20)

	declare @contratante varchar(250)
	declare @asegurado varchar(250)
	declare @aseguradoid numeric(8,0)

	declare @numeropoliza varchar(100)
	declare @ramoid numeric(8,0)
	declare @productoid numeric(8,0)
	declare @riesgoid numeric(8,0)
	declare @ramoafectado varchar(50)

--Insertando datos del AJUSTE

select
	@quienNotifico= quienNotifico,
	@nombredelNotificante= NombreDelNotificante,
	@faviso= faviso,
	@mediodeNotificacionid= isnull(medioDeNotificacionId,-1), 
	@NombrequienConfirma= NombreQuienConfirma, 
	@FechayHoraConfirmacion= FechayHoraConfirmacion, 
	@medioConfirmacionID = isnull(medioConfirmacion,-1),
	@cargoconfirmante= cargoconfirmante, 
	@brokerid= isnull(brokerId,-1),
	@NumeroSiniestroCia= NumeroSiniestroCia,
	@NumeroSiniestroBroker=NumeroSiniestroBroker,
	@tajusteid= tajusteid,
	@ajustadorid=isnull(ajustadorid,-1),	
	@FechaHoraProgramacion = fechaHoraProgramacion

from RGN_AJUSTE
where ajusteid=@ajusteid        

--Insertando contacto de la ASEGURADORA
select @nombreResponsable=nombreContacto, 
       @telefonoResponsable=telefonoContacto, 
       @emailResponsable=emailcontacto
from RGN_CONTACTOS_AJUSTE
where  ajusteid=@ajusteid and TipoContactoid=''1''

--Insertando contacto del BROKER
select @nombreResponsableBroker=nombreContacto, 
       @telefonoResponsableBroker=telefonoContacto, 
       @emailResponsableBroker=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''2''

--Insertando contactos del SINIESTRO
select @nombreResponsableSiniestro=nombreContacto, 
       @telefonoResponsableSiniestro=telefonoContacto, 
       @emailResponsableSiniestro=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''5''

--Insertando datos del SINIESTRO
select     @descripcion=descripcion, 
	   @fsiniestro=fsiniestro, 
	   @tiposiniestro_id=tiposiniestroid, 
	   @lugarsiniestro=lugarsiniestro,
	   @ubigeoid=ubigeoid 
from RGN_SINIESTRO 
where siniestroid=(select siniestroid from RGN_AJUSTE where ajusteid=@ajusteid)

select   @ajusteid=ajusteid,
	 @polizaid=polizaid,
	 @aseguradoraid=aseguradoraid	
from RGN_POLIZA_AJUSTE
where ajusteid=@ajusteid  

--insertando datos de la inspeccion
select  top 1 @FechaHoraCoordinacion=FechaHoraCoordinacion, 
	@lugardeReunion=lugarDeReunion,
	@referencia=referencia,
	@personacontacto=personacontacto,
	@FechaHoraReunion=FechaHoraReunion, 
	@ubigeoIDinspeccion=ubigeoid,
	@telefonoPersonaContacto=telefonoPersonaContacto        
from RGN_ACTIVIDAD
where ajusteid = @ajusteid and tipoActividadId = 5


--sacando datos de la poliza

select @contratante=contratante, 
		@aseguradoid=aseguradoid, 
		@numeropoliza=numeroPoliza, 
		@ramoid=ramoid,
		@productoid=productoid,
		@riesgoid=riesgoid
from RGN_POLIZA
where polizaid=@polizaid

select  @asegurado=persona from ADM_Persona where personaid=@aseguradoid

--datos del ramo afectado

select @ramoafectado=nombre from RGN_RAMO where ramoid=@ramoid

--mostrando el resultado

Select  @ajusteid as ajusteId, 
	isNull(@quienNotifico,''Cia Seguros'') as quiennotifico, 
	@NombreDelNotificante as NombreDelNotificante, 
     	@faviso as faviso, 
        isNull(@medioDeNotificacionId,-1) as ''medionotificacionId'',


	@NombreQuienConfirma as nombrequienconfirma, 
	@FechayHoraConfirmacion as fechayhoraconfirmacion, 
	isNull(@medioConfirmacionId,-1) as ''medioconfirmacionid'', 
	@cargoconfirmante as cargoconfirmante,

	isNull(@aseguradoraid,-1) as aseguradoraid, 
	@nombreresponsable as nombreresponsable, 
	@telefonoresponsable as telefonoresponsable, 
	@emailresponsable as emailresponsable, 

	IsNull(@brokerId,5) as brokerid, 
	@nombreresponsableBroker as nombreresponsablebroker, 
	@telefonoresponsableBroker as telefonoresponsablebroker, 
	@emailresponsableBroker as emailresponsablebroker, 
	@numeroSiniestroCia as ''numerosiniestroCia'', 
	@numeroSiniestroBroker as ''numerosiniestrobroker'',

	@fsiniestro as fsiniestro, 
	@lugarsiniestro as ''lugarsiniestro'', 
	@ubigeoid as ubigeo, 
	dbo.dameDistrito(@ubigeoid) as distrito,
	isNull(@tiposiniestro_id,1) as tiposiniestroId, 
	@nombreresponsableSiniestro as nombreresponsablesiniestro, 
	@telefonoresponsableSiniestro as telefonoresponsablesiniestro, 
	@emailresponsableSiniestro as emailresponsablesiniestro, 
	@descripcion as descripcion, 

   @polizaid as polizaid, 

   isNull(@ajustadorid,-1) as ajustadorid, 

   @FechaHoraCoordinacion as fechahoracoordinacion,
	 @FechaHoraProgramacion as Fechahoraprogramacion,
   @FechaHoraReunion as fechahorareunion,
   isNull(@ubigeoidInspeccion,'''') as ubigeoIDinspeccion,
   dbo.dameDistrito(@ubigeoidInspeccion) as distritoInspeccion,
   @personacontacto as personacontacto,
   isNull(@tajusteid ,1) as tajusteid, 
   @lugarDeReunion as lugareunion,  
   @referencia as referencia, 
   @telefonoPersonaContacto as telefonopersonacontacto,

   @contratante as contratante,
   @asegurado as asegurado,

   @numeropoliza as numeroPoliza,
   @ramoafectado as RamoAfectado,
   @ramoid as RamoId,
   @productoid as ProductoId,
   @riesgoId as RiesgoId

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_nueva_persona]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgn_nueva_persona] (
	@person varchar(1000),
	@tpid numeric(8,0),
	@perjur varchar(1)
)
AS
begin
	insert into ADM_PERSONA(persona,tpersonaid,personajuridica) values(@person,@tpid,@perjur)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SelectPersonaByTipoAndName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SelectPersonaByTipoAndName]
(
	@persona varchar(1000),
	@tpersonaId numeric (8,0),
	@estado varchar(1)
)
AS
	SET NOCOUNT ON;
SELECT     ADM_PERSONA.personaId, ADM_PERSONA.persona
FROM       ADM_PERSONA 
WHERE     (ADM_PERSONA.persona LIKE @persona + ''%'')
		AND (tpersonaId=@tpersonaId)
		AND (estado=@estado)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_asegurados_by_name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_asegurados_by_name]
(
	@nombre varchar(500)
)

AS
	SET NOCOUNT OFF;
	
	SELECT     
		ADM_PERSONA.persona,
		ADM_PERSONA.personaid
		
	FROM	ADM_ASEGURADO
				LEFT JOIN ADM_PERSONA ON ADM_PERSONA.personaId = ADM_ASEGURADO.personaId
				
	WHERE ADM_PERSONA.estado =''A'' AND (ADM_PERSONA.persona LIKE ''%''+@nombre+''%'')
	ORDER BY ADM_PERSONA.fcrea DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registroPoliza_Juridica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[sp_rgen_registroPoliza_Juridica](
  @aseguradoraid numeric(8,0),
  @numeroPoliza varchar(100),
  @RazonSocial varchar(200),
  @telefonoOficina varchar(20),
  @telefonomovil varchar(20),
  @contratante varchar(250),
  @GirodeNegocio varchar(250),
  @GrupoEconomico varchar(250),
  @RUC varchar(20),
  @Direccion varchar(100),
  @ubigeoid varchar(6),
  @referencia varchar(20),
  @FechaInicio datetime, 
  @FechaFin datetime,
  @Productoid numeric(8,0),
  @ramoid numeric(8,0),
  @cobertura numeric(8,0),
  @usuario varchar(100),
  @ajusteId numeric(8,0),
  @archivo varchar(100)

)
as

declare @aseguradoid numeric(8,0)

BEGIN  

    --INSERTANDO DATOS PERSONALES
    insert into ADM_PERSONA(persona,nombre1 ,estado, fcrea, tpersonaid, personajuridica)
     values(
     @RazonSocial,
	 @RazonSocial,
      ''A'',
      getdate(),
      ''3'',
      ''S''
    ) 

   select @aseguradoid=scope_identity()
   
   --INSERTANDO TELEFONOS
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonoOficina,''1'',getdate(),''A'',@usuario)    
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonomovil,''2'',getdate(),''A'',@usuario) 

   --INSERTANDO DIRECCION
   insert into ADM_DIRECCIONPERSONA(personaid, ubigeoid, direccion, referencia, fcrea,estado, ucrea) 
                             values(@aseguradoid,@ubigeoid,@direccion, @referencia,getdate(),''A'',@usuario) 

 
   --INSERTANDO DOCUMENTOS
   insert into ADM_DOCID(personaid, tdocidId, docid, fcrea, estado, ucrea)
          values(@aseguradoid,''6'',@RUC,getdate(),''A'',@usuario)
   
   --INSERTANDO OTROS CAMPOS 
   insert into ADM_ASEGURADO (personaid) values (@aseguradoid)

   --INSERTANDO DATOS DE LA POLIZA
   insert into RGN_POLIZA(aseguradoraid,
	   contratante, 
	   aseguradoid, 
           productoid, 
	   ramoid, 
	   riesgoid,
	   finicio,
           ffin, 
	   numeroPoliza,
           archivo,
           fcrea,
           estado,
           ucrea,
	   giroNegocio,
	   grupoEconomico
	   )
   values (@aseguradoraid, 
	   @contratante, 
           @aseguradoid, 
           @productoid, 
           @ramoid, 
           @cobertura, 
           @FechaInicio, 
           @Fechafin, 
           @numeroPoliza,
	   isnull(@archivo,''''),
           getdate(), 
           ''A'',
           isnull(@usuario,''usuario''),
	   @girodeNegocio,
	   @GrupoEconomico) 	
 
    --INSERTANDO EN TABLA POLIZA_AJUSTE

    DECLARE @polizaId numeric(8,0);
    SET @polizaId= scope_Identity();

    if (@ajusteId != -1) 
    begin
	    insert into RGN_POLIZA_AJUSTE
	    (
		aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate
	
	    )
	    
	    values (
	    	@aseguradoraid,
	 	@polizaId,
	        @ajusteId,
	        ''A'',
		getdate(),
		getdate(),
		isnull(@usuario,''usuario''),
		isnull(@usuario,''usuario'')
	    )
    end

END 









' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registroPoliza_Natural]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_registroPoliza_Natural](
  @aseguradoraid numeric(8,0),
  @numeroPoliza varchar(100),
  @PrimerNombre varchar(100),
  @SegundoNombre varchar(100),
  @ApellidoPaterno varchar(100),
  @ApellidoMaterno varchar(100),
  @telefonocasa varchar(20),
  @telefonomovil varchar(20),
  @contratante varchar(250),
  @GirodeNegocio varchar(250),
  @GrupoEconomico varchar(250),
  @DNI varchar(20),
  @Direccion varchar(100),
  @ubigeoid varchar(6),
  @referencia varchar(20),
  @FechaInicio datetime, 
  @FechaFin datetime,
  @Productoid numeric(8,0),
  @ramoid numeric(8,0),
  @cobertura numeric(8,0),
  @usuario varchar(100),
  @ajusteId numeric (8,0),
  @archivo varchar(100)
)
as

declare @aseguradoid numeric(8,0)

BEGIN  

    --INSERTANDO DATOS PERSONALES
    insert into ADM_PERSONA(persona, nombre1,nombre2, apellido1, apellido2, estado, fcrea, tpersonaid, personajuridica)
     values(
      dbo.quitaespacios(isnull(@Primernombre + '' '','''')+isNull(@SegundoNombre + '' '','''')+isNull(@ApellidoPaterno + '' '','''')+isNull(@ApellidoMaterno,'''')),
      @PrimerNombre,
      @SegundoNombre, 
      @ApellidoPaterno,
      @ApellidoMaterno,
      ''A'',
      getdate(),
      ''3'',
      ''N''
    ) 
   select @aseguradoid=scope_identity()
   
   --INSERTANDO TELEFONOS
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonocasa,''1'',getdate(),''A'',@usuario)    
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonomovil,''2'',getdate(),''A'',@usuario) 

   --INSERTANDO DIRECCION
   insert into ADM_DIRECCIONPERSONA(personaid, ubigeoid, direccion, referencia, fcrea,estado, ucrea) 
                             values(@aseguradoid,@ubigeoid,@direccion, @referencia,getdate(),''A'',@usuario) 

 
   --INSERTANDO DOCUMENTOS
   insert into ADM_DOCID(personaid, tdocidId, docid, fcrea, estado, ucrea)
          values(@aseguradoid,''1'',@DNI,getdate(),''A'',@usuario)
   
   --INSERTANDO OTROS CAMPOS 
   insert into ADM_ASEGURADO (personaid) values (@aseguradoid)

   --INSERTANDO DATOS DE LA POLIZA
   insert into RGN_POLIZA(aseguradoraid,contratante, aseguradoid, productoid, ramoid, riesgoid,finicio,ffin, numeroPoliza,archivo,fcrea,estado,ucrea,giroNegocio,grupoEconomico)
   values (@aseguradoraid, 
	   @contratante, 
           @aseguradoid, 
           @productoid, 
           @ramoid, 
           @cobertura, 
           @FechaInicio, 
           @Fechafin, 
           @numeroPoliza, 
	   isnull(@archivo,''''),
           getdate(), 
           ''A'',
           isnull(@usuario,''usuario''),
	   @girodeNegocio,
	   @GrupoEconomico)

--INSERTANDO EN TABLA POLIZA_AJUSTE

    DECLARE @polizaId numeric(8,0);
    SET @polizaId= scope_Identity();

    if (@ajusteId != -1)  
    begin
	    insert into RGN_POLIZA_AJUSTE
	    (
		aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate
	
	    )
	    
	    values (
	    	@aseguradoraid,
	 	@polizaId,
	        @ajusteId,
	        ''A'',
		getdate(),
		getdate(),
		isnull(@usuario,''usuario''),
		isnull(@usuario,''usuario'')
	    )
    end
 
END ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Total_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--sp_helptext sp_rgen_Ajuste_Total_Select

CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Total_Select]
(@ajusteid numeric(8,0))

AS
BEGIN

	declare @quienNotifico varchar(250)
	declare @NombreDelNotificante varchar(250)
 	declare @faviso datetime
	declare @medioDeNotificacionId numeric(8,0) 

	declare @NombreQuienConfirma varchar(250) 
	declare @FechayHoraConfirmacion datetime 
	declare @medioConfirmacionId numeric(8,0)
	declare @cargoconfirmante varchar(250) 

	declare @aseguradoraid numeric(8,0)
	declare @nombreresponsable varchar(250)
	declare @telefonoresponsable varchar(20)
	declare @emailresponsable varchar(250)

	declare @brokerId numeric(8,0)
	declare @nombreresponsableBroker varchar(250)
	declare @telefonoresponsableBroker varchar(20)
	declare @emailresponsableBroker varchar(250)
	declare @numeroSiniestroCia varchar(100)
	declare @numeroSiniestroBroker varchar(100)

	declare @fsiniestro datetime
	declare @lugarsiniestro varchar(250)
	declare @ubigeoid varchar(6)	
	declare @tiposiniestro_id numeric(8,0)
	declare @nombreresponsableSiniestro varchar(250)
	declare @telefonoresponsableSiniestro varchar(20)
	declare @emailresponsableSiniestro varchar(250)
	declare @descripcion varchar(250)

	declare @usuario varchar(100)
	declare @polizaid numeric(8,0)

	declare @ajustadorid numeric(8,0)
	declare @ejecutivosiniestrosid numeric(8,0)
	declare @FechaHoraCoordinacion datetime 
	declare @FechaHoraProgramacion datetime 
	declare @FechaHoraReunion datetime
	declare @ubigeoidInspeccion varchar(6)
    	declare @personacontacto varchar(250)
	declare @tajusteid numeric(8,0)
	declare @lugarDeReunion varchar(250) 
	declare @referencia varchar(250)
	declare @telefonoPersonaContacto varchar(20)

	declare @contratante varchar(250)
	declare @asegurado varchar(250)
	declare @aseguradoid numeric(8,0)

	declare @numeropoliza varchar(100)
	declare @ramoid numeric(8,0)
	declare @ramoafectado varchar(50)

--Insertando datos del AJUSTE

select
	@quienNotifico= quienNotifico,
	@nombredelNotificante= NombreDelNotificante,
	@faviso= faviso,
	@mediodeNotificacionid= isnull(medioDeNotificacionId,-1), 
	@NombrequienConfirma= NombreQuienConfirma, 
	@FechayHoraConfirmacion= FechayHoraConfirmacion, 
	@medioConfirmacionID = isnull(medioConfirmacion,-1),
	@cargoconfirmante= cargoconfirmante, 
	@brokerid= isnull(brokerId,-1),
	@NumeroSiniestroCia= NumeroSiniestroCia,
	@NumeroSiniestroBroker=NumeroSiniestroBroker,
	@tajusteid= tajusteid,
	@ajustadorid=isnull(ajustadorid,-1),	
	@ejecutivosiniestrosId=isnull(ejecutivoSiniestrosid,-1),	
	@FechaHoraProgramacion = fechaHoraProgramacion

from RGN_AJUSTE
where ajusteid=@ajusteid        

--Insertando contacto de la ASEGURADORA
select @nombreResponsable=nombreContacto, 
       @telefonoResponsable=telefonoContacto, 
       @emailResponsable=emailcontacto
from RGN_CONTACTOS_AJUSTE
where  ajusteid=@ajusteid and TipoContactoid=''1''

--Insertando contacto del BROKER
select @nombreResponsableBroker=nombreContacto, 
       @telefonoResponsableBroker=telefonoContacto, 
       @emailResponsableBroker=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''2''

--Insertando contactos del SINIESTRO
select @nombreResponsableSiniestro=nombreContacto, 
       @telefonoResponsableSiniestro=telefonoContacto, 
       @emailResponsableSiniestro=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''5''

--Insertando datos del SINIESTRO
select     @descripcion=descripcion, 
	   @fsiniestro=fsiniestro, 
	   @tiposiniestro_id=tiposiniestroid, 
	   @lugarsiniestro=lugarsiniestro,
	   @ubigeoid=ubigeoid 
from RGN_SINIESTRO 
where siniestroid=(select siniestroid from RGN_AJUSTE where ajusteid=@ajusteid)

select   @ajusteid=ajusteid,
	 @polizaid=polizaid,
	 @aseguradoraid=aseguradoraid	
from RGN_POLIZA_AJUSTE
where ajusteid=@ajusteid  

--insertando datos de la inspeccion
select  top 1 @FechaHoraCoordinacion=FechaHoraCoordinacion, 
	@lugardeReunion=lugarDeReunion,
	@referencia=referencia,
	@personacontacto=personacontacto,
	@FechaHoraReunion=FechaHoraReunion, 
	@ubigeoIDinspeccion=ubigeoid,
	@telefonoPersonaContacto=telefonoPersonaContacto        
from RGN_ACTIVIDAD
where ajusteid = @ajusteid and tipoActividadId = 5


--sacando datos de la poliza

select @contratante=contratante, @aseguradoid=aseguradoid, @numeropoliza=numeroPoliza, @ramoid=ramoid
from RGN_POLIZA
where polizaid=@polizaid

select  @asegurado=persona from ADM_Persona where personaid=@aseguradoid

--datos del ramo afectado

select @ramoafectado=nombre from RGN_RAMO where ramoid=@ramoid

--mostrando el resultado

Select  @ajusteid as ajusteId, 
	isNull(@quienNotifico,''Cia Seguros'') as quiennotifico, 
	@NombreDelNotificante as NombreDelNotificante, 
     	@faviso as faviso, 
        isNull(@medioDeNotificacionId,-1) as ''medionotificacionId'',


	@NombreQuienConfirma as nombrequienconfirma, 
	@FechayHoraConfirmacion as fechayhoraconfirmacion, 
	isNull(@medioConfirmacionId,-1) as ''medioconfirmacionid'', 
	@cargoconfirmante as cargoconfirmante,

	isNull(@aseguradoraid,-1) as aseguradoraid, 
	@nombreresponsable as nombreresponsable, 
	@telefonoresponsable as telefonoresponsable, 
	@emailresponsable as emailresponsable, 

	IsNull(@brokerId,5) as brokerid, 
	@nombreresponsableBroker as nombreresponsablebroker, 
	@telefonoresponsableBroker as telefonoresponsablebroker, 
	@emailresponsableBroker as emailresponsablebroker, 
	@numeroSiniestroCia as ''numerosiniestroCia'', 
	@numeroSiniestroBroker as ''numerosiniestrobroker'',

	@fsiniestro as fsiniestro, 
	@lugarsiniestro as ''lugarsiniestro'', 
	@ubigeoid as ubigeo, 
	dbo.dameDistrito(@ubigeoid) as distrito,
	isNull(@tiposiniestro_id,1) as tiposiniestroId, 
	@nombreresponsableSiniestro as nombreresponsablesiniestro, 
	@telefonoresponsableSiniestro as telefonoresponsablesiniestro, 
	@emailresponsableSiniestro as emailresponsablesiniestro, 
	@descripcion as descripcion, 

   @polizaid as polizaid, 

   isNull(@ajustadorid,-1) as ajustadorid,
   isNull(@ejecutivoSiniestrosId,-1) as ejecutivoSiniestrosid, 

   @FechaHoraCoordinacion as fechahoracoordinacion,
	 @FechaHoraProgramacion as Fechahoraprogramacion,
   @FechaHoraReunion as fechahorareunion,
   isNull(@ubigeoidInspeccion,'''') as ubigeoIDinspeccion,
   dbo.dameDistrito(@ubigeoidInspeccion) as distritoInspeccion,
   @personacontacto as personacontacto,
   isNull(@tajusteid ,1) as tajusteid, 
   @lugarDeReunion as lugareunion,  
   @referencia as referencia, 
   @telefonoPersonaContacto as telefonopersonacontacto,

   @contratante as contratante,
   @asegurado as asegurado,

   @numeropoliza as numeroPoliza,
   @ramoafectado as RamoAfectado,
   @ramoid as RamoId

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Parcial_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Parcial_Select]
(@ajusteid numeric(8,0))

AS
BEGIN

	declare @quienNotifico varchar(250)
	declare @NombreDelNotificante varchar(250)
     	declare @faviso datetime
        declare @medioDeNotificacionId numeric(8,0) 


	declare @NombreQuienConfirma varchar(250) 
	declare @FechayHoraConfirmacion datetime 
	declare @medioConfirmacionId numeric(8,0)
	declare @cargoconfirmante varchar(250) 

	declare @aseguradoraid numeric(8,0)
	declare @nombreresponsable varchar(250)
	declare @telefonoresponsable varchar(20)
	declare @emailresponsable varchar(250)

	declare @brokerId numeric(8,0)
	declare @nombreresponsableBroker varchar(250)
	declare @telefonoresponsableBroker varchar(20)
	declare @emailresponsableBroker varchar(250)
	declare @numeroSiniestroCia varchar(100)
	declare @numeroSiniestroBroker varchar(100)

	declare @fsiniestro datetime
	declare @lugarsiniestro varchar(250)
	declare @ubigeoid varchar(6)	
	declare @tiposiniestro_id numeric(8,0)
	declare @nombreresponsableSiniestro varchar(250)
	declare @telefonoresponsableSiniestro varchar(20)
	declare @emailresponsableSiniestro varchar(250)
	declare @descripcion varchar(250)

	declare @usuario varchar(100)
        declare @polizaid numeric(8,0)

	declare @contratante varchar(250)
	declare @asegurado varchar(250)
	declare @aseguradoid numeric(8,0)

--Insertando datos del AJUSTE

select
	@quienNotifico= quienNotifico,
	@nombredelNotificante= NombreDelNotificante,
	@faviso= faviso,
        @mediodeNotificacionid= medioDeNotificacionId, 
        @NombrequienConfirma= NombreQuienConfirma, 
	@FechayHoraConfirmacion= FechayHoraConfirmacion, 
	@medioConfirmacionID = medioConfirmacion,
	@cargoconfirmante= cargoconfirmante, 
	@brokerid= brokerId,
	@numeroSiniestroCia= NumeroSiniestroCia,
	@numeroSiniestroBroker=numeroSiniestroBroker

from RGN_AJUSTE
where ajusteid=@ajusteid        

--Insertando contacto de la ASEGURADORA
select @nombreResponsable=nombreContacto, 
       @telefonoResponsable=telefonoContacto, 
       @emailResponsable=emailcontacto
from RGN_CONTACTOS_AJUSTE
where  ajusteid=@ajusteid and TipoContactoid=''1''

--Insertando contacto del BROKER
select @nombreResponsableBroker=nombreContacto, 
       @telefonoResponsableBroker=telefonoContacto, 
       @emailResponsableBroker=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''2''

--Insertando contactos del SINIESTRO
select @nombreResponsableSiniestro=nombreContacto, 
       @telefonoResponsableSiniestro=telefonoContacto, 
       @emailResponsableSiniestro=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''5''

--Insertando datos del SINIESTRO
select     @descripcion=descripcion, 
	   @fsiniestro=fsiniestro, 
	   @tiposiniestro_id=tiposiniestroid, 
	   @lugarsiniestro=lugarsiniestro,
	   @ubigeoid=ubigeoid 
from RGN_SINIESTRO 
where siniestroid=(select siniestroid from RGN_AJUSTE where ajusteid=@ajusteid)

select   @ajusteid=ajusteid,
	 @polizaid=polizaid,
	 @aseguradoraid=aseguradoraid,
	 @numerosiniestroCia=numSiniestro
from RGN_POLIZA_AJUSTE
where ajusteid=@ajusteid  

--sacando datos de la poliza

select @contratante=contratante, @aseguradoid=aseguradoid
from RGN_POLIZA
where polizaid=@polizaid

select  @asegurado=persona from ADM_Persona where personaid=@aseguradoid

--mostrando el resultado

Select  @quienNotifico as quiennotifico, 
	@NombreDelNotificante as NombreDelNotificante, 
     	@faviso as faviso, 
        @medioDeNotificacionId as medionotificacion,


	@NombreQuienConfirma as nombrequienconfirma, 
	@FechayHoraConfirmacion as fechayhoraconfirmacion, 
	@medioConfirmacionId as medioconfirmacion, 
	@cargoconfirmante as cargoconfirmante,

	@aseguradoraid as aseguradoraid, 
	@nombreresponsable as nombreresponsable, 
	@telefonoresponsable as telefonoresponsable, 
	@emailresponsable as emailresponsable, 

	@brokerId as brokerid, 
	@nombreresponsableBroker as nombreresponsablebroker, 
	@telefonoresponsableBroker as telefonoresponsablebroker, 
	@emailresponsableBroker as emailresponsablebroker, 
	@numeroSiniestroCia as numerosiniestro,
	@numeroSiniestroBroker as numeroSiniestroBroker, 

	@fsiniestro as fsiniestro, 
	@lugarsiniestro as lugardesiniestro, 
	@ubigeoid as ubigeosiniestro, 
	@tiposiniestro_id as tiposiniestro, 
	@nombreresponsableSiniestro as nombreresponsablesiniestro, 
	@telefonoresponsableSiniestro as telefonoresponsablesiniestro, 
	@emailresponsableSiniestro as emailresponsablesiniestro, 
	@descripcion as descripcion, 

        @polizaid as polizaid, 

       @contratante as contratante,
       @asegurado as asegurado

END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_datosRecepcionCasoRimac]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- exec sp_rgen_datosRecepcionCasoRimac 2533

CREATE PROCEDURE [dbo].[sp_rgen_datosRecepcionCasoRimac](@ajusteid numeric(8,0))
as
BEGIN


SELECT  
		dbo.RGN_AJUSTE.numeroSiniestroCia, 
	    dbo.RGN_AJUSTE.NombreQuienConfirma, 
		dbo.RGN_AJUSTE.cargoConfirmante,
		dbo.RGN_AJUSTE.FechayHoraConfirmacion, 
        dbo.ADM_PERSONA.persona AS ajustador
		
FROM    dbo.ADM_AJUSTADOR INNER JOIN
        dbo.RGN_AJUSTE ON dbo.ADM_AJUSTADOR.personaId = dbo.RGN_AJUSTE.ajustadorId INNER JOIN
        dbo.ADM_PERSONA ON dbo.ADM_AJUSTADOR.personaId = dbo.ADM_PERSONA.personaId

WHERE ajusteId = @ajusteId

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EjecutivoSiniestrosCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_EjecutivoSiniestrosCombo]

AS
	SET NOCOUNT OFF;
	
	SELECT     
		ADM_PERSONA.persona,
		ADM_PERSONA.personaid
		
	FROM	ADM_EjecutivoSiniestros
				LEFT JOIN ADM_PERSONA ON ADM_PERSONA.personaId = ADM_EjecutivoSiniestros.personaId
				
	WHERE ADM_PERSONA.estado =''A'' 
	ORDER BY ADM_PERSONA.fcrea DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informacionInspeccionRimac]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- exec sp_rgen_informacionInspeccionRimac 2533

CREATE PROCEDURE [dbo].[sp_rgen_informacionInspeccionRimac](@ajusteid numeric(8,0))
as

BEGIN
SELECT     dbo.RGN_ACTIVIDAD.ajusteId, 
		dbo.RGN_ACTIVIDAD.FechaHoraCoordinacion, 
		dbo.RGN_ACTIVIDAD.lugarDeReunion, 
		dbo.dameDistrito(dbo.RGN_ACTIVIDAD.ubigeoid) as ubigeoInspeccion,
        dbo.RGN_ACTIVIDAD.personaContacto, 
		dbo.RGN_ACTIVIDAD.FechaHoraReunion, 
        dbo.RGN_ACTIVIDAD.PersonaEntrevistada
FROM   dbo.RGN_ACTIVIDAD INNER JOIN
       dbo.RGN_AJUSTE ON dbo.RGN_ACTIVIDAD.ajusteId = dbo.RGN_AJUSTE.ajusteId AND 
	   dbo.RGN_ACTIVIDAD.ajusteId = dbo.RGN_AJUSTE.ajusteId

WHERE dbo.RGN_AJUSTE.ajusteId = @ajusteId

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ocurrencia_select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_Ocurrencia_select](@ajusteid numeric(8,0))
as
BEGIN 

SELECT  dbo.RGN_SINIESTRO.tiposiniestroid as tiposiniestroid,
	dbo.RGN_SINIESTRO.siniestroid as siniestroid,
	dbo.RGN_SINIESTRO.fsiniestro as fsiniestro,
	dbo.RGN_SINIESTRO.lugarSiniestro as lugarsiniestro,
	dbo.dameDistrito(dbo.ADM_UBIGEO.ubigeoid) as ubigeosiniestro,
	dbo.ADM_UBIGEO.ubigeoid as ubigeoid,
	dbo.RGN_AJUSTE.causasiniestro as causas,
	dbo.RGN_AJUSTE.detalleocurrencia as detalle,
	dbo.RGN_AJUSTE.investigaciones as investigaciones,
	dbo.RGN_AJUSTE.ajusteId as ajusteid
	
FROM     dbo.RGN_SINIESTRO LEFT OUTER JOIN
         dbo.RGN_AJUSTE ON dbo.RGN_SINIESTRO.siniestroid = dbo.RGN_AJUSTE.siniestroid LEFT OUTER JOIN
         dbo.ADM_UBIGEO ON dbo.RGN_SINIESTRO.ubigeoId = dbo.ADM_UBIGEO.ubigeoId
where dbo.RGN_AJUSTE.ajusteid=@ajusteid


END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadLista]

	@ajusteId numeric

AS
BEGIN

Select    
	actividadId, 
	ajusteId,
	lugarDeReunion,
	personaContacto,
	FechaHoraReunion,
	ubigeoId,
  dbo.damedistrito(ubigeoId) as ubicacion,
	telefonoPersonaContacto,
	personaEntrevistada,
  RGN_ACTIVIDAD.descripcion,
	RGN_ACTIVIDAD.tipoActividadId,
	RGN_TIPOACTIVIDAD.tipoActividad
	
	FROM	RGN_ACTIVIDAD,RGN_TIPOACTIVIDAD

	WHERE RGN_ACTIVIDAD.ajusteId=@ajusteId AND 
	      RGN_TIPOACTIVIDAD.tipoActividadId= RGN_ACTIVIDAD.tipoActividadId
	      AND RGN_ACTIVIDAD.estado = ''A'' and RGN_TIPOACTIVIDAD.tipoActividadId <> 5 
		
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InspeccionSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InspeccionSelect] 
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;
	Select 
		RGN_AJUSTE.ajusteId,
		RGN_AJUSTE.descripcionRiesgo,
		RGN_ACTIVIDAD.actividadId,		
		RGN_ACTIVIDAD.PersonaEntrevistada,
		RGN_ACTIVIDAD.lugarDeReunion,
		RGN_ACTIVIDAD.ubigeoId,dbo.dameDistrito(ubigeoId)As ''distrito''
	FROM RGN_AJUSTE,RGN_ACTIVIDAD 

	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)and
	      (RGN_ACTIVIDAD.ajusteId=@ajusteId)and
	      (RGN_ACTIVIDAD.tipoactividadId=5) ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delainspeccion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delainspeccion](@ajusteid numeric(8,0))

as

select RGN_AJUSTE.ajusteId, RGN_AJUSTE.descripcionRiesgo, 
	   RGN_ACTIVIDAD.actividadId, RGN_ACTIVIDAD.PersonaEntrevistada, 
       RGN_ACTIVIDAD.lugarDeReunion, RGN_ACTIVIDAD.ubigeoId, 
       dbo.dameDistrito(ubigeoId) as Distrito 
from RGN_AJUSTE, RGN_ACTIVIDAD
where  (RGN_AJUSTE.ajusteId= @ajusteId) AND
	(RGN_AJUSTE.ajusteId= RGN_ACTIVIDAD.ajusteId)AND
	(RGN_ACTIVIDAD.tipoActividadId = 5)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dameGiroNegocio]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function  [dbo].[dameGiroNegocio](@ajusteId numeric(8,0))
Returns varchar(1000)
begin

declare @GiroNegocio varchar(1000)
SELECT    @GiroNegocio= dbo.ADM_ASEGURADO.grupoEconomico
FROM         dbo.RGN_POLIZA_AJUSTE INNER JOIN
                      dbo.RGN_POLIZA ON dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
                      dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId INNER JOIN
                      dbo.ADM_ASEGURADO ON dbo.RGN_POLIZA.aseguradoId = dbo.ADM_ASEGURADO.personaId
where dbo.RGN_POLIZA_AJUSTE.ajusteid=@ajusteid
 
	set @GiroNegocio = isnull(@GiroNegocio,'''')

	return(@GiroNegocio)
end



' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dameACtividad]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE function  [dbo].[dameACtividad](@ajusteId numeric(8,0))
Returns varchar(250)
begin

declare @Actividad varchar(250)
SELECT    @Actividad= dbo.ADM_ASEGURADO.actividad
FROM         dbo.RGN_POLIZA_AJUSTE INNER JOIN
                      dbo.RGN_POLIZA ON dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
                      dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId INNER JOIN
                      dbo.ADM_ASEGURADO ON dbo.RGN_POLIZA.aseguradoId = dbo.ADM_ASEGURADO.personaId
where dbo.RGN_POLIZA_AJUSTE.ajusteid=@ajusteid
 
	set @Actividad = isnull(@Actividad,'''')

	return(@Actividad)
end




' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registroPolizaRapidaNatural]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE   procedure [dbo].[sp_rgen_registroPolizaRapidaNatural](
  @aseguradoraid numeric(8,0),
  @numeroPoliza varchar(100),
  @PrimerNombre varchar(100),
  @SegundoNombre varchar(100),
  @ApellidoPaterno varchar(100),
  @ApellidoMaterno varchar(100),
  @telefonocasa varchar(20),
  @telefonomovil varchar(20),
  @contratante varchar(250),
  @GirodeNegocio varchar(250),
  @GrupoEconomico varchar(250),
  @DNI varchar(20),
  @Direccion varchar(100),
  @ubigeoid varchar(6),
  @referencia varchar(20),
  @FechaInicio datetime, 
  @FechaFin datetime,
  @Productoid numeric(8,0),
  @ramoid numeric(8,0),
  @cobertura numeric(8,0),
  @usuario varchar(100),
  @ajusteId numeric (8,0),
  @archivo varchar(100)
)
as

declare @aseguradoid numeric(8,0)

BEGIN  

    --INSERTANDO DATOS PERSONALES
    insert into ADM_PERSONA(persona, nombre1,nombre2, apellido1, apellido2, estado, fcrea, tpersonaid, personajuridica)
     values(
      isnull(@Primernombre,'''')+isNull(@SegundoNombre,'''')+isNull(@ApellidoPaterno,'''')+isNull(@ApellidoMaterno,''''),
      @PrimerNombre,
      @SegundoNombre, 
      @ApellidoPaterno,
      @ApellidoMaterno,
      ''A'',
      getdate(),
      ''3'',
      ''N''
    ) 
   select @aseguradoid=max(personaid) from ADM_PERSONA
   
   --INSERTANDO TELEFONOS
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonocasa,''1'',getdate(),''A'',@usuario)    
   insert into ADM_TELEFONOXPERSONA(personaid, telefono, ttelefonoid,fcrea,estado, ucrea) values(@aseguradoid,@telefonomovil,''2'',getdate(),''A'',@usuario) 

   --INSERTANDO DIRECCION
   insert into ADM_DIRECCIONPERSONA(personaid, ubigeoid, direccion, referencia, fcrea,estado, ucrea) 
                             values(@aseguradoid,@ubigeoid,@direccion, @referencia,getdate(),''A'',@usuario) 

 
   --INSERTANDO DOCUMENTOS
   insert into ADM_DOCID(personaid, tdocidId, docid, fcrea, estado, ucrea)
          values(@aseguradoid,''1'',@DNI,getdate(),''A'',@usuario)
   
   --INSERTANDO OTROS CAMPOS 
   insert into ADM_ASEGURADO (personaid, actividad, grupoeconomico) values (@aseguradoid, @girodeNegocio, @GrupoEconomico)

   --INSERTANDO DATOS DE LA POLIZA
   insert into RGN_POLIZA(aseguradoraid,contratante, aseguradoid, productoid, ramoid, riesgoid,finicio,ffin, numeroPoliza,archivo,fcrea,estado,ucrea)
   values (@aseguradoraid, 
	   @contratante, 
           @aseguradoid, 
           @productoid, 
           @ramoid, 
           @cobertura, 
           @FechaInicio, 
           @Fechafin, 
           @numeroPoliza, 
	   isnull(@archivo,''''),
           getdate(), 
           ''A'',
           isnull(@usuario,''usuario'')) 	

--INSERTANDO EN TABLA POLIZA_AJUSTE

    DECLARE @polizaId numeric(8,0);
    SET @polizaId= scope_Identity();

/*
    insert into RGN_POLIZA_AJUSTE
    (
	aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate

    )
    
    values (
    	@aseguradoraid,
 	@polizaId,
        @ajusteId,
        ''A'',
	getdate(),
	getdate(),
	isnull(@usuario,''usuario''),
	isnull(@usuario,''usuario'')
    )
*/ 
END 







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_informacionAjusteRimacUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_informacionAjusteRimacUpdate]
(
	@ajusteId numeric(8, 0),-- ajuste
	@polizaId numeric(8, 0),-- polizaPrincipal
	@descripcionRiesgo text = null, 
	@observaciones text = null, 
	@numAjustePASA varchar(30), 
	@causasiniestro text = null, 
    @detalleocurrencia text = null, 
	@situacionajuste text = null, 
	@verificaciongarantias text = null, 
    @siniestrosanteriores text = null,
	@salvamentoyrecupero text = null,
	@recomendaciones text = null,
    @investigaciones text = null,
	@TotalIndenmizacion numeric (14,2)= null,
	@opinionAjustador text = null,
    @descripcionLugarSiniestro text = null,
	@descripcionBienesAfectados text = null,
	@antecedentes text = null,
    @descripcionReclamo text = null,
	@descripcionReserva text = null,
	@materiaAsegurada text = null,
    @localAsegurado text = null,
	@seccion text = null



)
AS
BEGIN
	
	SET NOCOUNT OFF;
	UPDATE [RGN_AJUSTE] 
	SET 	
      descripcionRiesgo = @descripcionRiesgo, 
	  observaciones = @observaciones, 
	  numAjustePASA = @numAjustePASA, 
	  causasiniestro = @causasiniestro, 
      detalleocurrencia = @detalleocurrencia, 
	  situacionajuste =@situacionajuste, 
	  verificaciongarantias = @verificaciongarantias, 
      siniestrosanteriores = @siniestrosanteriores, 
	  salvamentoyrecupero = @salvamentoyrecupero, 
	  recomendaciones =@recomendaciones, 
      investigaciones = @investigaciones, 
	  TotalIndenmizacion = @TotalIndenmizacion, 
	  opinionAjustador = @opinionAjustador, 
      descripcionLugarSiniestro = @descripcionLugarSiniestro, 
	  descripcionBienesAfectados = @descripcionBienesAfectados, 
	  antecedentes = @antecedentes, 
      descripcionReclamo = @descripcionReclamo, 
	  descripcionReserva = @descripcionReserva
	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)

	UPDATE [RGN_POLIZA]
	SET
	  materiaAsegurada = @materiaAsegurada, 
      localAsegurado = @localAsegurado, 
	  seccion = @seccion
	WHERE [RGN_POLIZA].polizaId=@polizaId


END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_informacionAjusteRimac]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_informacionAjusteRimac]
(
	@ajusteId decimal(8,0)
)
AS
	
BEGIN

SELECT     
	  dbo.RGN_AJUSTE.ajusteId,
	  dbo.RGN_AJUSTE.descripcionRiesgo, 
	  dbo.RGN_AJUSTE.observaciones, 
	  dbo.RGN_AJUSTE.numAjustePASA, 
	  dbo.RGN_AJUSTE.causasiniestro, 
      dbo.RGN_AJUSTE.detalleocurrencia, 
	  dbo.RGN_AJUSTE.situacionajuste, 
	  dbo.RGN_AJUSTE.verificaciongarantias, 
      dbo.RGN_AJUSTE.siniestrosanteriores, 
	  dbo.RGN_AJUSTE.salvamentoyrecupero, 
	  dbo.RGN_AJUSTE.recomendaciones, 
      dbo.RGN_AJUSTE.investigaciones, 
	  dbo.RGN_AJUSTE.TotalIndenmizacion, 
	  dbo.RGN_AJUSTE.opinionAjustador, 
      dbo.RGN_AJUSTE.descripcionLugarSiniestro, 
	  dbo.RGN_AJUSTE.descripcionBienesAfectados, 
	  dbo.RGN_AJUSTE.antecedentes, 
      dbo.RGN_AJUSTE.descripcionReclamo, 
	  dbo.RGN_AJUSTE.descripcionReserva, 
	  dbo.RGN_POLIZA.materiaAsegurada, 
      dbo.RGN_POLIZA.localAsegurado, 
	  dbo.RGN_POLIZA.seccion
FROM         dbo.RGN_AJUSTE INNER JOIN
      dbo.RGN_POLIZA_AJUSTE ON dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId AND 
      dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId INNER JOIN
      dbo.RGN_POLIZA ON dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
      dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId

WHERE RGN_AJUSTE.ajusteId = @ajusteId

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_get_CodigoAseguradora_By_AjusteId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[proc_get_CodigoAseguradora_By_AjusteId](@AjusteId NUMERIC(8,0))
AS
BEGIN
	DECLARE @codigo VARCHAR(100)	
	
	DECLARE @aseguradoraId NUMERIC(8,0)		
	
	SELECT @aseguradoraId = [aseguradoraId] FROM [RGN_POLIZA_AJUSTE] WHERE [RGN_POLIZA_AJUSTE].[ajusteId] = @AjusteId
	
	SELECT @codigo = codigoAseguradora FROM [ADM_CLIENTE] WHERE [aseguradoraId] = @aseguradoraId
	
	IF @codigo IS NULL 
	SET @codigo = ''NO_CODE''
	SELECT @codigo AS ''codigo''
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[borrar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[borrar](@ajusteId numeric(8,0))  AS

delete from RGN_ACTIVIDAD where ajusteID = @ajusteId
delete from RGN_ANEXO where ajusteId = @ajusteId
delete from RGN_GASTO where ajusteId = ajusteID

delete from RGN_comunicacion where ajusteId = ajusteID
delete from RGN_CONTACTOS_AJUSTE where AjusteId =@ajusteId
delete from RGN_EstadosAJUSTE where AjusteId =@ajusteId
delete from RGN_POLIZA_AJUSTE where AJusteId =@ajusteId
delete from RGN_informacionrelevante where AJusteId =@ajusteId
delete from RGN_PERDIDA where AjusteID = @ajusteId
delete from RGN_reserva where AjusteID = @ajusteId
delete from RGN_reclamo where AjusteID = @ajusteId
delete from RGN_BIENAFECTADO where AjusteId = @ajusteId
delete from RGN_AJUSTE_RGN_REQUERIMIENTO where AjusteId = @ajusteId
delete from RGN_SOLICITUDDOCUMENTOs where AjusteId = @ajusteId
delete from RGN_SECCIONESAJUSTE where AjusteId = @ajusteId
delete from rgn_informe where AjusteId = @ajusteId
delete from RGN_AJUSTE_CLAUSULAS where AjusteId = @ajusteId
delete from RGN_ATRIBUTOPOLIZA_AJUSTE where AjusteId = @ajusteId
delete from RGN_EQUIPO where AjusteId = @ajusteId
delete from RGN_ITEMASEGURADO_AJUSTE where AjusteId = @ajusteId
delete from RGN_CONVENIOAJUSTE where AjusteId = @ajusteId

delete from RGN_SINIESTRO 
from RGN_AJUSTE  
where RGN_AJUSTE.siniestroid = RGN_SINIESTRO.siniestroid and
      RGN_AJUSTE.AjusteId = @ajusteId

delete from RGN_AJUSTE where AjusteId = @ajusteId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_solicitudDocumentosXInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_solicitudDocumentosXInsert](
	@SolicitudDocumentosId numeric(8,0) output,
	@numeroSolicitud varchar(100), 
	@Fecha datetime, 
	@ajusteId numeric(8,0), 
	@fcrea datetime, 
	@fupdate datetime, 
	@estado varchar(1), 
	@ucrea varchar(20), 
	@uupdate varchar(20), 
	@enreferencia varchar(250), 
	@tipo varchar(20)
)
as

INSERT INTO RGN_SOLICITUDDOCUMENTOS 
(numeroSolicitud, Fecha, ajusteId, fcrea, fupdate, estado, ucrea, uupdate, enreferencia, tipo) 
VALUES 
( @numeroSolicitud, @Fecha, @ajusteId, @fcrea, @fupdate, @estado, @ucrea, @uupdate, @enreferencia, @tipo)

set @SolicitudDocumentosId = scope_identity()

select @solicitudDocumentosId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Requisitos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_Requisitos]( @ajusteId numeric(8,0)) 
as
begin
	
	SELECT     RGN_AJUSTE_RGN_REQUERIMIENTO.*, RGN_SOLICITUDDOCUMENTOS.numeroSolicitud, RGN_REQUISITOS.nombre, 
                      RGN_REQUISITOS.descripcion
	
	FROM         RGN_SOLICITUDDOCUMENTOS INNER JOIN
                      RGN_AJUSTE_RGN_REQUERIMIENTO ON 
                      RGN_SOLICITUDDOCUMENTOS.solicitudDocumentosId = RGN_AJUSTE_RGN_REQUERIMIENTO.solicitudDocumentosId AND 
                      RGN_SOLICITUDDOCUMENTOS.ajusteId = RGN_AJUSTE_RGN_REQUERIMIENTO.ajusteId INNER JOIN
                      RGN_REQUISITOS ON RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId = RGN_REQUISITOS.requisitoId

	where RGN_AJUSTE_RGN_REQUERIMIENTO.ajusteId = @ajusteId

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SolicitudDocumentosLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SolicitudDocumentosLista]
(
	@AjusteId numeric(8,0)
)
as
begin
	select numerosolicitud,Fecha  from RGN_SOLICITUDDOCUMENTOS
	where ajusteId = @ajusteId
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_solicitudDocumentosDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_solicitudDocumentosDelete](@solicitudDocumentosId numeric(8,0)) 
as

UPDATE RGN_AJUSTE_RGN_REQUERIMIENTO SET estado = ''I'' WHERE (solicitudDocumentosId = @solicitudDocumentosId)
UPDATE RGN_SOLICITUDDOCUMENTOS SET estado = ''I'' WHERE (solicitudDocumentosId = @solicitudDocumentosId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesAjusteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SeccionesAjusteSelect] ( @ajusteid numeric(8, 0) )
AS 
    BEGIN
        select  [ajusteId],
				[ContenidoSeccion],
				[estado],
				[fcrea],
				[fupdate],
				[nivel],
				[seccionId],
				[seccionPadreId],
				[SubtituloSeccion],
				[TituloSeccion],
				[ucrea],
				[uupdate],
				ISNULL([visible],1) AS visible,
				keyName
        from    RGN_SECCIONESAJUSTE
        WHERE   ajusteId = @ajusteId
                AND nivel = ''2''
                AND seccionPadreId is null 


    end
    SET QUOTED_IDENTIFIER OFF ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesAjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesAjusteInsert]
    (
      @usuario varchar(100),
      @ajusteid numeric(8, 0),
      @tituloSeccion varchar(250),
      @contenidoSeccion text
	
    )
AS 
    BEGIN
        insert  into RGN_SECCIONESAJUSTE
                (
                  tituloSeccion,
                  contenidoSeccion,
                  ajusteId,
                  fupdate,
                  fcrea,
                  nivel,
                  estado,
                  ucrea,
                  uupdate,
                  visible
                  
                )
        values  (
                  @tituloSeccion,
                  @contenidoSeccion,
                  @ajusteid,
                  getdate(),
                  getdate(),
                  ''2'',
                  ''A'',
                  @usuario,
                  @usuario,
                  1
	          )	 


    end
    SET QUOTED_IDENTIFIER OFF 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesAjusteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesAjusteDelete]
(
	@seccionId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM RGN_SECCIONESAJUSTE
	WHERE RGN_SECCIONESAJUSTE.seccionId=@seccionId

	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesTotalPacifico]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[sp_rgen_SeccionesTotalPacifico] 
(	
	@ajusteid numeric(8,0)
)
AS

BEGIN

	SELECT	
					RGN_SECCIONESAJUSTE.seccionId AS seccionPadreId,
					RGN_SECCIONESAJUSTE.TituloSeccion AS tituloPadre,
					RGN_SECCIONESAJUSTE.ContenidoSeccion AS contenidoPadre,
					SUBTITULO.seccionId,
					SUBTITULO.TituloSeccion,
					SUBTITULO.ContenidoSeccion
	FROM 		RGN_SECCIONESAJUSTE LEFT OUTER JOIN
					RGN_SECCIONESAJUSTE SUBTITULO ON SUBTITULO.seccionPadreId = RGN_SECCIONESAJUSTE.seccionId
	WHERE		RGN_SECCIONESAJUSTE.ajusteId = @AjusteId AND
					RGN_SECCIONESAJUSTE.nivel = ''1'' AND RGN_SECCIONESAJUSTE.visible=1 AND
					RGN_SECCIONESAJUSTE.KEYNAME =NULL
	ORDER BY RGN_SECCIONESAJUSTE.seccionPadreId, SUBTITULO.seccionId


END


SET QUOTED_IDENTIFIER OFF 







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeSeccionesAjusteSelectPacifico]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeSeccionesAjusteSelectPacifico] ( @ajusteid numeric(8, 0) )
AS 
    BEGIN
        select  [ajusteId],
				[ContenidoSeccion],
				[estado],
				[fcrea],
				[fupdate],
				[nivel],
				[seccionId],
				[seccionPadreId],
				[SubtituloSeccion],
				[TituloSeccion],
				[ucrea],
				[uupdate],
				ISNULL([visible],1) AS visible,
				KeyName
				
        from    RGN_SECCIONESAJUSTE
        WHERE   ajusteId = @ajusteid
                AND nivel = ''2''
                AND seccionPadreId is null 
                AND KeyName IS null
				AND ISNULL([visible],1) = 1
				


    end
    SET QUOTED_IDENTIFIER OFF' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_secciones_ajuste_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[proc_secciones_ajuste_update] 
(
	@TituloSeccion varchar(250),
	@ContenidoSeccion TEXT,
	@uupdate VARCHAR(20),
	@visible BIT,
	@ajusteId NUMERIC(8,0),
	@seccionId NUMERIC(8,0)
)
AS
BEGIN

	UPDATE [RGN_SECCIONESAJUSTE] SET
		[TituloSeccion] = @TituloSeccion,		
		[ContenidoSeccion] = @ContenidoSeccion,
		[fupdate] = GETDATE(),				
		[uupdate] = @uupdate,
		[visible] = @visible
	WHERE ajusteId = @ajusteid AND 
		[seccionId] = @seccionId
		
		
	
	
	
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeSeccionesAjusteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeSeccionesAjusteSelect] ( @ajusteid numeric(8, 0) )
AS 
    BEGIN
        select  [ajusteId],
				[ContenidoSeccion],
				[estado],
				[fcrea],
				[fupdate],
				[nivel],
				[seccionId],
				[seccionPadreId],
				[SubtituloSeccion],
				[TituloSeccion],
				[ucrea],
				[uupdate],
				ISNULL([visible],1) AS visible,
				KeyName
				
        from    RGN_SECCIONESAJUSTE
        WHERE   ajusteId = @ajusteId
                AND nivel = ''2''
                AND seccionPadreId is null 
				AND visible=1


    end
    SET QUOTED_IDENTIFIER OFF 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesAjusteUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[sp_rgen_SeccionesAjusteUpdate]
    (
      @seccionId numeric(8, 0),
      @TituloSeccion VARCHAR(250),
      @ContenidoSeccion text,
      @uupdate VARCHAR(20),
      @visible BIT
	
    )
AS 
    BEGIN

        SET NOCOUNT OFF
        DECLARE @Err int

--	UPDATE RGN_SECCIONESAJUSTE
--	SET 
--	WHERE RGN_SECCIONESAJUSTE.seccionId=@seccionId AND 

        UPDATE  [dbo].[RGN_SECCIONESAJUSTE]
        SET     [TituloSeccion] = @TituloSeccion,
                [ContenidoSeccion] = @ContenidoSeccion,
                [fupdate] = GETDATE(),
                [uupdate] = @uupdate,
                [visible] = @visible
        WHERE   [RGN_SECCIONESAJUSTE].[seccionId] = @seccionId

        SET @Err = @@Error

        RETURN @Err
    END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesFinalInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SeccionesFinalInsert]
    (
      @usuario varchar(100),
      @ajusteid numeric(8, 0),
      @tituloSeccion varchar(200),
      @subtituloSeccion varchar(250),
      @contenidoSeccion TEXT      
    )
AS 
    BEGIN
    
  
    
        insert  into RGN_SECCIONESAJUSTE
                (
                  tituloSeccion,
                  subtituloSeccion,
                  contenidoSeccion,
                  nivel,
                  ajusteId,
                  fupdate,
                  fcrea,
                  estado,
                  ucrea,
                  uupdate,
                  visible
				
                )
        values  (
                  @tituloSeccion,
                  @subtituloSeccion,
                  @contenidoSeccion,
                  ''1'',
                  @ajusteid,
                  getdate(),
                  getdate(),
                  ''A'',
                  @usuario,
                  @usuario,
                  1
                )	 


    end
    SET QUOTED_IDENTIFIER OFF 



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesFinalDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesFinalDelete]
(
	@seccionId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM RGN_SECCIONESAJUSTE
	WHERE RGN_SECCIONESAJUSTE.seccionPadreId=@seccionId

	DELETE FROM RGN_SECCIONESAJUSTE
	WHERE RGN_SECCIONESAJUSTE.seccionId=@seccionId

	SET @Err = @@Error

	RETURN @Err
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesFinalSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_SeccionesFinalSelect]
(	
	@ajusteid numeric(8,0)
)
AS

BEGIN
select * from RGN_SECCIONESAJUSTE
WHERE (ajusteId=@ajusteId) AND
			(nivel=''1'') 


end
SET QUOTED_IDENTIFIER OFF 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesSubtituloFinal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesSubtituloFinal]
(	
	@ajusteid numeric(8,0),
	@seccionId numeric
)
AS

BEGIN

	SELECT * FROM RGN_SECCIONESAJUSTE
	WHERE ajusteId=@ajusteId AND
				nivel = ''2'' AND
				seccionPadreId = @seccionId


end
SET QUOTED_IDENTIFIER OFF 



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesSubtituloInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesSubtituloInsert]
(	
	@usuario varchar(100),
	@ajusteid numeric(8,0),
	@tituloSeccion varchar (200),
	@subtituloSeccion varchar (200),
	@contenidoSeccion varchar(200),
	@seccionPadreid numeric (8,0)
	
)
AS
BEGIN
insert into RGN_SECCIONESAJUSTE
       (		tituloSeccion,
						subtituloSeccion,
	     			contenidoSeccion,
						seccionPadreid,
						nivel,
	     			ajusteId,
            fupdate, 
			      fcrea,
            estado,
            ucrea,
            uupdate
				)
values 
      (			@tituloSeccion,
						@subtituloSeccion,
						@contenidoSeccion,
						@seccionPadreid,
						''2'',
			      @ajusteid,
		 				getdate(),
				    getdate(),
            ''A'',
            @usuario,
            @usuario
        )	 


end
SET QUOTED_IDENTIFIER OFF 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SeccionesTotal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_SeccionesTotal] 
(	
	@ajusteid numeric(8,0)
)
AS

BEGIN

	SELECT	
					RGN_SECCIONESAJUSTE.seccionId AS seccionPadreId,
					RGN_SECCIONESAJUSTE.TituloSeccion AS tituloPadre,
					RGN_SECCIONESAJUSTE.ContenidoSeccion AS contenidoPadre,
					SUBTITULO.seccionId,
					SUBTITULO.TituloSeccion,
					SUBTITULO.ContenidoSeccion
	FROM 		RGN_SECCIONESAJUSTE LEFT OUTER JOIN
					RGN_SECCIONESAJUSTE SUBTITULO ON SUBTITULO.seccionPadreId = RGN_SECCIONESAJUSTE.seccionId
	WHERE		RGN_SECCIONESAJUSTE.ajusteId = @AjusteId AND
					RGN_SECCIONESAJUSTE.nivel = ''1'' AND RGN_SECCIONESAJUSTE.visible=1
	ORDER BY RGN_SECCIONESAJUSTE.seccionPadreId, SUBTITULO.seccionId


END


SET QUOTED_IDENTIFIER OFF 






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Parcial_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Parcial_Update]
(
	@quienNotifico varchar(250),
	@NombreDelNotificante varchar(250),
	@faviso datetime,
        @medioDeNotificacionId numeric(8,0), 


	@NombreQuienConfirma varchar(250), 
	@FechayHoraConfirmacion datetime, 
	@medioConfirmacionId numeric(8,0),
	@cargoconfirmante varchar(250), 

	@aseguradoraid numeric(8,0),
	@nombreresponsable varchar(250),
	@telefonoresponsable varchar(20),
	@emailresponsable varchar(250),

	@brokerId numeric(8,0),
	@nombreresponsableBroker varchar(250),
	@telefonoresponsableBroker varchar(20),
	@emailresponsableBroker varchar(250),
	@numeroSiniestroCia varchar(100),
	@numeroSiniestroBroker varchar(100),

	@fsiniestro datetime,
	@lugarsiniestro varchar(250),
	@ubigeoid varchar(6),	
	@tiposiniestro_id numeric(8,0),
	@nombreresponsableSiniestro varchar(250),
	@telefonoresponsableSiniestro varchar(20),
	@emailresponsableSiniestro varchar(250),
	@descripcion varchar(250),

	@usuario varchar(100),
        @polizaid numeric(8,0),

	@ajusteid numeric(8,0)  --dato adicional al insert para saber cual de los ajustes se actualiza
)
AS
BEGIN

declare @estadoajusteid numeric(8,0)
--Insertando datos del AJUSTE

update RGN_AJUSTE
        set quienNotifico= @quienNotifico,
	nombredelNotificante= @NombreDelNotificante,
	faviso=	 @faviso,
        mediodeNotificacionid= @medioDeNotificacionId, 
        NombrequienConfirma= @NombreQuienConfirma, 
	FechayHoraConfirmacion= @FechayHoraConfirmacion, 
	medioConfirmacion = @medioConfirmacionId,
	cargoconfirmante= @cargoconfirmante, 
	brokerid= @brokerId,
	NumeroSiniestroCia= @NumeroSiniestroCia,
	numeroSiniestroBroker= @NumeroSiniestroBroker,
	tajusteid= ''1'', --valor por defecto
	fupdate= getdate(),
        uupdate=@usuario
where ajusteid=@ajusteid        

--Insertando contacto de la ASEGURADORA
update  RGN_CONTACTOS_AJUSTE 	 
	set	nombreContacto=@nombreresponsable, 
		telefonocontacto=@telefonoresponsable, 
		emailcontacto=@emailresponsable,
		fupdate= getdate(),
       		uupdate=@usuario
where  ajusteid=@ajusteid and TipoContactoid=''1''

--Insertando contacto del BROKER
update RGN_CONTACTOS_AJUSTE 
	set 	nombreContacto=@nombreresponsableBroker, 
		telefonocontacto=@telefonoresponsableBroker, 
		emailcontacto=@emailresponsableBroker,
		fupdate= getdate(),
       		uupdate=@usuario
where  ajusteid=@ajusteid and TipoContactoid=''2''

--Insertando contactos del SINIESTRO
update RGN_CONTACTOS_AJUSTE 
	set	nombreContacto=@nombreresponsableSiniestro, 
		telefonocontacto=@telefonoresponsableSiniestro, 
		emailcontacto=@emailresponsableSiniestro,
                fupdate= getdate(),
       		uupdate=@usuario
where  ajusteid=@ajusteid and TipoContactoid=''5''

--Insertando datos del SINIESTRO

update RGN_SINIESTRO 
       set descripcion=@descripcion, 
	   fsiniestro=@fsiniestro, 
	   tiposiniestroid=@tiposiniestro_id, 
	   lugarsiniestro=@lugarsiniestro,
	   ubigeoid=@ubigeoid, 
	   fupdate= getdate(),
       	   uupdate=@usuario
where siniestroid=(select siniestroid from RGN_AJUSTE where ajusteid=@ajusteid)

update RGN_POLIZA_AJUSTE  
       set     polizaid=@polizaid,
	       aseguradoraid=@aseguradoraid, 
	       ajusteid=@ajusteid,
	       numsiniestro=@numeroSiniestroCia,
 	       fupdate= getdate(),
       	       uupdate=@usuario
where ajusteid=@ajusteid

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_AjusteSelect]
(
	@AjusteId numeric(8,0)
)
AS
BEGIN


-- datos del AJUSTE

SELECT  quienNotifico,
        nombredelNotificante, 
        faviso,
        mediodeNotificacionid, 
        NombrequienConfirma, 
        FechayHoraConfirmacion, 
        medioConfirmacion,
        cargoconfirmante, 
        brokerid, 
        NumeroSiniestroCia,
        tajusteid

FROM RGN_AJUSTE      
WHERE RGN_AJUSTE.ajusteId=@AjusteId



END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajustador_AjusteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_Ajustador_AjusteSelect]
(
	@ajusteId numeric(8, 0)
	
)
AS
	SET NOCOUNT OFF;

SELECT ajusteId, ajustadorId, ejecutivoSiniestrosId
FROM RGN_AJUSTE 
WHERE RGN_AJUSTE.ajusteId=@ajusteId



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InspeccionLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_InspeccionLista]
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;
	Select 
		[RGN_AJUSTE].[ajusteId],
		[RGN_AJUSTE].[detalleocurrencia],
		[RGN_AJUSTE].[causasiniestro],
		[RGN_AJUSTE].[investigaciones],
		[RGN_AJUSTE].[situacionajuste]As situacionSiniestro,
		[RGN_AJUSTE].[verificaciongarantias],
		[RGN_AJUSTE].[siniestrosanteriores],
		[RGN_AJUSTE].[salvamentoyrecupero]AS Salvamento,
		[RGN_AJUSTE].[recomendaciones],
		[RGN_RESERVA].[monto] AS Reserva,
		[RGN_RESERVA].[monedaId] AS monedaReserva,
		[RGN_RECLAMO].[monto] AS Reclamo,
		[RGN_RECLAMO].[monedaId] AS monedaReclamo
	FROM [RGN_AJUSTE],[RGN_RESERVA],[RGN_RECLAMO] 

	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)and 
	      (RGN_AJUSTE.ajusteId=RGN_RECLAMO.ajusteId)and 
	      (RGN_AJUSTE.ajusteId=RGN_RESERVA.ajusteId) and 
	      (RGN_RECLAMO.reclamoId=(select max(reclamoId)from RGN_RECLAMO where @ajusteId=RGN_RECLAMO.ajusteId )) and
	      (RGN_RESERVA.reservaId=(select max(reservaId)from RGN_RESERVA where @ajusteId=RGN_RESERVA.ajusteId ))	
	
	' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InspeccionUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_InspeccionUpdate]
(
	@ajusteId numeric(8, 0),-- ajuste
	@actividadId numeric (8,0),
	@lugarDeReunion varchar (250),
	@PersonaEntrevistada varchar(1000),
        @ubigeoId varchar(6),
	@distrito varchar (1000),	
	@descripcionRiesgo varchar(2500)
 
			

)
AS

	SET NOCOUNT OFF;
	UPDATE RGN_AJUSTE 
	SET 	descripcionRiesgo=@descripcionRiesgo
		
	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)
	


	UPDATE RGN_ACTIVIDAD
	SET 
		lugarDeReunion=@lugarDeReunion,
		PersonaEntrevistada=@PersonaEntrevistada,
		ubigeoid=@ubigeoId
	
	WHERE (RGN_ACTIVIDAD.ajusteId=@ajusteId)and
              (RGN_ACTIVIDAD.actividadId=@actividadId)	





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_fechaavisoycoordinacion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- sp_rgen_informebasico_fechaavisoycoordinacion 1361
CREATE  PROCEDURE [dbo].[sp_rgen_informebasico_fechaavisoycoordinacion](@ajusteid int)
as

--declare @ajusteid int 
--set @ajusteid=1

declare @fechaaviso datetime
declare @quien varchar(50)
declare @via varchar(50)

SELECT	@fechaaviso = RGN_AJUSTE.faviso,
        @quien = RGN_AJUSTE.NombreDelNotificante,
        @via =  RGN_TIPOCOMUNICACION.nombre
FROM    RGN_AJUSTE INNER JOIN
        RGN_ACTIVIDAD ON RGN_AJUSTE.ajusteId = RGN_ACTIVIDAD.ajusteId INNER JOIN
        RGN_TIPOCOMUNICACION ON         
        RGN_AJUSTE.medioDeNotificacionId = RGN_TIPOCOMUNICACION.tcomunicacionId
where 	RGN_AJUSTE.ajusteid = @ajusteid


declare @fechacoordinacion datetime
declare @con1 varchar(250)

SELECT  @fechacoordinacion = RGN_ACTIVIDAD.FechaHoraCoordinacion, 
        @con1 = RGN_ACTIVIDAD.personaContacto
FROM    RGN_ACTIVIDAD INNER JOIN
        RGN_AJUSTE ON RGN_ACTIVIDAD.ajusteId = RGN_AJUSTE.ajusteId INNER JOIN
        RGN_TIPOACTIVIDAD ON 
        RGN_ACTIVIDAD.tipoActividadId = 5 --RGN_TIPOACTIVIDAD.tipoActividadId
WHERE   (RGN_AJUSTE.ajusteId = @ajusteid)
--WHERE   (RGN_TIPOACTIVIDAD.TipoActividad LIKE ''COORD%'') AND (RGN_AJUSTE.ajusteId = @ajusteid)

declare @fechainspeccion datetime
declare @con2 varchar(250)

SELECT	@fechainspeccion = RGN_ACTIVIDAD.FechaHoraReunion, 
        @con2 = RGN_ACTIVIDAD.personaEntrevistada
FROM    RGN_ACTIVIDAD INNER JOIN
        RGN_AJUSTE ON RGN_ACTIVIDAD.ajusteId = RGN_AJUSTE.ajusteId INNER JOIN
        RGN_TIPOACTIVIDAD ON 
        RGN_ACTIVIDAD.tipoActividadId = 5 --RGN_TIPOACTIVIDAD.tipoActividadId
WHERE   (RGN_AJUSTE.ajusteId = @ajusteid)
--WHERE   (RGN_TIPOACTIVIDAD.TipoActividad LIKE ''REUN%'') AND (RGN_AJUSTE.ajusteId = @ajusteid)

/*create table rgn_temp_informebasicofechas(
fechaaviso datetime,
quien varchar(50),
via varchar(50),
fechacoordinacion datetime,
con1 varchar(250),
fechainspeccion datetime,
con2 varchar(250)
)*/

delete from rgn_temp_informebasicofechas

insert into rgn_temp_informebasicofechas (fechaaviso,quien,via,fechacoordinacion,con1,fechainspeccion,con2)
values (@fechaaviso,@quien,@via,@fechacoordinacion,@con1,@fechainspeccion,@con2)

select * from rgn_temp_informebasicofechas




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Total_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Total_Update]
    (
      @ajusteid numeric(8, 0),
      @quiennotifico varchar(250),
      @NombreDelNotificante varchar(250),
      @faviso datetime,
      @medionotificacionid numeric(8, 0),
      @nombrequienconfirma varchar(250),
      @fechayhoraconfirmacion datetime,
      @medioconfirmacionid numeric(8, 0),
      @cargoconfirmante varchar(250),
      @aseguradoraid numeric(8, 0),
      @nombreresponsable varchar(250),
      @telefonoresponsable varchar(20),
      @emailresponsable varchar(250),
      @brokerid numeric(8, 0),
      @nombreresponsablebroker varchar(250),
      @telefonoresponsablebroker varchar(20),
      @emailresponsablebroker varchar(250),
      @numerosiniestroCia varchar(100),
      @numerosiniestroBroker varchar(100),
      @fsiniestro datetime,
      @lugarsiniestro varchar(250),
      @ubigeo varchar(6),
      @distrito Varchar(100),
      @tiposiniestroId numeric(8, 0),
      @nombreresponsablesiniestro varchar(250),
      @telefonoresponsablesiniestro varchar(250),
      @emailresponsablesiniestro varchar(250),
      @descripcion varchar(250),
      @polizaid numeric(8, 0),
      @ajustadorid numeric(8, 0),
	  @ejecutivoSiniestrosid numeric(8, 0),
      @fechahoracoordinacion datetime,
      @fechahoraprogramacion datetime,  --FECHAHORA PARA LA QUE SE PROGRAMA LA REUNION
      @fechahorareunion datetime,
      @ubigeoIDinspeccion varchar(6),
      @distritoInspeccion varchar(100),
      @personacontacto varchar(250),
      @tajusteid numeric(8, 0),
      @lugareunion varchar(250),
      @referencia varchar(250),
      @telefonopersonacontacto varchar(250),
      @contratante varchar(250),
      @asegurado varchar(250),
      @numeroPoliza varchar(200),
      @RamoAfectado varchar(200)
    )
AS 
    BEGIN

--Insertando datos del AJUSTE
        declare @estadoajusteid numeric(8, 0)

        if ( @medionotificacionid = -1 ) 
            begin
                set @medionotificacionid = null
            end

        if ( @medioConfirmacionId = -1 ) 
            begin
                set @medioConfirmacionId = null
            end

        if ( @brokerId = -1 ) 
            begin
                set @brokerId = null
            end

        if ( @ajustadorid = -1 ) 
            begin
                set @ajustadorid = null
            end

		if ( @ejecutivoSiniestrosId = -1 ) 
            begin
                set @ejecutivoSiniestrosId = null
            end



        update  RGN_AJUSTE
        set     quienNotifico = @quienNotifico,
                nombredelNotificante = @NombreDelNotificante,
                faviso = @faviso,
                mediodeNotificacionid = @medionotificacionid,
                NombrequienConfirma = @NombreQuienConfirma,
                FechayHoraConfirmacion = @FechayHoraConfirmacion,
                medioConfirmacion = @medioConfirmacionId,
                cargoconfirmante = @cargoconfirmante,
                brokerid = @brokerId,
                NumeroSiniestroCia = @NumeroSiniestroCia,
                NumeroSiniestroBroker = @NumeroSiniestroBroker,
                tajusteid = @tajusteid,
                ajustadorid = @ajustadorid,
				ejecutivoSiniestrosId = @ejecutivoSiniestrosId,
                fupdate = getdate(),
                fechaHoraProgramacion = @fechahoraprogramacion
        where   ajusteid = @ajusteid        

--Insertando contacto de la ASEGURADORA     
        update  RGN_CONTACTOS_AJUSTE
        set     nombreContacto = @nombreresponsable,
                telefonocontacto = @telefonoresponsable,
                emailcontacto = @emailresponsable,
                fupdate = getdate()
        where   ajusteid = @ajusteid
                and TipoContactoid = ''1''
                
        if @@ROWCOUNT = 0 
            BEGIN 
                insert  into RGN_CONTACTOS_AJUSTE
                        (
                          TipoContactoid,
                          ajusteid,
                          nombreContacto,
                          telefonocontacto,
                          emailcontacto,
                          fcrea,
                          fupdate,
                          estado,
                          ucrea,
                          uupdate
                        )
                values  (
                          1,
                          @ajusteid,
                          @nombreresponsable,
                          @telefonoresponsable,
                          @emailresponsable,
                          getdate(),
                          getdate(),
                          ''A'',
                          '''',
                          ''''
  
                        )
            END
            
                
                

--Insertando contacto del BROKER
        update  RGN_CONTACTOS_AJUSTE
        set     nombreContacto = @nombreresponsableBroker,
                telefonocontacto = @telefonoresponsableBroker,
                emailcontacto = @emailresponsableBroker,
                fupdate = getdate()
        where   ajusteid = @ajusteid
                and TipoContactoid = ''2''
                
                
                         
        if @@ROWCOUNT = 0 
            BEGIN 
                insert  into RGN_CONTACTOS_AJUSTE
                        (
                          TipoContactoid,
                          ajusteid,
                          nombreContacto,
                          telefonocontacto,
                          emailcontacto,
                          fcrea,
                          fupdate,
                          estado,
                          ucrea,
                          uupdate
                        )
                values  (
                          2,
                          @ajusteid,
                          @nombreresponsableBroker,
                          @telefonoresponsableBroker,
                          @emailresponsableBroker,
                          getdate(),
                          getdate(),
                          ''A'',
                          '''',
                          ''''
	                  )
            END
            

--Insertando contactos del SINIESTRO
        update  RGN_CONTACTOS_AJUSTE
        set     nombreContacto = @nombreresponsableSiniestro,
                telefonocontacto = @telefonoresponsableSiniestro,
                emailcontacto = @emailresponsableSiniestro,
                fupdate = getdate()
        where   ajusteid = @ajusteid
                and TipoContactoid = ''5''
                
        IF @@ROWCOUNT = 0 
            BEGIN
                insert  into RGN_CONTACTOS_AJUSTE
                        (
                          TipoContactoid,
                          ajusteid,
                          nombreContacto,
                          telefonocontacto,
                          emailcontacto,
                          fcrea,
                          fupdate,
                          estado,
                          ucrea,
                          uupdate
                        )
                values  (
                          5,
                          @ajusteid,
                          @nombreresponsableSiniestro,
                          @telefonoresponsableSiniestro,
                          @emailresponsableSiniestro,
                          getdate(),
                          getdate(),
                          ''A'',
                          '''',
                          ''''
	                  )

            END

--Insertando datos del SINIESTRO

        update  RGN_SINIESTRO
        set     descripcion = @descripcion,
                fsiniestro = @fsiniestro,
                tiposiniestroid = @tiposiniestroid,
                lugarsiniestro = @lugarsiniestro,
                ubigeoid = @ubigeo,
                fupdate = getdate()
        where   siniestroid = ( select  siniestroid
                                from    RGN_AJUSTE
                                where   ajusteid = @ajusteid
                              )

        update  RGN_POLIZA_AJUSTE
        set     ajusteid = @ajusteid,
                numsiniestro = @numeroSiniestroCia,
                fupdate = getdate()
        where   ajusteid = @ajusteid
                and polizaid = @polizaid
                and aseguradoraid = @aseguradoraid

--insertando datos de la inspeccion

        update  RGN_ACTIVIDAD
        set     FechaHoraCoordinacion = @fechahoracoordinacion,
                lugardeReunion = @lugareunion,
                referencia = @referencia,
                personacontacto = @personacontacto,
                FechaHoraReunion = @FechaHoraReunion,
                ubigeoID = @ubigeoidInspeccion,
                telefonoPersonaContacto = @telefonoPersonaContacto,
                tipoactividadId = ''5'',
                fupdate = getdate()
        where   ajusteid = @ajusteid

        if @@ROWCOUNT = 0 
            BEGIN 
                insert  into RGN_ACTIVIDAD
                        (
                          FechaHoraCoordinacion,
                          lugardeReunion,
                          referencia,
                          personacontacto,
                          FechaHoraReunion,
                          ubigeoID,
                          telefonoPersonaContacto,
                          tipoactividadId,
                          fupdate,
                          ajusteId
                        )
                values  (
                          @FechaHoraCoordinacion,
                          @lugareunion,
                          @referencia,
                          @personacontacto,
                          @FechaHoraReunion,
                          @ubigeoidInspeccion,
                          @telefonoPersonaContacto,
                          ''5'',
                          getdate(),
                          @ajusteId  
                        )
            END

--NOTA EL MANEJO DE LOS CAMBIOS DE ESTADO SE HACE AHORA VIA 
--LA APLICACIÓN DESPUÉS DE CADA ACTUALIZACIÓN
--insertando estados

--IF (@FechaHoraCoordinacion is NULL OR @FechaHoraReunion is NULL) set @estadoajusteid=13
--ELSE set @estadoajusteid=14
--exec sp_rgen_actualizaEstadoAjuste @ajusteid, @estadoAjusteId,''''


    END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EliminarAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_EliminarAjuste]
(
	@fEliminacion datetime,
	@motivo varchar(250),
	@ajusteId numeric (8,0)

	
)
AS
	SET NOCOUNT OFF;

UPDATE RGN_AJUSTE SET 
	situacionAjustelistados = @motivo, 
	fUpdate = @fEliminacion,
	estado=''I''
	
WHERE ((ajusteId = @ajusteId));' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteSelectbyId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[sp_rgen_AjusteSelectbyId]
(
	@ajusteId numeric(8,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[ajusteId],
		[quienNotifico],
		[NombreDelNotificante],
		[faviso],
		[referenciaConAsegurado],
		[descripcionRiesgo],
		[brokerId],
		[observaciones],
		[ajustadorId],
		[numAjustePASA],
		[numAjusteAseguradora],
		[estado],
		[tajusteid],
		[causasiniestro],
		[detalleocurrencia],
		[situacionajuste],
		[verificaciongarantias],
		[siniestrosanteriores],
		[salvamentoyrecupero],
		[recomendaciones],
		[siniestroid],
		[fultimocambio],
		[numeroSiniestroBroker],
		[NombreQuienConfirma],
		[FechayHoraConfirmacion],
		[numeroSiniestroCia],
		[investigaciones],
		[TotalDeducible],
		[TotalIndenmizacion],
		[medioDeNotificacionId],
		[medioConfirmacion]
	FROM [RGN_AJUSTE]
	WHERE
		([ajusteId] = @ajusteId)

	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ocurrencia_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_Ocurrencia_update](
 @tiposiniestroid numeric(8,0), 
 @fsiniestro datetime, 
 @lugarsiniestro varchar(250), 
 @ubigeosiniestro varchar(100), 
 @ubigeoid varchar(6),
 @detalle text, 
 @causas text, 
 @investigaciones text, 
 @siniestroid numeric(8,0),
 @ajusteid numeric(8,0)
)
as

BEGIN 

update   RGN_SINIESTRO set RGN_SINIESTRO.tiposiniestroid=@tiposiniestroid
where     dbo.RGN_SINIESTRO.siniestroid = @siniestroid 


update dbo.RGN_SINIESTRO set dbo.RGN_SINIESTRO.fsiniestro=@fsiniestro
where  dbo.RGN_SINIESTRO.siniestroid = @siniestroid 

update dbo.RGN_SINIESTRO set dbo.RGN_SINIESTRO.lugarSiniestro=@lugarsiniestro
where  dbo.RGN_SINIESTRO.siniestroid = @siniestroid 


update dbo.RGN_SINIESTRO  set dbo.RGN_SINIESTRO.ubigeoId=@ubigeoid
where  dbo.RGN_SINIESTRO.siniestroid = @siniestroid 

update  dbo.RGN_AJUSTE set causasiniestro=@causas  where dbo.RGN_AJUSTE.ajusteid=@ajusteid
update  dbo.RGN_AJUSTE set detalleocurrencia= @detalle where dbo.RGN_AJUSTE.ajusteid=@ajusteid

update  dbo.RGN_AJUSTE set investigaciones=@investigaciones  where dbo.RGN_AJUSTE.ajusteid=@ajusteid


END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ObservacionInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ObservacionInsert]
(
	@ajusteId numeric(8,0),
	@observacion varchar(250)

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	Update RGN_AJUSTE set situacionajustelistados=@observacion	
	where ajusteid=@ajusteid


	SET @Err = @@Error

	

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AjusteInsert]
(
	@ajusteId numeric(8,0) = NULL output,
	@quienNotifico varchar(250) = NULL,
	@NombreDelNotificante varchar(250) = NULL,
	@faviso datetime = NULL,
	@referenciaConAsegurado varchar(250) = NULL,
	@descripcionRiesgo varchar(2500) = NULL,
	@brokerId numeric(8,0) = NULL,
	@observaciones varchar(2500) = NULL,
	@ajustadorId numeric(8,0) = NULL,
	@numAjustePASA varchar(20) = NULL,
	@numAjusteAseguradora varchar(20) = NULL,
	@estado varchar(1) = NULL,
	@tajusteid numeric(8,0),
	@causasiniestro text=NULL,
	@detalleocurrencia text = NULL,
	@situacionajuste text = NULL,
	@verificaciongarantias text = NULL,
	@siniestrosanteriores text = NULL,
	@salvamentoyrecupero text = NULL,
	@recomendaciones text = NULL,
	@siniestroid numeric(8,0) = NULL,
	@fultimocambio datetime = NULL,
	@numeroSiniestroBroker varchar(20) = NULL,
	@NombreQuienConfirma varchar(250) = NULL,
	@FechayHoraConfirmacion datetime = NULL,
	@numeroSiniestroCia varchar(100) = NULL,
	@informacionPolicial varchar(1000) = NULL,
	@TotalDeducible numeric(14,2) = NULL,
	@TotalIndenmizacion numeric(14,2) = NULL,
	@medioDeNotificacionId numeric(8,0) = NULL,
	@medioConfirmacionId numeric(8,0) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [RGN_AJUSTE]
	(
		[quienNotifico],
		[NombreDelNotificante],
		[faviso],
		[referenciaConAsegurado],
		[descripcionRiesgo],
		[brokerId],
		[observaciones],
		[ajustadorId],
		[numAjustePASA],
		[numAjusteAseguradora],
		[estado],
		[tajusteid],
		[causasiniestro],
		[detalleocurrencia],
		[situacionajuste],
		[verificaciongarantias],
		[siniestrosanteriores],
		[salvamentoyrecupero],
		[recomendaciones],
		[siniestroid],
		[fultimocambio],
		[numeroSiniestroBroker],
		[NombreQuienConfirma],
		[FechayHoraConfirmacion],
		[numeroSiniestroCia],
		[investigaciones],
		[TotalDeducible],
		[TotalIndenmizacion],
		[medioDeNotificacionId],
		[medioConfirmacion]
	)
	VALUES
	(
		@quienNotifico,
		@NombreDelNotificante,
		@faviso,
		@referenciaConAsegurado,
		@descripcionRiesgo,
		@brokerId,
		@observaciones,
		@ajustadorId,
		@numAjustePASA,
		@numAjusteAseguradora,
		@estado,
		@tajusteid,
		@causasiniestro,
		@detalleocurrencia,
		@situacionajuste,
		@verificaciongarantias,
		@siniestrosanteriores,
		@salvamentoyrecupero,
		@recomendaciones,
		@siniestroid,
		@fultimocambio,
		@numeroSiniestroBroker,
		@NombreQuienConfirma,
		@FechayHoraConfirmacion,
		@numeroSiniestroCia,
		@informacionPolicial,
		@TotalDeducible,
		@TotalIndenmizacion,
		@medioDeNotificacionId,
		@medioConfirmacionId
	)

	SET @Err = @@Error

	SELECT @ajusteId = SCOPE_IDENTITY()

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_AjusteDelete]
(
	@ajusteId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [RGN_AJUSTE]
	WHERE
		[ajusteId] = @ajusteId
	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformacionComplementariaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformacionComplementariaUpdate]
(
	@ajusteId numeric(8, 0),-- ajuste
--	@detalleocurrencia varchar(2500),
--	@causasiniestro varchar(2500),
--	@investigaciones varchar(2500),
	
	@reserva varchar(9),
	@monedareserva numeric(5,0),
	@situacionajuste text,
	@verificaciongarantias text,
	@siniestrosanteriores text,
	@salvamentoyrecupero	text,
	@opinionAjustador text,
	@recomendaciones text


	

	--@reclamo varchar(90),
	--@monedareclamo numeric(5,0)


)
AS
--	declare @cambioreclamo numeric(9,0)
	declare @cambioreserva numeric(9,0)
	DECLARE @Err int

	SET NOCOUNT OFF;
	UPDATE [RGN_AJUSTE] 
	SET 	
--                [detalleocurrencia]=@detalleocurrencia,
--		[causasiniestro]=@causasiniestro,
--		[investigaciones]=@investigaciones,
		[situacionajuste]=@situacionajuste,
		[verificaciongarantias]=@verificaciongarantias,
		[siniestrosanteriores]=@siniestrosanteriores,
		[salvamentoyrecupero]=@salvamentoyrecupero,
		[opinionAjustador]=@opinionAjustador,
		[recomendaciones]=@recomendaciones

	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)
	


--	select @cambioreclamo=factor
--	from 	adm_TipoCambio
--	where monedaId= @monedareclamo and tipoCambioId=(select max(tipoCambioId)from adm_tipoCambio where monedaId=@monedareclamo)
	

	select @cambioreserva=factor
	from 	adm_TipoCambio
	where monedaId= @monedareserva and tipoCambioId=(select max(tipoCambioId)from adm_tipoCambio where monedaId=@monedareserva)
	
	INSERT
	INTO [RGN_RESERVA]
	(
		[ajusteId],
		[monto],
		[montosoles],
		[tipoCambio],
		[monedaId],
		[fecha],
		[fcrea],
		[fupdate],
		[estado],
		[ucrea],
		[uupdate]	
		
	)
	VALUES
	(
		@ajusteId,
		Convert(numeric(14,2),@reserva),
		Convert(numeric(14,2),@reserva)*@cambioreserva,
		@cambioreserva,
		@monedareserva,
		getDate(),
		getDate(),
		getDate(),
		''A'',
		''dbo'',
		''dbo''
	)


--	INSERT
--	INTO [RGN_RECLAMO]
--	(
	--	[ajusteId],
		--[monto],
		--[montosoles],
		--[tipoCambio],
		--[monedaId]
		
	--)
	--VALUES
	--(
	--	@ajusteId,
	--	Convert(numeric(9,0),@reclamo),
	--	Convert(numeric(9,0),@reclamo)*@cambioreclamo,
	--	@cambioreclamo,
	--	@monedareclamo		
	--)

	SET @Err = @@Error

	RETURN @Err





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_getNumeroAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_getNumeroAjuste](@ajusteId numeric(8,0)) 
as
begin
	select numAjustePASA as numeroAjuste from RGN_AJUSTE where ajusteId = @ajusteId
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delainspeccionUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delainspeccionUpdate](
	@ajusteId numeric(8,0),
	@descripcionRiesgo text,
	@actividadId numeric(8,0),
	@PersonaEntrevistada varchar(1000),
	@lugarDeReunion varchar(1000),
	@ubigeoId varchar(20),
	@Distrito varchar(500)
)

as

update RGN_ACTIVIDAD 
	set 
	PersonaEntrevistada = @PersonaEntrevistada,
	lugarDeReunion = @lugarDeReunion,
	ubigeoId = @ubigeoId
where 	actividadId = @actividadId

update RGN_AJUSTE
	set 
	descripcionRiesgo = @descripcionRiesgo 
	where ajusteId = @ajusteId
	

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_FechaHoraCoordinacion_select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_FechaHoraCoordinacion_select](@ajusteid numeric(8,0))
as

declare @faviso datetime
declare @quienNotifico varchar(250)
declare @mediodeNotificacion varchar(100)
declare @FechaHoraCoordinacion datetime
declare @Quiencoordino varchar (250)
declare @cargocontacto varchar(250)
declare @finspeccion datetime


BEGIN

select @faviso=faviso,
	   @quienNotifico=quienNotifico
FROM  dbo.RGN_AJUSTE where ajusteid=@ajusteid


select  @mediodeNotificacion=dbo.RGN_TIPOCOMUNICACION.nombre
FROM         dbo.RGN_AJUSTE INNER JOIN
             dbo.RGN_TIPOCOMUNICACION ON dbo.RGN_AJUSTE.medioConfirmacion = dbo.RGN_TIPOCOMUNICACION.tcomunicacionId AND 
             dbo.RGN_AJUSTE.medioDeNotificacionId = dbo.RGN_TIPOCOMUNICACION.tcomunicacionId
where dbo.RGN_AJUSTE.ajusteid=@ajusteid


SELECT   @FechaHoraCoordinacion= dbo.RGN_ACTIVIDAD.FechaHoraCoordinacion,
		@QuienCoordino=dbo.RGN_ACTIVIDAD.personaContacto,
		@cargocontacto=dbo.RGN_ACTIVIDAD.CargoPersonaContacto,
		@finspeccion=dbo.RGN_ACTIVIDAD.FechaHoraReunion
FROM         dbo.RGN_AJUSTE INNER JOIN
             dbo.RGN_ACTIVIDAD ON dbo.RGN_AJUSTE.ajusteId = dbo.RGN_ACTIVIDAD.ajusteId
where dbo.RGN_AJUSTE.ajusteid=@ajusteid and dbo.RGN_ACTIVIDAD.tipoactividadID=5


select @faviso as faviso,
 @quienNotifico as quienNotifico,
 @mediodeNotificacion as MediodeNotificacion,
 @FechaHoraCoordinacion as FechaHoraCoordinacion,
 @Quiencoordino as QuienCoordino, 
 @cargocontacto as cargocontacto, 
 @finspeccion as finspeccion, 
 @ajusteid as ajusteid

END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_informebasicoReclamoRimacUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[proc_informebasicoReclamoRimacUpdate]
(
	@ajusteId numeric(8, 0),
	@reservaMonedaId numeric(8, 0),
	@reserva varchar(9),
	@monedareserva varchar(10),
	@situacionajuste text,
	@notas text,
    @reclamo varchar(9),
	@reclamoMonedaId numeric(8,0),
	@monedareclamo varchar(10),
	@enviarNumSiniestro tinyint,
	@enviarCopiaPoliza tinyint


)
AS
BEGIN
	declare @cambioreclamo numeric(9,0)
	declare @cambioreserva numeric(9,0)
	DECLARE @Err int

	SET NOCOUNT OFF;
	UPDATE [RGN_AJUSTE] 
	SET 	
		[situacionajuste]=@situacionajuste,
		[notas]=@notas,
		[enviarCopiaPoliza]=@enviarCopiaPoliza,
		[enviarNumSiniestro]=@enviarNumSiniestro
		

	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)
	


	select @cambioreclamo=factor
	from 	adm_TipoCambio
	where monedaId= @reclamoMonedaId and tipoCambioId=(select max(tipoCambioId)from adm_tipoCambio where monedaId=@reclamoMonedaId)
	

	select @cambioreserva=factor
	from 	adm_TipoCambio
	where monedaId= @reservaMonedaId and tipoCambioId=(select max(tipoCambioId)from adm_tipoCambio where monedaId=@reservaMonedaId)
	
	INSERT
	INTO [RGN_RESERVA]
	(
		[ajusteId],
		[monto],
		[montosoles],
		[tipoCambio],
		[monedaId],
		[fecha],
		[fcrea],
		[fupdate],
		[estado],
		[ucrea],
		[uupdate]	
		
	)
	VALUES
	(
		@ajusteId,
		Convert(numeric(14,2),@reserva),
		Convert(numeric(14,2),@reserva)*@cambioreserva,
		@cambioreserva,
		@reservaMonedaId,
		getDate(),
		getDate(),
		getDate(),
		''A'',
		''dbo'',
		''dbo''
	)


	INSERT
	INTO [RGN_RECLAMO]
	(
	    [ajusteId],
		[monto],
		[montosoles],
		[tipoCambio],
		[monedaId]
		
	)
	VALUES
	(
		@ajusteId,
		Convert(numeric(9,0),@reclamo),
		Convert(numeric(9,0),@reclamo)*@cambioreclamo,
		@cambioreclamo,
		@reclamoMonedaId		
	)

	SET @Err = @@Error

	RETURN @Err
END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_updateUbigeo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[sp_updateUbigeo] as

update adm_direccionpersona set ubigeoid = ''20201'' where ubigeoId = ''20201''
update adm_direccionpersona set ubigeoid = ''20201'' where ubigeoId = ''20201''
update adm_direccionpersona set ubigeoid = ''20201'' where ubigeoId = ''20201''
update adm_direccionpersona set ubigeoid = ''40101'' where ubigeoId = ''40101''
update adm_direccionpersona set ubigeoid = ''40101'' where ubigeoId = ''40101''
update adm_direccionpersona set ubigeoid = ''40101'' where ubigeoId = ''40101''
update adm_direccionpersona set ubigeoid = ''150103'' where ubigeoId = ''150103''
update adm_direccionpersona set ubigeoid = ''150103'' where ubigeoId = ''150103''
update adm_direccionpersona set ubigeoid = ''150103'' where ubigeoId = ''150103''
update adm_direccionpersona set ubigeoid = ''50101'' where ubigeoId = ''50101''
update adm_direccionpersona set ubigeoid = ''50101'' where ubigeoId = ''50101''
update adm_direccionpersona set ubigeoid = ''50101'' where ubigeoId = ''50101''
update adm_direccionpersona set ubigeoid = ''10701'' where ubigeoId = ''10701''
update adm_direccionpersona set ubigeoid = ''150104'' where ubigeoId = ''150119''
update adm_direccionpersona set ubigeoid = ''70102'' where ubigeoId = ''70102''
update adm_direccionpersona set ubigeoid = ''70102'' where ubigeoId = ''70102''
update adm_direccionpersona set ubigeoid = ''60101'' where ubigeoId = ''60101''
update adm_direccionpersona set ubigeoid = ''60101'' where ubigeoId = ''60101''
update adm_direccionpersona set ubigeoid = ''70101'' where ubigeoId = ''70101''
update adm_direccionpersona set ubigeoid = ''70101'' where ubigeoId = ''70101''
update adm_direccionpersona set ubigeoid = ''70101'' where ubigeoId = ''70101''
update adm_direccionpersona set ubigeoid = ''10502'' where ubigeoId = ''10402''
update adm_direccionpersona set ubigeoid = ''10502'' where ubigeoId = ''10402''
update adm_direccionpersona set ubigeoid = ''10502'' where ubigeoId = ''10402''
update adm_direccionpersona set ubigeoid = ''51005'' where ubigeoId = ''50705''
update adm_direccionpersona set ubigeoid = ''51005'' where ubigeoId = ''50705''
update adm_direccionpersona set ubigeoid = ''51005'' where ubigeoId = ''50705''
update adm_direccionpersona set ubigeoid = ''150401''  where ubigeoId = ''150301''
update adm_direccionpersona set ubigeoid = ''150605''  where ubigeoId = ''150505''
update adm_direccionpersona set ubigeoid = ''150605''  where ubigeoId = ''150505''
update adm_direccionpersona set ubigeoid = ''21801'' where ubigeoId = ''21201''
update adm_direccionpersona set ubigeoid = ''21801'' where ubigeoId = ''21201''
update adm_direccionpersona set ubigeoid = ''21801'' where ubigeoId = ''21201''
update adm_direccionpersona set ubigeoid = ''150108'' where ubigeoId = ''150107''
update adm_direccionpersona set ubigeoid = ''150108'' where ubigeoId = ''150107''
update adm_direccionpersona set ubigeoid = ''21803'' where ubigeoId = ''21203''
update adm_direccionpersona set ubigeoid = ''21803'' where ubigeoId = ''21203''
update adm_direccionpersona set ubigeoid = ''21803'' where ubigeoId = ''21203''
update adm_direccionpersona set ubigeoid = ''80101'' where ubigeoId = ''80101''
update adm_direccionpersona set ubigeoid = ''80101'' where ubigeoId = ''80101''
update adm_direccionpersona set ubigeoid = ''150111''  where ubigeoId = ''150136''
update adm_direccionpersona set ubigeoid = ''150111''  where ubigeoId = ''150136''
update adm_direccionpersona set ubigeoid = ''90101'' where ubigeoId = ''90101''
update adm_direccionpersona set ubigeoid = ''90101'' where ubigeoId = ''90101''
update adm_direccionpersona set ubigeoid = ''150601''  where ubigeoId = ''150501''
update adm_direccionpersona set ubigeoid = ''150601''  where ubigeoId = ''150501''
update adm_direccionpersona set ubigeoid = ''150601''  where ubigeoId = ''150501''
update adm_direccionpersona set ubigeoid = ''20101'' where ubigeoId = ''20101''
update adm_direccionpersona set ubigeoid = ''20101'' where ubigeoId = ''20101''
update adm_direccionpersona set ubigeoid = ''190104''  where ubigeoId = ''190104''
update adm_direccionpersona set ubigeoid = ''190104''  where ubigeoId = ''190104''
update adm_direccionpersona set ubigeoid = ''190104''  where ubigeoId = ''190104''
update adm_direccionpersona set ubigeoid = ''80903'' where ubigeoId = ''80903''
update adm_direccionpersona set ubigeoid = ''80903'' where ubigeoId = ''80903''
update adm_direccionpersona set ubigeoid = ''110101'' where ubigeoId = ''110101''
update adm_direccionpersona set ubigeoid = ''110101'' where ubigeoId = ''110101''
update adm_direccionpersona set ubigeoid = ''180301'' where ubigeoId = ''180301''
update adm_direccionpersona set ubigeoid = ''180301'' where ubigeoId = ''180301''
update adm_direccionpersona set ubigeoid = ''180301'' where ubigeoId = ''180301''
update adm_direccionpersona set ubigeoid = ''150113'' where ubigeoId = ''150133''
update adm_direccionpersona set ubigeoid = ''150113'' where ubigeoId = ''150133''
update adm_direccionpersona set ubigeoid = ''150113'' where ubigeoId = ''150133''
update adm_direccionpersona set ubigeoid = ''130105'' where ubigeoId = ''130105''
update adm_direccionpersona set ubigeoid = ''130105'' where ubigeoId = ''130105''
update adm_direccionpersona set ubigeoid = ''150114''  where ubigeoId = ''150131''
update adm_direccionpersona set ubigeoid = ''150114''  where ubigeoId = ''150131''
update adm_direccionpersona set ubigeoid = ''150114''  where ubigeoId = ''150131''
update adm_direccionpersona set ubigeoid = ''150115'' where ubigeoId = ''150108''
update adm_direccionpersona set ubigeoid = ''150115'' where ubigeoId = ''150108''
update adm_direccionpersona set ubigeoid = ''150115'' where ubigeoId = ''150108''
update adm_direccionpersona set ubigeoid = ''140301'' where ubigeoId = ''140201''
update adm_direccionpersona set ubigeoid = ''140301'' where ubigeoId = ''140201''
update adm_direccionpersona set ubigeoid = ''140301'' where ubigeoId = ''140201''
update adm_direccionpersona set ubigeoid = ''150101'' where ubigeoId = ''150101''
update adm_direccionpersona set ubigeoid = ''150101'' where ubigeoId = ''150101''
update adm_direccionpersona set ubigeoid = ''150101'' where ubigeoId = ''150101''
update adm_direccionpersona set ubigeoid = ''150116''  where ubigeoId = ''150109''
update adm_direccionpersona set ubigeoid = ''150117''  where ubigeoId = ''150142''
update adm_direccionpersona set ubigeoid = ''150117''  where ubigeoId = ''150142''
update adm_direccionpersona set ubigeoid = ''150117''  where ubigeoId = ''150142''
update adm_direccionpersona set ubigeoid = ''200705''  where ubigeoId = ''200705''
update adm_direccionpersona set ubigeoid = ''200705''  where ubigeoId = ''200705''
update adm_direccionpersona set ubigeoid = ''150119'' where ubigeoId = ''150111''
update adm_direccionpersona set ubigeoid = ''150119'' where ubigeoId = ''150111''
update adm_direccionpersona set ubigeoid = ''150119'' where ubigeoId = ''150111''
update adm_direccionpersona set ubigeoid = ''150509''  where ubigeoId = ''150409''
update adm_direccionpersona set ubigeoid = ''150509''  where ubigeoId = ''150409''
update adm_direccionpersona set ubigeoid = ''150509''  where ubigeoId = ''150409''
update adm_direccionpersona set ubigeoid = ''150122'' where ubigeoId = ''150114''
update adm_direccionpersona set ubigeoid = ''150122'' where ubigeoId = ''150114''
update adm_direccionpersona set ubigeoid = ''150122'' where ubigeoId = ''150114''
update adm_direccionpersona set ubigeoid = ''140108'' where ubigeoId = ''140108''
update adm_direccionpersona set ubigeoid = ''140108'' where ubigeoId = ''140108''
update adm_direccionpersona set ubigeoid = ''180101''  where ubigeoId = ''180101''
update adm_direccionpersona set ubigeoid = ''180101''  where ubigeoId = ''180101''
update adm_direccionpersona set ubigeoid = ''210705''  where ubigeoId = ''210605''
update adm_direccionpersona set ubigeoid = ''210705''  where ubigeoId = ''210605''
update adm_direccionpersona set ubigeoid = ''81306'' where ubigeoId = ''81306''
update adm_direccionpersona set ubigeoid = ''81306'' where ubigeoId = ''81306''
update adm_direccionpersona set ubigeoid = ''150906''  where ubigeoId = ''151006''
update adm_direccionpersona set ubigeoid = ''150906''  where ubigeoId = ''151006''
update adm_direccionpersona set ubigeoid = ''150906''  where ubigeoId = ''151006''
update adm_direccionpersona set ubigeoid = ''150202''  where ubigeoId = ''150902''
update adm_direccionpersona set ubigeoid = ''120303'' where ubigeoId = ''120803''
update adm_direccionpersona set ubigeoid = ''120303'' where ubigeoId = ''120803''
update adm_direccionpersona set ubigeoid = ''110501'' where ubigeoId = ''110401''
update adm_direccionpersona set ubigeoid = ''110501'' where ubigeoId = ''110401''
update adm_direccionpersona set ubigeoid = ''110501'' where ubigeoId = ''110401''
update adm_direccionpersona set ubigeoid = ''200101''  where ubigeoId = ''200101''
update adm_direccionpersona set ubigeoid = ''200101''  where ubigeoId = ''200101''
update adm_direccionpersona set ubigeoid = ''200101''  where ubigeoId = ''200101''
update adm_direccionpersona set ubigeoid = ''140118'' where ubigeoId = ''140118''
update adm_direccionpersona set ubigeoid = ''140118'' where ubigeoId = ''140118''
update adm_direccionpersona set ubigeoid = ''210101''  where ubigeoId = ''210101''
update adm_direccionpersona set ubigeoid = ''210101''  where ubigeoId = ''210101''
update adm_direccionpersona set ubigeoid = ''210101''  where ubigeoId = ''210101''
update adm_direccionpersona set ubigeoid = ''131006'' where ubigeoId = ''130706''
update adm_direccionpersona set ubigeoid = ''131006'' where ubigeoId = ''130706''
update adm_direccionpersona set ubigeoid = ''131006'' where ubigeoId = ''130706''
update adm_direccionpersona set ubigeoid = ''130206'' where ubigeoId = ''132006''
update adm_direccionpersona set ubigeoid = ''130206'' where ubigeoId = ''132006''
update adm_direccionpersona set ubigeoid = ''130206'' where ubigeoId = ''132006''
update adm_direccionpersona set ubigeoid = ''021701''  where ubigeoId = ''21101''
update adm_direccionpersona set ubigeoid = ''150128''  where ubigeoId = ''150117''
update adm_direccionpersona set ubigeoid = ''150128''  where ubigeoId = ''150117''
update adm_direccionpersona set ubigeoid = ''110506'' where ubigeoId = ''110406''
update adm_direccionpersona set ubigeoid = ''110506'' where ubigeoId = ''110406''
update adm_direccionpersona set ubigeoid = ''150130''  where ubigeoId = ''150140''
update adm_direccionpersona set ubigeoid = ''150130''  where ubigeoId = ''150140''
update adm_direccionpersona set ubigeoid = ''150130''  where ubigeoId = ''150140''
update adm_direccionpersona set ubigeoid = ''150131''  where ubigeoId = ''150118''
update adm_direccionpersona set ubigeoid = ''150131''  where ubigeoId = ''150118''
update adm_direccionpersona set ubigeoid = ''150131''  where ubigeoId = ''150118''
update adm_direccionpersona set ubigeoid = ''150133''  where ubigeoId = ''150135''
update adm_direccionpersona set ubigeoid = ''150133''  where ubigeoId = ''150135''
update adm_direccionpersona set ubigeoid = ''150133''  where ubigeoId = ''150135''
update adm_direccionpersona set ubigeoid = ''150135''  where ubigeoId = ''150123''
update adm_direccionpersona set ubigeoid = ''150135''  where ubigeoId = ''150123''
update adm_direccionpersona set ubigeoid = ''150135''  where ubigeoId = ''150123''
update adm_direccionpersona set ubigeoid = ''150136''  where ubigeoId = ''150120''
update adm_direccionpersona set ubigeoid = ''150136''  where ubigeoId = ''150120''
update adm_direccionpersona set ubigeoid = ''150136''  where ubigeoId = ''150120''
update adm_direccionpersona set ubigeoid = ''150501''  where ubigeoId = ''150401''
update adm_direccionpersona set ubigeoid = ''150501''  where ubigeoId = ''150401''
update adm_direccionpersona set ubigeoid = ''150137''  where ubigeoId = ''150143''
update adm_direccionpersona set ubigeoid = ''150137''  where ubigeoId = ''150143''
update adm_direccionpersona set ubigeoid = ''150137''  where ubigeoId = ''150143''
update adm_direccionpersona set ubigeoid = ''150140''  where ubigeoId = ''150121''
update adm_direccionpersona set ubigeoid = ''150140''  where ubigeoId = ''150121''
update adm_direccionpersona set ubigeoid = ''150140''  where ubigeoId = ''150121''
update adm_direccionpersona set ubigeoid = ''230101''  where ubigeoId = ''230101''
update adm_direccionpersona set ubigeoid = ''230101''  where ubigeoId = ''230101''
update adm_direccionpersona set ubigeoid = ''220901''  where ubigeoId = ''220601''
update adm_direccionpersona set ubigeoid = ''220901''  where ubigeoId = ''220601''
update adm_direccionpersona set ubigeoid = ''220901''  where ubigeoId = ''220601''
update adm_direccionpersona set ubigeoid = ''130101'' where ubigeoId = ''130101''
update adm_direccionpersona set ubigeoid = ''130101'' where ubigeoId = ''130101''
update adm_direccionpersona set ubigeoid = ''130101'' where ubigeoId = ''130101''
update adm_direccionpersona set ubigeoid = ''150142''  where ubigeoId = ''150141''
update adm_direccionpersona set ubigeoid = ''150142''  where ubigeoId = ''150141''
update adm_direccionpersona set ubigeoid = ''150142''  where ubigeoId = ''150141''
update adm_direccionpersona set ubigeoid = ''150143''  where ubigeoId = ''150129''
update adm_direccionpersona set ubigeoid = ''150143''  where ubigeoId = ''150129''
update adm_direccionpersona set ubigeoid = ''80108'' where ubigeoId = ''80108''
update adm_direccionpersona set ubigeoid = ''80108'' where ubigeoId = ''80108''
update adm_direccionpersona set ubigeoid = ''250105''  where ubigeoId = ''250105''
update adm_direccionpersona set ubigeoid = ''250105''  where ubigeoId = ''250105''
update adm_direccionpersona set ubigeoid = ''250105''  where ubigeoId = ''250105''
update adm_direccionpersona set ubigeoid = ''120810'' where ubigeoId = ''120510''
update adm_direccionpersona set ubigeoid = ''120810'' where ubigeoId = ''120510''



update RGN_ACTIVIDAD set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_ACTIVIDAD set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_ACTIVIDAD set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_ACTIVIDAD set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_ACTIVIDAD set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_ACTIVIDAD set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_ACTIVIDAD set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_ACTIVIDAD set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_ACTIVIDAD set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_ACTIVIDAD set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_ACTIVIDAD set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_ACTIVIDAD set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_ACTIVIDAD set ubigeoid = ''10701'' where ubigeoId = ''10701''
update RGN_ACTIVIDAD set ubigeoid = ''150104'' where ubigeoId = ''150119''
update RGN_ACTIVIDAD set ubigeoid = ''70102'' where ubigeoId = ''70102''
update RGN_ACTIVIDAD set ubigeoid = ''70102'' where ubigeoId = ''70102''
update RGN_ACTIVIDAD set ubigeoid = ''60101'' where ubigeoId = ''60101''
update RGN_ACTIVIDAD set ubigeoid = ''60101'' where ubigeoId = ''60101''
update RGN_ACTIVIDAD set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_ACTIVIDAD set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_ACTIVIDAD set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_ACTIVIDAD set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_ACTIVIDAD set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_ACTIVIDAD set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_ACTIVIDAD set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_ACTIVIDAD set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_ACTIVIDAD set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_ACTIVIDAD set ubigeoid = ''150401'' where ubigeoId = ''150301''
update RGN_ACTIVIDAD set ubigeoid = ''150605'' where ubigeoId = ''150505''
update RGN_ACTIVIDAD set ubigeoid = ''150605'' where ubigeoId = ''150505''
update RGN_ACTIVIDAD set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_ACTIVIDAD set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_ACTIVIDAD set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_ACTIVIDAD set ubigeoid = ''150108'' where ubigeoId = ''150107''
update RGN_ACTIVIDAD set ubigeoid = ''150108'' where ubigeoId = ''150107''
update RGN_ACTIVIDAD set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_ACTIVIDAD set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_ACTIVIDAD set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_ACTIVIDAD set ubigeoid = ''80101'' where ubigeoId = ''80101''
update RGN_ACTIVIDAD set ubigeoid = ''80101'' where ubigeoId = ''80101''
update RGN_ACTIVIDAD set ubigeoid = ''150111''  where ubigeoId = ''150136''
update RGN_ACTIVIDAD set ubigeoid = ''150111''  where ubigeoId = ''150136''
update RGN_ACTIVIDAD set ubigeoid = ''90101'' where ubigeoId = ''90101''
update RGN_ACTIVIDAD set ubigeoid = ''90101'' where ubigeoId = ''90101''
update RGN_ACTIVIDAD set ubigeoid = ''150601'' where ubigeoId = ''150501''
update RGN_ACTIVIDAD set ubigeoid = ''150601'' where ubigeoId = ''150501''
update RGN_ACTIVIDAD set ubigeoid = ''150601'' where ubigeoId = ''150501''
update RGN_ACTIVIDAD set ubigeoid = ''20101'' where ubigeoId = ''20101''
update RGN_ACTIVIDAD set ubigeoid = ''20101'' where ubigeoId = ''20101''
update RGN_ACTIVIDAD set ubigeoid = ''190104'' where ubigeoId = ''190104''
update RGN_ACTIVIDAD set ubigeoid = ''190104''  where ubigeoId = ''190104''
update RGN_ACTIVIDAD set ubigeoid = ''190104''  where ubigeoId = ''190104''
update RGN_ACTIVIDAD set ubigeoid = ''80903'' where ubigeoId = ''80903''
update RGN_ACTIVIDAD set ubigeoid = ''80903'' where ubigeoId = ''80903''
update RGN_ACTIVIDAD set ubigeoid = ''110101'' where ubigeoId = ''110101''
update RGN_ACTIVIDAD set ubigeoid = ''110101'' where ubigeoId = ''110101''
update RGN_ACTIVIDAD set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_ACTIVIDAD set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_ACTIVIDAD set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_ACTIVIDAD set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_ACTIVIDAD set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_ACTIVIDAD set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_ACTIVIDAD set ubigeoid = ''130105'' where ubigeoId = ''130105''
update RGN_ACTIVIDAD set ubigeoid = ''130105'' where ubigeoId = ''130105''
update RGN_ACTIVIDAD set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_ACTIVIDAD set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_ACTIVIDAD set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_ACTIVIDAD set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_ACTIVIDAD set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_ACTIVIDAD set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_ACTIVIDAD set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_ACTIVIDAD set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_ACTIVIDAD set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_ACTIVIDAD set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_ACTIVIDAD set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_ACTIVIDAD set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_ACTIVIDAD set ubigeoid = ''150116''  where ubigeoId = ''150109''
update RGN_ACTIVIDAD set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_ACTIVIDAD set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_ACTIVIDAD set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_ACTIVIDAD set ubigeoid = ''200705''  where ubigeoId = ''200705''
update RGN_ACTIVIDAD set ubigeoid = ''200705''  where ubigeoId = ''200705''
update RGN_ACTIVIDAD set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_ACTIVIDAD set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_ACTIVIDAD set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_ACTIVIDAD set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_ACTIVIDAD set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_ACTIVIDAD set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_ACTIVIDAD set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_ACTIVIDAD set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_ACTIVIDAD set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_ACTIVIDAD set ubigeoid = ''140108'' where ubigeoId = ''140108''
update RGN_ACTIVIDAD set ubigeoid = ''140108'' where ubigeoId = ''140108''
update RGN_ACTIVIDAD set ubigeoid = ''180101''  where ubigeoId = ''180101''
update RGN_ACTIVIDAD set ubigeoid = ''180101''  where ubigeoId = ''180101''
update RGN_ACTIVIDAD set ubigeoid = ''210705''  where ubigeoId = ''210605''
update RGN_ACTIVIDAD set ubigeoid = ''210705''  where ubigeoId = ''210605''
update RGN_ACTIVIDAD set ubigeoid = ''81306'' where ubigeoId = ''81306''
update RGN_ACTIVIDAD set ubigeoid = ''81306'' where ubigeoId = ''81306''
update RGN_ACTIVIDAD set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_ACTIVIDAD set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_ACTIVIDAD set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_ACTIVIDAD set ubigeoid = ''150202''  where ubigeoId = ''150902''
update RGN_ACTIVIDAD set ubigeoid = ''120303'' where ubigeoId = ''120803''
update RGN_ACTIVIDAD set ubigeoid = ''120303'' where ubigeoId = ''120803''
update RGN_ACTIVIDAD set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_ACTIVIDAD set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_ACTIVIDAD set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_ACTIVIDAD set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_ACTIVIDAD set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_ACTIVIDAD set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_ACTIVIDAD set ubigeoid = ''140118'' where ubigeoId = ''140118''
update RGN_ACTIVIDAD set ubigeoid = ''140118'' where ubigeoId = ''140118''
update RGN_ACTIVIDAD set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_ACTIVIDAD set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_ACTIVIDAD set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_ACTIVIDAD set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_ACTIVIDAD set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_ACTIVIDAD set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_ACTIVIDAD set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_ACTIVIDAD set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_ACTIVIDAD set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_ACTIVIDAD set ubigeoid = ''021701''  where ubigeoId = ''21101''
update RGN_ACTIVIDAD set ubigeoid = ''150128''  where ubigeoId = ''150117''
update RGN_ACTIVIDAD set ubigeoid = ''150128''  where ubigeoId = ''150117''
update RGN_ACTIVIDAD set ubigeoid = ''110506'' where ubigeoId = ''110406''
update RGN_ACTIVIDAD set ubigeoid = ''110506'' where ubigeoId = ''110406''
update RGN_ACTIVIDAD set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_ACTIVIDAD set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_ACTIVIDAD set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_ACTIVIDAD set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_ACTIVIDAD set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_ACTIVIDAD set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_ACTIVIDAD set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_ACTIVIDAD set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_ACTIVIDAD set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_ACTIVIDAD set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_ACTIVIDAD set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_ACTIVIDAD set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_ACTIVIDAD set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_ACTIVIDAD set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_ACTIVIDAD set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_ACTIVIDAD set ubigeoid = ''150501''  where ubigeoId = ''150401''
update RGN_ACTIVIDAD set ubigeoid = ''150501''  where ubigeoId = ''150401''
update RGN_ACTIVIDAD set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_ACTIVIDAD set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_ACTIVIDAD set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_ACTIVIDAD set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_ACTIVIDAD set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_ACTIVIDAD set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_ACTIVIDAD set ubigeoid = ''230101''  where ubigeoId = ''230101''
update RGN_ACTIVIDAD set ubigeoid = ''230101''  where ubigeoId = ''230101''
update RGN_ACTIVIDAD set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_ACTIVIDAD set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_ACTIVIDAD set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_ACTIVIDAD set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_ACTIVIDAD set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_ACTIVIDAD set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_ACTIVIDAD set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_ACTIVIDAD set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_ACTIVIDAD set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_ACTIVIDAD set ubigeoid = ''150143''  where ubigeoId = ''150129''
update RGN_ACTIVIDAD set ubigeoid = ''150143''  where ubigeoId = ''150129''
update RGN_ACTIVIDAD set ubigeoid = ''80108'' where ubigeoId = ''80108''
update RGN_ACTIVIDAD set ubigeoid = ''80108'' where ubigeoId = ''80108''
update RGN_ACTIVIDAD set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_ACTIVIDAD set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_ACTIVIDAD set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_ACTIVIDAD set ubigeoid = ''120810'' where ubigeoId = ''120510''
update RGN_ACTIVIDAD set ubigeoid = ''120810'' where ubigeoId = ''120510''


update RGN_SINIESTRO set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_SINIESTRO set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_SINIESTRO set ubigeoid = ''20201'' where ubigeoId = ''20201''
update RGN_SINIESTRO set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_SINIESTRO set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_SINIESTRO set ubigeoid = ''40101'' where ubigeoId = ''40101''
update RGN_SINIESTRO set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_SINIESTRO set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_SINIESTRO set ubigeoid = ''150103'' where ubigeoId = ''150103''
update RGN_SINIESTRO set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_SINIESTRO set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_SINIESTRO set ubigeoid = ''50101'' where ubigeoId = ''50101''
update RGN_SINIESTRO set ubigeoid = ''10701'' where ubigeoId = ''10701''
update RGN_SINIESTRO set ubigeoid = ''150104'' where ubigeoId = ''150119''
update RGN_SINIESTRO set ubigeoid = ''70102'' where ubigeoId = ''70102''
update RGN_SINIESTRO set ubigeoid = ''70102'' where ubigeoId = ''70102''
update RGN_SINIESTRO set ubigeoid = ''60101'' where ubigeoId = ''60101''
update RGN_SINIESTRO set ubigeoid = ''60101'' where ubigeoId = ''60101''
update RGN_SINIESTRO set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_SINIESTRO set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_SINIESTRO set ubigeoid = ''70101'' where ubigeoId = ''70101''
update RGN_SINIESTRO set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_SINIESTRO set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_SINIESTRO set ubigeoid = ''10502'' where ubigeoId = ''10402''
update RGN_SINIESTRO set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_SINIESTRO set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_SINIESTRO set ubigeoid = ''51005'' where ubigeoId = ''50705''
update RGN_SINIESTRO set ubigeoid = ''150401''  where ubigeoId = ''150301''
update RGN_SINIESTRO set ubigeoid = ''150605''  where ubigeoId = ''150505''
update RGN_SINIESTRO set ubigeoid = ''150605''  where ubigeoId = ''150505''
update RGN_SINIESTRO set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_SINIESTRO set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_SINIESTRO set ubigeoid = ''21801'' where ubigeoId = ''21201''
update RGN_SINIESTRO set ubigeoid = ''150108'' where ubigeoId = ''150107''
update RGN_SINIESTRO set ubigeoid = ''150108'' where ubigeoId = ''150107''
update RGN_SINIESTRO set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_SINIESTRO set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_SINIESTRO set ubigeoid = ''21803'' where ubigeoId = ''21203''
update RGN_SINIESTRO set ubigeoid = ''80101'' where ubigeoId = ''80101''
update RGN_SINIESTRO set ubigeoid = ''80101'' where ubigeoId = ''80101''
update RGN_SINIESTRO set ubigeoid = ''150111''  where ubigeoId = ''150136''
update RGN_SINIESTRO set ubigeoid = ''150111''  where ubigeoId = ''150136''
update RGN_SINIESTRO set ubigeoid = ''90101'' where ubigeoId = ''90101''
update RGN_SINIESTRO set ubigeoid = ''90101'' where ubigeoId = ''90101''
update RGN_SINIESTRO set ubigeoid = ''150601''  where ubigeoId = ''150501''
update RGN_SINIESTRO set ubigeoid = ''150601''  where ubigeoId = ''150501''
update RGN_SINIESTRO set ubigeoid = ''150601''  where ubigeoId = ''150501''
update RGN_SINIESTRO set ubigeoid = ''20101'' where ubigeoId = ''20101''
update RGN_SINIESTRO set ubigeoid = ''20101'' where ubigeoId = ''20101''
update RGN_SINIESTRO set ubigeoid = ''190104''  where ubigeoId = ''190104''
update RGN_SINIESTRO set ubigeoid = ''190104''  where ubigeoId = ''190104''
update RGN_SINIESTRO set ubigeoid = ''190104''  where ubigeoId = ''190104''
update RGN_SINIESTRO set ubigeoid = ''80903'' where ubigeoId = ''80903''
update RGN_SINIESTRO set ubigeoid = ''80903'' where ubigeoId = ''80903''
update RGN_SINIESTRO set ubigeoid = ''110101'' where ubigeoId = ''110101''
update RGN_SINIESTRO set ubigeoid = ''110101'' where ubigeoId = ''110101''
update RGN_SINIESTRO set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_SINIESTRO set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_SINIESTRO set ubigeoid = ''180301'' where ubigeoId = ''180301''
update RGN_SINIESTRO set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_SINIESTRO set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_SINIESTRO set ubigeoid = ''150113'' where ubigeoId = ''150133''
update RGN_SINIESTRO set ubigeoid = ''130105'' where ubigeoId = ''130105''
update RGN_SINIESTRO set ubigeoid = ''130105'' where ubigeoId = ''130105''
update RGN_SINIESTRO set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_SINIESTRO set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_SINIESTRO set ubigeoid = ''150114''  where ubigeoId = ''150131''
update RGN_SINIESTRO set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_SINIESTRO set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_SINIESTRO set ubigeoid = ''150115'' where ubigeoId = ''150108''
update RGN_SINIESTRO set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_SINIESTRO set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_SINIESTRO set ubigeoid = ''140301'' where ubigeoId = ''140201''
update RGN_SINIESTRO set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_SINIESTRO set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_SINIESTRO set ubigeoid = ''150101'' where ubigeoId = ''150101''
update RGN_SINIESTRO set ubigeoid = ''150116''  where ubigeoId = ''150109''
update RGN_SINIESTRO set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_SINIESTRO set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_SINIESTRO set ubigeoid = ''150117''  where ubigeoId = ''150142''
update RGN_SINIESTRO set ubigeoid = ''200705''  where ubigeoId = ''200705''
update RGN_SINIESTRO set ubigeoid = ''200705''  where ubigeoId = ''200705''
update RGN_SINIESTRO set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_SINIESTRO set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_SINIESTRO set ubigeoid = ''150119'' where ubigeoId = ''150111''
update RGN_SINIESTRO set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_SINIESTRO set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_SINIESTRO set ubigeoid = ''150509''  where ubigeoId = ''150409''
update RGN_SINIESTRO set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_SINIESTRO set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_SINIESTRO set ubigeoid = ''150122'' where ubigeoId = ''150114''
update RGN_SINIESTRO set ubigeoid = ''140108'' where ubigeoId = ''140108''
update RGN_SINIESTRO set ubigeoid = ''140108'' where ubigeoId = ''140108''
update RGN_SINIESTRO set ubigeoid = ''180101''  where ubigeoId = ''180101''
update RGN_SINIESTRO set ubigeoid = ''180101''  where ubigeoId = ''180101''
update RGN_SINIESTRO set ubigeoid = ''210705''  where ubigeoId = ''210605''
update RGN_SINIESTRO set ubigeoid = ''210705''  where ubigeoId = ''210605''
update RGN_SINIESTRO set ubigeoid = ''81306'' where ubigeoId = ''81306''
update RGN_SINIESTRO set ubigeoid = ''81306'' where ubigeoId = ''81306''
update RGN_SINIESTRO set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_SINIESTRO set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_SINIESTRO set ubigeoid = ''150906''  where ubigeoId = ''151006''
update RGN_SINIESTRO set ubigeoid = ''150202''  where ubigeoId = ''150902''
update RGN_SINIESTRO set ubigeoid = ''120303'' where ubigeoId = ''120803''
update RGN_SINIESTRO set ubigeoid = ''120303'' where ubigeoId = ''120803''
update RGN_SINIESTRO set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_SINIESTRO set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_SINIESTRO set ubigeoid = ''110501'' where ubigeoId = ''110401''
update RGN_SINIESTRO set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_SINIESTRO set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_SINIESTRO set ubigeoid = ''200101''  where ubigeoId = ''200101''
update RGN_SINIESTRO set ubigeoid = ''140118'' where ubigeoId = ''140118''
update RGN_SINIESTRO set ubigeoid = ''140118'' where ubigeoId = ''140118''
update RGN_SINIESTRO set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_SINIESTRO set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_SINIESTRO set ubigeoid = ''210101''  where ubigeoId = ''210101''
update RGN_SINIESTRO set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_SINIESTRO set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_SINIESTRO set ubigeoid = ''131006'' where ubigeoId = ''130706''
update RGN_SINIESTRO set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_SINIESTRO set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_SINIESTRO set ubigeoid = ''130206'' where ubigeoId = ''132006''
update RGN_SINIESTRO set ubigeoid = ''021701''  where ubigeoId = ''21101''
update RGN_SINIESTRO set ubigeoid = ''150128''  where ubigeoId = ''150117''
update RGN_SINIESTRO set ubigeoid = ''150128''  where ubigeoId = ''150117''
update RGN_SINIESTRO set ubigeoid = ''110506'' where ubigeoId = ''110406''
update RGN_SINIESTRO set ubigeoid = ''110506'' where ubigeoId = ''110406''
update RGN_SINIESTRO set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_SINIESTRO set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_SINIESTRO set ubigeoid = ''150130''  where ubigeoId = ''150140''
update RGN_SINIESTRO set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_SINIESTRO set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_SINIESTRO set ubigeoid = ''150131''  where ubigeoId = ''150118''
update RGN_SINIESTRO set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_SINIESTRO set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_SINIESTRO set ubigeoid = ''150133''  where ubigeoId = ''150135''
update RGN_SINIESTRO set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_SINIESTRO set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_SINIESTRO set ubigeoid = ''150135''  where ubigeoId = ''150123''
update RGN_SINIESTRO set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_SINIESTRO set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_SINIESTRO set ubigeoid = ''150136''  where ubigeoId = ''150120''
update RGN_SINIESTRO set ubigeoid = ''150501''  where ubigeoId = ''150401''
update RGN_SINIESTRO set ubigeoid = ''150501''  where ubigeoId = ''150401''
update RGN_SINIESTRO set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_SINIESTRO set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_SINIESTRO set ubigeoid = ''150137''  where ubigeoId = ''150143''
update RGN_SINIESTRO set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_SINIESTRO set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_SINIESTRO set ubigeoid = ''150140''  where ubigeoId = ''150121''
update RGN_SINIESTRO set ubigeoid = ''230101''  where ubigeoId = ''230101''
update RGN_SINIESTRO set ubigeoid = ''230101''  where ubigeoId = ''230101''
update RGN_SINIESTRO set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_SINIESTRO set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_SINIESTRO set ubigeoid = ''220901''  where ubigeoId = ''220601''
update RGN_SINIESTRO set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_SINIESTRO set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_SINIESTRO set ubigeoid = ''130101'' where ubigeoId = ''130101''
update RGN_SINIESTRO set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_SINIESTRO set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_SINIESTRO set ubigeoid = ''150142''  where ubigeoId = ''150141''
update RGN_SINIESTRO set ubigeoid = ''150143''  where ubigeoId = ''150129''
update RGN_SINIESTRO set ubigeoid = ''150143''  where ubigeoId = ''150129''
update RGN_SINIESTRO set ubigeoid = ''80108'' where ubigeoId = ''80108''
update RGN_SINIESTRO set ubigeoid = ''80108'' where ubigeoId = ''80108''
update RGN_SINIESTRO set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_SINIESTRO set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_SINIESTRO set ubigeoid = ''250105''  where ubigeoId = ''250105''
update RGN_SINIESTRO set ubigeoid = ''120810'' where ubigeoId = ''120510''
update RGN_SINIESTRO set ubigeoid = ''120810'' where ubigeoId = ''120510''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_RamosSelectByProductoId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgenx_RamosSelectByProductoId] (@productoId numeric(8,0) = null)

as

if (@productoId is null) 
SELECT   distinct  dbo.RGN_RAMO.ramoId, dbo.RGN_RAMO.nombre AS ramo
FROM         dbo.RGN_RAMO INNER JOIN
                      dbo.RGN_PRODUCTOXRAMO ON dbo.RGN_RAMO.ramoId = dbo.RGN_PRODUCTOXRAMO.ramoId
WHERE     (dbo.RGN_RAMO.estado <> ''I'') 
else 
SELECT   distinct  dbo.RGN_RAMO.ramoId, dbo.RGN_RAMO.nombre AS ramo
FROM         dbo.RGN_RAMO INNER JOIN
                      dbo.RGN_PRODUCTOXRAMO ON dbo.RGN_RAMO.ramoId = dbo.RGN_PRODUCTOXRAMO.ramoId
WHERE     (dbo.RGN_RAMO.estado <> ''I'') AND (dbo.RGN_PRODUCTOXRAMO.productoId = @productoId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ramoxProductoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ramoxProductoInsert](
@productoId numeric(8,0),
@ramoId numeric(8,0))

as 

select * from RGN_PRODUCTOXRAMO where productoId = @productoId and ramoId = @ramoId

if (@@rowcount = 0) 
begin
	insert into RGN_PRODUCTOXRAMO 
		(productoId,ramoId) 
	values 
		(@productoId,@ramoId)
end		
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ramosByProductoIdToChk]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ramosByProductoIdToChk]
(@productoId numeric(8,0) = null)
as
SELECT     dbo.RGN_RAMO.nombre, dbo.fn_rgn_toBit(dbo.RGN_PRODUCTOXRAMO.productoId) AS chk, dbo.RGN_RAMO.ramoId
FROM         dbo.RGN_PRODUCTOXRAMO RIGHT OUTER JOIN
                      dbo.RGN_RAMO ON dbo.RGN_PRODUCTOXRAMO.ramoId = dbo.RGN_RAMO.ramoId AND dbo.RGN_PRODUCTOXRAMO.productoId = @productoId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ramoxPRoductoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ramoxPRoductoDelete](
@productoId numeric(8,0),
@ramoId numeric(8,0))

as 

delete from RGN_PRODUCTOXRAMO where productoId = @productoId and ramoId = @ramoId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameTelefonoPrincipalPersona]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameTelefonoPrincipalPersona](@personaid numeric(8,0))
as
begin
	select top 1 tp.telefonoid,tp.telefono,tp.ttelefonoid,tt.nombre from adm_telefonoxpersona tp,adm_ttelefono tt where personaId = @personaid and (tt.ttelefonoid = tp.ttelefonoid)
end



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameTelefonosPersona]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameTelefonosPersona](@personaid numeric(8,0))
as
begin
	select tp.telefonoid,tp.telefono,tp.ttelefonoid,tt.nombre from adm_telefonoxpersona tp,adm_ttelefono tt where personaId = @personaid and (tt.ttelefonoid = tp.ttelefonoid)
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ObtenerTipoCambio]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ObtenerTipoCambio]
(
	@monedaId numeric(8, 0)
)
AS

	SET NOCOUNT ON;
	select factor
	from 	adm_TipoCambio
	where monedaId= @monedaId and tipoCambioId=(select max(tipoCambioId)from adm_tipoCambio where monedaId=@monedaId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_requerimientos_ajuste_select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_requerimientos_ajuste_select]
    (
      @solicitudDocumentosId numeric(8, 0),
      @AjusteId numeric(8, 0)
    )
as 
    begin

        select  RGN_AJUSTE_RGN_REQUERIMIENTO.estado,
                RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId,
                RGN_REQUISITOS.nombre,
                .RGN_AJUSTE_RGN_REQUERIMIENTO.FechaEntrega,
				[RGN_AJUSTE_RGN_REQUERIMIENTO].Orden
        from    RGN_AJUSTE_RGN_REQUERIMIENTO,
                RGN_REQUISITOS
        where   SolicitudDocumentosId = @SolicitudDocumentosId
                and ajusteId = @ajusteId
                and RGN_REQUISITOS.requisitoId = RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId
		ORDER BY [RGN_AJUSTE_RGN_REQUERIMIENTO].orden asc

    end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_elimina_requisitos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_elimina_requisitos] (@requisitoId numeric(8,0))
as

delete from dbo.RGN_AJUSTE_RGN_REQUERIMIENTO where requisitoId = @requisitoId
delete from dbo.RGN_REQUISITO_RIESGO where requisitoId = @requisitoId
delete from RGN_REQUISITOS where requisitoId = @requisitoId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_documentacionsolicitada]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_informebasico_documentacionsolicitada] 
	@ajusteid int
as

SELECT	
	RGN_AJUSTE_RGN_REQUERIMIENTO.ajusteId,
	RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId,
	RGN_REQUISITOS.nombre, 
	RGN_AJUSTE_RGN_REQUERIMIENTO.fcrea
FROM    RGN_AJUSTE_RGN_REQUERIMIENTO INNER JOIN
        RGN_REQUISITOS ON RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId = RGN_REQUISITOS.requisitoId
WHERE  	RGN_AJUSTE_RGN_REQUERIMIENTO.ajusteid = @ajusteid and
       	RGN_AJUSTE_RGN_REQUERIMIENTO.fcrea = (select min(b.fcrea) 
					      from RGN_AJUSTE_RGN_REQUERIMIENTO b, RGN_REQUISITOS c
					      where b.requisitoId = c.requisitoId and
						    b.requisitoId = RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId and
					            b.ajusteid = @ajusteid
						group by b.requisitoId )
		AND (dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.estado = ''N'')


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_documentosDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_documentosDelete]
(
	@requisitoId numeric(8,0),
	@uupdate varchar(20)
)
as 

update RGN_REQUISITOS set 
	estado = ''I'', uupdate = @uupdate, fupdate = getDate()
where requisitoId = @requisitoId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_insertaRequisito]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_insertaRequisito](
@requisitoId numeric(8,0) output,@nombre varchar(1000), @descripcion varchar(1000),@ucrea varchar(20) )
as
	INSERT INTO 
		RGN_REQUISITOS(nombre, descripcion, fcrea, ucrea, estado, fupdate, uupdate) 
	VALUES (@nombre, @descripcion, getDate(), @ucrea,''A'', getDate(), @ucrea)
	
	set @requisitoId = scope_identity();
	
	select @requisitoId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[doInsertUbigeo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE procedure [dbo].[doInsertUbigeo]
as

insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010000'',''AMAZONAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010100'',''CHACHAPOYAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010101'',''CHACHAPOYAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010102'',''ASUNCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010103'',''BALSAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010104'',''CHETO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010105'',''CHILIQUIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010106'',''CHUQUIBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010107'',''GRANADA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010108'',''HUANCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010109'',''LA JALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010110'',''LEIMEBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010111'',''LEVANTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010112'',''MAGDALENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010113'',''MARISCAL CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010114'',''MOLINOPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010115'',''MONTEVIDEO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010116'',''OLLEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010117'',''QUINJALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010118'',''SAN FRANCISCO DE DAGUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010119'',''SAN ISIDRO DE MAINO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010120'',''SOLOCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010121'',''SONCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010200'',''BAGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010201'',''LA PECA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010202'',''ARAMANGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010203'',''COPALLIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010204'',''EL PARCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010205'',''IMAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010300'',''BONGARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010301'',''JUMBILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010302'',''CHISQUILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010303'',''CHURUJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010304'',''COROSHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010305'',''CUISPES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010306'',''FLORIDA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010307'',''JAZAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010308'',''RECTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010309'',''SAN CARLOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010310'',''SHIPASBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010311'',''VALERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010312'',''YAMBRASBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010400'',''CONDORCANQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010401'',''NIEVA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010402'',''EL CENEPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010403'',''RIO SANTIAGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010500'',''LUYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010501'',''LAMUD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010502'',''CAMPORREDONDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010503'',''COCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010504'',''COLCAMAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010505'',''CONILA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010506'',''INGUILPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010507'',''LONGUITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010508'',''LONYA CHICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010509'',''LUYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010510'',''LUYA VIEJO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010511'',''MARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010512'',''OCALLI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010513'',''OCUMAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010514'',''PISUQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010515'',''PROVIDENCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010516'',''SAN CRISTOBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010517'',''SAN FRANCISCO DEL YESO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010518'',''SAN JERONIMO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010519'',''SAN JUAN DE LOPECANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010520'',''SANTA CATALINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010521'',''SANTO TOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010522'',''TINGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010523'',''TRITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010600'',''RODRIGUEZ DE MENDOZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010601'',''SAN NICOLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010602'',''CHIRIMOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010603'',''COCHAMAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010604'',''HUAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010605'',''LIMABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010606'',''LONGAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010607'',''MARISCAL BENAVIDES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010608'',''MILPUC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010609'',''OMIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010610'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010611'',''TOTORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010612'',''VISTA ALEGRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010700'',''UTCUBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010701'',''BAGUA GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010702'',''CAJARURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010703'',''CUMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010704'',''EL MILAGRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010705'',''JAMALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010706'',''LONYA GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''010707'',''YAMON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020000'',''ANCASH'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020100'',''HUARAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020101'',''HUARAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020102'',''COCHABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020103'',''COLCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020104'',''HUANCHAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020105'',''INDEPENDENCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020106'',''JANGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020107'',''LA LIBERTAD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020108'',''OLLEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020109'',''PAMPAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020110'',''PARIACOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020111'',''PIRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020112'',''TARICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020200'',''AIJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020201'',''AIJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020202'',''CORIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020203'',''HUACLLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020204'',''LA MERCED'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020205'',''SUCCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020300'',''ANTONIO RAYMONDI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020301'',''LLAMELLIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020302'',''ACZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020303'',''CHACCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020304'',''CHINGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020305'',''MIRGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020306'',''SAN JUAN DE RONTOY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020400'',''ASUNCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020401'',''CHACAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020402'',''ACOCHACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020500'',''BOLOGNESI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020501'',''CHIQUIAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020502'',''ABELARDO PARDO LEZAMETA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020503'',''ANTONIO RAYMONDI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020504'',''AQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020505'',''CAJACAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020506'',''CANIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020507'',''COLQUIOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020508'',''HUALLANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020509'',''HUASTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020510'',''HUAYLLACAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020511'',''LA PRIMAVERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020512'',''MANGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020513'',''PACLLON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020514'',''SAN MIGUEL DE CORPANQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020515'',''TICLLOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020600'',''CARHUAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020601'',''CARHUAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020602'',''ACOPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020603'',''AMASHCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020604'',''ANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020605'',''ATAQUERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020606'',''MARCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020607'',''PARIAHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020608'',''SAN MIGUEL DE ACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020609'',''SHILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020610'',''TINCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020611'',''YUNGAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020700'',''CARLOS FERMIN FITZCARRALD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020701'',''SAN LUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020702'',''SAN NICOLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020703'',''YAUYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020800'',''CASMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020801'',''CASMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020802'',''BUENA VISTA ALTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020803'',''COMANDANTE NOEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020804'',''YAUTAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020900'',''CORONGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020901'',''CORONGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020902'',''ACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020903'',''BAMBAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020904'',''CUSCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020905'',''LA PAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020906'',''YANAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''020907'',''YUPAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021000'',''HUARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021001'',''HUARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021002'',''ANRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021003'',''CAJAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021004'',''CHAVIN DE HUANTAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021005'',''HUACACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021006'',''HUACCHIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021007'',''HUACHIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021008'',''HUANTAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021009'',''MASIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021010'',''PAUCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021011'',''PONTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021012'',''RAHUAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021013'',''RAPAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021014'',''SAN MARCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021015'',''SAN PEDRO DE CHANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021016'',''UCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021100'',''HUARMEY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021101'',''HUARMEY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021102'',''COCHAPETI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021103'',''CULEBRAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021104'',''HUAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021105'',''MALVAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021200'',''HUAYLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021201'',''CARAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021202'',''HUALLANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021203'',''HUATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021204'',''HUAYLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021205'',''MATO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021206'',''PAMPAROMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021207'',''PUEBLO LIBRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021208'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021209'',''SANTO TORIBIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021210'',''YURACMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021300'',''MARISCAL LUZURIAGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021301'',''PISCOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021302'',''CASCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021303'',''ELEAZAR GUZMAN BARRON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021304'',''FIDEL OLIVAS ESCUDERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021305'',''LLAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021306'',''LLUMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021307'',''LUCMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021308'',''MUSGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021400'',''OCROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021401'',''OCROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021402'',''ACAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021403'',''CAJAMARQUILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021404'',''CARHUAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021405'',''COCHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021406'',''CONGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021407'',''LLIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021408'',''SAN CRISTOBAL DE RAJAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021409'',''SAN PEDRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021410'',''SANTIAGO DE CHILCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021500'',''PALLASCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021501'',''CABANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021502'',''BOLOGNESI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021503'',''CONCHUCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021504'',''HUACASCHUQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021505'',''HUANDOVAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021506'',''LACABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021507'',''LLAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021508'',''PALLASCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021509'',''PAMPAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021510'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021511'',''TAUCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021600'',''POMABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021601'',''POMABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021602'',''HUAYLLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021603'',''PAROBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021604'',''QUINUABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021700'',''RECUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021701'',''RECUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021702'',''CATAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021703'',''COTAPARACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021704'',''HUAYLLAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021705'',''LLACLLIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021706'',''MARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021707'',''PAMPAS CHICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021708'',''PARARIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021709'',''TAPACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021710'',''TICAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021800'',''SANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021801'',''CHIMBOTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021802'',''CACERES DEL PERU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021803'',''COISHCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021804'',''MACATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021805'',''MORO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021806'',''NEPEÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021807'',''SAMANCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021808'',''SANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021809'',''NUEVO CHIMBOTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021900'',''SIHUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021901'',''SIHUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021902'',''ACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021903'',''ALFONSO UGARTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021904'',''CASHAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021905'',''CHINGALPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021906'',''HUAYLLABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021907'',''QUICHES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021908'',''RAGASH'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021909'',''SAN JUAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''021910'',''SICSIBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022000'',''YUNGAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022001'',''YUNGAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022002'',''CASCAPARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022003'',''MANCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022004'',''MATACOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022005'',''QUILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022006'',''RANRAHIRCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022007'',''SHUPLUY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''022008'',''YANAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030000'',''APURIMAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030100'',''ABANCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030101'',''ABANCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030102'',''CHACOCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030103'',''CIRCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030104'',''CURAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030105'',''HUANIPACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030106'',''LAMBRAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030107'',''PICHIRHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030108'',''SAN PEDRO DE CACHORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030109'',''TAMBURCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030200'',''ANDAHUAYLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030201'',''ANDAHUAYLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030202'',''ANDARAPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030203'',''CHIARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030204'',''HUANCARAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030205'',''HUANCARAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030206'',''HUAYANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030207'',''KISHUARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030208'',''PACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030209'',''PACUCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030210'',''PAMPACHIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030211'',''POMACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030212'',''SAN ANTONIO DE CACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030213'',''SAN JERONIMO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030214'',''SAN MIGUEL DE CHACCRAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030215'',''SANTA MARIA DE CHICMO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030216'',''TALAVERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030217'',''TUMAY HUARACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030218'',''TURPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030219'',''KAQUIABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030300'',''ANTABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030301'',''ANTABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030302'',''EL ORO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030303'',''HUAQUIRCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030304'',''JUAN ESPINOZA MEDRANO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030305'',''OROPESA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030306'',''PACHACONAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030307'',''SABAINO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030400'',''AYMARAES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030401'',''CHALHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030402'',''CAPAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030403'',''CARAYBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030404'',''CHAPIMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030405'',''COLCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030406'',''COTARUSE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030407'',''HUAYLLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030408'',''JUSTO APU SAHUARAURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030409'',''LUCRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030410'',''POCOHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030411'',''SAN JUAN DE CHACÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030412'',''SAÑAYCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030413'',''SORAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030414'',''TAPAIRIHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030415'',''TINTAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030416'',''TORAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030417'',''YANACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030500'',''COTABAMBAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030501'',''TAMBOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030502'',''COTABAMBAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030503'',''COYLLURQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030504'',''HAQUIRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030505'',''MARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030506'',''CHALLHUAHUACHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030600'',''CHINCHEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030601'',''CHINCHEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030602'',''ANCO-HUALLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030603'',''COCHARCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030604'',''HUACCANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030605'',''OCOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030606'',''ONGOY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030607'',''URANMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030608'',''RANRACANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030700'',''GRAU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030701'',''CHUQUIBAMBILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030702'',''CURPAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030703'',''GAMARRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030704'',''HUAYLLATI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030705'',''MAMARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030706'',''MICAELA BASTIDAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030707'',''PATAYPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030708'',''PROGRESO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030709'',''SAN ANTONIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030710'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030711'',''TURPAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030712'',''VILCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030713'',''VIRUNDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''030714'',''CURASCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040000'',''AREQUIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040100'',''AREQUIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040101'',''AREQUIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040102'',''ALTO SELVA ALEGRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040103'',''CAYMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040104'',''CERRO COLORADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040105'',''CHARACATO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040106'',''CHIGUATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040107'',''JACOBO HUNTER'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040108'',''LA JOYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040109'',''MARIANO MELGAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040110'',''MIRAFLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040111'',''MOLLEBAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040112'',''PAUCARPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040113'',''POCSI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040114'',''POLOBAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040115'',''QUEQUEÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040116'',''SABANDIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040117'',''SACHACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040118'',''SAN JUAN DE SIGUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040119'',''SAN JUAN DE TARUCANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040120'',''SANTA ISABEL DE SIGUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040121'',''SANTA RITA DE SIGUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040122'',''SOCABAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040123'',''TIABAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040124'',''UCHUMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040125'',''VITOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040126'',''YANAHUARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040127'',''YARABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040128'',''YURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040129'',''JOSE LUIS BUSTAMANTE Y RIVERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040200'',''CAMANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040201'',''CAMANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040202'',''JOSE MARIA QUIMPER'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040203'',''MARIANO NICOLAS VALCARCEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040204'',''MARISCAL CACERES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040205'',''NICOLAS DE PIEROLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040206'',''OCOÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040207'',''QUILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040208'',''SAMUEL PASTOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040300'',''CARAVELI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040301'',''CARAVELI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040302'',''ACARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040303'',''ATICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040304'',''ATIQUIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040305'',''BELLA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040306'',''CAHUACHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040307'',''CHALA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040308'',''CHAPARRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040309'',''HUANUHUANU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040310'',''JAQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040311'',''LOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040312'',''QUICACHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040313'',''YAUCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040400'',''CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040401'',''APLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040402'',''ANDAGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040403'',''AYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040404'',''CHACHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040405'',''CHILCAYMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040406'',''CHOCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040407'',''HUANCARQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040408'',''MACHAGUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040409'',''ORCOPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040410'',''PAMPACOLCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040411'',''TIPAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040412'',''UÑON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040413'',''URACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040414'',''VIRACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040500'',''CAYLLOMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040501'',''CHIVAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040502'',''ACHOMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040503'',''CABANACONDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040504'',''CALLALLI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040505'',''CAYLLOMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040506'',''COPORAQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040507'',''HUAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040508'',''HUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040509'',''ICHUPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040510'',''LARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040511'',''LLUTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040512'',''MACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040513'',''MADRIGAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040514'',''SAN ANTONIO DE CHUCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040515'',''SIBAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040516'',''TAPAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040517'',''TISCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040518'',''TUTI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040519'',''YANQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040520'',''MAJES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040600'',''CONDESUYOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040601'',''CHUQUIBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040602'',''ANDARAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040603'',''CAYARANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040604'',''CHICHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040605'',''IRAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040606'',''RIO GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040607'',''SALAMANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040608'',''YANAQUIHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040700'',''ISLAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040701'',''MOLLENDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040702'',''COCACHACRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040703'',''DEAN VALDIVIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040704'',''ISLAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040705'',''MEJIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040706'',''PUNTA DE BOMBON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040800'',''LA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040801'',''COTAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040802'',''ALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040803'',''CHARCANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040804'',''HUAYNACOTAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040805'',''PAMPAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040806'',''PUYCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040807'',''QUECHUALLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040808'',''SAYLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040809'',''TAURIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040810'',''TOMEPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''040811'',''TORO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050000'',''AYACUCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050100'',''HUAMANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050101'',''AYACUCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050102'',''ACOCRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050103'',''ACOS VINCHOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050104'',''CARMEN ALTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050105'',''CHIARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050106'',''OCROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050107'',''PACAYCASA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050108'',''QUINUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050109'',''SAN JOSE DE TICLLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050110'',''SAN JUAN BAUTISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050111'',''SANTIAGO DE PISCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050112'',''SOCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050113'',''TAMBILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050114'',''VINCHOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050115'',''JESUS NAZARENO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050200'',''CANGALLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050201'',''CANGALLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050202'',''CHUSCHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050203'',''LOS MOROCHUCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050204'',''MARIA PARADO DE BELLIDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050205'',''PARAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050206'',''TOTOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050300'',''HUANCA SANCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050301'',''SANCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050302'',''CARAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050303'',''SACSAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050304'',''SANTIAGO DE LUCANAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050400'',''HUANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050401'',''HUANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050402'',''AYAHUANCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050403'',''HUAMANGUILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050404'',''IGUAIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050405'',''LURICOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050406'',''SANTILLANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050407'',''SIVIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050408'',''LLOCHEGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050500'',''LA MAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050501'',''SAN MIGUEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050502'',''ANCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050503'',''AYNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050504'',''CHILCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050505'',''CHUNGUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050506'',''LUIS CARRANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050507'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050508'',''TAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050600'',''LUCANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050601'',''PUQUIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050602'',''AUCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050603'',''CABANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050604'',''CARMEN SALCEDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050605'',''CHAVIÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050606'',''CHIPAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050607'',''HUAC-HUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050608'',''LARAMATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050609'',''LEONCIO PRADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050610'',''LLAUTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050611'',''LUCANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050612'',''OCAÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050613'',''OTOCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050614'',''SAISA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050615'',''SAN CRISTOBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050616'',''SAN JUAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050617'',''SAN PEDRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050618'',''SAN PEDRO DE PALCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050619'',''SANCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050620'',''SANTA ANA DE HUAYCAHUACHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050621'',''SANTA LUCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050700'',''PARINACOCHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050701'',''CORACORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050702'',''CHUMPI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050703'',''CORONEL CASTAÑEDA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050704'',''PACAPAUSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050705'',''PULLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050706'',''PUYUSCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050707'',''SAN FRANCISCO DE RAVACAYCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050708'',''UPAHUACHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050800'',''PAUCAR DEL SARA SARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050801'',''PAUSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050802'',''COLTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050803'',''CORCULLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050804'',''LAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050805'',''MARCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050806'',''OYOLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050807'',''PARARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050808'',''SAN JAVIER DE ALPABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050809'',''SAN JOSE DE USHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050810'',''SARA SARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050900'',''SUCRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050901'',''QUEROBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050902'',''BELEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050903'',''CHALCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050904'',''CHILCAYOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050905'',''HUACAÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050906'',''MORCOLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050907'',''PAICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050908'',''SAN PEDRO DE LARCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050909'',''SAN SALVADOR DE QUIJE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050910'',''SANTIAGO DE PAUCARAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''050911'',''SORAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051000'',''VICTOR FAJARDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051001'',''HUANCAPI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051002'',''ALCAMENCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051003'',''APONGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051004'',''ASQUIPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051005'',''CANARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051006'',''CAYARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051007'',''COLCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051008'',''HUAMANQUIQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051009'',''HUANCARAYLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051010'',''HUAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051011'',''SARHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051012'',''VILCANCHOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051100'',''VILCAS HUAMAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051101'',''VILCAS HUAMAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051102'',''ACCOMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051103'',''CARHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051104'',''CONCEPCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051105'',''HUAMBALPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051106'',''INDEPENDENCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051107'',''SAURAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''051108'',''VISCHONGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060000'',''CAJAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060100'',''CAJAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060101'',''CAJAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060102'',''ASUNCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060103'',''CHETILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060104'',''COSPAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060105'',''ENCAÑADA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060106'',''JESUS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060107'',''LLACANORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060108'',''LOS BAÑOS DEL INCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060109'',''MAGDALENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060110'',''MATARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060111'',''NAMORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060112'',''SAN JUAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060200'',''CAJABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060201'',''CAJABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060202'',''CACHACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060203'',''CONDEBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060204'',''SITACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060300'',''CELENDIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060301'',''CELENDIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060302'',''CHUMUCH'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060303'',''CORTEGANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060304'',''HUASMIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060305'',''JORGE CHAVEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060306'',''JOSE GALVEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060307'',''MIGUEL IGLESIAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060308'',''OXAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060309'',''SOROCHUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060310'',''SUCRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060311'',''UTCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060312'',''LA LIBERTAD DE PALLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060400'',''CHOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060401'',''CHOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060402'',''ANGUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060403'',''CHADIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060404'',''CHIGUIRIP'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060405'',''CHIMBAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060406'',''CHOROPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060407'',''COCHABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060408'',''CONCHAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060409'',''HUAMBOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060410'',''LAJAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060411'',''LLAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060412'',''MIRACOSTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060413'',''PACCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060414'',''PION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060415'',''QUEROCOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060416'',''SAN JUAN DE LICUPIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060417'',''TACABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060418'',''TOCMOCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060419'',''CHALAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060500'',''CONTUMAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060501'',''CONTUMAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060502'',''CHILETE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060503'',''CUPISNIQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060504'',''GUZMANGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060505'',''SAN BENITO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060506'',''SANTA CRUZ DE TOLED'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060507'',''TANTARICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060508'',''YONAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060600'',''CUTERVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060601'',''CUTERVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060602'',''CALLAYUC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060603'',''CHOROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060604'',''CUJILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060605'',''LA RAMADA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060606'',''PIMPINGOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060607'',''QUEROCOTILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060608'',''SAN ANDRES DE CUTERVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060609'',''SAN JUAN DE CUTERVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060610'',''SAN LUIS DE LUCMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060611'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060612'',''SANTO DOMINGO DE LA CAPILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060613'',''SANTO TOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060614'',''SOCOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060615'',''TORIBIO CASANOVA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060700'',''HUALGAYOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060701'',''BAMBAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060702'',''CHUGUR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060703'',''HUALGAYOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060800'',''JAEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060801'',''JAEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060802'',''BELLAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060803'',''CHONTALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060804'',''COLASAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060805'',''HUABAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060806'',''LAS PIRIAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060807'',''POMAHUACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060808'',''PUCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060809'',''SALLIQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060810'',''SAN FELIPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060811'',''SAN JOSE DEL ALTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060812'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060900'',''SAN IGNACIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060901'',''SAN IGNACIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060902'',''CHIRINOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060903'',''HUARANGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060904'',''LA COIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060905'',''NAMBALLE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060906'',''SAN JOSE DE LOURDES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''060907'',''TABACONAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061000'',''SAN MARCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061001'',''PEDRO GALVEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061002'',''CHANCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061003'',''EDUARDO VILLANUEVA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061004'',''GREGORIO PITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061005'',''ICHOCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061006'',''JOSE MANUEL QUIROZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061007'',''JOSE SABOGAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061100'',''SAN MIGUEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061101'',''SAN MIGUEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061102'',''BOLIVAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061103'',''CALQUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061104'',''CATILLUC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061105'',''EL PRADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061106'',''LA FLORIDA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061107'',''LLAPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061108'',''NANCHOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061109'',''NIEPOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061110'',''SAN GREGORIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061111'',''SAN SILVESTRE DE COCHAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061112'',''TONGOD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061113'',''UNION AGUA BLANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061200'',''SAN PABLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061201'',''SAN PABLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061202'',''SAN BERNARDINO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061203'',''SAN LUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061204'',''TUMBADEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061300'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061301'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061302'',''ANDABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061303'',''CATACHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061304'',''CHANCAYBAÑOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061305'',''LA ESPERANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061306'',''NINABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061307'',''PULAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061308'',''SAUCEPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061309'',''SEXI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061310'',''UTICYACU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''061311'',''YAUYUCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070000'',''CALLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070100'',''CALLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070101'',''CALLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070102'',''BELLAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070103'',''CARMEN DE LA LEGUA REYNOSO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070104'',''LA PERLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070105'',''LA PUNTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''070106'',''VENTANILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080000'',''CUSCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080100'',''CUSCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080101'',''CUSCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080102'',''CCORCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080103'',''POROY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080104'',''SAN JERONIMO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080105'',''SAN SEBASTIAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080106'',''SANTIAGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080107'',''SAYLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080108'',''WANCHAQ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080200'',''ACOMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080201'',''ACOMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080202'',''ACOPIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080203'',''ACOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080204'',''MOSOC LLACTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080205'',''POMACANCHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080206'',''RONDOCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080207'',''SANGARARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080300'',''ANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080301'',''ANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080302'',''ANCAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080303'',''CACHIMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080304'',''CHINCHAYPUJIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080305'',''HUAROCONDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080306'',''LIMATAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080307'',''MOLLEPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080308'',''PUCYURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080309'',''ZURITE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080400'',''CALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080401'',''CALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080402'',''COYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080403'',''LAMAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080404'',''LARES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080405'',''PISAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080406'',''SAN SALVADOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080407'',''TARAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080408'',''YANATILE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080500'',''CANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080501'',''YANAOCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080502'',''CHECCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080503'',''KUNTURKANKI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080504'',''LANGUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080505'',''LAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080506'',''PAMPAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080507'',''QUEHUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080508'',''TUPAC AMARU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080600'',''CANCHIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080601'',''SICUANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080602'',''CHECACUPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080603'',''COMBAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080604'',''MARANGANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080605'',''PITUMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080606'',''SAN PABLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080607'',''SAN PEDRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080608'',''TINTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080700'',''CHUMBIVILCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080701'',''SANTO TOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080702'',''CAPACMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080703'',''CHAMACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080704'',''COLQUEMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080705'',''LIVITACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080706'',''LLUSCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080707'',''QUIÑOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080708'',''VELILLE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080800'',''ESPINAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080801'',''ESPINAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080802'',''CONDOROMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080803'',''COPORAQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080804'',''OCORURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080805'',''PALLPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080806'',''PICHIGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080807'',''SUYCKUTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080808'',''ALTO PICHIGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080900'',''LA CONVENCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080901'',''SANTA ANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080902'',''ECHARATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080903'',''HUAYOPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080904'',''MARANURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080905'',''OCOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080906'',''QUELLOUNO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080907'',''KIMBIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080908'',''SANTA TERESA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080909'',''VILCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''080910'',''PICHARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081000'',''PARURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081001'',''PARURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081002'',''ACCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081003'',''CCAPI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081004'',''COLCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081005'',''HUANOQUITE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081006'',''OMACHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081007'',''PACCARITAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081008'',''PILLPINTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081009'',''YAURISQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081100'',''PAUCARTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081101'',''PAUCARTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081102'',''CAICAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081103'',''CHALLABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081104'',''COLQUEPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081105'',''HUANCARANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081106'',''KOSÑIPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081200'',''QUISPICANCHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081201'',''URCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081202'',''ANDAHUAYLILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081203'',''CAMANTI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081204'',''CCARHUAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081205'',''CCATCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081206'',''CUSIPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081207'',''HUARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081208'',''LUCRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081209'',''MARCAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081210'',''OCONGATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081211'',''OROPESA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081212'',''QUIQUIJANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081300'',''URUBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081301'',''URUBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081302'',''CHINCHERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081303'',''HUAYLLABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081304'',''MACHUPICCHU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081305'',''MARAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081306'',''OLLANTAYTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''081307'',''YUCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090000'',''HUANCAVELICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090100'',''HUANCAVELICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090101'',''HUANCAVELICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090102'',''ACOBAMBILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090103'',''ACORIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090104'',''CONAYCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090105'',''CUENCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090106'',''HUACHOCOLPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090107'',''HUAYLLAHUARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090108'',''IZCUCHACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090109'',''LARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090110'',''MANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090111'',''MARISCAL CACERES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090112'',''MOYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090113'',''NUEVO OCCORO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090114'',''PALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090115'',''PILCHACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090116'',''VILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090117'',''YAULI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090118'',''ASCENSION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090119'',''HUANDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090200'',''ACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090201'',''ACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090202'',''ANDABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090203'',''ANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090204'',''CAJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090205'',''MARCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090206'',''PAUCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090207'',''POMACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090208'',''ROSARIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090300'',''ANGARAES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090301'',''LIRCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090302'',''ANCHONGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090303'',''CALLANMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090304'',''CCOCHACCASA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090305'',''CHINCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090306'',''CONGALLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090307'',''HUANCA-HUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090308'',''HUAYLLAY GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090309'',''JULCAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090310'',''SAN ANTONIO DE ANTAPARCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090311'',''SANTO TOMAS DE PATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090312'',''SECCLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090400'',''CASTROVIRREYNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090401'',''CASTROVIRREYNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090402'',''ARMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090403'',''AURAHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090404'',''CAPILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090405'',''CHUPAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090406'',''COCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090407'',''HUACHOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090408'',''HUAMATAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090409'',''MOLLEPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090410'',''SAN JUAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090411'',''SANTA ANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090412'',''TANTARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090413'',''TICRAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090500'',''CHURCAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090501'',''CHURCAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090502'',''ANCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090503'',''CHINCHIHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090504'',''EL CARMEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090505'',''LA MERCED'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090506'',''LOCROJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090507'',''PAUCARBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090508'',''SAN MIGUEL DE MAYOCC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090509'',''SAN PEDRO DE CORIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090510'',''PACHAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090600'',''HUAYTARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090601'',''HUAYTARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090602'',''AYAVI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090603'',''CORDOVA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090604'',''HUAYACUNDO ARMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090605'',''LARAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090606'',''OCOYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090607'',''PILPICHACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090608'',''QUERCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090609'',''QUITO-ARMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090610'',''SAN ANTONIO DE CUSICANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090611'',''SAN FRANCISCO DE SANGAYAICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090612'',''SAN ISIDRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090613'',''SANTIAGO DE CHOCORVOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090614'',''SANTIAGO DE QUIRAHUARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090615'',''SANTO DOMINGO DE CAPILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090616'',''TAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090700'',''TAYACAJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090701'',''PAMPAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090702'',''ACOSTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090703'',''ACRAQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090704'',''AHUAYCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090705'',''COLCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090706'',''DANIEL HERNANDEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090707'',''HUACHOCOLPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090709'',''HUARIBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090710'',''ÑAHUIMPUQUIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090711'',''PAZOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090713'',''QUISHUAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090714'',''SALCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090715'',''SALCAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090716'',''SAN MARCOS DE ROCCHAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090717'',''SURCUBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''090718'',''TINTAY PUNCU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100000'',''HUANUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100100'',''HUANUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100101'',''HUANUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100102'',''AMARILIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100103'',''CHINCHAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100104'',''CHURUBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100105'',''MARGOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100106'',''QUISQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100107'',''SAN FRANCISCO DE CAYRAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100108'',''SAN PEDRO DE CHAULAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100109'',''SANTA MARIA DEL VALLE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100110'',''YARUMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100111'',''PILLCO MARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100200'',''AMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100201'',''AMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100202'',''CAYNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100203'',''COLPAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100204'',''CONCHAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100205'',''HUACAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100206'',''SAN FRANCISCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100207'',''SAN RAFAEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100208'',''TOMAY KICHWA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100300'',''DOS DE MAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100301'',''LA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100307'',''CHUQUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100311'',''MARIAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100313'',''PACHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100316'',''QUIVILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100317'',''RIPAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100321'',''SHUNQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100322'',''SILLAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100323'',''YANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100400'',''HUACAYBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100401'',''HUACAYBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100402'',''CANCHABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100403'',''COCHABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100404'',''PINRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100500'',''HUAMALIES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100501'',''LLATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100502'',''ARANCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100503'',''CHAVIN DE PARIARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100504'',''JACAS GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100505'',''JIRCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100506'',''MIRAFLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100507'',''MONZON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100508'',''PUNCHAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100509'',''PUÑOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100510'',''SINGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100511'',''TANTAMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100600'',''LEONCIO PRADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100601'',''RUPA-RUPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100602'',''DANIEL ALOMIA ROBLES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100603'',''HERMILIO VALDIZAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100604'',''JOSE CRESPO Y CASTILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100605'',''LUYANDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100606'',''MARIANO DAMASO BERAUN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100700'',''MARAÑON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100701'',''HUACRACHUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100702'',''CHOLON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100703'',''SAN BUENAVENTURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100800'',''PACHITEA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100801'',''PANAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100802'',''CHAGLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100803'',''MOLINO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100804'',''UMARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100900'',''PUERTO INCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100901'',''PUERTO INCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100902'',''CODO DEL POZUZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100903'',''HONORIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100904'',''TOURNAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''100905'',''YUYAPICHIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101000'',''LAURICOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101001'',''JESUS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101002'',''BAÑOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101003'',''JIVIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101004'',''QUEROPALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101005'',''RONDOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101006'',''SAN FRANCISCO DE ASIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101007'',''SAN MIGUEL DE CAURI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101100'',''YAROWILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101101'',''CHAVINILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101102'',''CAHUAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101103'',''CHACABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101104'',''APARICIO POMARES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101105'',''JACAS CHICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101106'',''OBAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101107'',''PAMPAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''101108'',''CHORAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110000'',''ICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110100'',''ICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110101'',''ICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110102'',''LA TINGUIÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110103'',''LOS AQUIJES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110104'',''OCUCAJE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110105'',''PACHACUTEC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110106'',''PARCONA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110107'',''PUEBLO NUEVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110108'',''SALAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110109'',''SAN JOSE DE LOS MOLINOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110110'',''SAN JUAN BAUTISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110111'',''SANTIAGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110112'',''SUBTANJALLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110113'',''TATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110114'',''YAUCA DEL ROSARIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110200'',''CHINCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110201'',''CHINCHA ALTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110202'',''ALTO LARAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110203'',''CHAVIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110204'',''CHINCHA BAJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110205'',''EL CARMEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110206'',''GROCIO PRADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110207'',''PUEBLO NUEVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110208'',''SAN JUAN DE YANAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110209'',''SAN PEDRO DE HUACARPANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110210'',''SUNAMPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110211'',''TAMBO DE MORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110300'',''NAZCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110301'',''NAZCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110302'',''CHANGUILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110303'',''EL INGENIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110304'',''MARCONA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110305'',''VISTA ALEGRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110400'',''PALPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110401'',''PALPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110402'',''LLIPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110403'',''RIO GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110404'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110405'',''TIBILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110500'',''PISCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110501'',''PISCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110502'',''HUANCANO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110503'',''HUMAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110504'',''INDEPENDENCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110505'',''PARACAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110506'',''SAN ANDRES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110507'',''SAN CLEMENTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''110508'',''TUPAC AMARU INCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120000'',''JUNIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120100'',''HUANCAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120101'',''HUANCAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120104'',''CARHUACALLANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120105'',''CHACAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120106'',''CHICCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120107'',''CHILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120108'',''CHONGOS ALTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120111'',''CHUPURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120112'',''COLCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120113'',''CULLHUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120114'',''EL TAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120116'',''HUACRAPUQUIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120117'',''HUALHUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120119'',''HUANCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120120'',''HUASICANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120121'',''HUAYUCACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120122'',''INGENIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120124'',''PARIAHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120125'',''PILCOMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120126'',''PUCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120127'',''QUICHUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120128'',''QUILCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120129'',''SAN AGUSTIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120130'',''SAN JERONIMO DE TUNAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120132'',''SAÑO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120133'',''SAPALLANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120134'',''SICAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120135'',''SANTO DOMINGO DE ACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120136'',''VIQUES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120200'',''CONCEPCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120201'',''CONCEPCION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120202'',''ACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120203'',''ANDAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120204'',''CHAMBARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120205'',''COCHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120206'',''COMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120207'',''HEROINAS TOLEDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120208'',''MANZANARES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120209'',''MARISCAL CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120210'',''MATAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120211'',''MITO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120212'',''NUEVE DE JULIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120213'',''ORCOTUNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120214'',''SAN JOSE DE QUERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120215'',''SANTA ROSA DE OCOPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120300'',''CHANCHAMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120301'',''CHANCHAMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120302'',''PERENE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120303'',''PICHANAQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120304'',''SAN LUIS DE SHUARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120305'',''SAN RAMON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120306'',''VITOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120400'',''JAUJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120401'',''JAUJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120402'',''ACOLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120403'',''APATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120404'',''ATAURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120405'',''CANCHAYLLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120406'',''CURICACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120407'',''EL MANTARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120408'',''HUAMALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120409'',''HUARIPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120410'',''HUERTAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120411'',''JANJAILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120412'',''JULCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120413'',''LEONOR ORDOÑEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120414'',''LLOCLLAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120415'',''MARCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120416'',''MASMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120417'',''MASMA CHICCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120418'',''MOLINOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120419'',''MONOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120420'',''MUQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120421'',''MUQUIYAUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120422'',''PACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120423'',''PACCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120424'',''PANCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120425'',''PARCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120426'',''POMACANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120427'',''RICRAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120428'',''SAN LORENZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120429'',''SAN PEDRO DE CHUNAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120430'',''SAUSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120431'',''SINCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120432'',''TUNAN MARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120433'',''YAULI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120434'',''YAUYOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120500'',''JUNIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120501'',''JUNIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120502'',''CARHUAMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120503'',''ONDORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120504'',''ULCUMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120600'',''SATIPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120601'',''SATIPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120602'',''COVIRIALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120603'',''LLAYLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120604'',''MAZAMARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120605'',''PAMPA HERMOSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120606'',''PANGOA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120607'',''RIO NEGRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120608'',''RIO TAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120700'',''TARMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120701'',''TARMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120702'',''ACOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120703'',''HUARICOLCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120704'',''HUASAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120705'',''LA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120706'',''PALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120707'',''PALCAMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120708'',''SAN PEDRO DE CAJAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120709'',''TAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120800'',''YAULI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120801'',''LA OROYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120802'',''CHACAPALPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120803'',''HUAY-HUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120804'',''MARCAPOMACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120805'',''MOROCOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120806'',''PACCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120807'',''SANTA BARBARA DE CARHUACAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120808'',''SANTA ROSA DE SACCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120809'',''SUITUCANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120810'',''YAULI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120900'',''CHUPACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120901'',''CHUPACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120902'',''AHUAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120903'',''CHONGOS BAJO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120904'',''HUACHAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120905'',''HUAMANCACA CHICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120906'',''SAN JUAN DE ISCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120907'',''SAN JUAN DE JARPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120908'',''TRES DE DICIEMBRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''120909'',''YANACANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130000'',''LA LIBERTAD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130100'',''TRUJILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130101'',''TRUJILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130102'',''EL PORVENIR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130103'',''FLORENCIA DE MORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130104'',''HUANCHACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130105'',''LA ESPERANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130106'',''LAREDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130107'',''MOCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130108'',''POROTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130109'',''SALAVERRY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130110'',''SIMBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130111'',''VICTOR LARCO HERRERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130200'',''ASCOPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130201'',''ASCOPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130202'',''CHICAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130203'',''CHOCOPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130204'',''MAGDALENA DE CAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130205'',''PAIJAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130206'',''RAZURI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130207'',''SANTIAGO DE CAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130208'',''CASA GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130300'',''BOLIVAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130301'',''BOLIVAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130302'',''BAMBAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130303'',''CONDORMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130304'',''LONGOTEA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130305'',''UCHUMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130306'',''UCUNCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130400'',''CHEPEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130401'',''CHEPEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130402'',''PACANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130403'',''PUEBLO NUEVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130500'',''JULCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130501'',''JULCAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130502'',''CALAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130503'',''CARABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130504'',''HUASO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130600'',''OTUZCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130601'',''OTUZCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130602'',''AGALLPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130604'',''CHARAT'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130605'',''HUARANCHAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130606'',''LA CUESTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130608'',''MACHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130610'',''PARANDAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130611'',''SALPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130613'',''SINSICAP'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130614'',''USQUIL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130700'',''PACASMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130701'',''SAN PEDRO DE LLOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130702'',''GUADALUPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130703'',''JEQUETEPEQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130704'',''PACASMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130705'',''SAN JOSE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130800'',''PATAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130801'',''TAYABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130802'',''BULDIBUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130803'',''CHILLIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130804'',''HUANCASPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130805'',''HUAYLILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130806'',''HUAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130807'',''ONGON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130808'',''PARCOY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130809'',''PATAZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130810'',''PIAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130811'',''SANTIAGO DE CHALLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130812'',''TAURIJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130813'',''URPAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130900'',''SANCHEZ CARRION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130901'',''HUAMACHUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130902'',''CHUGAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130903'',''COCHORCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130904'',''CURGOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130905'',''MARCABAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130906'',''SANAGORAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130907'',''SARIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''130908'',''SARTIMBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131000'',''SANTIAGO DE CHUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131001'',''SANTIAGO DE CHUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131002'',''ANGASMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131003'',''CACHICADAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131004'',''MOLLEBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131005'',''MOLLEPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131006'',''QUIRUVILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131007'',''SANTA CRUZ DE CHUCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131008'',''SITABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131100'',''GRAN CHIMU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131101'',''CASCAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131102'',''LUCMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131103'',''MARMOT'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131104'',''SAYAPULLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131200'',''VIRU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131201'',''VIRU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131202'',''CHAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''131203'',''GUADALUPITO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140000'',''LAMBAYEQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140100'',''CHICLAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140101'',''CHICLAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140102'',''CHONGOYAPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140103'',''ETEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140104'',''ETEN PUERTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140105'',''JOSE LEONARDO ORTIZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140106'',''LA VICTORIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140107'',''LAGUNAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140108'',''MONSEFU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140109'',''NUEVA ARICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140110'',''OYOTUN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140111'',''PICSI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140112'',''PIMENTEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140113'',''REQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140114'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140115'',''SAÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140116'',''CAYALTI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140117'',''PATAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140118'',''POMALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140119'',''PUCALA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140120'',''TUMAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140200'',''FERREÑAFE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140201'',''FERREÑAFE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140202'',''CAÑARIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140203'',''INCAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140204'',''MANUEL ANTONIO MESONES MURO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140205'',''PITIPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140206'',''PUEBLO NUEVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140300'',''LAMBAYEQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140301'',''LAMBAYEQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140302'',''CHOCHOPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140303'',''ILLIMO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140304'',''JAYANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140305'',''MOCHUMI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140306'',''MORROPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140307'',''MOTUPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140308'',''OLMOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140309'',''PACORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140310'',''SALAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140311'',''SAN JOSE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''140312'',''TUCUME'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150000'',''LIMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150100'',''LIMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150101'',''LIMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150102'',''ANCON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150103'',''ATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150104'',''BARRANCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150105'',''BREÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150106'',''CARABAYLLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150107'',''CHACLACAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150108'',''CHORRILLOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150109'',''CIENEGUILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150110'',''COMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150111'',''EL AGUSTINO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150112'',''INDEPENDENCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150113'',''JESUS MARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150114'',''LA MOLINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150115'',''LA VICTORIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150116'',''LINCE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150117'',''LOS OLIVOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150118'',''LURIGANCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150119'',''LURIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150120'',''MAGDALENA DEL MAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150121'',''MAGDALENA VIEJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150122'',''MIRAFLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150123'',''PACHACAMAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150124'',''PUCUSANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150125'',''PUENTE PIEDRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150126'',''PUNTA HERMOSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150127'',''PUNTA NEGRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150128'',''RIMAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150129'',''SAN BARTOLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150130'',''SAN BORJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150131'',''SAN ISIDRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150132'',''SAN JUAN DE LURIGANCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150133'',''SAN JUAN DE MIRAFLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150134'',''SAN LUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150135'',''SAN MARTIN DE PORRES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150136'',''SAN MIGUEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150137'',''SANTA ANITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150138'',''SANTA MARIA DEL MAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150139'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150140'',''SANTIAGO DE SURCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150141'',''SURQUILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150142'',''VILLA EL SALVADOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150143'',''VILLA MARIA DEL TRIUNFO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150200'',''BARRANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150201'',''BARRANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150202'',''PARAMONGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150203'',''PATIVILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150204'',''SUPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150205'',''SUPE PUERTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150300'',''CAJATAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150301'',''CAJATAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150302'',''COPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150303'',''GORGOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150304'',''HUANCAPON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150305'',''MANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150400'',''CANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150401'',''CANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150402'',''ARAHUAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150403'',''HUAMANTANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150404'',''HUAROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150405'',''LACHAQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150406'',''SAN BUENAVENTURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150407'',''SANTA ROSA DE QUIVES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150500'',''CAÑETE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150501'',''SAN VICENTE DE CAÑETE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150502'',''ASIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150503'',''CALANGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150504'',''CERRO AZUL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150505'',''CHILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150506'',''COAYLLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150507'',''IMPERIAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150508'',''LUNAHUANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150509'',''MALA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150510'',''NUEVO IMPERIAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150511'',''PACARAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150512'',''QUILMANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150513'',''SAN ANTONIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150514'',''SAN LUIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150515'',''SANTA CRUZ DE FLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150516'',''ZUÑIGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150600'',''HUARAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150601'',''HUARAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150602'',''ATAVILLOS ALTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150603'',''ATAVILLOS BAJO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150604'',''AUCALLAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150605'',''CHANCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150606'',''IHUARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150607'',''LAMPIAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150608'',''PACARAOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150609'',''SAN MIGUEL DE ACOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150610'',''SANTA CRUZ DE ANDAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150611'',''SUMBILCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150612'',''VEINTISIETE DE NOVIEMBRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150700'',''HUAROCHIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150701'',''MATUCANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150702'',''ANTIOQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150703'',''CALLAHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150704'',''CARAMPOMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150705'',''CHICLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150706'',''CUENCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150707'',''HUACHUPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150708'',''HUANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150709'',''HUAROCHIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150710'',''LAHUAYTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150711'',''LANGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150712'',''LARAOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150713'',''MARIATANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150714'',''RICARDO PALMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150715'',''SAN ANDRES DE TUPICOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150716'',''SAN ANTONIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150717'',''SAN BARTOLOME'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150718'',''SAN DAMIAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150719'',''SAN JUAN DE IRIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150720'',''SAN JUAN DE TANTARANCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150721'',''SAN LORENZO DE QUINTI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150722'',''SAN MATEO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150723'',''SAN MATEO DE OTAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150724'',''SAN PEDRO DE CASTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150725'',''SAN PEDRO DE HUANCAYRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150726'',''SANGALLAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150727'',''SANTA CRUZ DE COCACHACRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150728'',''SANTA EULALIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150729'',''SANTIAGO DE ANCHUCAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150730'',''SANTIAGO DE TUNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150731'',''SANTO DOMINGO DE LOS OLLEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150732'',''SURCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150800'',''HUAURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150801'',''HUACHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150802'',''AMBAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150803'',''CALETA DE CARQUIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150804'',''CHECRAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150805'',''HUALMAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150806'',''HUAURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150807'',''LEONCIO PRADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150808'',''PACCHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150809'',''SANTA LEONOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150810'',''SANTA MARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150811'',''SAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150812'',''VEGUETA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150900'',''OYON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150901'',''OYON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150902'',''ANDAJES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150903'',''CAUJUL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150904'',''COCHAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150905'',''NAVAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''150906'',''PACHANGARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151000'',''YAUYOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151001'',''YAUYOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151002'',''ALIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151003'',''AYAUCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151004'',''AYAVIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151005'',''AZANGARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151006'',''CACRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151007'',''CARANIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151008'',''CATAHUASI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151009'',''CHOCOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151010'',''COCHAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151011'',''COLONIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151012'',''HONGOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151013'',''HUAMPARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151014'',''HUANCAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151015'',''HUANGASCAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151016'',''HUANTAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151017'',''HUAÑEC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151018'',''LARAOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151019'',''LINCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151020'',''MADEAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151021'',''MIRAFLORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151022'',''OMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151023'',''PUTINZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151024'',''QUINCHES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151025'',''QUINOCAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151026'',''SAN JOAQUIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151027'',''SAN PEDRO DE PILAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151028'',''TANTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151029'',''TAURIPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151030'',''TOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151031'',''TUPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151032'',''VIÑAC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''151033'',''VITIS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160000'',''LORETO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160100'',''MAYNAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160101'',''IQUITOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160102'',''ALTO NANAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160103'',''FERNANDO LORES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160104'',''INDIANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160105'',''LAS AMAZONAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160106'',''MAZAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160107'',''NAPO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160108'',''PUNCHANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160109'',''PUTUMAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160110'',''TORRES CAUSANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160112'',''BELEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160113'',''SAN JUAN BAUTISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160200'',''ALTO AMAZONAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160201'',''YURIMAGUAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160202'',''BALSAPUERTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160203'',''BARRANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160204'',''CAHUAPANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160205'',''JEBEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160206'',''LAGUNAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160207'',''MANSERICHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160208'',''MORONA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160209'',''PASTAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160210'',''SANTA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160211'',''TENIENTE CESAR LOPEZ ROJAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160300'',''LORETO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160301'',''NAUTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160302'',''PARINARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160303'',''TIGRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160304'',''TROMPETEROS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160305'',''URARINAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160400'',''MARISCAL RAMON CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160401'',''RAMON CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160402'',''PEBAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160403'',''YAVARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160404'',''SAN PABLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160500'',''REQUENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160501'',''REQUENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160502'',''ALTO TAPICHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160503'',''CAPELO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160504'',''EMILIO SAN MARTIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160505'',''MAQUIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160506'',''PUINAHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160507'',''SAQUENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160508'',''SOPLIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160509'',''TAPICHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160510'',''JENARO HERRERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160511'',''YAQUERANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160600'',''UCAYALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160601'',''CONTAMANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160602'',''INAHUAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160603'',''PADRE MARQUEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160604'',''PAMPA HERMOSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160605'',''SARAYACU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''160606'',''VARGAS GUERRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170000'',''MADRE DE DIOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170100'',''TAMBOPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170101'',''TAMBOPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170102'',''INAMBARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170103'',''LAS PIEDRAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170104'',''LABERINTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170200'',''MANU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170201'',''MANU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170202'',''FITZCARRALD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170203'',''MADRE DE DIOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170204'',''HUEPETUHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170300'',''TAHUAMANU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170301'',''IÑAPARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170302'',''IBERIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''170303'',''TAHUAMANU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180000'',''MOQUEGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180100'',''MARISCAL NIETO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180101'',''MOQUEGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180102'',''CARUMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180103'',''CUCHUMBAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180104'',''SAMEGUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180105'',''SAN CRISTOBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180106'',''TORATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180200'',''GENERAL SANCHEZ CERRO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180201'',''OMATE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180202'',''CHOJATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180203'',''COALAQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180204'',''ICHUÑA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180205'',''LA CAPILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180206'',''LLOQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180207'',''MATALAQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180208'',''PUQUINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180209'',''QUINISTAQUILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180210'',''UBINAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180211'',''YUNGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180300'',''ILO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180301'',''ILO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180302'',''EL ALGARROBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''180303'',''PACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190000'',''PASCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190100'',''PASCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190101'',''CHAUPIMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190102'',''HUACHON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190103'',''HUARIACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190104'',''HUAYLLAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190105'',''NINACACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190106'',''PALLANCHACRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190107'',''PAUCARTAMBO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190108'',''SAN FCO.DE ASIS DE YARUSYACAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190109'',''SIMON BOLIVAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190110'',''TICLACAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190111'',''TINYAHUARCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190112'',''VICCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190113'',''YANACANCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190200'',''DANIEL ALCIDES CARRION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190201'',''YANAHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190202'',''CHACAYAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190203'',''GOYLLARISQUIZGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190204'',''PAUCAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190205'',''SAN PEDRO DE PILLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190206'',''SANTA ANA DE TUSI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190207'',''TAPUC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190208'',''VILCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190300'',''OXAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190301'',''OXAPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190302'',''CHONTABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190303'',''HUANCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190304'',''PALCAZU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190305'',''POZUZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190306'',''PUERTO BERMUDEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''190307'',''VILLA RICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200000'',''PIURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200100'',''PIURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200101'',''PIURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200104'',''CASTILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200105'',''CATACAOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200107'',''CURA MORI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200108'',''EL TALLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200109'',''LA ARENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200110'',''LA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200111'',''LAS LOMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200114'',''TAMBO GRANDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200200'',''AYABACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200201'',''AYABACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200202'',''FRIAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200203'',''JILILI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200204'',''LAGUNAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200205'',''MONTERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200206'',''PACAIPAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200207'',''PAIMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200208'',''SAPILLICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200209'',''SICCHEZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200210'',''SUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200300'',''HUANCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200301'',''HUANCABAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200302'',''CANCHAQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200303'',''EL CARMEN DE LA FRONTERA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200304'',''HUARMACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200305'',''LALAQUIZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200306'',''SAN MIGUEL DE EL FAIQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200307'',''SONDOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200308'',''SONDORILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200400'',''MORROPON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200401'',''CHULUCANAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200402'',''BUENOS AIRES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200403'',''CHALACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200404'',''LA MATANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200405'',''MORROPON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200406'',''SALITRAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200407'',''SAN JUAN DE BIGOTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200408'',''SANTA CATALINA DE MOSSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200409'',''SANTO DOMINGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200410'',''YAMANGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200500'',''PAITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200501'',''PAITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200502'',''AMOTAPE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200503'',''ARENAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200504'',''COLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200505'',''LA HUACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200506'',''TAMARINDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200507'',''VICHAYAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200600'',''SULLANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200601'',''SULLANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200602'',''BELLAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200603'',''IGNACIO ESCUDERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200604'',''LANCONES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200605'',''MARCAVELICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200606'',''MIGUEL CHECA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200607'',''QUERECOTILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200608'',''SALITRAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200700'',''TALARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200701'',''PARIÑAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200702'',''EL ALTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200703'',''LA BREA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200704'',''LOBITOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200705'',''LOS ORGANOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200706'',''MANCORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200800'',''SECHURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200801'',''SECHURA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200802'',''BELLAVISTA DE LA UNION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200803'',''BERNAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200804'',''CRISTO NOS VALGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200805'',''VICE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''200806'',''RINCONADA LLICUAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210000'',''PUNO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210100'',''PUNO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210101'',''PUNO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210102'',''ACORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210103'',''AMANTANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210104'',''ATUNCOLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210105'',''CAPACHICA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210106'',''CHUCUITO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210107'',''COATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210108'',''HUATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210109'',''MAÑAZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210110'',''PAUCARCOLLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210111'',''PICHACANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210112'',''PLATERIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210113'',''SAN ANTONIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210114'',''TIQUILLACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210115'',''VILQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210200'',''AZANGARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210201'',''AZANGARO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210202'',''ACHAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210203'',''ARAPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210204'',''ASILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210205'',''CAMINACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210206'',''CHUPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210207'',''JOSE DOMINGO CHOQUEHUANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210208'',''MUÑANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210209'',''POTONI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210210'',''SAMAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210211'',''SAN ANTON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210212'',''SAN JOSE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210213'',''SAN JUAN DE SALINAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210214'',''SANTIAGO DE PUPUJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210215'',''TIRAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210300'',''CARABAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210301'',''MACUSANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210302'',''AJOYANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210303'',''AYAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210304'',''COASA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210305'',''CORANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210306'',''CRUCERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210307'',''ITUATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210308'',''OLLACHEA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210309'',''SAN GABAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210310'',''USICAYOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210400'',''CHUCUITO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210401'',''JULI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210402'',''DESAGUADERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210403'',''HUACULLANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210404'',''KELLUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210405'',''PISACOMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210406'',''POMATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210407'',''ZEPITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210500'',''EL COLLAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210501'',''ILAVE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210502'',''CAPAZO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210503'',''PILCUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210504'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210505'',''CONDURIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210600'',''HUANCANE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210601'',''HUANCANE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210602'',''COJATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210603'',''HUATASANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210604'',''INCHUPALLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210605'',''PUSI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210606'',''ROSASPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210607'',''TARACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210608'',''VILQUE CHICO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210700'',''LAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210701'',''LAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210702'',''CABANILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210703'',''CALAPUJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210704'',''NICASIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210705'',''OCUVIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210706'',''PALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210707'',''PARATIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210708'',''PUCARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210709'',''SANTA LUCIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210710'',''VILAVILA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210800'',''MELGAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210801'',''AYAVIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210802'',''ANTAUTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210803'',''CUPI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210804'',''LLALLI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210805'',''MACARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210806'',''NUÑOA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210807'',''ORURILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210808'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210809'',''UMACHIRI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210900'',''MOHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210901'',''MOHO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210902'',''CONIMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210903'',''HUAYRAPATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''210904'',''TILALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211000'',''SAN ANTONIO DE PUTINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211001'',''PUTINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211002'',''ANANEA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211003'',''PEDRO VILCA APAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211004'',''QUILCAPUNCU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211005'',''SINA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211100'',''SAN ROMAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211101'',''JULIACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211102'',''CABANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211103'',''CABANILLAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211104'',''CARACOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211200'',''SANDIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211201'',''SANDIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211202'',''CUYOCUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211203'',''LIMBANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211204'',''PATAMBUCO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211205'',''PHARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211206'',''QUIACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211207'',''SAN JUAN DEL ORO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211208'',''YANAHUAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211209'',''ALTO INAMBARI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211300'',''YUNGUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211301'',''YUNGUYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211302'',''ANAPIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211303'',''COPANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211304'',''CUTURAPI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211305'',''OLLARAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211306'',''TINICACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''211307'',''UNICACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220000'',''SAN MARTIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220100'',''MOYOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220101'',''MOYOBAMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220102'',''CALZADA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220103'',''HABANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220104'',''JEPELACIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220105'',''SORITOR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220106'',''YANTALO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220200'',''BELLAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220201'',''BELLAVISTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220202'',''ALTO BIAVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220203'',''BAJO BIAVO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220204'',''HUALLAGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220205'',''SAN PABLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220206'',''SAN RAFAEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220300'',''EL DORADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220301'',''SAN JOSE DE SISA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220302'',''AGUA BLANCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220303'',''SAN MARTIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220304'',''SANTA ROSA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220305'',''SHATOJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220400'',''HUALLAGA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220401'',''SAPOSOA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220402'',''ALTO SAPOSOA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220403'',''EL ESLABON'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220404'',''PISCOYACU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220405'',''SACANCHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220406'',''TINGO DE SAPOSOA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220500'',''LAMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220501'',''LAMAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220502'',''ALONSO DE ALVARADO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220503'',''BARRANQUITA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220504'',''CAYNARACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220505'',''CUÑUMBUQUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220506'',''PINTO RECODO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220507'',''RUMISAPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220508'',''SAN ROQUE DE CUMBAZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220509'',''SHANAO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220510'',''TABALOSOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220511'',''ZAPATERO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220600'',''MARISCAL CACERES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220601'',''JUANJUI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220602'',''CAMPANILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220603'',''HUICUNGO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220604'',''PACHIZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220605'',''PAJARILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220700'',''PICOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220701'',''PICOTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220702'',''BUENOS AIRES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220703'',''CASPISAPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220704'',''PILLUANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220705'',''PUCACACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220706'',''SAN CRISTOBAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220707'',''SAN HILARION'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220708'',''SHAMBOYACU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220709'',''TINGO DE PONASA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220710'',''TRES UNIDOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220800'',''RIOJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220801'',''RIOJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220802'',''AWAJUN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220803'',''ELIAS SOPLIN VARGAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220804'',''NUEVA CAJAMARCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220805'',''PARDO MIGUEL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220806'',''POSIC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220807'',''SAN FERNANDO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220808'',''YORONGOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220809'',''YURACYACU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220900'',''SAN MARTIN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220901'',''TARAPOTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220902'',''ALBERTO LEVEAU'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220903'',''CACATACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220904'',''CHAZUTA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220905'',''CHIPURANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220906'',''EL PORVENIR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220907'',''HUIMBAYOC'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220908'',''JUAN GUERRA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220909'',''LA BANDA DE SHILCAYO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220910'',''MORALES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220911'',''PAPAPLAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220912'',''SAN ANTONIO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220913'',''SAUCE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''220914'',''SHAPAJA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221000'',''TOCACHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221001'',''TOCACHE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221002'',''NUEVO PROGRESO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221003'',''POLVORA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221004'',''SHUNTE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''221005'',''UCHIZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230000'',''TACNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230100'',''TACNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230101'',''TACNA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230102'',''ALTO DE LA ALIANZA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230103'',''CALANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230104'',''CIUDAD NUEVA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230105'',''INCLAN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230106'',''PACHIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230107'',''PALCA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230108'',''POCOLLAY'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230109'',''SAMA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230110'',''CORONEL GREGORIO ALBARRACIN LANCHIPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230200'',''CANDARAVE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230201'',''CANDARAVE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230202'',''CAIRANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230203'',''CAMILACA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230204'',''CURIBAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230205'',''HUANUARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230206'',''QUILAHUANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230300'',''JORGE BASADRE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230301'',''LOCUMBA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230302'',''ILABAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230303'',''ITE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230400'',''TARATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230401'',''TARATA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230402'',''CHUCATAMANI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230403'',''ESTIQUE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230404'',''ESTIQUE-PAMPA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230405'',''SITAJARA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230406'',''SUSAPAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230407'',''TARUCACHI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''230408'',''TICACO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240000'',''TUMBES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240100'',''TUMBES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240101'',''TUMBES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240102'',''CORRALES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240103'',''LA CRUZ'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240104'',''PAMPAS DE HOSPITAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240105'',''SAN JACINTO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240106'',''SAN JUAN DE LA VIRGEN'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240200'',''CONTRALMIRANTE VILLAR'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240201'',''ZORRITOS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240202'',''CASITAS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240300'',''ZARUMILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240301'',''ZARUMILLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240302'',''AGUAS VERDES'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240303'',''MATAPALO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''240304'',''PAPAYAL'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250000'',''UCAYALI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250100'',''CORONEL PORTILLO'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250101'',''CALLERIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250102'',''CAMPOVERDE'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250103'',''IPARIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250104'',''MASISEA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250105'',''YARINACOCHA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250106'',''NUEVA REQUENA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250200'',''ATALAYA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250201'',''RAYMONDI'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250202'',''SEPAHUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250203'',''TAHUANIA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250204'',''YURUA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250300'',''PADRE ABAD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250301'',''PADRE ABAD'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250302'',''IRAZOLA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250303'',''CURIMANA'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250400'',''PURUS'',''A'')
insert into adm_ubigeo (ubigeoid,ubigeo,estado) values (''250401'',''PURUS'',''A'')


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameDatosActividad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameDatosActividad](@ajusteid numeric(8,0),@tipoActividad numeric(8,0))
as
begin
	SELECT     TOP 1 dbo.RGN_ACTIVIDAD.FechaHoraCoordinacion, dbo.RGN_ACTIVIDAD.lugarDeReunion, dbo.RGN_ACTIVIDAD.referencia, 
                      dbo.RGN_ACTIVIDAD.personaContacto, dbo.RGN_ACTIVIDAD.CargoPersonaContacto, dbo.RGN_ACTIVIDAD.PersonaEntrevistada, 
                      dbo.RGN_ACTIVIDAD.FechaHoraReunion, dbo.RGN_ACTIVIDAD.descripcion, dbo.RGN_ACTIVIDAD.ubigeoId, 
                      dbo.RGN_ACTIVIDAD.telefonoPersonaContacto, dbo.ADM_UBIGEO.ubigeo
FROM         dbo.RGN_ACTIVIDAD INNER JOIN
                      dbo.ADM_UBIGEO ON dbo.RGN_ACTIVIDAD.ubigeoId = dbo.ADM_UBIGEO.ubigeoId

	WHERE     (ajusteId = @ajusteId) AND (tipoActividadId = @tipoActividad)

end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_PolizaAsociadaDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_Rgen_PolizaAsociadaDelete]
(
	@polizaId numeric(8,0),
	@ajusteId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	delete FROM RGN_AJUSTE_CLAUSULAS
	WHERE polizaId = @polizaId  AND
		[ajusteId] = @ajusteId
	
	delete from RGN_ATRIBUTOPOLIZA_AJUSTE 
	where polizaId = @polizaId  AND
		[ajusteId] = @ajusteId

    delete from dbo.RGN_ITEMASEGURADO_AJUSTE
	where polizaId = @polizaId  AND
		[ajusteId] = @ajusteId
	
	SET @Err = @@Error

	if @Err = 0 
	begin 	
		DELETE
		FROM [RGN_POLIZA_AJUSTE]
		WHERE
		[polizaId] = @polizaId AND
		[ajusteId] = @ajusteId
	end 
	else 
	begin
		raiserror(''hubo problemas al desasociar la póliza por favor contacte al administrador'', 16,1);
		return;
	end

	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasAjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ClausulasAjusteInsert]
(
	@ajusteId numeric(8,0),
	@polizaId numeric (8,0),
	@clausulasId numeric (8,0),
	@usuario varchar(20)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @aseguradoraId  numeric (8,0)

	Select @aseguradoraId=aseguradoraId
	FROM RGN_POLIZA
	WHERE RGN_POLIZA.polizaId=@polizaId

	SELECT * FROM RGN_AJUSTE_CLAUSULAS
	WHERE (ajusteId=@ajusteId)AND (polizaId=@polizaId)
		AND (clausulasId=@clausulasId)

	if @@ROWCOUNT=0
	BEGIN 

		INSERT
		INTO RGN_AJUSTE_CLAUSULAS
		(
			ajusteId,
			polizaId,
			aseguradoraId,
			clausulasId,
			ucrea,
			uupdate,
			fcrea,
			fupdate
			
		)
		VALUES
		(
			@ajusteId,
			@polizaId,
			@aseguradoraId,
			@clausulasId,
			@usuario,
			@usuario,
			getdate(),
			getdate()
		)
	END
	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delapoliza_clausulas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delapoliza_clausulas]
(
	@ajusteid int
)
as

	SELECT  RGN_CLAUSULAS.nombre
	FROM    RGN_AJUSTE_CLAUSULAS INNER JOIN
          RGN_CLAUSULAS ON 
          RGN_AJUSTE_CLAUSULAS.clausulasId = RGN_CLAUSULAS.clausulasId AND 
          RGN_AJUSTE_CLAUSULAS.polizaId = RGN_CLAUSULAS.polizaId AND 
          RGN_AJUSTE_CLAUSULAS.aseguradoraId = RGN_CLAUSULAS.aseguradoraId
	WHERE   (RGN_AJUSTE_CLAUSULAS.ajusteId = @ajusteid)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_ClausulasAjusteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_ClausulasAjusteDelete]
(
	@clausulasId numeric(8,0),
	@ajusteId numeric (8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_AJUSTE_CLAUSULAS]
	WHERE [RGN_AJUSTE_CLAUSULAS].clausulasId=@clausulasId
	AND ajusteId=@ajusteId

	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ClausulasSelectById]
    (
      @polizaId numeric(8, 0),
      @ajusteId numeric(8, 0) = null
    )
AS 
    BEGIN
        SET NOCOUNT ON
        DECLARE @Err INT
        
        IF ( @ajusteId IS NOT NULL ) 
            BEGIN
		
                SELECT  [clausulasId],
                        [polizaId],
                        [aseguradoraId],
                        [nombre],
                        [contenido],
                        [FLAGExiste] = case isnull(( select x.polizaId
                                                     from   RGN_AJUSTE_CLAUSULAS x
                                                     where  x.clausulasId = RGN_CLAUSULAS.clausulasId
                                                            and x.polizaId = RGN_CLAUSULAS.polizaId
                                                            and x.aseguradoraId = RGN_CLAUSULAS.aseguradoraId
                                                            and x.ajusteId = @ajusteId
                                                   ), -1)
                                         when -1 then 1
                                         else 0
                                       end
                FROM    [RGN_CLAUSULAS]
                WHERE   ( [polizaId] = @polizaId )
        
            END
        
        ELSE 
            BEGIN
                SELECT  [clausulasId],
                        [polizaId],
                        [aseguradoraId],
                        [nombre],
                        [contenido],
                        1 AS FlagExiste
                FROM    [RGN_CLAUSULAS]
                WHERE   [polizaId] = @polizaId   AND ([estado] <>''I''  or estado is null)
            END
        

        SET @Err = @@Error

        RETURN @Err
    END





--[sp_rgen_ClausulasSelectById] 978

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_ClausulasDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_ClausulasDelete]
(
	@clausulasId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_AJUSTE_CLAUSULAS]
	WHERE [RGN_AJUSTE_CLAUSULAS].clausulasId=@clausulasId

	DELETE
	FROM [RGN_CLAUSULAS]
	WHERE
		[clausulasId] = @clausulasId
	SET @Err = @@Error

	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AnexoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AnexoDelete]
(
	@Original_ajusteId numeric(8, 0),
	@Original_archivoId numeric
)
AS
	SET NOCOUNT OFF;
DELETE FROM  [RGN_ANEXO] WHERE (([ajusteId] = @Original_ajusteId) AND ([archivoId] = @Original_archivoId))' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AnexoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_AnexoInsert]
(
	@ajusteId numeric(8, 0),
	@nombrearchivo varchar(255),
	@descripcion varchar(250),
	@archivoFisico image,
	@imagen bit,
	@imagenthumb image
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [RGN_ANEXO] 
([ajusteId], [nombrearchivo], [descripcion], [fechaRegistro], [archivoFisico], [imagen], [imagenthumb], [mostrarEnInformes] ) 
VALUES (@ajusteId, @nombrearchivo, @descripcion, getDate(), @archivoFisico, @imagen, @imagenthumb, 1);
	
SELECT ajusteId, nombrearchivo, descripcion, archivoFisico, archivoId,imagen FROM RGN_ANEXO WHERE (ajusteId = @ajusteId) AND (archivoId = SCOPE_IDENTITY())
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AnexoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AnexoUpdate]
(	
	@archivoid numeric(8,0),
	@descripcion varchar(250),
	@uupdate varchar(20),
	@mostrarEninformes bit,
	@original_ajusteId numeric(8,0),
	@original_archivoId numeric(8,0)
)
AS
	SET NOCOUNT OFF;
update [RGN_ANEXO] set

[descripcion]= @descripcion,
[uupdate] = @uupdate,
[fupdate] = getdate(),
[mostrarEnInformes]  = @mostrarEninformes

where ajusteId = @original_ajusteId and archivoId = @original_archivoId
	
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_imagenes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_informebasico_imagenes](@ajusteid int)
as

	SELECT	archivoId,archivoFisico, UPPER(descripcion) AS descripcion
	FROM    RGN_ANEXO
	WHERE   (RGN_ANEXO.imagen = 1) AND
	        (RGN_ANEXO.ajusteid = @ajusteid)AND RGN_ANEXO.mostrarEnInformes=1



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AnexoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AnexoSelect]
(
	@ajusteId numeric(8, 0)
)
AS
SET NOCOUNT ON;
SELECT     ajusteId,
	   nombrearchivo,
	   descripcion,
           archivoId,
	   fechaRegistro,
	   imagenthumb,
	   imagen,
	   mostrarEnInformes
FROM      RGN_ANEXO
WHERE     (ajusteId = @ajusteId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SelectThumbNail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SelectThumbNail]
(
	@ajusteId numeric(8, 0),
	@archivoId numeric
)
AS
	SET NOCOUNT ON;
SELECT     imagenthumb
FROM         RGN_ANEXO
WHERE     (ajusteId = @ajusteId) AND (archivoId = @archivoId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SelectContents]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SelectContents]
(
	@ajusteId numeric(8, 0),
	@archivoid numeric
)
AS
	SET NOCOUNT ON;
SELECT     archivoFisico
FROM         RGN_ANEXO
WHERE     (ajusteId = @ajusteId) AND (archivoId = @archivoid)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_DeduciblesAjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_DeduciblesAjusteInsert]
(
	@ajusteId numeric(8,0),
	@polizaId numeric (8,0),
	@atributoId numeric (8,0),
	@usuario varchar(20)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @aseguradoraId  numeric (8,0)

	Select @aseguradoraId=aseguradoraId
	FROM RGN_POLIZA
	WHERE RGN_POLIZA.polizaId=@polizaId

	Select * FROM RGN_ATRIBUTOPOLIZA_AJUSTE
	WHERE (ajusteId=@ajusteId)AND (polizaId=@polizaId)
		AND (atributoId=@atributoId)

	if @@ROWCOUNT=0
	BEGIN 
		

		INSERT
		INTO RGN_ATRIBUTOPOLIZA_AJUSTE
		(
			ajusteId,
			polizaId,
			aseguradoraId,
			atributoId,
			ucrea,
			uupdate,
			fcrea,
			fupdate
			
		)
		VALUES
		(
			@ajusteId,
			@polizaId,
			@aseguradoraId,
			@atributoId,
			@usuario,
			@usuario,
			getdate(),
			getdate()
		)
	END
	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_AtributosPolizaAjusteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_AtributosPolizaAjusteDelete]
(
	@atributoId numeric(8,0),
	@ajusteId numeric (8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_ATRIBUTOPOLIZA_AJUSTE]
	WHERE [RGN_ATRIBUTOPOLIZA_AJUSTE].atributoId=@atributoId
	AND	ajusteId=@ajusteId
	
	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ComunicacionDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ComunicacionDelete]
(
	@Original_ajusteId numeric(8, 0),
	@Original_comunicacionid numeric
)
AS
	SET NOCOUNT OFF;
DELETE FROM  [RGN_COMUNICACION] WHERE (([ajusteId] = @Original_ajusteId) AND ([comunicacionid] = @Original_comunicacionid))' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ComunicacionInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ComunicacionInsert]
(
	@ajusteId numeric(8, 0),
	@descripcion varchar(250),
	@nombreArchivo varchar(100),
	@tcomunicacionId numeric(8, 0),
	@asunto varchar(100),
	@archivoFisico image,
	@cuerpoCorreo varchar(1000),
	@Emisor varchar(250),
	@Receptor varchar(250)
)
AS
	SET NOCOUNT OFF;
INSERT INTO  [RGN_COMUNICACION] ([ajusteId], [descripcion], [nombreArchivo], [fechaRegistro], [tcomunicacionId], [asunto], [archivoFisico], [cuerpoCorreo], [Emisor], [Receptor]) VALUES (@ajusteId, @descripcion, @nombreArchivo, getDate(), @tcomunicacionId,
 @asunto, @archivoFisico, @cuerpoCorreo, @Emisor, @Receptor);
	
SELECT ajusteId, descripcion, nombreArchivo, fechaRegistro, tcomunicacionId, asunto, archivoFisico, cuerpoCorreo, Emisor, Receptor, comunicacionid FROM RGN_COMUNICACION WHERE (ajusteId = @ajusteId) AND (comunicacionid = SCOPE_IDENTITY())' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ComunicacionUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ComunicacionUpdate]
(
	@ajusteId numeric(8, 0),
	@descripcion varchar(250),
	@nombreArchivo varchar(100),
	@fechaRegistro datetime,
	@tcomunicacionId numeric(8, 0),
	@asunto varchar(100),
	@archivoFisico image,
	@cuerpoCorreo varchar(1000),
	@Emisor varchar(250),
	@Receptor varchar(250),
	@Original_ajusteId numeric(8, 0),
	@Original_comunicacionid numeric,
	@comunicacionid numeric
)
AS
	SET NOCOUNT OFF;
UPDATE  [RGN_COMUNICACION] SET [ajusteId] = @ajusteId, [descripcion] = @descripcion, [nombreArchivo] = @nombreArchivo, [fechaRegistro] = @fechaRegistro, [tcomunicacionId] = @tcomunicacionId, [asunto] = @asunto, [archivoFisico] = @archivoFisico, [cuerpoCorreo] = @cuerpoCorreo, [Emisor] = @Emisor, [Receptor] = @Receptor WHERE (([ajusteId] = @Original_ajusteId) AND ([comunicacionid] = @Original_comunicacionid));
	
SELECT ajusteId, descripcion, nombreArchivo, fechaRegistro, tcomunicacionId, asunto, archivoFisico, cuerpoCorreo, Emisor, Receptor, comunicacionid FROM RGN_COMUNICACION WHERE (ajusteId = @ajusteId) AND (comunicacionid = @comunicacionid)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ComunicacionSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ComunicacionSelect]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT ajusteId, descripcion, nombreArchivo, fechaRegistro, tcomunicacionId, asunto, archivoFisico, cuerpoCorreo, Emisor, Receptor, comunicacionid FROM RGN_COMUNICACION WHERE (ajusteId = @ajusteId)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ComunicacionLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ComunicacionLista]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT        RGN_COMUNICACION.ajusteId, 
	      RGN_COMUNICACION.descripcion, 
	      RGN_COMUNICACION.nombreArchivo, 
	      RGN_COMUNICACION.fechaRegistro, 
	      RGN_COMUNICACION.tcomunicacionId, 
	      RGN_COMUNICACION.asunto, 
	      RGN_COMUNICACION.cuerpoCorreo, 
	      RGN_COMUNICACION.Emisor, 
	      RGN_COMUNICACION.Receptor, 
              RGN_TIPOCOMUNICACION.nombre, 
	      RGN_COMUNICACION.comunicacionid
FROM         RGN_COMUNICACION INNER JOIN
                      RGN_TIPOCOMUNICACION ON 
               RGN_COMUNICACION.tcomunicacionId = RGN_TIPOCOMUNICACION.tcomunicacionId
WHERE     (RGN_COMUNICACION.ajusteId = @ajusteId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EquipoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_EquipoSelect]
	@AjusteId numeric 
AS
	SET NOCOUNT ON;
SELECT     equipoId, NombrePersona, Especialidad, ajusteId, estado
FROM         RGN_EQUIPO
WHERE  (RGN_EQUIPO.estado=''A'')and RGN_EQUIPO.ajusteid=@AjusteId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EquipoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_EquipoInsert]
(
	@NombrePersona varchar(500),
	@Especialidad varchar(500),
	@ajusteId numeric(8, 0),
	@ucrea varchar(20),
	@uupdate varchar(20)


)
AS
	SET NOCOUNT OFF;
INSERT INTO [RGN_EQUIPO] 
           ([NombrePersona], 
            [Especialidad], 
            [ajusteId], 
            [estado],
            [fcrea],
	    [fupdate],
            [ucrea],
            [uupdate]) 
       VALUES (@NombrePersona, 
               @Especialidad, 
               @ajusteId, 
               ''A'',
	       getDate(),
	       getDate(),
	       @ucrea,
	       @uupdate)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EquipoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_EquipoDelete]
(
	@equipoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_Equipo]
	WHERE [equipoId]=@equipoId

	SET @Err = @@Error

	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_administraEstados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_administraEstados] 
(
	@ajusteId numeric(8,0)
)
as

SELECT     dbo.RGN_ESTADOAJUSTE.estadoajuste, dbo.RGN_ESTADOAJUSTE.codigo, dbo.RGN_ESTADOSAJUSTE.FechaDeCambio, 
                      dbo.RGN_ESTADOAJUSTE.estadoajusteid
FROM         dbo.RGN_ESTADOSAJUSTE RIGHT OUTER JOIN
                      dbo.RGN_ESTADOAJUSTE ON dbo.RGN_ESTADOSAJUSTE.estadoajusteid = dbo.RGN_ESTADOAJUSTE.estadoajusteid AND 
                      dbo.RGN_ESTADOSAJUSTE.estadoajusteid = dbo.RGN_ESTADOAJUSTE.estadoajusteid AND dbo.RGN_ESTADOSAJUSTE.ajusteId = @ajusteId
ORDER BY dbo.RGN_ESTADOAJUSTE.codigo' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTiempoEnElEstado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[pTiempoEnElEstado](@ajusteId numeric(8,0),@codigo numeric(18,0))
as

declare @siguientecodigo numeric(18,0)
declare @codigoId numeric(8,0)
declare @siguientecodigoId numeric(8,0)

declare @Fecha1 datetime
declare @Fecha2 datetime
	
	set  @siguientecodigo = @codigo + 1

	select @codigoId = estadoajusteid 
	from dbo.RGN_ESTADOAJUSTE
	where codigo =@codigo

	select @siguientecodigoId = estadoajusteid 
	from dbo.RGN_ESTADOAJUSTE
	where codigo =@siguientecodigo
 

	select @Fecha1 = FechaDeCambio
	from  RGN_ESTADOSAJUSTE 
	where ajusteId = @ajusteId and 
			  estadoajusteid = @codigoId

	select @Fecha2 = FechaDeCambio
	from  RGN_ESTADOSAJUSTE 
	where ajusteId = @ajusteId and 
			  estadoajusteid = @siguientecodigoId

	select datediff(d,@Fecha1,@Fecha2)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_cambiaEstadoAjusteAdmin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_cambiaEstadoAjusteAdmin](
	@FechaDeCambio datetime,
	@ajusteId numeric(8,0),
	@estadoajusteid numeric(8,0),
	@u_ucrea varchar(50))
as
begin
	declare @EstadoEnc numeric(8,0)
	
	select @EstadoEnc = Count(*) from rgn_estadosAjuste where ajusteId = @AjusteId and estadoAjusteId = @estadoAjusteId

	if (@EstadoEnc =  0) 
	begin	
		insert 
		into 
			rgn_estadosAjuste(FechaDeCambio,ajusteId,estadoAjusteId,ucrea,estado,fcrea)
		values
		(@FechaDeCambio,
		@AjusteId,
		 @estadoAjusteId,
		 @u_ucrea,
		 ''A'',
		getDate())

	end
	else 
	begin	
		--if (@estadoAjusteId <> 19) 
		--begin
			update rgn_estadosAjuste set 
				FechaDeCambio = @FechaDeCambio,
				fupdate = getDate(),
				uupdate = @u_ucrea			
			where ajusteId = @AjusteId and estadoAjusteId = @estadoAjusteId
		--end
	end

end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActualizaEstadoAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActualizaEstadoAjuste](
	@AjusteId numeric(8,0),
	@estadoAjusteId numeric(8,0),
	@u_ucrea varchar(50))
as
begin
	update 	rgn_estadosAjuste set estadoajusteid=@estadoajusteid
	where ajusteid=@AjusteId and fcrea=@u_ucrea	
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_cambiaEstadoAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_cambiaEstadoAjuste](
	@fechaAux datetime,
	@AjusteId numeric(8,0),
	@estadoAjusteId numeric(8,0),
	@u_ucrea varchar(50))
as
begin
	declare @EstadoEnc numeric(8,0)
	
	select @EstadoEnc = Count(*) from rgn_estadosAjuste where ajusteId = @AjusteId and estadoAjusteId = @estadoAjusteId

	if (@EstadoEnc =  0) 
	begin	
		insert 
		into 
			rgn_estadosAjuste(FechaDeCambio,ajusteId,estadoAjusteId,ucrea,estado,fcrea)
		values
		(@fechaAux,
		@AjusteId,
		 @estadoAjusteId,
		 @u_ucrea,
		 ''A'',
		 getDate())

	end
	else 
	begin	
		if (@estadoAjusteId <> 18)  --cuando no es del tipo informe complementario actualiza el estado anterior, de manera 
		begin
			update rgn_estadosAjuste set 
				FechaDeCambio = @fechaAux,
				fupdate = getDate(),
				uupdate = @u_ucrea			
			where ajusteId = @AjusteId and estadoAjusteId = @estadoAjusteId
		end
	end

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TiempoEnElEstado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_TiempoEnElEstado](
	@ajusteId numeric(8,0),
	@codigo numeric(8,0)
)
as

begin

declare @codigoId numeric(8,0)
declare @siguientecodigo numeric(18,0)
declare @siguientecodigoId numeric(18,0)
declare @Fecha1 datetime
declare @Fecha2 datetime

select @codigoId = estadoajusteid 
	from dbo.RGN_ESTADOAJUSTE
	where codigo =@codigo

IF (@codigoId < 21)
BEGIN
		set @siguientecodigo = @codigo + 1

		select @siguientecodigoId = estadoajusteid 
			from dbo.RGN_ESTADOAJUSTE
			where codigo =@siguientecodigo

		select @Fecha1 = FechaDeCambio
			from  RGN_ESTADOSAJUSTE 
			where ajusteId = @ajusteId 
						and 
						estadoajusteid = @codigoId

			select @Fecha2 = FechaDeCambio
			from  RGN_ESTADOSAJUSTE 
			where ajusteId = @ajusteId 
						and 
						estadoajusteid = @siguientecodigoId

			if (@Fecha2 is Null) 
			begin
				set @Fecha2 = getdate()
			end

END
ELSE
BEGIN
	
			select @Fecha1 = FechaDeCambio
			from  RGN_ESTADOSAJUSTE 
			where ajusteId = @ajusteId 
						and 
						estadoajusteid = (@codigoId -1)

			select @Fecha2 = FechaDeCambio
			from  RGN_ESTADOSAJUSTE 
			where ajusteId = @ajusteId 
						and 
						estadoajusteid = @codigoId

END

declare @dias decimal
set @dias = datediff(d,@Fecha1,@Fecha2)
if (@dias < 0) set @dias = 0
select @codigo as codigo,isNull(@dias,-1) as dias

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_adduserobject_vcs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dt_adduserobject_vcs]
    @vchProperty varchar(64)

as

set nocount on

declare @iReturn int
    /*
    ** Create the user object if it does not exist already
    */
    begin transaction
        select @iReturn = objectid from dbo.dtproperties where property = @vchProperty
        if @iReturn IS NULL
        begin
            insert dbo.dtproperties (property) VALUES (@vchProperty)
            update dbo.dtproperties set objectid=@@identity
                    where id=@@identity and property=@vchProperty
            select @iReturn = @@identity
        end
    commit
    return @iReturn


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_checkinobject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' 
CREATE  proc [dbo].[dt_checkinobject]
    @chObjectType  char(4),
    @vchObjectName varchar(255),
    @vchComment    varchar(255)='''',
    @vchLoginName  varchar(255),
    @vchPassword   varchar(255)='''',
    @iVCSFlags     int = 0,
    @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
    @txStream1     Text = '''', /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
    @txStream2     Text = '''', /* alter  stream */
    @txStream3     Text = ''''  /* grant stream  */


as

	set nocount on

	declare @iReturn int
	declare @iObjectId int
	select @iObjectId = 0
	declare @iStreamObjectId int

	declare @VSSGUID varchar(100)
	select @VSSGUID = ''SQLVersionControl.VCS_SQL''

	declare @iPropertyObjectId int
	select @iPropertyObjectId  = 0

    select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = ''VCSProjectID'')

    declare @vchProjectName   varchar(255)
    declare @vchSourceSafeINI varchar(255)
    declare @vchServerName    varchar(255)
    declare @vchDatabaseName  varchar(255)
    declare @iReturnValue	  int
    declare @pos			  int
    declare @vchProcLinePiece varchar(255)

    
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSProject'',       @vchProjectName   OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSourceSafeINI'', @vchSourceSafeINI OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSQLServer'',     @vchServerName    OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSQLDatabase'',   @vchDatabaseName  OUT

    if @chObjectType = ''PROC''
    begin
        if @iActionFlag = 1
        begin
            /* Procedure Can have up to three streams
            Drop Stream, alter  Stream, GRANT stream */

            begin tran compile_all

            /* try to compile the streams */
            exec (@txStream1)
            if @@error <> 0 GOTO E_Compile_Fail

            exec (@txStream2)
            if @@error <> 0 GOTO E_Compile_Fail

            exec (@txStream3)
            if @@error <> 0 GOTO E_Compile_Fail
        end

        exec @iReturn = master.dbo.sp_OAalter  @VSSGUID, @iObjectId OUT
        if @iReturn <> 0 GOTO E_OAError

        exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, ''GetStreamObject'', @iStreamObjectId OUT
        if @iReturn <> 0 GOTO E_OAError
        
        if @iActionFlag = 1
        begin
            
            declare @iStreamLength int
			
			select @pos=1
			select @iStreamLength = datalength(@txStream2)
			
			if @iStreamLength > 0
			begin
			
				while @pos < @iStreamLength
				begin
						
					select @vchProcLinePiece = substring(@txStream2, @pos, 255)
					
					exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, ''AddStream'', @iReturnValue OUT, @vchProcLinePiece
            		if @iReturn <> 0 GOTO E_OAError
            		
					select @pos = @pos + 255
					
				end
            
				exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
														''CheckIn_StoredProcedure'',
														NULL,
														@sProjectName = @vchProjectName,
														@sSourceSafeINI = @vchSourceSafeINI,
														@sServerName = @vchServerName,
														@sDatabaseName = @vchDatabaseName,
														@sObjectName = @vchObjectName,
														@sComment = @vchComment,
														@sLoginName = @vchLoginName,
														@sPassword = @vchPassword,
														@iVCSFlags = @iVCSFlags,
														@iActionFlag = @iActionFlag,
														@sStream = ''''
                                        
			end
        end
        else
        begin
        
            select colid, text into #ProcLines
            from syscomments
            where id = object_id(@vchObjectName)
            order by colid

            declare @iCurProcLine int
            declare @iProcLines int
            select @iCurProcLine = 1
            select @iProcLines = (select count(*) from #ProcLines)
            while @iCurProcLine <= @iProcLines
            begin
                select @pos = 1
                declare @iCurLineSize int
                select @iCurLineSize = len((select text from #ProcLines where colid = @iCurProcLine))
                while @pos <= @iCurLineSize
                begin                
                    select @vchProcLinePiece = convert(varchar(255),
                        substring((select text from #ProcLines where colid = @iCurProcLine),
                                  @pos, 255 ))
                    exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, ''AddStream'', @iReturnValue OUT, @vchProcLinePiece
                    if @iReturn <> 0 GOTO E_OAError
                    select @pos = @pos + 255                  
                end
                select @iCurProcLine = @iCurProcLine + 1
            end
            drop table #ProcLines

            exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
													''CheckIn_StoredProcedure'',
													NULL,
													@sProjectName = @vchProjectName,
													@sSourceSafeINI = @vchSourceSafeINI,
													@sServerName = @vchServerName,
													@sDatabaseName = @vchDatabaseName,
													@sObjectName = @vchObjectName,
													@sComment = @vchComment,
													@sLoginName = @vchLoginName,
													@sPassword = @vchPassword,
													@iVCSFlags = @iVCSFlags,
													@iActionFlag = @iActionFlag,
													@sStream = ''''
        end

        if @iReturn <> 0 GOTO E_OAError

        if @iActionFlag = 1
        begin
            commit tran compile_all
            if @@error <> 0 GOTO E_Compile_Fail
        end

    end

CleanUp:
	return

E_Compile_Fail:
	declare @lerror int
	select @lerror = @@error
	rollback tran compile_all
	RAISERROR (@lerror,16,-1)
	goto CleanUp

E_OAError:
	if @iActionFlag = 1 rollback tran compile_all
	exec dbo.dt_displayoaerror @iObjectId, @iReturn
	goto CleanUp



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_whocheckedout]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' 
CREATE  proc [dbo].[dt_whocheckedout]
        @chObjectType  char(4),
        @vchObjectName varchar(255),
        @vchLoginName  varchar(255),
        @vchPassword   varchar(255)

as

set nocount on

declare @iReturn int
declare @iObjectId int
select @iObjectId =0

declare @VSSGUID varchar(100)
select @VSSGUID = ''SQLVersionControl.VCS_SQL''

    declare @iPropertyObjectId int

    select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = ''VCSProjectID'')

    declare @vchProjectName   varchar(255)
    declare @vchSourceSafeINI varchar(255)
    declare @vchServerName    varchar(255)
    declare @vchDatabaseName  varchar(255)
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSProject'',       @vchProjectName   OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSourceSafeINI'', @vchSourceSafeINI OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSQLServer'',     @vchServerName    OUT
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSQLDatabase'',   @vchDatabaseName  OUT

    if @chObjectType = ''PROC''
    begin
        exec @iReturn = master.dbo.sp_OAalter  @VSSGUID, @iObjectId OUT

        if @iReturn <> 0 GOTO E_OAError

        declare @vchReturnValue varchar(255)
        select @vchReturnValue = ''''

        exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
												''WhoCheckedOut'',
												@vchReturnValue OUT,
												@sProjectName = @vchProjectName,
												@sSourceSafeINI = @vchSourceSafeINI,
												@sObjectName = @vchObjectName,
												@sServerName = @vchServerName,
												@sDatabaseName = @vchDatabaseName,
												@sLoginName = @vchLoginName,
												@sPassword = @vchPassword

        if @iReturn <> 0 GOTO E_OAError

        select @vchReturnValue

    end

CleanUp:
    return

E_OAError:
    exec dbo.dt_displayoaerror @iObjectId, @iReturn
    GOTO CleanUp



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_validateloginparams]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' 
CREATE  proc [dbo].[dt_validateloginparams]
    @vchLoginName  varchar(255),
    @vchPassword   varchar(255)
as

set nocount on

declare @iReturn int
declare @iObjectId int
select @iObjectId =0

declare @VSSGUID varchar(100)
select @VSSGUID = ''SQLVersionControl.VCS_SQL''

    declare @iPropertyObjectId int
    select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = ''VCSProjectID'')

    declare @vchSourceSafeINI varchar(255)
    exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, ''VCSSourceSafeINI'', @vchSourceSafeINI OUT

    exec @iReturn = master.dbo.sp_OAalter  @VSSGUID, @iObjectId OUT
    if @iReturn <> 0 GOTO E_OAError

    exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
											''ValidateLoginParams'',
											NULL,
											@sSourceSafeINI = @vchSourceSafeINI,
											@sLoginName = @vchLoginName,
											@sPassword = @vchPassword
    if @iReturn <> 0 GOTO E_OAError

CleanUp:
    return

E_OAError:
    exec dbo.dt_displayoaerror @iObjectId, @iReturn
    GOTO CleanUp



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getpropertiesbyid_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Retrieve properties by id''s
**
**	dt_getproperties objid, null or '''' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
CREATE  procedure [dbo].[dt_getpropertiesbyid_u]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '''')
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_droppropertiesbyid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  procedure [dbo].[dt_droppropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '''')
		delete from dbo.dtproperties where objectid=@id
	else
		delete from dbo.dtproperties 
			where objectid=@id and property=@property
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_dropuserobjectbyid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Drop an object from the dbo.dtproperties table
*/
CREATE  procedure [dbo].[dt_dropuserobjectbyid]
	@id int
as
	set nocount on
	delete from dbo.dtproperties where objectid=@id' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getobjwithprop_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Retrieve the owner object(s) of a given property
*/
CREATE  procedure [dbo].[dt_getobjwithprop_u]
	@property varchar(30),
	@uvalue nvarchar(255)
as
	set nocount on

	if (@property is null) or (@property = '''')
	begin
		raiserror(''Must specify a property name.'',-1,-1)
		return (1)
	end

	if (@uvalue is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and uvalue=@uvalue' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getpropertiesbyid_vcs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  procedure [dbo].[dt_getpropertiesbyid_vcs]
    @id       int,
    @property varchar(64),
    @value    varchar(255) = NULL OUT

as

    set nocount on

    select @value = (
        select value
                from dbo.dtproperties
                where @id=objectid and @property=property
                )
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_generateansiname]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
**	Generate an ansi name that is unique in the dtproperties.value column 
*/ 
CREATE PROCEDURE [dbo].[dt_generateansiname](@name varchar(255) output) 
as 
	declare @prologue varchar(20) 
	declare @indexstring varchar(20) 
	declare @index integer 
 
	set @prologue = ''MSDT-A-'' 
	set @index = 1 
 
	while 1 = 1 
	begin 
		set @indexstring = cast(@index as varchar(20)) 
		set @name = @prologue + @indexstring 
		if not exists (select value from dtproperties where value = @name) 
			break 
		 
		set @index = @index + 1 
 
		if (@index = 10000) 
			goto TooMany 
	end 
 
Leave: 
 
	return 
 
TooMany: 
 
	set @name = ''DIAGRAM'' 
	goto Leave 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_adduserobject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Add an object to the dtproperties table
*/
CREATE PROCEDURE [dbo].[dt_adduserobject]
as
	set nocount on
	/*
	** Create the user object if it does not exist already
	*/
	begin transaction
		insert dbo.dtproperties (property) VALUES (''DtgSchemaOBJECT'')
		update dbo.dtproperties set objectid=@@identity 
			where id=@@identity and property=''DtgSchemaOBJECT''
	commit
	return @@identity
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_setpropertybyid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		value -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
CREATE PROCEDURE [dbo].[dt_setpropertybyid]
	@id int,
	@property varchar(64),
	@value varchar(255),
	@lvalue image
as
	set nocount on
	declare @uvalue nvarchar(255) 
	set @uvalue = convert(nvarchar(255), @value) 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@value, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @value, @uvalue, @lvalue)
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getobjwithprop]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Retrieve the owner object(s) of a given property
*/
CREATE PROCEDURE [dbo].[dt_getobjwithprop]
	@property varchar(30),
	@value varchar(255)
as
	set nocount on

	if (@property is null) or (@property = '''')
	begin
		raiserror(''Must specify a property name.'',-1,-1)
		return (1)
	end

	if (@value is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and value=@value' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getpropertiesbyid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	Retrieve properties by id''s
**
**	dt_getproperties objid, null or '''' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
CREATE  procedure [dbo].[dt_getpropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '''')
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformacionRelevanteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformacionRelevanteSelect] 
(	
	
	@ajusteid numeric(8,0)
	
	
	
)
AS
BEGIN
select * from RGN_INFORMACIONRELEVANTE
WHERE ajusteId=@ajusteId order by fcrea desc


end
SET QUOTED_IDENTIFIER OFF 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformacionRelevanteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformacionRelevanteDelete]
(
	@informacionId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_INFORMACIONRELEVANTE]
	WHERE [RGN_INFORMACIONRELEVANTE].informacionId=@informacionId

	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformacionRelevanteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformacionRelevanteInsert]
(	
	@usuario varchar(100),
	@ajusteid numeric(8,0),
	@titulo varchar (200),
	@contenido varchar(200)
	
)
AS
BEGIN
insert into RGN_INFORMACIONRELEVANTE
            (titulo,
	     contenido,
	     ajusteId,
             fupdate, 
 	     fcrea,
             estado,
             ucrea,
             uupdate)
       values (  @titulo,
		 @contenido,
		 @ajusteid,
		 getdate(),
		 getdate(),
                 ''A'',
                 @usuario,
                 @usuario
	       )	 


end
SET QUOTED_IDENTIFIER OFF 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_ItemAseguradoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_ItemAseguradoDelete]
(
	@itemAseguradosId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [RGN_ITEMASEGURADO_AJUSTE]
	WHERE
		[itemAseguradosId] = @itemAseguradosId


	DELETE
	FROM [RGN_ITEMASEGURADO]
	WHERE
		[itemAseguradosId] = @itemAseguradosId
	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ItemAseguradoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ItemAseguradoSelectById]
(
	@polizaId numeric(8,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		RGN_ITEMASEGURADO.itemAseguradosId,
		RGN_ITEMASEGURADO.polizaId,
		RGN_ITEMASEGURADO.aseguradoraId,
		RGN_ITEMASEGURADO.nombreItem,
		RGN_ITEMASEGURADO.concepto,
		RGN_ITEMASEGURADO.montoAsegurado,
		RGN_ITEMASEGURADO.montosoles,
		RGN_ITEMASEGURADO.concepto2,
		RGN_ITEMASEGURADO.montoAsegurado2,
		RGN_ITEMASEGURADO.montosoles2,
		ADM_MONEDA.simbolo As simbolo,
		RGN_ITEMASEGURADO.monedaId,
		RGN_ITEMASEGURADO.tipoCambio,
		RGN_ITEMASEGURADO.localItem,
--		RGN_ITEMASEGURADO.nroItem,
		FLAGExiste = 
		case isnull((select x.polizaId 
			from RGN_ITEMASEGURADO_AJUSTE x
			where x.itemAseguradosId = RGN_ITEMASEGURADO.itemAseguradosId and
			  x.polizaId = RGN_ITEMASEGURADO.polizaId and
			  x.aseguradoraId = RGN_ITEMASEGURADO.aseguradoraId
			),-1) 
		when -1 then 1 else 0 end
	FROM  RGN_ITEMASEGURADO, ADM_MONEDA
	WHERE
		
		(RGN_ITEMASEGURADO.polizaId = @polizaId)and
		(ADM_MONEDA.monedaId=RGN_ITEMASEGURADO.monedaId) 

	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_ItemAseguradoAjusteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_ItemAseguradoAjusteDelete]
(
	@itemAseguradosId numeric(8,0),
	@ajusteId numeric (8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM RGN_ITEMASEGURADO_AJUSTE
	WHERE
		itemAseguradosId = @itemAseguradosId 
		AND	ajusteId=@ajusteId


	SET @Err = @@Error

	RETURN @Err
END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ItemAsegurado_Poliza_Ajuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ItemAsegurado_Poliza_Ajuste]
(
	@polizaId numeric(8,0),
	@ajusteId numeric(8,0)	
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		RGN_ITEMASEGURADO.itemAseguradosId,
		RGN_ITEMASEGURADO.polizaId,
		RGN_ITEMASEGURADO.aseguradoraId,
		RGN_ITEMASEGURADO.nombreItem,
		RGN_ITEMASEGURADO.concepto,
		RGN_ITEMASEGURADO.montoAsegurado,
		RGN_ITEMASEGURADO.montosoles,
		RGN_ITEMASEGURADO.concepto2,
		RGN_ITEMASEGURADO.montoAsegurado2,
		RGN_ITEMASEGURADO.montosoles2,
		ADM_MONEDA.simbolo As simbolo,
		RGN_ITEMASEGURADO.monedaId,
		RGN_ITEMASEGURADO.tipoCambio,
		RGN_ITEMASEGURADO.localItem,
--		RGN_ITEMASEGURADO.nroItem,
		FLAGExiste = 
		case isnull((select x.polizaId 
			from RGN_ITEMASEGURADO_AJUSTE x
			where x.itemAseguradosId = RGN_ITEMASEGURADO.itemAseguradosId and
			  x.polizaId = RGN_ITEMASEGURADO.polizaId and
			  x.aseguradoraId = RGN_ITEMASEGURADO.aseguradoraId and
			  x.ajusteId= @ajusteId
			),-1) 
		when -1 then 1 else 0 end
	FROM  RGN_ITEMASEGURADO, ADM_MONEDA
	WHERE
		
		(RGN_ITEMASEGURADO.polizaId = @polizaId)and
		(ADM_MONEDA.monedaId=RGN_ITEMASEGURADO.monedaId) 

	SET @Err = @@Error

	RETURN @Err
END








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delapoliza_detalle]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delapoliza_detalle] (@ajusteid int)
AS



	SELECT     
		--RGN_ITEMASEGURADO.itemAseguradosId AS item, 
		RGN_ITEMASEGURADO.nombreItem AS detalle, 
		ADM_MONEDA.simbolo AS simbolo, 
		CASE 
		   WHEN RGN_ITEMASEGURADO.concepto = ''Ninguno'' THEN ''''
		   ELSE RGN_ITEMASEGURADO.concepto
		END as concepto,
		RGN_ITEMASEGURADO.montoAsegurado AS monto,
		CASE 
		   WHEN RGN_ITEMASEGURADO.concepto2 = ''Ninguno'' THEN ''''
		   ELSE RGN_ITEMASEGURADO.concepto2	
		END as concepto2,
		RGN_ITEMASEGURADO.montoAsegurado2,
		RGN_ITEMASEGURADO.localItem
	FROM		RGN_ITEMASEGURADO_AJUSTE INNER JOIN
          RGN_ITEMASEGURADO ON 
          RGN_ITEMASEGURADO_AJUSTE.itemAseguradosId = RGN_ITEMASEGURADO.itemAseguradosId AND 
          RGN_ITEMASEGURADO_AJUSTE.polizaId = RGN_ITEMASEGURADO.polizaId AND 
          RGN_ITEMASEGURADO_AJUSTE.aseguradoraId = RGN_ITEMASEGURADO.aseguradoraId INNER JOIN
          ADM_MONEDA ON RGN_ITEMASEGURADO.monedaId = ADM_MONEDA.monedaId
	where 	RGN_ITEMASEGURADO_AJUSTE.ajusteid = @ajusteid 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ItemsAseguradosAjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ItemsAseguradosAjusteInsert]
(
	@ajusteId numeric(8,0),
	@polizaId numeric (8,0),
	@itemAseguradosId numeric (8,0),
	@usuario varchar(20)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DECLARE @aseguradoraId  numeric (8,0)

	Select @aseguradoraId=aseguradoraId
	FROM RGN_POLIZA
	WHERE RGN_POLIZA.polizaId=@polizaId

	SELECT * FROM RGN_ITEMASEGURADO_AJUSTE
	WHERE (ajusteId=@ajusteId)AND (polizaId=@polizaId)
		AND (itemAseguradosId=@itemAseguradosId)

	if @@ROWCOUNT=0
	BEGIN 

		INSERT
		INTO RGN_ITEMASEGURADO_AJUSTE
		(
			ajusteId,
			polizaId,
			aseguradoraId,
			itemAseguradosId,
			ucrea,
			uupdate,
			fcrea,
			fupdate
			
		)
		VALUES
		(
			@ajusteId,
			@polizaId,
			@aseguradoraId,
			@itemAseguradosId,
			@usuario,
			@usuario,
			getdate(),
			getdate()
		)
	END
	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_addtosourcecontrol]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_addtosourcecontrol]
    @vchSourceSafeINI varchar(255) = '''',
    @vchProjectName   varchar(255) ='''',
    @vchComment       varchar(255) ='''',
    @vchLoginName     varchar(255) ='''',
    @vchPassword      varchar(255) =''''

as

set nocount on

declare @iReturn int
declare @iObjectId int
select @iObjectId = 0

declare @iStreamObjectId int
select @iStreamObjectId = 0

declare @VSSGUID varchar(100)
select @VSSGUID = ''SQLVersionControl.VCS_SQL''

declare @vchDatabaseName varchar(255)
select @vchDatabaseName = db_name()

declare @iReturnValue int
select @iReturnValue = 0

declare @iPropertyObjectId int
declare @vchParentId varchar(255)

declare @iObjectCount int
select @iObjectCount = 0

    exec @iReturn = master.dbo.sp_OAalter  @VSSGUID, @iObjectId OUT
    if @iReturn <> 0 GOTO E_OAError


    /* alter  Project in SS */
    exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
											''AddProjectToSourceSafe'',
											NULL,
											@vchSourceSafeINI,
											@vchProjectName output,
											@@SERVERNAME,
											@vchDatabaseName,
											@vchLoginName,
											@vchPassword,
											@vchComment


    if @iReturn <> 0 GOTO E_OAError

    /* Set Database Properties */

    begin tran SetProperties

    /* add high level object */

    exec @iPropertyObjectId = dbo.dt_adduserobject_vcs ''VCSProjectID''

    select @vchParentId = CONVERT(varchar(255),@iPropertyObjectId)

    exec dbo.dt_setpropertybyid @iPropertyObjectId, ''VCSProjectID'', @vchParentId , NULL
    exec dbo.dt_setpropertybyid @iPropertyObjectId, ''VCSProject'' , @vchProjectName , NULL
    exec dbo.dt_setpropertybyid @iPropertyObjectId, ''VCSSourceSafeINI'' , @vchSourceSafeINI , NULL
    exec dbo.dt_setpropertybyid @iPropertyObjectId, ''VCSSQLServer'', @@SERVERNAME, NULL
    exec dbo.dt_setpropertybyid @iPropertyObjectId, ''VCSSQLDatabase'', @vchDatabaseName, NULL

    if @@error <> 0 GOTO E_General_Error

    commit tran SetProperties
    
    select @iObjectCount = 0;

CleanUp:
    select @vchProjectName
    select @iObjectCount
    return

E_General_Error:
    /* this is an all or nothing.  No specific error messages */
    goto CleanUp

E_OAError:
    exec dbo.dt_displayoaerror @iObjectId, @iReturn
    goto CleanUp
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_displayoaerror_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  PROCEDURE [dbo].[dt_displayoaerror_u]
    @iObject int,
    @iresult int
as
	-- This procedure should no longer be called;  dt_displayoaerror should be called instead.
	-- Calls are forwarded to dt_displayoaerror to maintain backward compatibility.
	set nocount on
	exec dbo.dt_displayoaerror
		@iObject,
		@iresult

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correosADM_update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correosADM_update]
(
	@tipoParametro varchar(50),
	@NombreParametro varchar(250),
	@valorParametro varchar(250),	
	@parametroid int,
	@uupdate varchar(50),
	@fupdate datetime
)
AS
	SET NOCOUNT OFF;
UPDATE [ADM_PARAMETRO] SET 
	[tipoParametro] = @tipoParametro, 
	[NombreParametro] = @NombreParametro, 
	[valorParametro] = @valorParametro 
WHERE (([parametroid] = @parametroid));
	
SELECT parametroid, tipoParametro, NombreParametro, valorParametro FROM ADM_PARAMETRO WHERE (parametroid = @parametroid)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correosADM_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correosADM_delete]
(
	@Original_parametroid int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [ADM_PARAMETRO] WHERE (([parametroid] = @Original_parametroid))
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_generaNumeroAjustepasa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_generaNumeroAjustepasa](@retorno varchar(250) output,@fecha varchar(4)) 

as

begin
	declare @numajustepasa varchar(20)
        declare @aux2 varchar(250)
	
	set @aux2 = '''';
	select top 1 @aux2=valorParametro from ADM_PARAMETRO where nombreparametro = ''NUMEROAJUSTEACTUAL''
	
                                     --convert(varchar(10),@ajusteid)

        set @numajustepasa=''PA-''+@aux2+''-''+@fecha

	if (@aux2 != '''') 
	begin 
		declare @numAux numeric(8,0) 
		set @numAux = convert(numeric(8,0),@aux2)
		set @numAux= @numAux + 1
		update ADM_PARAMETRO set valorParametro = convert(varchar(10),@numAux)
	end	
	
	--return @numajustepasa
	select @retorno = @numajustepasa 

end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_numeroComunicacionActualUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_numeroComunicacionActualUpdate] (@valorParametro varchar(250))
as

update adm_parametro set valorParametro = @valorParametro where nombreParametro = ''NUMEROCOMUNICACION''' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_actualizaNumeroCartaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--sp_helptext sp_rgen_actualizaNumeroCartaUpdate
CREATE 
procedure [dbo].[sp_rgen_actualizaNumeroCartaUpdate]
as 
    declare @aux2 varchar(250)
	
    set @aux2 = '''' ;
    select top 1
            @aux2 = valorParametro
    from    ADM_PARAMETRO
    where   nombreparametro = ''NUMEROCOMUNICACION''                               

    if ( @aux2 != '''' ) 
        begin 
            declare @numAux numeric(8, 0) 
            set @numAux = convert(numeric(8, 0), @aux2)
            set @numAux = @numAux + 1
            update  ADM_PARAMETRO
            set     valorParametro = convert(varchar(10), @numAux)
            where   ( NombreParametro = ''NUMEROCOMUNICACION'' )
        end	


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_numeroComunicacionActual]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_numeroComunicacionActual] 
as
select top 1 valorParametro from ADM_PARAMETRO where nombreparametro = ''NUMEROCOMUNICACION''' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_generaNumeroComunicacion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_generaNumeroComunicacion]
as
declare @anno varchar (250)
declare @numacarta varchar(250)
set @anno = year(getdate())
        declare @aux2 varchar(250)
	
	set @aux2 = '''';
	select top 1 @aux2=valorParametro from ADM_PARAMETRO where nombreparametro = ''NUMEROCOMUNICACION''                               

        set @numacarta=''PA-RG-''+@anno+''-''+@aux2

	if (@aux2 != '''') /*
	begin 
		declare @numAux numeric(8,0) 
		set @numAux = convert(numeric(8,0),@aux2)
		set @numAux= @numAux + 1
		update ADM_PARAMETRO set valorParametro = convert(varchar(10),@numAux)
		where (NombreParametro = ''NUMEROCOMUNICACION'')
	end	
	*/

select @numacarta' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dameNumeroActualdeAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dameNumeroActualdeAjuste]
AS
	SET NOCOUNT ON;
SELECT     valorParametro
FROM         ADM_PARAMETRO
WHERE     (NombreParametro = ''NUMEROAJUSTEACTUAL'')' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correosADM_select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correosADM_select]
AS
	SET NOCOUNT ON;
SELECT     parametroid, tipoParametro, NombreParametro, valorParametro
FROM         ADM_PARAMETRO
WHERE     (NombreParametro = ''CORREOADM'')
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_correosADM_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_correosADM_insert]
(
	@tipoParametro varchar(50),
	@NombreParametro varchar(250),
	@valorParametro varchar(250),
	@ucrea varchar(50),
	@fcrea Datetime
)
AS
	SET NOCOUNT OFF;

INSERT INTO [ADM_PARAMETRO] ([tipoParametro], [NombreParametro], [valorParametro],[ucrea],[fcrea],[estado],[fupdate],[uupdate]) 
VALUES (@tipoParametro, @NombreParametro, @valorParametro,@ucrea,@fcrea,''A'',@fcrea,@ucrea);
	
SELECT parametroid, tipoParametro, NombreParametro, valorParametro FROM ADM_PARAMETRO WHERE (parametroid = SCOPE_IDENTITY())

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[actualizaNumeroAjusteInicial]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[actualizaNumeroAjusteInicial]
(
	@valorParametro varchar(250)
)
AS
	SET NOCOUNT OFF;
UPDATE    ADM_PARAMETRO
SET              valorParametro = @valorParametro
WHERE     (NombreParametro = ''NUMEROAJUSTEACTUAL'')' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_requisitos_ajuste_insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_requisitos_ajuste_insert]
    (
      @requisitoId numeric(8, 0),
      @solicitudDocumentosId numeric(8, 0),
      @ajusteId numeric(8, 0),
      @ucrea varchar(20)
    )
as 
    declare @cantidad numeric(8, 0)

    select  @cantidad = count(*)
    from    RGN_AJUSTE_RGN_REQUERIMIENTO
    where   requisitoId = @requisitoId
            and solicitudDocumentosId = @solicitudDocumentosId
            and @ajusteId = ajusteId

    if ( @cantidad = 0 ) 
        begin

            INSERT  INTO RGN_AJUSTE_RGN_REQUERIMIENTO
                    (
                      RequisitoId,
                      FechaEntrega,
                      fcrea,
                      fupdate,
                      estado,
                      ucrea,
                      uupdate,
                      solicitudDocumentosId,
                      ajusteId,
					  orden
                    )
            VALUES  (
                      @RequisitoId,
                      null,
                      getDate(),
                      getDate(),
                      ''N'',
                      @ucrea,
                      @ucrea,
                      @solicitudDocumentosId,
                      @ajusteId,
					  1
                    )
        END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RequisitosInsertToSolicitud]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RequisitosInsertToSolicitud]
(
	@requisitoId numeric(8,0),
	@ajusteId numeric(8,0),
	@solDocId numeric (8,0),
	@ucrea varchar(20),
	@uupdate varchar(20)
	
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	

	INSERT
	INTO [RGN_AJUSTE_RGN_REQUERIMIENTO]
	(
		[ajusteId],
		[requisitoId],
		[solicitudDocumentosId],
		[fcrea],
		[fupdate],
		[ucrea],
		[uupdate],
		[estado]
	)
	VALUES
	(
		@ajusteId,
		@requisitoId,
		@solDocId,
		getDate(),
		getDate(),
		@ucrea,
		@uupdate,
		''A''
	)

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RequerimientoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RequerimientoUpdate]
(
	@requisitoId numeric(8,0),
	@FechaEntrega datetime = NULL,
	@fupdate datetime = NULL,
	@estado varchar(1) = NULL,
	@uupdate varchar(20) = NULL,
	@solicitudDocumentosId numeric(8,0) = NULL,
	@ajusteId numeric(8,0)
)
AS
	SET NOCOUNT ON
	
	UPDATE [RGN_AJUSTE_RGN_REQUERIMIENTO]
	SET

		[FechaEntrega] = @FechaEntrega,		
		[fupdate] = @fupdate,
		[estado] = @estado,		
		[uupdate] = @uupdate
		
	WHERE 
		[requisitoId] = @requisitoId and 	
		[solicitudDocumentosId] = @solicitudDocumentosId and
		[ajusteId] = @ajusteId
		
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RequisitosDeDocumentoLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RequisitosDeDocumentoLista]( @ajusteId numeric(8,0),@SolDocId numeric(8,0)) 
as
begin
	select * from RGN_AJUSTE_RGN_REQUERIMIENTO where ajusteId = @ajusteId and solicitudDocumentosid = @SolDocId
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[numeroDeDocumentosSolicitados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[numeroDeDocumentosSolicitados]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     COUNT(*) AS numDocs
FROM         RGN_AJUSTE_RGN_REQUERIMIENTO
WHERE     (ajusteId = @ajusteId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_asignaPolizaPrincipal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgn_asignaPolizaPrincipal]( 
	@polizaId numeric(8,0),
	@aseguradoraId numeric(8,0) ,
	@ajusteId numeric(8,0),
	@NumSiniestro decimal, 
	@uupdate varchar(250)
)
as 
declare @cantidad decimal

/*
CORRECCION AL 26/04/2006
*/
delete RGN_POLIZA_AJUSTE
from RGN_POLIZA_AJUSTE,RGN_POLIZA
where RGN_POLIZA_AJUSTE.polizaid = RGN_POLIZA.polizaid and
	RGN_POLIZA.sistema = ''S'' and
	RGN_POLIZA_AJUSTE.ajusteid = @ajusteId

select @cantidad = count(*) from RGN_POLIZA_AJUSTE where ajusteId = @ajusteId 

if (@cantidad = 0)  

begin
INSERT INTO RGN_POLIZA_AJUSTE
                      (polizaId, aseguradoraId, ajusteId, 
		NumSiniestro,fcrea,fupdate,estado,ucrea, uupdate)
VALUES     (@polizaId,@aseguradoraId ,@ajusteId,@NumSiniestro ,
	getDate(),getDate(),''A'' ,@uupdate,@uupdate)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_registroPoliza_Nuevo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_registroPoliza_Nuevo](
  @aseguradoraid numeric(8,0),
  @numeroPoliza varchar(100),
  @aseguradoid numeric(8,0),
  @contratante varchar(250),
  @GirodeNegocio varchar(250),
  @GrupoEconomico varchar(250),
  @FechaInicio datetime, 
  @FechaFin datetime,
  @Productoid numeric(8,0),
  @ramoid numeric(8,0),
  @cobertura numeric(8,0),
  @usuario varchar(100),
  @ajusteId numeric (8,0),
  @archivo varchar(100)
)
as

BEGIN  
   insert into RGN_POLIZA(aseguradoraid,
		contratante, 
		aseguradoid, 
		productoid, 
		ramoid, 
		riesgoid,
		finicio,
		ffin, 
		numeroPoliza,
		archivo,
		fcrea,
		estado,
		ucrea,
		giroNegocio,
		grupoEconomico)

   values (@aseguradoraid, 
	   @contratante, 
	   @aseguradoid, 
	   @productoid, 
	   @ramoid, 
	   @cobertura, 
	   @FechaInicio, 
	   @Fechafin, 
	   @numeroPoliza,
	   isnull(@archivo,''''), 
	   getdate(), 
	   ''A'',
	   isnull(@usuario,''usuario''),
	   @GirodeNegocio,
	   @GrupoEconomico) 	

   DECLARE @polizaId numeric(8,0);
   SET @polizaId= scope_Identity();
	
--INSERTANDO EN TABLA POLIZA_AJUSTE

    if (@ajusteId != -1) 
	begin
	    insert into RGN_POLIZA_AJUSTE
	    (
		aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate
		
	    )
	    
	    values (
	    	@aseguradoraid,
	 	@polizaId,
	        @ajusteId,
	        ''A'',
		getdate(),
		getdate(),
		isnull(@usuario,''usuario''),
		isnull(@usuario,''usuario'')
	    )
	end 
END ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizaAsociadaInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizaAsociadaInsert](
  @ajusteId numeric(8,0),
  @polizaId numeric(8,0),
  @aseguradoraId numeric(8,0),
  @usuario varchar(100)
)
as
BEGIN
 
    --INSERTANDO EN TABLA POLIZA_AJUSTE

   
    insert into RGN_POLIZA_AJUSTE
    (
	aseguradoraid,polizaid,ajusteid,estado,fcrea,fupdate,ucrea,uupdate

    )
    
    values (
    	@aseguradoraid,
 	@polizaId,
        @ajusteId,
        ''A'',
	getdate(),
	getdate(),
	isnull(@usuario,''usuario''),
	isnull(@usuario,''usuario'')
    )

END 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dimePolizasDelAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dimePolizasDelAjuste](@ajusteId numeric(8,0))
as
begin
	SELECT     dbo.RGN_POLIZA_AJUSTE.polizaId, dbo.RGN_POLIZA_AJUSTE.aseguradoraId, dbo.RGN_POLIZA_AJUSTE.ajusteId, p.numeroPoliza
	FROM         dbo.RGN_POLIZA_AJUSTE INNER JOIN
	                      dbo.RGN_POLIZA p ON dbo.RGN_POLIZA_AJUSTE.polizaId = p.polizaId
	WHERE     (dbo.RGN_POLIZA_AJUSTE.ajusteId = @ajusteId)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_damePrincipalPolizaAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_damePrincipalPolizaAjuste](@ajusteId numeric(8,0))
as
begin
	SELECT     top 1 dbo.RGN_POLIZA_AJUSTE.polizaId, dbo.RGN_POLIZA_AJUSTE.aseguradoraId, dbo.RGN_POLIZA_AJUSTE.ajusteId, p.numeroPoliza
	FROM         dbo.RGN_POLIZA_AJUSTE INNER JOIN
	                      dbo.RGN_POLIZA p ON dbo.RGN_POLIZA_AJUSTE.polizaId = p.polizaId
	WHERE     (dbo.RGN_POLIZA_AJUSTE.ajusteId = @ajusteId)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeListaControl]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_InformeListaControl]
AS
	SET NOCOUNT ON;

	SELECT     
					ListaAjuste.*, 
					RGN_INFORME.estadoValidacion,
					CASE RGN_INFORME.estadoValidacion
						WHEN 1 THEN ''APROBADO''
						WHEN 0 THEN ''POR APROBAR''
					END AS Validacion, 
					RGN_INFORME.observado, 
					CASE RGN_INFORME.observado
						WHEN 1 THEN ''OBSERVADO''
						WHEN 0 THEN ''NO OBSERVADO''
					END AS Observacion,
					RGN_TINFORME.nombre, 
					RGN_TINFORME.tinformeId
	FROM 		ListaAjuste INNER JOIN
          RGN_INFORME ON ListaAjuste.ajusteId = RGN_INFORME.ajusteId INNER JOIN
          RGN_TINFORME ON RGN_INFORME.tinformeId = RGN_TINFORME.tinformeId
	WHERE   RGN_INFORME.estadoValidacion = 0 AND
					RGN_INFORME.estado = ''A''
	ORDER BY RGN_INFORME.fcrea DESC



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeListaAprobado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_InformeListaAprobado]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;

	SELECT     
					RGN_TINFORME.nombre, 
					RGN_INFORME.fcrea, 
					RGN_INFORME.estadoValidacion,
					CASE RGN_INFORME.estadoValidacion
						WHEN 1 THEN ''APROBADO''
						WHEN 0 THEN ''POR APROBAR''
					END AS Validacion, 
					RGN_INFORME.observado, 
					CASE RGN_INFORME.observado
						WHEN 1 THEN ''OBSERVADO''
						WHEN 0 THEN ''NO OBSERVADO''
					END AS Observacion, 
					RGN_INFORME.ajusteId, 
					RGN_INFORME.informeId
	FROM		RGN_INFORME INNER JOIN
	        RGN_TINFORME ON RGN_INFORME.tinformeId = RGN_TINFORME.tinformeId
	WHERE   (RGN_INFORME.ajusteId = @ajusteId) AND
					RGN_INFORME.estadoValidacion = 1
	ORDER BY RGN_INFORME.fcrea DESC

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeLista] 
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;

	SELECT     
					RGN_TINFORME.nombre, 
					RGN_INFORME.fcrea, 
					RGN_INFORME.estadoValidacion,
					CASE RGN_INFORME.estadoValidacion
						WHEN 1 THEN ''APROBADO''
						WHEN 0 THEN ''POR APROBAR''
					END AS Validacion, 
					RGN_INFORME.observado, 
					CASE RGN_INFORME.observado
						WHEN 1 THEN ''OBSERVADO''
						WHEN 0 THEN ''NO OBSERVADO''
					END AS Observacion, 
					RGN_INFORME.ajusteId, 
					RGN_INFORME.informeId
	FROM		RGN_INFORME INNER JOIN
	        RGN_TINFORME ON RGN_INFORME.tinformeId = RGN_TINFORME.tinformeId
	WHERE   (RGN_INFORME.ajusteId = @ajusteId) and (estadoValidacion = 1)
	ORDER BY RGN_INFORME.fcrea DESC


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeControl]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_InformeControl] 
	@ajusteId numeric
AS
	SET NOCOUNT ON;

	DECLARE @tinformeId numeric, @StatusId numeric

	SET @tinformeId = 0
	SET @StatusId = 0

	SELECT     
					/*ListaAjuste.*, 
					RGN_INFORME.estadoValidacion,
					CASE RGN_INFORME.estadoValidacion
						WHEN 1 THEN ''APROBADO''
						WHEN 0 THEN ''POR APROBAR''
					END AS Validacion, 
					RGN_INFORME.observado, 
					CASE RGN_INFORME.observado
						WHEN 1 THEN ''OBSERVADO''
						WHEN 0 THEN ''NO OBSERVADO''
					END AS Observacion,
					RGN_TINFORME.nombre, */
					@tinformeId = RGN_TINFORME.tinformeId,
					@StatusId = ListaAjuste.StatusId
	FROM 		ListaAjuste INNER JOIN
          RGN_INFORME ON ListaAjuste.ajusteId = RGN_INFORME.ajusteId INNER JOIN
          RGN_TINFORME ON RGN_INFORME.tinformeId = RGN_TINFORME.tinformeId
	WHERE   RGN_INFORME.estadoValidacion = 0 AND
					RGN_INFORME.estado = ''A'' AND
					ListaAjuste.ajusteId = @ajusteId
	ORDER BY RGN_INFORME.fcrea DESC


	SELECT	@tinformeId;

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_TipoActividadLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgn_TipoActividadLista]
AS
	SET NOCOUNT ON;
SELECT     TipoActividad, Descripcion, tipoActividadId
FROM         RGN_TIPOACTIVIDAD
where estado =''A''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_TipoActividadSelectByTipoActividad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgn_TipoActividadSelectByTipoActividad](
	@TipoActividad varchar(250)
)
AS
	SET NOCOUNT ON;
SELECT     tipoActividadId, TipoActividad, Descripcion
FROM        RGN_TIPOACTIVIDAD
WHERE     (TipoActividad LIKE ''%''+@TipoActividad+''%'') and (TipoActividadId <> 5) and estado = ''A''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_TipoActividadInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgn_TipoActividadInsert](	
	@TipoActividad varchar(250),
	@Descripcion varchar(250)
)
AS
	SET NOCOUNT ON;
	insert into RGN_TIPOACTIVIDAD
	(	
		TipoActividad,
		Descripcion
	)
	values 
	(
		@TipoActividad,
		@Descripcion	
	)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadInsertNueva]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ActividadInsertNueva]
(
	@ajusteId 						numeric(8, 0),
	@lugarDeReunion 			varchar(250),
	@personaContacto 			varchar(250),
	@personaEntrevistada 	varchar(1000),
	@descripcion 					varchar(100),
	@FechaHoraReunion 		datetime,
	@ubigeoId 						varchar(6),
	@telefonoPersonaContacto varchar(20),
	@tipoActividadId 			numeric(8, 0),
	@tipoActividad 				varchar(250),
	@uupdate 							varchar(20)
)
AS
	SET NOCOUNT OFF;


		-- Insertando el Nuevo Tipo ---------------------------------------------------
		DECLARE @actividadesSimilares int

		IF @tipoActividadId IS NULL
			BEGIN 
				--SELECT @actividadesSimilares = COUNT(*)	FROM RGN_TIPOACTIVIDAD WHERE SOUNDEX(@tipoActividad) = SOUNDEX(tipoActividad)

				--IF @actividadesSimilares = 0 -- NO HAY SIMILITUD
					BEGIN 
						INSERT INTO RGN_TIPOACTIVIDAD (tipoActividad, Descripcion, ucrea, uupdate)
						VALUES (@tipoActividad, @descripcion, @uupdate, @uupdate)
			
						SET @tipoActividadId = SCOPE_IDENTITY()
					END
				--ELSE
					--BEGIN 
						--SELECT TOP 1 @tipoActividadId = tipoActividadId FROM RGN_TIPOACTIVIDAD WHERE DIFFERENCE(REPLACE(tipoActividad, '' '',''''), ''coordinacion'') = 4
					--END
			END
		
	
		INSERT INTO RGN_ACTIVIDAD
	       (
					ajusteId, 
					lugarDeReunion, 
					personaContacto,
					personaEntrevistada,
					descripcion,
					estado, 
					FechaHoraReunion, 
					ubigeoId, 
					telefonoPersonaContacto,
					tipoActividadId,
					ucrea,
					uupdate,
					fcrea,
					fupdate
        )
		VALUES    
	        (
            @ajusteId,
				    @lugarDeReunion,
            @personaContacto,
            @personaEntrevistada,
				    @descripcion,
				    ''A'',
            @FechaHoraReunion,
            @ubigeoId,
            @telefonoPersonaContacto,
            @tipoActividadId,
				    @uupdate,
				    @uupdate,
						GETDATE(),
						GETDATE()
	         )

	
	
	
	
	
	
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadListaEdit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadListaEdit]
(
	@ajusteId numeric,
	@actividadId numeric
)
AS
BEGIN

Select    
	actividadId, 
	ajusteId,
	FechaHoraCoordinacion,
	lugarDeReunion,
	referencia,
	personaContacto,
	FechaHoraReunion,
	rgn_actividad.descripcion,
	ubigeoId,
	(SELECT    REPLACE(D.distrito +''/''+P.provincia+ ''/''+ DD.departamento,'' '', '''')
	FROM       vi_DistritoCombo D,
	           vi_ProvinciaCombo P,
					   vi_DepartamentoCombo DD     
	where (P.provinciaid = D.provinciaId) 
	and (DD.departamentoid = P.departamentoid) 
	and(D.departamentoid = P.departamentoid) 
	and (dd.departamentoid+p.provinciaid+d.distritoid = ubigeoId)) as ''ubicacion'',
	telefonoPersonaContacto,
	personaEntrevistada,
	RGN_ACTIVIDAD.tipoActividadId,
	RGN_TIPOACTIVIDAD.tipoActividad	

	FROM	RGN_ACTIVIDAD,RGN_TIPOACTIVIDAD

	WHERE (RGN_ACTIVIDAD.ajusteId=@ajusteId) AND
		 (RGN_ACTIVIDAD.actividadId=@actividadId) AND 
		RGN_ACTIVIDAD.tipoActividadId=RGN_TIPOACTIVIDAD.tipoActividadId
		
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadSelect]
(
	@actividadId numeric,
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     
	   RGN_ACTIVIDAD.actividadId, 
	   RGN_ACTIVIDAD.ajusteId, 
	   RGN_ACTIVIDAD.lugarDeReunion, 
     RGN_ACTIVIDAD.personaContacto, 
     RGN_ACTIVIDAD.estado, 
     RGN_ACTIVIDAD.FechaHoraReunion, 
     RGN_ACTIVIDAD.descripcion, 
     RGN_ACTIVIDAD.ubigeoId, 
     RGN_ACTIVIDAD.telefonoPersonaContacto, 
     RGN_ACTIVIDAD.personaEntrevistada,
     RGN_ACTIVIDAD.tipoActividadId,
     RGN_TIPOACTIVIDAD.tipoActividad,
     RGN_ACTIVIDAD.uupdate
         
FROM   	RGN_ACTIVIDAD LEFT OUTER JOIN
				RGN_TIPOACTIVIDAD ON RGN_TIPOACTIVIDAD.tipoActividadId = RGN_ACTIVIDAD.tipoActividadId 
WHERE  	RGN_ACTIVIDAD.actividadId = @actividadId AND 
				RGN_ACTIVIDAD.ajusteId = @ajusteId AND
				RGN_ACTIVIDAD.estado = ''A''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BienAfectadoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_BienAfectadoSelectById]
(
	@ajusteId numeric(8,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		RGN_BIENAFECTADO.bienAfectadoId,
		RGN_BIENAFECTADO.ajusteId,
		RGN_BIENAFECTADO.item,
		RGN_BIENAFECTADO.descripcion,
		RGN_BIENAFECTADO.montorep,
		RGN_BIENAFECTADO.localDelBien,
		RGN_BIENAFECTADO.montosoles,
		RGN_BIENAFECTADO.monedaId,
		RGN_BIENAFECTADO.tipoCambio,
		ADM_MONEDA.simbolo AS simboloMoneda
	FROM RGN_BIENAFECTADO INNER JOIN
           	ADM_MONEDA ON RGN_BIENAFECTADO.monedaId = ADM_MONEDA.monedaId
	WHERE
		
		(ajusteId = @ajusteId)

	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_MonedaCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_MonedaCombo]
AS
	SET NOCOUNT ON;
SELECT     *
FROM         ADM_MONEDA
WHERE ADM_MONEDA.estado=''A''
ORDER BY ADM_MONEDA.fcrea DESC


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_GastoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_GastoSelectById]
(
	@gastoId numeric(8, 0)
	
)
AS
	SET NOCOUNT ON;

SELECT     ADM_MONEDA.simbolo AS simbolo, 
	   RGN_GASTO.ajusteId, 
	   RGN_GASTO.gastoId, 
	   RGN_GASTO.concepto, 
           RGN_GASTO.monto,
	   RGN_GASTO.montosoles, 
           RGN_GASTO.tipoCambio, 
           RGN_GASTO.monedaId, 
           RGN_GASTO.fechaGasto,
           RGN_GASTO.descripcion, 
           RGN_GASTO.numDoc,
           RGN_GASTO.giradoa


FROM       RGN_GASTO INNER JOIN
           ADM_MONEDA ON RGN_GASTO.monedaId = ADM_MONEDA.monedaId

WHERE     
	   (RGN_GASTO.gastoId = @gastoId)
	  ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_GastoLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_GastoLista]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;

SELECT     ADM_MONEDA.simbolo AS Simbolo, 
	   RGN_GASTO.ajusteId, 
	   RGN_GASTO.gastoId, 
	   RGN_GASTO.concepto, 
           RGN_GASTO.monto,
	   RGN_GASTO.montosoles, 
           RGN_GASTO.tipoCambio, 
           RGN_GASTO.monedaId, 
           RGN_GASTO.fechaGasto,
           RGN_GASTO.descripcion, 
           RGN_GASTO.numDoc,
           RGN_GASTO.giradoa


FROM       RGN_GASTO INNER JOIN
           ADM_MONEDA ON RGN_GASTO.monedaId = ADM_MONEDA.monedaId

WHERE     (RGN_GASTO.ajusteId = @ajusteId)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_configuracionAseguradora]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_configuracionAseguradora]
(
	@aseguradoraId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     diasIB, diasIP, diasIC, diasIFR, aseguradoraId
FROM         RGN_CONFIGURACIONXASEGURADORA
WHERE     (aseguradoraId = @aseguradoraId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_configuracionUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_configuracionUpdate]
(
	@diasIB numeric(5, 0),
	@diasIP decimal(18, 0),
	@diasIC decimal(18, 0),
	@diasIFR decimal(18, 0),
	@Original_aseguradoraId numeric(18, 0)
	
)
AS
	SET NOCOUNT OFF;
UPDATE [RGN_CONFIGURACIONXASEGURADORA] SET [diasIB] = @diasIB, [diasIP] = @diasIP, [diasIC] = @diasIC, [diasIFR] = @diasIFR WHERE ([aseguradoraId] = @Original_aseguradoraId);
	

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_configuracionSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_configuracionSelect]
(
	@aseguradoraId numeric(18, 0)
)
AS
	SET NOCOUNT ON;
SELECT     RGN_CONFIGURACIONXASEGURADORA.*
FROM         RGN_CONFIGURACIONXASEGURADORA
WHERE     (aseguradoraId = @aseguradoraId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_GastoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_GastoDelete]
(
	@gastoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM [RGN_GASTO]
	WHERE [gastoId]=@gastoId

	SET @Err = @@Error

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_GastoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_GastoInsert]
(
	@gastoId numeric(8,0) = NULL output,
	@ajusteId numeric(8,0),
	@numDoc varchar(50) = NULL,
	@fechaGasto	datetime =NULL,
	@concepto varchar(250) = NULL,
	@descripcion varchar(250) = NULL,
	@giradoa varchar(250) = NULL,
	@monto numeric(14,2) = NULL,
	@montosoles numeric(14,2) = NULL,
	@monedaId numeric(8,0),
	@tipoCambio numeric(14,2) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [RGN_GASTO]
	(
		[ajusteId],
		[numDoc],
		[fechaGasto],
		[concepto],
		[descripcion],
		[monto],
		[montosoles],
		[monedaId],
		[tipoCambio],
		[giradoa]
	)
	VALUES
	(
		@ajusteId,
		@numDoc,
		@fechaGasto,
		@concepto,
		@descripcion,
		@monto,
		@montosoles,
		@monedaId,
		@tipoCambio,
		@giradoa
	)

	SET @Err = @@Error

	SELECT @gastoId = SCOPE_IDENTITY()

	RETURN @Err
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getRolNameFromUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[getRolNameFromUserId](
	@userid numeric (8,0)
)
as 
begin

	SELECT SYS_ROL.rol
	FROM         SYS_ROLUSUARIO INNER JOIN
	                      SYS_ROL ON SYS_ROLUSUARIO.rolId = SYS_ROL.rolId
	WHERE     (SYS_ROLUSUARIO.usuarioId = @userid)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_getRolNameFromUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_getRolNameFromUserId]  (
	@userid numeric (8,0)
)
as 
begin

	SELECT SYS_ROL.rol,SYS_rol.rolId
	FROM         SYS_ROLUSUARIO INNER JOIN
	                      SYS_ROL ON SYS_ROLUSUARIO.rolId = SYS_ROL.rolId
	WHERE     (SYS_ROLUSUARIO.usuarioId = @userid)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_RolComboByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgn_RolComboByUser]
(
	@tipoUsuario	varchar(100)
)
AS
	SET NOCOUNT ON;

	if (@tipoUsuario=''Broker'')
		SELECT rolId, rol	FROM SYS_ROL WHERE rol=''EjecutivoBroker'';
		
	if (@tipoUsuario=''Aseguradora'')
		SELECT rolId, rol	FROM SYS_ROL WHERE rol=''EjecutivoCiaSeguros'';

	if (@tipoUsuario=''Administrador'')
		--SELECT rolId, rol	FROM SYS_ROL WHERE rol=''Ajustador'' or rol=''Aseguradora'' or rol=''Broker'';
		SELECT rolId, rol	FROM SYS_ROL WHERE rol=''Ajustador'' or rol=''AdminCiaSeguros'' or rol=''AdminBroker'' or rol=''Asistente'';			
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_RolComboByUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgn_RolComboByUserId]
(
	@tipoUsuario	varchar(100)
)
AS
	SET NOCOUNT ON;

	if (@tipoUsuario=''Broker'')
		SELECT rolId, rol	FROM SYS_ROL WHERE rol=''EjecutivoBroker'';
		
	if (@tipoUsuario=''Aseguradora'')
		SELECT rolId, rol	FROM SYS_ROL WHERE rol=''EjecutivoAseguradora'';

	if (@tipoUsuario=''Administrador'')
		SELECT rolId	FROM SYS_ROL WHERE rol=''Ajustador'' or rol=''Aseguradora'' or rol=''Broker'';
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_UsuariosByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgn_UsuariosByName] --rimac
(	
	@usuario varchar(20)
)
AS

SELECT	usuarioId,
  		usuario, 
		clave, 
		estado
From	SYS_USUARIO
WHERE	usuario = @usuario



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgn_UsuarioDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgn_UsuarioDelete]
(
	@usuarioId 	int
	--@personaId 	id
)
AS
	DECLARE @Error int
	DECLARE @personaId int
	SET NOCOUNT OFF;
	
/*BEGIN TRAN
	SELECT @personaId=personaId FROM ADM_PERSONA WHERE usuarioId=@usuarioId;
	-----------------------------------
	UPDATE 	ADM_PERSONA 
		set usuarioId=null
	WHERE 	(personaId = @personaId);
	
	DELETE 	FROM SYS_ROLUSUARIO		--Intento Borrar
	WHERE 	(usuarioId=@usuarioId);

	DELETE FROM SYS_USUARIO 		
	WHERE 	(usuarioId=@usuarioId);
	
	SET @Error=@@ERROR
	-----------------------------------

	-----------------------------------
	IF (@Error<>0) 					--Si no se puede: Borrado lógico
		BEGIN
	    	ROLLBACK TRAN

			BEGIN TRAN

	    	UPDATE SYS_USUARIO
			set ESTADO=''I''
			WHERE (usuarioId=@usuarioId);

	   	 	GOTO Salir

	  	END
	ELSE							--Borrado Físico
	  	BEGIN
	    	DELETE 	FROM ADM_TELEFONOxPERSONA
			WHERE 	(personaId = @personaId);
	
			DELETE 	FROM ADM_DOCID
			WHERE	(personaId = @personaId);

			DELETE	FROM ADM_PERSONA
			WHERE 	(personaId = @personaId);
	  	END

	-----------------------------------

Salir:
	COMMIT TRAN */

			UPDATE SYS_USUARIO
			set ESTADO=''I''
			WHERE (usuarioId=@usuarioId);


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_riesgosdelRequisito]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[sp_rgn_riesgosdelRequisito]
    (
      @requisitoid numeric(8, 0) = NULL

    )
as 

    SELECT  dbo.RGN_RAMO.nombre,
            dbo.RGN_RAMO.ramoId,
            dbo.fn_rgn_toBit(dbo.RGN_REQUISITO_RAMO.requisitoId) AS chk
    FROM    dbo.RGN_RAMO
            LEFT OUTER JOIN dbo.RGN_REQUISITO_RAMO ON dbo.RGN_RAMO.ramoId = dbo.RGN_REQUISITO_RAMO.ramoId
                                                      AND dbo.RGN_REQUISITO_RAMO.requisitoId = @requisitoid




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ItemAseguradoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE     PROCEDURE [dbo].[sp_rgen_ItemAseguradoInsert]
(
	@polizaId numeric(8,0),
	@nombreItem text = NULL,
	@concepto varchar(50)=NULL,
	@montoAsegurado numeric(14,2) = NULL,
	@montosoles numeric(14,2) = NULL,
	@concepto2 varchar(50)=NULL,
	@montoAsegurado2 numeric(14,2) = NULL,
	@montosoles2 numeric(14,2) = NULL,
	@monedaId numeric(8,0),
	@tipoCambio numeric(14,2) = NULL,
--	@nroItem varchar(50),
	@localItem varchar(250)=NULL,
	@usuario varchar (20)=NULL

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	DECLARE @aseguradoraId  numeric (8,0)

	Select @aseguradoraId=aseguradoraId
	FROM RGN_POLIZA
	WHERE RGN_POLIZA.polizaId=@polizaId

	INSERT
	INTO RGN_ITEMASEGURADO
	(
		polizaId,
		aseguradoraId,
		nombreItem,
		concepto,
		montoAsegurado,
		montosoles,
		concepto2,
		montoAsegurado2,
		montosoles2,
		monedaId,
		tipoCambio,
	--	nroItem,
		localItem,
		ucrea,
		uupdate,
		fcrea,
		fupdate
	)
	VALUES
	(
		@polizaId,
		@aseguradoraId,
		@nombreItem,
		@concepto,
		@montoAsegurado,
		@montosoles,
		@concepto2,
		@montoAsegurado2,
		@montosoles2,
		@monedaId,
		@tipoCambio,
	--	@nroItem,
		@localItem,
		@usuario,
		@usuario,
		getdate(),
		getdate()
	)

	SET @Err = @@Error

	

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoAjusteCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_TipoAjusteCombo]
AS
	SET NOCOUNT ON;
SELECT     RGN_TIPOAJUSTE.*
FROM         RGN_TIPOAJUSTE
WHERE RGN_TIPOAJUSTE.estado=''A''
ORDER BY RGN_TIPOAJUSTE.fcrea DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ReclamoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE	PROCEDURE [dbo].[sp_rgen_ReclamoUpdate] 
(
	@ajusteId numeric(8, 0),
	@reclamo varchar(90),
	@monedareclamo numeric(5,0)

)
AS
	declare @cambioreclamo numeric(9,0)

	DECLARE @Err int

	SET NOCOUNT OFF;

	INSERT
	INTO [RGN_RECLAMO]
	(
        	[ajusteId],
		[monto],
		[montosoles],
		[tipoCambio],
		[monedaId],
		[fecha],
		[fcrea],
		[fupdate],
		[estado],
		[ucrea],
		[uupdate]		
	)
	VALUES
	(
		@ajusteId,
		Convert(numeric(14,6),@reclamo),
		Convert(numeric(14,6),@reclamo)*@cambioreclamo,
		@cambioreclamo,
		@monedareclamo,	
		getDate(),
		getDate(),
		getDate(),
		''A'',
		''dbo'',
		''dbo''
	)

	SET @Err = @@Error

	RETURN @Err

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjusteListaByAjustadorId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AjusteListaByAjustadorId]
(
	@ajustadorId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     Asegurado, siniestro, fsiniestro, NroDias, Aseguradora, numAjustePASA, NumeroAjuste, numeroPoliza, Ramo, Reserva, Status, Dias, 
           observaciones, Ajustador, Broker, ajusteId, siniestroid, ajustadorId, brokerId, aseguradoId, ramoId,numeroSiniestroCia,aseguradoraId
FROM       ListaAjuste, RGN_ESTADOAJUSTE
WHERE     (ajustadorId = @ajustadorId)AND (RGN_ESTADOAJUSTE.estadoAjusteId=12)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EstadoAjusteCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_EstadoAjusteCombo]
AS
	SET NOCOUNT ON;
SELECT     estadoajusteid, estadoajuste, descripcion
FROM       RGN_ESTADOAJUSTE
WHERE RGN_ESTADOAJUSTE.estado=''A''
ORDER BY RGN_ESTADOAJUSTE.fcrea DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_TipoComunicacionLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgn_TipoComunicacionLista]
AS
	SET NOCOUNT ON;
SELECT    tcomunicacionId, nombre,Descripcion
FROM         RGN_TIPOCOMUNICACION
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TipoComunicacionCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_TipoComunicacionCombo]
AS
	SET NOCOUNT ON;
SELECT     tcomunicacionId, nombre
FROM         RGN_TIPOCOMUNICACION
Where RGN_TIPOCOMUNICACION.estado=''A''
ORDER BY RGN_TIPOCOMUNICACION.fcrea DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RamoCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_RamoCombo]
AS
	SET NOCOUNT ON;
SELECT     *
FROM         rgn_ramo
WHERE RGN_RAMO.estado=''A''
ORDER BY RGN_RAMO.nombre asc' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_BienAfectadoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_Rgen_BienAfectadoDelete]
(
	@bienAfectadoId numeric(8,0)

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [RGN_BIENAFECTADO]
	WHERE
		[bienAfectadoId] = @bienAfectadoId 
		
	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BienAfectadoLista]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_BienAfectadoLista]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[bienAfectadoId],
		[ajusteId],
		[item],
		[descripcion],
		[montorep],
		[montosoles],
		[monedaId],
		[tipoCambio]
	FROM [RGN_BIENAFECTADO]

	SET @Err = @@Error

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_dameTotalIndemnizacion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_dameTotalIndemnizacion]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     totalIndemnizacion, ajusteId
FROM         RGN_CONVENIOAJUSTE
WHERE     (ajusteId = @ajusteId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeTipo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeTipo]
	@ajusteId 		numeric,
	@tipoInforme	varchar(1)
AS
	DECLARE @tinformeId	numeric
	DECLARE @informeId	numeric

	IF @tipoInforme =''X''
	begin
		select @informeId = ajusteId from dbo.RGN_CONVENIOAJUSTE where ajusteId = @ajusteId
	end
	else 
	begin
	IF @tipoInforme = ''B''
		SET @tinformeId = 15
	ELSE IF @tipoInforme = ''P''
		SET @tinformeId = 17
	ELSE IF @tipoInforme = ''C''
		SET @tinformeId = 19
	ELSE IF @tipoInforme = ''F''
		SET @tinformeId = 21

	SELECT 	@informeId = MAX(RGN_INFORME.informeId)
	FROM		RGN_INFORME
	WHERE		RGN_INFORME.ajusteId = @ajusteId AND
					RGN_INFORME.tinformeId = @tinformeId

	end
	
	IF @informeId IS NULL
		SET	@informeId = 0
	
	SELECT 	@informeId AS informeId


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_trace]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_trace](@trace VARCHAR(4000))
AS

INSERT INTO SYS_TRACE(value) VALUES (@trace)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ClausulasInsert]
(
	@ClausulasId numeric(8,0) = NULL output,
	@polizaId numeric(8,0),
	@nombre varchar(100) = NULL,
	@contenido varchar(1000) = NULL,
	@usuario varchar (20)=NULL

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	DECLARE @aseguradoraId  numeric (8,0)

	Select @aseguradoraId=aseguradoraId
	FROM RGN_POLIZA
	WHERE RGN_POLIZA.polizaId=@polizaId

	INSERT
	INTO RGN_CLAUSULAS
	(
		polizaId,
		aseguradoraId,
		nombre,
		contenido,
		ucrea,
		uupdate,
		fcrea,
		fupdate
	)
	VALUES
	(
		@polizaId,
		@aseguradoraId,
		@nombre,
		@contenido,
		@usuario,
		@usuario,
		getdate(),
		getdate()
	)

	SET @Err = @@Error

	SELECT @clausulasId = SCOPE_IDENTITY()

	RETURN @Err
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_elCasoEstaEnControlCalidad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgenx_elCasoEstaEnControlCalidad](@ajusteId numeric(8,0)) 
as
select estadoValidacion from RGN_INFORME where ajusteId = @ajusteId and estadoValidacion = 0 and estado != ''I''' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeBasicoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_InformeBasicoSelect]
(
	@ajusteId numeric(8,0),
	@informeId varchar(100)
)
AS
BEGIN

	SET NOCOUNT OFF

	select 
		[ajusteId],
		[informeId],
		[ruta],
		[nombre],
		[uupdate]
	from  [RGN_INFORME]
	Where  [RGN_INFORME].[ajusteId]=@ajusteId and
	       [RGN_INFORME].[informeId]=@informeId

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeBasicoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeBasicoInsert]
(
	@ajusteId numeric(8,0),
	@nombre varchar(100),
	@ruta varchar(100),
	@tipoInforme varchar(1),
	@estadoValidacion bit,
	@observado bit,
	@usuario varchar(20)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int, @tinformeId numeric
	DECLARE @estadoAjusteId numeric

	IF @tipoInforme = ''B''
	BEGIN
		SET @tinformeId = 15
		SET @estadoAjusteId=16
	END
	ELSE IF @tipoInforme = ''P''
	BEGIN
		SET @tinformeId = 17
		SET @estadoAjusteId=17
	END
	ELSE IF @tipoInforme = ''C''
	BEGIN
		SET @tinformeId = 19
		SET @estadoAjusteId=18
	END
	ELSE IF @tipoInforme = ''F''
	BEGIN
		SET @tinformeId = 21
		SET @estadoAjusteId=19
	END
	UPDATE 	RGN_INFORME SET estado = ''I'' 
	WHERE 	ajusteId = @ajusteId AND tinformeId = @tinformeId

	INSERT
	INTO  RGN_INFORME
	(
		ajusteId,
		tinformeId,
		fecha,
		fcrea,
		fupdate,
		ucrea,
		uupdate,
		ruta,
		nombre,
		numero,
		estadoValidacion,
		observado,
		estado
	)
	VALUES
	(
		@ajusteId,
		@tinformeId, 
		getDate(),
		getDate(),
		getDate(),
		@usuario,
		@usuario,
		@ruta,
		@nombre,
		1,
		@estadoValidacion,
		@observado,
		''A''
	)
/*
	declare @fecha datetime
	set @fecha=getdate()
	IF (@estadoValidacion=1)
	BEGIN
		exec dbo.sp_rgen_cambiaEstadoAjuste @fecha,@ajusteId,@estadoAjusteId,@usuario
	END
*/
	select 
		ajusteId,
		informeId,
		ruta,
		nombre,
		uupdate
	from  RGN_INFORME
	Where  RGN_INFORME.ajusteId=@ajusteId and
	       RGN_INFORME.informeId= SCOPE_IDENTITY()


END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_DatosInformeSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_DatosInformeSelect]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;

	SELECT   *  
	FROM	 RGN_INFORME 
	WHERE    RGN_INFORME.ajusteId = @ajusteId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformeEnvioUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformeEnvioUpdate]
(
	@ajusteId numeric(8,0),
	@informeId numeric(8,0),
	@enviadoA varchar(1000)

)
AS
BEGIN

update RGN_INFORME set enviadoA=@enviadoA,fechaEnvio=getdate()

where (ajusteId=@ajusteId) and (informeId=@informeId)




END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_TieneinformeBasico]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_TieneinformeBasico]
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;

SELECT     nombre
FROM         RGN_INFORME
WHERE     (ajusteId = @ajusteId) AND (tinformeId = 15)  	
	
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_tieneInformePreliminar]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_tieneInformePreliminar]
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;

SELECT     nombre
FROM         RGN_INFORME
WHERE     (ajusteId = @ajusteId) AND (tinformeId = 17)  	
	' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_ClausulasComunesDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_Rgen_ClausulasComunesDelete]
(
	@clausulaId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE FROM RGN_CLAUSULAS_COMUNES
	WHERE RGN_CLAUSULAS_COMUNES.clausulaId=@clausulaId

	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasComunes_RamoId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ClausulasComunes_RamoId]
(
	@ramoId numeric(8, 0)
	
)
AS
	SET NOCOUNT ON;


	if (@ramoId = -1) 
	begin
		SELECT * 		
		FROM 	RGN_CLAUSULAS_COMUNES
			
	end
	else 
	begin
	   SELECT *

	   FROM	RGN_CLAUSULAS_COMUNES
	   WHERE     
	   (RGN_CLAUSULAS_COMUNES.ramoId = @ramoId)	  
	
	end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ClausulasComunesInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ClausulasComunesInsert]
(
	@ramoId numeric(8,0),
	@nombre varchar(100) = NULL,
	@contenido varchar(1000) = NULL,
	@archivo image,
	@nombreArchivo varchar(255)=NULL,
	@usuario varchar (20)

)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	
	INSERT
	INTO RGN_CLAUSULAS_COMUNES
	(
		ramoId,
		nombre,
		contenido,
		archivo,
		nombreArchivo,
		fcrea,
		fupdate,
		ucrea,
		uupdate
		
	)
	VALUES
	(
		@ramoId,
		@nombre,
		@contenido,
		@archivo,
		@nombreArchivo,
		getDate(),
		getDate(),
		@usuario,
		@usuario

	)

	SET @Err = @@Error



	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AsociaRequisitoaRiesgo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_AsociaRequisitoaRiesgo](@requisitoId numeric(8,0), @ramoId numeric(8,0) )
as
	if ((select count(*) from dbo.RGN_REQUISITO_RAMO where requisitoid=@requisitoId and ramoId=@ramoId)=0)
		INSERT INTO dbo.RGN_REQUISITO_RAMO (requisitoid, ramoId) values(@requisitoId,@ramoId)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_DesasociaRequisitoaRiesgo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_DesasociaRequisitoaRiesgo](@requisitoId numeric(8,0), @ramoId numeric(8,0) )
as
	if ((select count(*) from dbo.RGN_REQUISITO_RAMO where requisitoid=@requisitoId and ramoId=@ramoId)>0)
		delete from dbo.RGN_REQUISITO_RAMO  where requisitoid=@requisitoId and ramoId=@ramoId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ItemInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create PROCEDURE [dbo].[sp_rgen_ItemInsert]
    (
      @ajusteId numeric(8, 0),
      @FechaHoraCoordinacion datetime,
      @lugarDeReunion varchar(250),
      @referencia varchar(250),
      @personaContacto varchar(250),
      @estado varchar(250),
      @FechaHoraReunion datetime,
      @descripcion varchar(1000),
      @ubigeoId varchar(6),
      @telefonoPersonaContacto varchar(20),
      @personaEntrevistada varchar(1000),
      @tipoActividadId numeric(8, 0)
    )
AS 
    SET NOCOUNT OFF ;
    INSERT  INTO [RGN_ACTIVIDAD]
            (
              [ajusteId],
              [FechaHoraCoordinacion],
              [lugarDeReunion],
              [referencia],
              [personaContacto],
              [estado],
              [FechaHoraReunion],
              [descripcion],
              [ubigeoId],
              [telefonoPersonaContacto],
              [personaEntrevistada],
              [tipoActividadId]
            )
    VALUES  (
              @ajusteId,
              @FechaHoraCoordinacion,
              @lugarDeReunion,
              @referencia,
              @personaContacto,
              @estado,
              @FechaHoraReunion,
              @descripcion,
              @ubigeoId,
              @telefonoPersonaContacto,
              @personaEntrevistada,
              @tipoActividadId
            ) ;
	
    SELECT  actividadId,
            ajusteId,
            FechaHoraCoordinacion,
            lugarDeReunion,
            referencia,
            personaContacto,
            estado,
            FechaHoraReunion,
            descripcion,
            ubigeoId,
            telefonoPersonaContacto,
            personaEntrevistada,
            tipoActividadId
    FROM    RGN_ACTIVIDAD
    WHERE   ( actividadId = SCOPE_IDENTITY() )
            AND ( ajusteId = @ajusteId )' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadDelete]
(
	@actividadId numeric
	
)
AS
	SET NOCOUNT OFF;
DELETE FROM  [RGN_ACTIVIDAD] WHERE ([actividadId] = @actividadId)


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadUpdate]
    (
      @ajusteId numeric(8, 0),
      @FechaHoraCoordinacion datetime,
      @lugarDeReunion varchar(250),
      @referencia varchar(250),
      @personaContacto varchar(250),
      @estado varchar(250),
      @FechaHoraReunion datetime,
      @descripcion varchar(1000),
      @ubigeoId varchar(6),
      @telefonoPersonaContacto varchar(20),
      @personaEntrevistada varchar(1000),
      @tipoActividadId numeric(8, 0),
      @Original_actividadId numeric,
      @Original_ajusteId numeric(8, 0),
      @actividadId numeric
    )
AS 
    SET NOCOUNT OFF ;
    UPDATE  [RGN_ACTIVIDAD]
    SET     [ajusteId] = @ajusteId,
            [FechaHoraCoordinacion] = @FechaHoraCoordinacion,
            [lugarDeReunion] = @lugarDeReunion,
            [referencia] = @referencia,
            [personaContacto] = @personaContacto,
            [estado] = @estado,
            [FechaHoraReunion] = @FechaHoraReunion,
            [descripcion] = @descripcion,
            [ubigeoId] = @ubigeoId,
            [telefonoPersonaContacto] = @telefonoPersonaContacto,
            [personaEntrevistada] = @personaEntrevistada,
            [tipoActividadId] = @tipoActividadId
    WHERE   ( ( [actividadId] = @Original_actividadId )
              AND ( [ajusteId] = @Original_ajusteId )
            ) ;
	
    SELECT  actividadId,
            ajusteId,
            FechaHoraCoordinacion,
            lugarDeReunion,
            referencia,
            personaContacto,
            estado,
            FechaHoraReunion,
            descripcion,
            ubigeoId,
            telefonoPersonaContacto,
            personaEntrevistada,
            tipoActividadId
    FROM    RGN_ACTIVIDAD
    WHERE   ( actividadId = @actividadId )
            AND ( ajusteId = @ajusteId )


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ActividadUpdateEdit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ActividadUpdateEdit]
(
	@actividadId numeric(8,0),
	@ajusteId numeric(8, 0),
	@FechaHoraCoordinacion datetime,
	@lugarDeReunion varchar(250),
	@referencia varchar(250),
	@personaContacto varchar(250),
	@estado varchar(250),
	@FechaHoraReunion datetime,
	@descripcion  varchar(1000),
	@ubigeoId varchar(6),
	@ubicacion varchar(250),
	@telefonoPersonaContacto varchar(20),
	@tipoActividadId numeric(5, 0),
	@personaEntrevistada varchar(1000),
	@tipoActividad varchar(100)

)
AS
	SET NOCOUNT OFF;
UPDATE    RGN_ACTIVIDAD
SET              estado = @estado, descripcion = @descripcion, personaEntrevistada = @personaEntrevistada
WHERE     (actividadId = @actividadId) AND (ajusteId = @ajusteId)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_CoberturasByRamoId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgenx_CoberturasByRamoId](@ramoId numeric(8,0)) 
as
if (@ramoId is null) 
select riesgoId,nombre from dbo.RGN_RIESGO_COBERTURA
where (estado <> ''I'')

else 
select riesgoId,nombre from dbo.RGN_RIESGO_COBERTURA
where (estado <> ''I'') and @ramoId = dbo.RGN_RIESGO_COBERTURA.ramoId' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RiesgoCoberturaSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RiesgoCoberturaSelectAll]
as 

select 	riesgoId,
	nombre,
	descripcion,
	fcrea,
	fupdate,
	estado,
	ucrea,
	uupdate
from RGN_RIESGO_COBERTURA
where estado = ''A''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RiesgoCoberturaInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RiesgoCoberturaInsert](
	@riesgoId numeric(8,0) output,
	@nombre varchar(255),
	@descripcion varchar(500),
	@ucrea varchar(20),
	@ramoId numeric(8,0)
)
as 

insert into RGN_RIESGO_COBERTURA (nombre,
	descripcion,
	fcrea,
	fupdate,
	estado,
	ucrea,
	uupdate,
	ramoid)
values (
	@nombre,
	@descripcion,
	getDate(),
	getDate(),
	''A'',
	@ucrea,
	@ucrea,
	@ramoId
)

set @riesgoId = scope_identity()

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CoberturaCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_CoberturaCombo]
AS
	SET NOCOUNT ON;
SELECT     *
FROM         RGN_RIESGO_COBERTURA
WHERE RGN_RIESGO_COBERTURA.estado =''A'' 
ORDER BY RGN_RIESGO_COBERTURA.nombre asc


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RiesgoCoberturaDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RiesgoCoberturaDelete](
	@riesgoId numeric(8,0),
	@uupdate varchar(20)
)
as 

update RGN_RIESGO_COBERTURA 
set estado = ''I'', uupdate = @uupdate, fupdate = getDate()
where riesgoId = @riesgoId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_RiesgoCoberturaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_RiesgoCoberturaUpdate](
	@riesgoId numeric(8,0) output,
	@nombre varchar(255),
	@descripcion varchar(500),
	@uupdate varchar(20)
)
as
update RGN_RIESGO_COBERTURA 
set nombre = @nombre, descripcion = @descripcion,
uupdate = @uupdate, fupdate = getdate()
where riesgoId = @riesgoId
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Rgen_RiesgoCombo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Rgen_RiesgoCombo]
AS
	SET NOCOUNT ON;
SELECT     RGN_RIESGO_COBERTURA.*
FROM        RGN_RIESGO_COBERTURA
WHERE RGN_RIESGO_COBERTURA.estado=''A''
ORDER BY RGN_RIESGO_COBERTURA.fcrea DESC' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CoberturaInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_CoberturaInsert]
(
	@riesgoId numeric(8,0) output,
	@nombre varchar(500),
	@descripcion varchar(500),
	@ramoId numeric(8,0),
	@ucrea varchar(20)
	
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT INTO [rgenx].[dbo].[RGN_RIESGO_COBERTURA]
           (
           [nombre]
           ,[descripcion]
           ,[fcrea]
           ,[fupdate]
           ,[estado]
           ,[ucrea]
           ,[uupdate]
           ,[ramoid])
     VALUES
           (
            @nombre,
            @descripcion, 
           getDate(),
           getDate(),
           ''A'',
           @ucrea,
           @ucrea,
           @ramoid)

	SET @Err = @@Error

	SELECT @riesgoId = SCOPE_IDENTITY()

	RETURN @Err
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_coberturaUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_coberturaUpdate](
@riesgoId numeric(8,0),
@nombre varchar(500),
@descripcion varchar(500),
@ramoid numeric(8,0),
@uupdate varchar(20)
)
as

UPDATE [rgenx].[dbo].[RGN_RIESGO_COBERTURA]
   SET 
      [nombre] = @nombre
      ,[descripcion] = @descripcion
      ,[fupdate] = getDate()            
      ,[uupdate] = @uupdate
      ,[ramoid] = @ramoid
 WHERE riesgoId = @riesgoId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CoberturaSelectByPrimaryKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_CoberturaSelectByPrimaryKey]
(	
	@riesgoId numeric(8,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT [riesgoId]
      ,[nombre]
      ,[descripcion]
      ,[fcrea]
      ,[fupdate]
      ,[estado]
      ,[ucrea]
      ,[uupdate]
      ,[ramoid]
  FROM [rgenx].[dbo].[RGN_RIESGO_COBERTURA]
	WHERE		
		([riesgoId] = @riesgoId)
		

	SET @Err = @@Error

	RETURN @Err
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_CoberturaToggleDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_CoberturaToggleDelete]
(	
	@riesgoId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
	
	declare @estadoActual varchar(1)

	select @estadoActual = estado from RGN_RIESGO_COBERTURA where @riesgoId = riesgoId

	if (@estadoActual = ''A'') 
	begin
		UPDATE RGN_RIESGO_COBERTURA SET [estado] = ''I''		
		WHERE @riesgoId = riesgoId

	end
	else 
	begin
		UPDATE RGN_RIESGO_COBERTURA SET [estado] = ''A''		
		WHERE @riesgoId = riesgoId

	end
		
	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_polizaPrincipal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_polizaPrincipal](@ajusteid numeric(8,0))

as
declare @contratante varchar(250)
declare @asegurado varchar(250)
declare @aseguradora varchar(250)
declare @aseguradoid numeric(8,0)
declare @aseguradoraid numeric(8,0)
declare @producto varchar(250)
declare @ramo varchar(100)
declare @cobertura varchar(250)

declare @polizaid numeric(8,0)

BEGIN
set @polizaid=(select top 1 polizaid from RGN_POLIZA_AJUSTE where ajusteid=@ajusteid)
set @contratante=(select contratante from RGN_POLIZA where polizaid=@polizaid)
set @asegurado=dbo.dameasegurado(@ajusteid)
set @aseguradora=dbo.dameaseguradora(@ajusteid)

SELECT @producto=dbo.RGN_PRODUCTO.nombre
FROM   dbo.RGN_POLIZA INNER JOIN
       dbo.RGN_PRODUCTO ON dbo.RGN_POLIZA.productoId = dbo.RGN_PRODUCTO.productoId
       where dbo.RGN_POLIZA.polizaid=@polizaid

SELECT  @ramo=dbo.RGN_RAMO.nombre
FROM    dbo.RGN_POLIZA INNER JOIN
        dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId
where dbo.RGN_POLIZA.polizaid=@polizaid

--set @cobertura=
SELECT    @cobertura= dbo.RGN_RIESGO_COBERTURA.nombre
FROM      dbo.RGN_POLIZA INNER JOIN
          dbo.RGN_RIESGO_COBERTURA ON dbo.RGN_POLIZA.riesgoId = dbo.RGN_RIESGO_COBERTURA.riesgoId
where dbo.RGN_POLIZA.polizaid=@polizaid

select @aseguradoid=aseguradoid, @aseguradoraid=aseguradoraid 
from RGN_POLIZA
where polizaid=@polizaid

select isnull(@contratante,''--'') as contratante,
       isnull(@asegurado,''--'') as asegurado,
       isnull(@aseguradora,''--'') as aseguradora,
       isnull(@producto,''--'') as producto, 
       isnull(@ramo,''--'') as ramo,
       isnull(@cobertura,''--'') as cobertura,
       @ajusteid as ajuste,
       @polizaid as poliza,
       @aseguradoid as aseguradoid,
       @aseguradoraid as aseguradoraid
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ConvenioAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ConvenioAjuste]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;

	DECLARE @reserva numeric
	DECLARE @monedaId numeric
	DECLARE @simboloMonedaReserva varchar(3)
	DECLARE @dameNombreMoneda varchar(20)
	
	SET @reserva = dbo.UltimoEstimadoReservaAjuste(@ajusteid)
	SET @monedaId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
	SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaId)
	SET @dameNombreMoneda = dbo.dameNombreMoneda(@monedaId)


	SELECT	TOP 1
				RGN_RAMO.nombre AS ramo,
				RGN_AJUSTE.numeroSiniestroCia AS numsiniestro, 
				RGN_AJUSTE.numAjustePASA AS numajuste, 
				RGN_PRODUCTO.nombre AS tipopoliza, 
				RGN_POLIZA.numeroPoliza AS numpoliza, 
				RGN_TIPOSINIESTRO.tiposiniestro AS tiposiniestro, 
				ADM_PERSONA.persona AS ajustador,
				RGN_SINIESTRO.fsiniestro,
				ASEGURADO.persona AS asegurado,
				CLIENTE.persona AS aseguradora,
				RGN_CONVENIOAJUSTE.fconvenio, 
				RGN_CONVENIOAJUSTE.representante, 
				RGN_CONVENIOAJUSTE.montoIndemnizacion, 
				RGN_CONVENIOAJUSTE.totalPerdida, 
				RGN_CONVENIOAJUSTE.totalIndemnizacion, 
				RGN_CONVENIOAJUSTE.totalDeducible,
				@simboloMonedaReserva as simbolo,
				@dameNombreMoneda as nombreMoneda
	FROM  RGN_AJUSTE LEFT OUTER JOIN
				RGN_CONVENIOAJUSTE ON RGN_CONVENIOAJUSTE.ajusteId = RGN_AJUSTE.ajusteId INNER JOIN
				RGN_POLIZA_AJUSTE ON RGN_AJUSTE.ajusteId = RGN_POLIZA_AJUSTE.ajusteId INNER JOIN
				RGN_POLIZA ON RGN_POLIZA_AJUSTE.polizaId = RGN_POLIZA.polizaId AND 
				RGN_POLIZA_AJUSTE.aseguradoraId = RGN_POLIZA.aseguradoraId INNER JOIN
				RGN_RAMO ON RGN_RAMO.ramoId = RGN_POLIZA.ramoId INNER JOIN
				RGN_PRODUCTO ON RGN_POLIZA.productoId = RGN_PRODUCTO.productoId INNER JOIN
				RGN_SINIESTRO ON RGN_AJUSTE.siniestroid = RGN_SINIESTRO.siniestroid INNER JOIN
				RGN_TIPOSINIESTRO ON RGN_SINIESTRO.tiposiniestroid = RGN_TIPOSINIESTRO.tiposiniestroid INNER JOIN
				ADM_AJUSTADOR ON RGN_AJUSTE.ajustadorId = ADM_AJUSTADOR.personaId INNER JOIN
				ADM_PERSONA ON ADM_AJUSTADOR.personaId = ADM_PERSONA.personaId INNER JOIN
	      ADM_ASEGURADO ON ADM_ASEGURADO.personaId = RGN_POLIZA.aseguradoId INNER JOIN
	      ADM_PERSONA ASEGURADO ON ASEGURADO.personaId = ADM_ASEGURADO.personaId INNER JOIN
        ADM_CLIENTE ON ADM_CLIENTE.aseguradoraId = RGN_POLIZA.aseguradoraId INNER JOIN
        ADM_PERSONA CLIENTE ON CLIENTE.personaId = ADM_CLIENTE.aseguradoraId 
	WHERE RGN_AJUSTE.ajusteId = @ajusteId

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_PolizasAsociadasSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_PolizasAsociadasSelect] 
(	
	
	@ajusteid numeric(8,0)
	
	
	
)
AS
BEGIN

DELETE FROM RGN_POLIZAS_ASOCIADAS

declare @polizaId numeric(8,0)
declare @numPoliza varchar(100)
declare @asegurado varchar(1000)
declare @aseguradora varchar (1000)
declare @cobertura varchar (100)
declare @producto varchar (100)
declare @ramo varchar (100)

DECLARE cursorPolizas CURSOR FOR 
SELECT polizaId FROM RGN_POLIZA_AJUSTE
WHERE ajusteId=@ajusteId

OPEN cursorPolizas 
FETCH NEXT FROM cursorPolizas INTO @polizaId
WHILE @@FETCH_STATUS = 0 
BEGIN 
	
	SELECT 
		@numPoliza = dbo.RGN_POLIZA.numeroPoliza,
		@cobertura = dbo.RGN_RIESGO_COBERTURA.nombre,
		@producto = dbo.RGN_PRODUCTO.nombre,
		@ramo= dbo.RGN_RAMO.nombre
		
	FROM   dbo.RGN_POLIZA 
		INNER JOIN dbo.RGN_RIESGO_COBERTURA ON dbo.RGN_POLIZA.riesgoId = dbo.RGN_RIESGO_COBERTURA.riesgoId
	       INNER JOIN dbo.RGN_PRODUCTO ON dbo.RGN_POLIZA.productoId = dbo.RGN_PRODUCTO.productoId
	       INNER JOIN dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId		

	WHERE dbo.RGN_POLIZA.polizaId=@polizaId	   


	set @asegurado= dbo.dameAsegurado(@ajusteId)
	set @aseguradora=dbo.dameAseguradora(@ajusteId)


	insert into RGN_POLIZAS_ASOCIADAS 
	(
		ajusteId,
		polizaId,
		numPoliza,	
		cobertura,
		asegurado,
		aseguradora,
		ramo,
		producto

	)values
	(
		@ajusteId,
		@polizaId,
		@numPoliza,	
		@cobertura,
		@asegurado,
		@aseguradora,
		@ramo,
		@producto
	)

	FETCH NEXT FROM cursorPolizas INTO @polizaId
END 
CLOSE cursorPolizas
DEALLOCATE cursorPolizas

	select * from RGN_POLIZAS_ASOCIADAS  


END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Encabezado_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--sp_rgen_Encabezado_Select 185
CREATE PROCEDURE [dbo].[sp_rgen_Encabezado_Select]
(@ajusteid numeric(8,0))

AS
BEGIN

	declare @quienNotifico varchar(250)
	declare @NombreDelNotificante varchar(250)
 	declare @faviso datetime
  declare @medioDeNotificacionId numeric(8,0) 

	declare @NombreQuienConfirma varchar(250) 
	declare @FechayHoraConfirmacion datetime 
	declare @medioConfirmacionId numeric(8,0)
	declare @cargoconfirmante varchar(250) 

	declare @aseguradoraid numeric(8,0)
	declare @aseguradora varchar(1000)
	declare @nombreresponsable varchar(250)
	declare @telefonoresponsable varchar(20)
	declare @emailresponsable varchar(250)

	declare @brokerId numeric(8,0)
	declare @broker varchar (1000)
	declare @nombreresponsableBroker varchar(250)
	declare @telefonoresponsableBroker varchar(20)
	declare @emailresponsableBroker varchar(250)
	declare @numeroSiniestroCia varchar(100)
	declare @numeroAjuste varchar(30)

	declare @fsiniestro datetime
	declare @lugarsiniestro varchar(250)
	declare @ubigeoid varchar(6)	
	declare @tiposiniestro_id numeric(8,0)
	declare @tipoSiniestro varchar(250)
	declare @nombreresponsableSiniestro varchar(250)
	declare @telefonoresponsableSiniestro varchar(20)
	declare @emailresponsableSiniestro varchar(250)
	declare @descripcion varchar(250)

	declare @usuario varchar(100)
  declare @polizaid numeric(8,0)

	declare @ajustadorid numeric(8,0)
	declare @ajustador varchar(1000)
	declare @FechaHoraCoordinacion datetime 
	declare @FechaHoraReunion datetime
	declare @ubigeoidInspeccion varchar(6)
  declare @personacontacto varchar(250)
  declare @tajusteid numeric(8,0)
  declare @lugarDeReunion varchar(250) 
  declare @referencia varchar(250)
  declare @telefonoPersonaContacto varchar(20)

	declare @contratante varchar(250)
	declare @asegurado varchar(250)
	declare @aseguradoid numeric(8,0)

	declare @numeropoliza varchar(100)
	declare @ramoid numeric(8,0)
	declare @ramoafectado varchar(50)

--Insertando datos del AJUSTE

select
	@quienNotifico= quienNotifico,
	@nombredelNotificante= NombreDelNotificante,
	@faviso= faviso,
  @mediodeNotificacionid= medioDeNotificacionId, 
  @NombrequienConfirma= NombreQuienConfirma, 
	@FechayHoraConfirmacion= FechayHoraConfirmacion, 
	@medioConfirmacionID = medioConfirmacion,
	@cargoconfirmante= cargoconfirmante, 
	@brokerid= brokerId,
	@NumeroSiniestroCia= NumeroSiniestroCia,
	@tajusteid= tajusteid,
  @ajustadorid=ajustadorid,
	@numeroAjuste=numAjustePASA	

from RGN_AJUSTE
where ajusteid=@ajusteid        

--Insertando contacto de la ASEGURADORA
select @nombreResponsable=nombreContacto, 
       @telefonoResponsable=telefonoContacto, 
       @emailResponsable=emailcontacto
from RGN_CONTACTOS_AJUSTE
where  ajusteid=@ajusteid and TipoContactoid=''1''

--Insertando contacto del BROKER
select @nombreResponsableBroker=nombreContacto, 
       @telefonoResponsableBroker=telefonoContacto, 
       @emailResponsableBroker=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''2''

--Insertando contactos del SINIESTRO
select @nombreResponsableSiniestro=nombreContacto, 
       @telefonoResponsableSiniestro=telefonoContacto, 
       @emailResponsableSiniestro=emailcontacto
from RGN_CONTACTOS_AJUSTE 	
where  ajusteid=@ajusteid and TipoContactoid=''5''

--Insertando datos del SINIESTRO
select     
		 @descripcion=descripcion, 
	   @fsiniestro=fsiniestro, 
	   @tiposiniestro_id=tiposiniestroid, 
	   @lugarsiniestro=lugarsiniestro,
	   @ubigeoid=ubigeoid 
from RGN_SINIESTRO 
where siniestroid=(select siniestroid from RGN_AJUSTE where ajusteid=@ajusteid)

select   @ajusteid=ajusteid,
	 @polizaid=polizaid,
	 @aseguradoraid=aseguradoraid	
from RGN_POLIZA_AJUSTE
where ajusteid=@ajusteid  

--insertando datos de la inspeccion
select  top 1 @FechaHoraCoordinacion=FechaHoraCoordinacion, 
	@lugardeReunion=lugarDeReunion,
	@referencia=referencia,
	@personacontacto=personacontacto,
	@FechaHoraReunion=FechaHoraReunion, 
	@ubigeoIDinspeccion=ubigeoid,
	@telefonoPersonaContacto=telefonoPersonaContacto        
from RGN_ACTIVIDAD
where ajusteid = @ajusteid and tipoActividadId = 5


--sacando datos de la poliza

select @contratante=contratante, @aseguradoid=aseguradoid, @numeropoliza=numeroPoliza, @ramoid=ramoid
from RGN_POLIZA
where polizaid=@polizaid

select  @asegurado=persona from ADM_Persona where personaid=@aseguradoid

--datos del ramo afectado

select @ramoafectado=nombre from RGN_RAMO where ramoid=@ramoid

--Nombre de la Ajustador, Aseguradora y Broker
SELECT @ajustador=ADM_PERSONA.persona FROM ADM_PERSONA
WHERE ADM_PERSONA.personaId=@ajustadorId


SELECT @broker=ADM_PERSONA.persona FROM ADM_PERSONA
WHERE ADM_PERSONA.personaId=@brokerId

SELECT @aseguradora=ADM_PERSONA.persona FROM ADM_PERSONA
WHERE ADM_PERSONA.personaId=@aseguradoraId

SELECT @tipoSiniestro=RGN_TIPOSINIESTRO.tiposiniestro FROM RGN_TIPOSINIESTRO 
WHERE RGN_TIPOSINIESTRO.tipoSiniestroId=@tipoSiniestro_Id

--Sacando la reserva
DECLARE @reserva numeric
DECLARE @monedaId numeric
DECLARE @simboloMonedaReserva varchar(3)

SET @reserva = dbo.UltimoEstimadoReservaAjuste(@ajusteid)
SET @monedaId =dbo.UltimaMonedaReclamoAjuste(@ajusteId)
SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaId)


--mostrando el resultado

Select  @ajusteid as ajusteId, 
		@numeroAjuste as numeroAjuste,
		isNull(@quienNotifico,''Cia Seguros'') as quiennotifico, 
		@NombreDelNotificante as NombreDelNotificante, 
		@faviso as faviso, 
		isNull(@medioDeNotificacionId,1) as ''medionotificacionId'',
		
		
		@NombreQuienConfirma as nombrequienconfirma, 
		@FechayHoraConfirmacion as fechayhoraconfirmacion, 
		isNull(@medioConfirmacionId,1) as ''medioconfirmacionid'', 
		@cargoconfirmante as cargoconfirmante,
		
		isNull(@aseguradoraid,2) as aseguradoraid, 
		@nombreresponsable as nombreresponsable, 
		@telefonoresponsable as telefonoresponsable, 
		@emailresponsable as emailresponsable, 
		
		IsNull(@brokerId,5) as brokerid, 
		@nombreresponsableBroker as nombreresponsablebroker, 
		@telefonoresponsableBroker as telefonoresponsablebroker, 
		@emailresponsableBroker as emailresponsablebroker, 
		@numeroSiniestroCia as ''numerosiniestroCia'', 
		
		@fsiniestro as fsiniestro, 
		@lugarsiniestro as ''lugarsiniestro'', 
		@ubigeoid as ubigeo, 
		dbo.dameDistrito(@ubigeoid) as distrito,
		isNull(@tiposiniestro_id,1) as tiposiniestroId, 
		@nombreresponsableSiniestro as nombreresponsablesiniestro, 
		@telefonoresponsableSiniestro as telefonoresponsablesiniestro, 
		@emailresponsableSiniestro as emailresponsablesiniestro, 
		@descripcion as descripcion, 
		
		@polizaid as polizaid, 
		
		isNull(@ajustadorid,46) as ajustadorid, 
		
		@FechaHoraCoordinacion as fechahoracoordinacion,
		@FechaHoraReunion as fechahorareunion,
		isNull(@ubigeoidInspeccion,'''') as ubigeoIDinspeccion,
		dbo.dameDistrito(@ubigeoidInspeccion) as distritoInspeccion,
		@personacontacto as personacontacto,
		isNull(@tajusteid ,1) as tajusteid, 
		@lugarDeReunion as lugareunion,  
		@referencia as referencia, 
		@telefonoPersonaContacto as telefonopersonacontacto,
		
		@contratante as contratante,
		@asegurado as asegurado,
		
		@numeropoliza as numeroPoliza,
		@ramoafectado as RamoAfectado,
		@ajustador as ajustador,
		@broker as broker,
		@aseguradora as aseguradora,
		@tipoSiniestro as tipoSiniestro,
		@reserva AS reserva,
		@simboloMonedaReserva As moneda 


END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_mensajes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_mensajes](@ajusteid numeric(8,0))

as

declare @registroInicial varchar(1500)
declare @registroAvanzado varchar(1500)
declare @CoordinacionInspeccion varchar(1500)
declare @InformeBasico varchar(1500)
declare @Inspeccion varchar(1000)
declare @SolicitudDocumentos varchar(1000)
declare @InformeComplementario varchar(2000)
declare @InformePreliminar varchar(2000)
declare @InformeFinal varchar(2000)
declare @convenioAjuste varchar(2000)
declare @cabecera varchar(8000)
declare @ultimascomunicaciones varchar(1000)
declare @ultimosAnexos varchar(1000)
declare @ultimosGastos varchar(1000)
declare @ultimasActividades varchar(1000)

declare @auxTEXTO varchar(250)
declare @auxTEXTO2 varchar(250)
declare @auxTEXTO3 varchar(250)
declare @auxFECHA datetime
declare @auxFechaTexto char(250)
declare @auxFECHA2 datetime
declare @auxNUMERICO numeric(8,0)
declare @auxNUMERICO2 numeric(8,0)
declare @polizaid numeric(8,0)
declare @numpoliza varchar(50)

BEGIN

--REGISTRO INICIAL
 set @auxtexto=''''
 set @auxfecha=''''
 set @auxfecha2=''''
 set @auxnumerico=0
 set @auxnumerico2=0
 set @registroinicial=''''

 select @auxtexto=quienNotifico,@auxFechaTexto=faviso, @auxfecha=faviso, @auxnumerico=mediodenotificacionid,  @auxnumerico2=siniestroid 
 from RGN_AJUSTE 
 where ajusteid=@ajusteid

 set @registroinicial=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
        <tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 0),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="150"><strong>Se comunicó</strong></td>    
		<td width="400">''+isnull(@auxtexto,''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>El día</strong></td>
		<td>''+isnull(convert(varchar(100),@auxfecha,103),''--'')+
		''</td>  
		</tr>  
		<tr> 
		<td><strong>medio de comunicación </strong></td>
		<td>''+isnull((select top 1 nombre from RGN_TIPOCOMUNICACION where tcomunicacionid= @auxnumerico),''--'')+
		''</td>  
		</tr>
		<tr> 
		<td><strong>El tipo de siniestro fue</strong></td>
		<td>''+isnull((select tiposiniestro from RGN_TIPOSINIESTRO where tiposiniestroid=(select top 1 tiposiniestroId from RGN_SINIESTRO where siniestroid=@auxnumerico2)),''--'')+
		''</td>  
		</tr>
		</table>
		</div>''


		     
		     
 		    

--REGISTRO AVANZADO
set @auxtexto=''''
set @auxtexto2=''''
set @auxtexto3=''''
set @auxnumerico=0
set @registroavanzado=''''
select @auxtexto=persona from ADM_PERSONA where personaid =(select ajustadorid from RGN_AJUSTE where ajusteid=@ajusteid)
select @polizaid=polizaid from RGN_POLIZA_AJUSTE where ajusteid=@ajusteid
select @numpoliza=numeroPOLIZA from RGN_POLIZA where polizaid=@polizaid
select @auxtexto2=nombre from RGN_RAMO where ramoid=(select ramoid from RGN_POLIZA where polizaid=@polizaid)
select @auxtexto3=telefono from ADM_TELEFONOxPERSONA where personaid =(select ajustadorid from RGN_AJUSTE where ajusteid=@ajusteid)

set @registroavanzado=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 1),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>Ajustador Asignado</strong></td>    
		<td width="400">''+isnull(@auxtexto,''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Nº de Póliza</strong></td>
		<td>''+isnull(convert(char(20),(@numpoliza)),''--'')+
		''</td>  
		</tr>  
		<tr> 
		<td><strong>Ramo</strong></td>
		<td>''+isnull(@auxtexto2,''--'')+
		''</td>  
		</tr>
		<tr> 
		<td><strong>Teléfono</strong></td>
		<td>''+isnull(@auxtexto3,''--'')+
		''</td>  
		</tr>
		</table>
		</div>''




		     

--REGISTRO COORDINACION(BLOQUE3)
declare @telefono varchar(15)

declare @lugar varchar(200)

set @auxtexto=''''
set @auxFecha=''''
set @coordinacionInspeccion=''''
set @telefono=''''
set @lugar=''''

select @auxFechaTexto=FechaHoracoordinacion, @auxFecha=FechaHoracoordinacion,@auxFecha2=FechaHoraReunion, @auxTexto=personacontacto, @telefono=telefonoPersonaContacto,@lugar=lugarDeReunion from RGN_ACTIVIDAD where ajusteid=@ajusteid 

if (@auxfecha <  ''01/01/1950'') 
begin
       set @CoordinacionInspeccion=''Aun no se ha realizado la coordinación de Inspección''+''<br />''
end
else
	set @CoordinacionInspeccion=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 2),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>Fecha en la que se coordinó la inspección</strong></td>    
		<td width="300">''+isnull(convert(char(10),@auxFecha,103),''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Fecha prevista para la inspección</strong></td>
		<td>''+isnull(convert(char(10),@auxFecha2,103),''--'')+
		''</td>  
		</tr>  
		<tr> 
		<td><strong>Contacto</strong></td>
		<td>''+isnull(@auxTexto,''--'')+
		''</td>  
		</tr>
		<tr> 
		<td><strong>Teléfono</strong></td>
		<td>''+isnull(@telefono,''--'')+
		''</td>  
		</tr>
		<tr> 
		<td><strong>Lugar</strong></td>
		<td>''+isnull(@lugar,''--'')+
		''</td>  
		</tr>
		</table>
		</div>''


--COORDINACION INSPECCION(BLOQUE4)
set @auxFecha=''''
set @Auxtexto=''''
set @Inspeccion=''''

select @auxFechaTexto = RGN_AJUSTE.fechaHoraProgramacion , @auxFecha=RGN_AJUSTE.fechaHoraProgramacion, @auxTexto=RGN_ACTIVIDAD.personaentrevistada from RGN_ACTIVIDAD,RGN_AJUSTE 
where RGN_AJUSTE.ajusteid=@ajusteid and  RGN_AJUSTE.ajusteid=RGN_ACTIVIDAD.ajusteid
if (@auxfecha <  ''01/01/1950'') 
begin
	set @Inspeccion=''Aun no se ha realizado la inspección''+''<br />''
end
else
        set @Inspeccion=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 3),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>La inspección se realizó el día</strong></td>    
		<td width="400">''+isnull(convert(char(11),@auxFecha,103),''--'')+isnull(convert(char(10),@auxFecha,108),''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Contacto</strong></td>
		<td>''+isnull(@auxTexto,''--'')+
		''</td>  
		</tr>  
		<tr> 
		<td><strong>Lugar</strong></td>
		<td>''+isnull(@lugar,''--'')+
		''</td>  
		</tr>
		</table>
		</div>''



--INFORME BASICO(BLOQUE 5)
set @auxFecha=''''
set @Auxtexto=''''
set @InformeBasico=''''

select @auxFechaTexto = fecha, @auxFecha=fecha, @Auxtexto=enviadoa from RGN_INFORME where ajusteid=@ajusteid and tinformeid=''15''
IF (@auxfecha <  ''01/01/1950'') 
   begin
	set @InformeBasico=''Aun no se envió el Informe Basico''+''<br />''
   end 
ELSE 
 set @InformeBasico=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 4),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>Fecha de envio</strong></td>    
		<td width="400">''+isnull(convert(char(10),@auxFecha,103),''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Enviado a</strong></td>
		<td>''+isnull(@auxtexto,''--'')+
		''</td>  
		</tr>  
		</table>
		</div>''


--DOCUMENTOS FALTANTES(BLOQUE 6)
set @SolicitudDocumentos=''''
set @SolicitudDocumentos=dbo.damedocumentos(@ajusteId)+''<br />''



--INFORME PRELIMINAR(BLOQUE 7)
set @auxfecha=''''
set @InformePreliminar=''''
select @auxFechaTexto= fecha, @auxfecha=fecha, @Auxtexto=enviadoa from RGN_INFORME where @ajusteid=ajusteid and tinformeid=''17''

IF (@auxfecha <  ''01/01/1950'') 
   begin
	set @InformePreliminar=''Aun no se envió el Informe Preliminar''+''<br />''
   end 
ELSE 
  set @InformePreliminar=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 5),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>Fecha de envio</strong></td>    
		<td width="400">''+isNull(convert(char(10),@auxFecha,103),'' -- '')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Enviado a</strong></td>
		<td>''+isnull(@auxtexto,''--'')+
		''</td>  
		</tr>  
		</table>
		</div>''




--INFORME COMPLEMENTARIO(BLOQUE 8)
set @auxnumerico=0
set @auxFecha=''''
set @InformeComplementario=''''
set @auxTexto=''''

select  @auxnumerico=count(*) from RGN_INFORME where ajusteid=@ajusteid and tinformeid=''19'' 
select @auxFechaTexto = max(fechaEnvio), @auxFecha=max(fechaEnvio),  @auxtexto=enviadoA from RGN_INFORME where ajusteid=@ajusteid and tinformeid=''19'' group by enviadoA


IF (@auxfechaTexto <  ''01/01/1950'') 
   begin
	set @InformeComplementario=''Aun no se registro ningún informe complentario''+''<br />''
   end 
ELSE 
   set @InformeComplementario=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 6),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="200"><strong>Número de informes</strong></td>    
		<td width="400">''+isnull(convert(char(2),@auxnumerico),''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Fecha de último envío</strong></td>
		<td>''+isnull(convert(char(10), @auxFecha,103),''--'')+
		''</td>  
		</tr>  
		<tr> 
		<td><strong>Enviado a</strong></td>
		<td>''+isnull(@auxTexto,''--'')+
		''</td>  
		</tr>
		</table>
		</div>''




--CONVENIO DE AJUSTE(BLOQUE 9)
DECLARE @monedaId numeric
DECLARE @simboloMonedaReserva varchar(3)

SET @monedaId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaId)



declare @fechaasegurado datetime 
declare @auxfechaenvioAseguradora datetime

set @auxfecha=''''
set @ConvenioAjuste=''''
set @fechaasegurado=''''
set @auxnumerico=0

select @auxfechaTexto=fconvenio, @auxfecha=fconvenio, @auxfechaenvioAseguradora = fenvioAseguradora, @fechaasegurado=fenvioAsegurado, @auxnumerico=totalIndemnizacion  from RGN_CONVENIOAJUSTE where @ajusteid=ajusteid 
IF ( @auxfechaTexto <  ''01/01/1950'') 
   begin
	set @ConvenioAjuste=''Aun no se registro el convenio de ajuste''+''<br />''
   end 
ELSE 
set @convenioajuste=''<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>    
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 7),103),''--''))
          +'')</strong></td>
        </tr>
		<td width="200"><strong>Fecha de Envío al Asegurado</strong></td>    
		<td width="400">''+isNull(convert(char(10),@fechaasegurado,103),'' -- '')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Fecha de Envío a la Aseguradora</strong></td>
		<td>''+isNull(convert(char(10),@auxfechaenvioAseguradora,103),'' -- '') +
		''</td>  
		</tr>  
		<tr> 
		<td><strong>Indemnización</strong></td>
		<td>''+@simboloMonedaReserva+'' ''+ isNull(convert(char(15), @auxnumerico),'' -- '')+
		''</td>  
		</tr>
		</table>
		</div>''






--INFORME FINAL(BLOQUE 10)
declare @auxfechafinal datetime

set @auxfechafinal=''''
set @auxfecha=''''
set @InformeFinal=''''
set @auxtexto=''''
select @auxfechaTexto =fecha, @auxfecha=fecha, @auxTexto=enviadoA from RGN_INFORME where @ajusteid=ajusteid and tinformeid=''21''
select @auxfechafinal=fcargoInformeFinal from RGN_AJUSTE where @ajusteid=ajusteid
-- 


IF (@auxfecha <  ''01/01/1950'') 
   begin
	set @InformeFinal=''Aun no se envió el Informe Final''+''<br />''
   end 
ELSE 
set @InformeFinal=''
		<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  
		<tr>
          <td><strong>(''+
			(select isnull(convert(varchar(20),dbo.sp_rgen_administraFechaCambio(@ajusteid, 8),103),''--''))
          +'')</strong></td>
        </tr>
		<tr>    
		<td width="100"><strong>Fecha de envio</strong></td>    
		<td width="400">''+isnull(convert(char(10),@auxFecha,103),''--'')+
		''</td>  
		</tr> 
		<tr>  
		<td><strong>Fecha de Cargo</strong></td>
		<td>''+isnull(convert(char(10),@auxfechafinal,103),''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Enviado a</strong></td>
		<td>''+isnull(@auxtexto,''--'')+
		''</td>  
		</tr>  
		<tr>  
		<td><strong>Indemnización</strong></td>
		<td>''+@simboloMonedaReserva+'' ''+isnull(convert(char(15), @auxnumerico),''--'')+
		''</td>  
		</tr>  
		</table>
		</div>''


--select * from RGN_ajuste
--sp_rgen_mensajes 185






--CABECERA
set @cabecera = ''
<div style="width:50%;padding:5px; font-size: 10px;"><table  width="100%" border="0" cellspacing="4" cellpadding="0">  <tr>    <td width="110"><strong>Asegurado</strong></td>    <td width="690">''+
isnull(dbo.dameasegurado(@ajusteid),''--'')+
''</td>  </tr>  <tr>    <td><strong>Aseguradora</strong></td>    <td>''
+isnull(dbo.dameaseguradora(@ajusteid),''--'')+
''</td>  </tr>  <tr>    <td><strong>Ramo</strong></td>    <td>''
+isNull((select r.nombre from RGN_POLIZA a, RGN_RAMO r where polizaId = dbo.PrimeraPoliza(@ajusteId) and (r.ramoId = a.ramoId)),''--'')+
''</td>  </tr>  <tr>    <td><strong>Tipo de Siniestro</strong> </td><td>''+isnull((SELECT     dbo.RGN_TIPOSINIESTRO.tipoSiniestro
				     FROM         dbo.RGN_AJUSTE INNER JOIN
                      		     dbo.RGN_SINIESTRO ON dbo.RGN_AJUSTE.siniestroid = dbo.RGN_SINIESTRO.siniestroid INNER JOIN
                      		     dbo.RGN_TIPOSINIESTRO ON dbo.RGN_SINIESTRO.tipoSiniestroId = dbo.RGN_TIPOSINIESTRO.tipoSiniestroId 
                                     where dbo.RGN_AJUSTE.ajusteid=@ajusteid),''--'')+
''</td>  </tr>  <tr>    <td><strong>Ajustador</strong></td>    <td>''
+isnull(dbo.dimeQuePersonaEs((select ajustadorid from RGN_AJUSTE where ajusteid=@ajusteid)),''--'')+
''</td>  </tr>  <tr>    <td><strong>N&deg; P&oacute;liza</strong> </td>    <td>''
+isnull(convert(char(20),(@numpoliza)),''--'')+''</td>  </tr>  <tr>    <td><strong>N&deg; Siniestro</strong> </td>    <td>''
+isnull((select numerosiniestrocia from RGN_AJUSTE where ajusteid=@ajusteid),''--'')+
''</td>  </tr>  <tr>    <td><strong>N&deg; Ajuste</strong> </td>    <td>''
+isnull((select numajustepasa from RGN_AJUSTE where ajusteid=@ajusteid),''--'')+
''</td> </tr></table></div>''

set @ultimascomunicaciones=dbo.dameUltimasComunicaciones(@ajusteid)
set @ultimosAnexos=dbo.dameUltimosAnexos(@ajusteid)
set @ultimosGastos=dbo.dameUltimosGastos(@ajusteid)	      	
set @ultimasActividades=dbo.dameUltimasActividades(@ajusteid)	

select isnull(@registroinicial,''--'') as RegistroInicial, 
       isnull(@registroavanzado,''--'') as RegistroAvanzado, 
       isnull(@CoordinacionInspeccion,''--'') as CoordinacionInspeccion, 
       isnull(@Inspeccion,''--'') as Inspeccion, 
       isnull(@informebasico,''--'') as InformeBasico, 
       isnull(@solicitudDocumentos,''--'') as SolicitudDocumentos,
       isnull(@InformePreliminar,''--'') as InformePreliminar,
       isnull(@InformeFinal,''--'') as InformeFinal, 
       isnull(@InformeComplementario,''--'') as InformeComplementario,
       isnull(@convenioajuste,''--'') as convenioajuste,
       isnull(@cabecera,''--'') as cabecera,
       isnull(@ultimascomunicaciones,''--'') as UltimasComunicaciones,
       isnull(@ultimosAnexos,''--'') as UltimosAnexos,
       isnull(@ultimosGastos,''--'') as UltimosGastos,
       isnull(@ultimasActividades,''--'') as UltimasActividades	

END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_cabecera]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




--sp_rgen_informebasico_cabecera 1509

CREATE    PROCEDURE [dbo].[sp_rgen_informebasico_cabecera] (@ajusteid int)
as
--declare @ajusteid int
--set @ajusteid = 1
	DECLARE @reserva numeric
	DECLARE @monedaId numeric
	DECLARE @simboloMonedaReserva varchar(3)
	DECLARE @tipoSiniestro varchar(50)
	
	SET @reserva = dbo.UltimoEstimadoReservaAjuste(@ajusteid)
	SET @monedaId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
	SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaId)
	SELECT   
		distinct  RGN_AJUSTE.numeroSiniestroCia AS numsiniestro, 
		RGN_AJUSTE.numeroSiniestroBroker AS numsiniestroBroker,
		RGN_AJUSTE.numAjustePASA AS numajuste, 
		RGN_RAMO.nombre AS tipopoliza, 
		RGN_POLIZA.numeroPoliza AS numpoliza, 
		SUBSTRING(RGN_TIPOSINIESTRO.tiposiniestro,0,15)+''...'' AS tipoSiniestro , 
		ADM_PERSONA.persona AS ajustador,
		RGN_SINIESTRO.fsiniestro,
		@reserva AS reserva,
		@simboloMonedaReserva As moneda
	FROM  RGN_AJUSTE INNER JOIN
				RGN_POLIZA_AJUSTE ON RGN_AJUSTE.ajusteId = RGN_POLIZA_AJUSTE.ajusteId INNER JOIN
				RGN_POLIZA ON RGN_POLIZA_AJUSTE.polizaId = RGN_POLIZA.polizaId AND 
				RGN_POLIZA_AJUSTE.aseguradoraId = RGN_POLIZA.aseguradoraId INNER JOIN
				RGN_RAMO ON RGN_POLIZA.ramoId = RGN_RAMO.ramoId INNER JOIN
				RGN_SINIESTRO ON RGN_AJUSTE.siniestroid = RGN_SINIESTRO.siniestroid INNER JOIN
				RGN_TIPOSINIESTRO ON RGN_SINIESTRO.tiposiniestroid = RGN_TIPOSINIESTRO.tiposiniestroid INNER JOIN
				ADM_AJUSTADOR ON RGN_AJUSTE.ajustadorId = ADM_AJUSTADOR.personaId INNER JOIN
				ADM_PERSONA ON ADM_AJUSTADOR.personaId = ADM_PERSONA.personaId
	where RGN_AJUSTE.ajusteId=@ajusteid
	-- seccion para obtener una sola poliza para el ajuste
	     and RGN_POLIZA_AJUSTE.polizaId=(select min(P.polizaId) from RGN_POLIZA_AJUSTE P where P.ajusteId=@ajusteId)







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_InformeBasicoPacificoDatosAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N' --proc_InformeBasicoPacificoDatosAjuste 1403
CREATE PROCEDURE [dbo].[proc_InformeBasicoPacificoDatosAjuste] (@ajusteid int)
as

	DECLARE @reserva numeric
	DECLARE @reclamo numeric
	DECLARE @monedaReservaId numeric
	DECLARE @monedaReclamoId numeric
	DECLARE @simboloMonedaReserva varchar(3)
	DECLARE @simboloMonedaReclamo varchar(3)
	
	SET @reserva = dbo.UltimoEstimadoReservaAjuste(@ajusteid)
	SET @reclamo = dbo.UltimoReclamoAjuste(@ajusteid)
	SET @monedaReservaId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
	SET @monedaReclamoId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
	SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaReservaId)
	SET @simboloMonedaReclamo = dbo.dameSimboloMoneda(@monedaReclamoId)

SELECT     dbo.RGN_AJUSTE.numeroSiniestroBroker, 
		   dbo.RGN_AJUSTE.numeroSiniestroCia, 
		   dbo.RGN_AJUSTE.numAjustePASA, 
		   dbo.ADM_PERSONA.persona AS ajustador, 
           dbo.RGN_TIPOSINIESTRO.tipoSiniestro, 
		   dbo.RGN_SINIESTRO.fsiniestro, 
		   dbo.RGN_SINIESTRO.lugarSiniestro, 
		   dbo.dameDistrito(dbo.RGN_SINIESTRO.ubigeoId) AS distritoSiniestro, 
           dbo.RGN_AJUSTE.detalleocurrencia, 
		   dbo.RGN_AJUSTE.causasiniestro, 
		   dbo.RGN_AJUSTE.investigaciones, 
		   dbo.RGN_AJUSTE.descripcionRiesgo, 
           dbo.RGN_ACTIVIDAD.lugarDeReunion, 
		   dbo.RGN_ACTIVIDAD.personaContacto,
		   dbo.RGN_ACTIVIDAD.cargoPersonaContacto,
		   dbo.dameDistrito(dbo.RGN_ACTIVIDAD.ubigeoId) AS distritoReunion,
		   @reserva AS reserva,
		   @reclamo AS reclamo,
		   @simboloMonedaReserva As monedaReserva,
		   @simboloMonedaReclamo As monedaReclamo,
		   dbo.RGN_ACTIVIDAD.FechaHoraReunion, 
		   dbo.RGN_ACTIVIDAD.PersonaEntrevistada,
		   dbo.RGN_AJUSTE.situacionAjuste


FROM         dbo.ADM_AJUSTADOR INNER JOIN
			dbo.ADM_PERSONA ON dbo.ADM_AJUSTADOR.personaId = dbo.ADM_PERSONA.personaId INNER JOIN
			dbo.RGN_AJUSTE ON dbo.ADM_AJUSTADOR.personaId = dbo.RGN_AJUSTE.ajustadorId INNER JOIN
			dbo.RGN_POLIZA_AJUSTE ON dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId AND 
			dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId INNER JOIN
			dbo.RGN_POLIZA ON dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
			dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId AND
			dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId INNER JOIN
			dbo.RGN_ACTIVIDAD ON dbo.RGN_AJUSTE.ajusteId = dbo.RGN_ACTIVIDAD.ajusteId AND 
			dbo.RGN_AJUSTE.ajusteId = dbo.RGN_ACTIVIDAD.ajusteId INNER JOIN
			dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId AND dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId INNER JOIN
			dbo.RGN_SINIESTRO ON dbo.RGN_AJUSTE.siniestroid = dbo.RGN_SINIESTRO.siniestroid INNER JOIN
			dbo.RGN_TIPOSINIESTRO ON dbo.RGN_SINIESTRO.tipoSiniestroId = dbo.RGN_TIPOSINIESTRO.tipoSiniestroId AND 
			dbo.RGN_SINIESTRO.tipoSiniestroId = dbo.RGN_TIPOSINIESTRO.tipoSiniestroId

WHERE (RGN_AJUSTE.ajusteId = @ajusteid) AND
	   	  (RGN_ACTIVIDAD.tipoActividadId = 5) AND 
		  RGN_POLIZA_AJUSTE.polizaId=(select min(P.polizaId) from RGN_POLIZA_AJUSTE P where P.ajusteId=@ajusteId)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_UsuariosListaFilteredByCreator]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_UsuariosListaFilteredByCreator](@pid numeric(8,0)) 
as
begin
SELECT     ADM_PERSONA.personaId, ISNULL(ADM_PERSONA.creadorId, -1) AS creadorId, IsNull(dbo.dameTipoPersona(ADM_PERSONA.creadorId),'' -- '') as tipoPersonaCreador , ADM_PERSONA.persona, ADM_PERSONA.fcrea, 
                      ADM_PERSONA.fupdate, ADM_PERSONA.usuarioId, ADM_PERSONA.personajuridica, ADM_PERSONA.ucrea, ADM_PERSONA.estado, 
                      ADM_PERSONA.uupdate, ADM_TPERSONA.tpersona
FROM         ADM_PERSONA INNER JOIN
                      ADM_TPERSONA ON ADM_PERSONA.tpersonaid = ADM_TPERSONA.tpersonaid

where ADM_PERSONA.creadorId = @pid;	

end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsuariosListaFilteredByCreator]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UsuariosListaFilteredByCreator](@pid numeric(8,0)) 
as
begin
SELECT     ADM_PERSONA.personaId, ISNULL(ADM_PERSONA.creadorId, -1) AS creadorId, IsNull(dbo.dameTipoPersona(ADM_PERSONA.creadorId),'' -- '') as tipoPersonaCreador , ADM_PERSONA.persona, ADM_PERSONA.fcrea, 
                      ADM_PERSONA.fupdate, ADM_PERSONA.usuarioId, ADM_PERSONA.personajuridica, ADM_PERSONA.ucrea, ADM_PERSONA.estado, 
                      ADM_PERSONA.uupdate, ADM_TPERSONA.tpersona
FROM         ADM_PERSONA INNER JOIN
                      ADM_TPERSONA ON ADM_PERSONA.tpersonaid = ADM_TPERSONA.tpersonaid

where ADM_PERSONA.creadorId = @pid;	

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_UsuariosListaByNameAndPassword]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgn_UsuariosListaByNameAndPassword](	
	@usuario varchar(250),
	@password varchar(250)
)
AS
	

declare @pid numeric(8,0)

select @pid = usuarioId from SYS_USUARIO where usuario = @usuario 
		and clave= @password and estado=''A''

SELECT     dbo.ADM_PERSONA.personaId, ISNULL(dbo.ADM_PERSONA.creadorId, - 1) AS creadorId, 
                      ISNULL(dbo.dameTipoPersona(dbo.ADM_PERSONA.creadorId), '' -- '') AS tipoPersonaCreador, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.fcrea, 
                      dbo.ADM_PERSONA.fupdate, dbo.ADM_PERSONA.usuarioId, dbo.ADM_PERSONA.personajuridica, dbo.ADM_PERSONA.ucrea, 
                      dbo.ADM_PERSONA.estado, dbo.ADM_PERSONA.uupdate, dbo.ADM_TPERSONA.tpersona
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_TPERSONA ON dbo.ADM_PERSONA.tpersonaid = dbo.ADM_TPERSONA.tpersonaid
WHERE     (ADM_PERSONA.usuarioId = @pid) 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_BrokerByName] 
(
 @name varchar(1000)=NULL
)
AS
BEGIN

	SET NOCOUNT ON;
	
	/*if (@name is null)
	begin
		SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, IsNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid, dbo.ADM_PERSONA.estado
		FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
	                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
	                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
	                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
		WHERE     (dbo.ADM_PERSONA.tpersonaid =1) 
		order by dbo.ADM_PERSONA.persona
		
	end
	else
	begin*/
		SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, IsNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid, dbo.ADM_PERSONA.estado
		FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
	                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
	                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
	                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
		WHERE     (dbo.ADM_PERSONA.tpersonaid =1) and  dbo.ADM_PERSONA.persona like ''%''+@name+''%''
		order by dbo.ADM_PERSONA.persona
		
--	end




END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoraSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoraSelectAll]
AS
BEGIN

	SET NOCOUNT ON;


SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, isNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid, dbo.adm_persona.estado
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid =2)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgenx_EjectivoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[sp_rgenx_EjectivoSelectById](
	@personaId numeric(8,0)
)
as 

SELECT     	dbo.ADM_PERSONA.creadorId,
		dbo.ADM_PERSONA.personaId, 
	   	dbo.ADM_PERSONA.persona, 
		dbo.ADM_PERSONA.tpersonaid, 
		dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, 
		dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 1) AS TFIJO, 
		dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, 
		dbo.ADM_DIRECCIONPERSONA.direccion, 
                dbo.ADM_DIRECCIONPERSONA.ubigeoId, 
		dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                dbo.ADM_TDOCID.tdocid, 
		isNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, 
		dbo.ADM_DOCID.docid, 
		dbo.ADM_PERSONA.estado,
		dbo.ADM_PERSONA.email
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid = 9) and dbo.ADM_PERSONA.personaId = @personaId and dbo.ADM_PERSONA.estado = ''A''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoSelectById] 
(
    @personaId numeric(8,0)
)
AS
BEGIN

	SET NOCOUNT ON;


SELECT     dbo.ADM_PERSONA.personaId,dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.estado, dbo.ADM_PERSONA.nombre1 AS PrimerNombre,dbo.ADM_PERSONA.nombre2 AS SegundoNombre,dbo.ADM_PERSONA.apellido1 AS ApellidoPaterno,
dbo.ADM_PERSONA.apellido2 AS ApellidoMaterno, dbo.ADM_PERSONA.tpersonaid, 
	dbo.getPersonaJuridicaBit(personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, IsNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid = 3) and (dbo.ADM_PERSONA.personaId = @personaId)

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoSelectAll]
    (
      @persona VARCHAR(1000) = null
    )
AS 
    BEGIN

        SET NOCOUNT ON ;
		
        IF ( LEN(@persona) > 0 ) 
            BEGIN			
                SELECT  dbo.ADM_PERSONA.personaId,
                        dbo.ADM_PERSONA.persona,
                        dbo.ADM_PERSONA.estado,
                        dbo.ADM_PERSONA.nombre1 AS PrimerNombre,
                        dbo.ADM_PERSONA.nombre2 AS SegundoNombre,
                        dbo.ADM_PERSONA.apellido1 AS ApellidoPaterno,
                        dbo.ADM_PERSONA.apellido2 AS ApellidoMaterno,
                        dbo.ADM_PERSONA.tpersonaid,
                        dbo.getPersonaJuridicaBit(personajuridica) AS chkPersonaJuridica,
                        dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento,
                        dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 1) AS TFIJO,
                        dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX,
                        dbo.ADM_DIRECCIONPERSONA.direccion,
                        dbo.ADM_DIRECCIONPERSONA.ubigeoId,
                        dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo,
                        dbo.ADM_TDOCID.tdocid,
                        isNull(dbo.ADM_DOCID.tdocidId, -1) as tdocidId,
                        dbo.ADM_DOCID.docid
                FROM    dbo.ADM_PERSONA
                        LEFT OUTER JOIN dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId
                        LEFT OUTER JOIN dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId
                        LEFT OUTER JOIN dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
                WHERE   ( dbo.ADM_PERSONA.tpersonaid = 3 )
                        AND [persona] LIKE ''%'' + @persona + ''%'' 
            END
        ELSE 
            BEGIN
                SELECT  dbo.ADM_PERSONA.personaId,
                        dbo.ADM_PERSONA.persona,
                        dbo.ADM_PERSONA.estado,
                        dbo.ADM_PERSONA.nombre1 AS PrimerNombre,
                        dbo.ADM_PERSONA.nombre2 AS SegundoNombre,
                        dbo.ADM_PERSONA.apellido1 AS ApellidoPaterno,
                        dbo.ADM_PERSONA.apellido2 AS ApellidoMaterno,
                        dbo.ADM_PERSONA.tpersonaid,
                        dbo.getPersonaJuridicaBit(personajuridica) AS chkPersonaJuridica,
                        dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento,
                        dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 1) AS TFIJO,
                        dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX,
                        dbo.ADM_DIRECCIONPERSONA.direccion,
                        dbo.ADM_DIRECCIONPERSONA.ubigeoId,
                        dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo,
                        dbo.ADM_TDOCID.tdocid,
                        isNull(dbo.ADM_DOCID.tdocidId, -1) as tdocidId,
                        dbo.ADM_DOCID.docid
                FROM    dbo.ADM_PERSONA
                        LEFT OUTER JOIN dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId
                        LEFT OUTER JOIN dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId
                        LEFT OUTER JOIN dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
                WHERE   ( dbo.ADM_PERSONA.tpersonaid = 3 )
            END
            

    END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_BrokerSelectAll]
AS
BEGIN

	SET NOCOUNT ON;


SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, IsNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid, dbo.ADM_PERSONA.estado
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid =1) 
order by dbo.ADM_PERSONA.persona
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_BrokerSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_BrokerSelectById]
(
	@personaId numeric(5,0)
)
AS
BEGIN

	SET NOCOUNT ON;


SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, isNull(dbo.ADM_DOCID.tdocidId,6) as tdocidId, dbo.ADM_DOCID.docid, dbo.adm_persona.estado
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid =1) AND (dbo.ADM_PERSONA.personaId = @personaId)
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_solicitud_docs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_solicitud_docs] 
(@ajusteId numeric(8,0),
@solicitudDocumentosId numeric(8,0)
)AS


SELECT    
dbo.RGN_AJUSTE.numAjustePASA, 
dbo.RGN_AJUSTE.ajusteId, 
dbo.RGN_SOLICITUDDOCUMENTOS.numeroSolicitud, 
dbo.RGN_REQUISITOS.nombre, 
dbo.RGN_SOLICITUDDOCUMENTOS.Fecha, 
dbo.ADM_PERSONA.persona,
dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.estado
FROM	dbo.RGN_SOLICITUDDOCUMENTOS INNER JOIN
      dbo.RGN_AJUSTE_RGN_REQUERIMIENTO ON 
      dbo.RGN_SOLICITUDDOCUMENTOS.solicitudDocumentosId = dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.solicitudDocumentosId AND 
      dbo.RGN_SOLICITUDDOCUMENTOS.ajusteId = dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.ajusteId INNER JOIN
      dbo.RGN_REQUISITOS ON dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.requisitoId = dbo.RGN_REQUISITOS.requisitoId INNER JOIN
      dbo.RGN_AJUSTE ON dbo.RGN_SOLICITUDDOCUMENTOS.ajusteId = dbo.RGN_AJUSTE.ajusteId INNER JOIN
      dbo.RGN_POLIZA_AJUSTE ON dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId AND dbo.PrimeraPoliza(dbo.RGN_AJUSTE.ajusteId) = dbo.RGN_POLIZA_AJUSTE.polizaId INNER JOIN
      dbo.ADM_PERSONA ON dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.ADM_PERSONA.personaId
WHERE dbo.RGN_AJUSTE.ajusteId = @ajusteId AND
			dbo.RGN_SOLICITUDDOCUMENTOS.solicitudDocumentosId = @solicitudDocumentosId 

order by dbo.RGN_AJUSTE_RGN_REQUERIMIENTO.orden asc ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AseguradoraSelectById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AseguradoraSelectById]
(
	@personaId numeric(5,0)
)
AS
BEGIN

	SET NOCOUNT ON;


SELECT     dbo.ADM_PERSONA.personaId, dbo.ADM_PERSONA.persona, dbo.ADM_PERSONA.tpersonaid, dbo.getPersonaJuridicaBit(dbo.ADM_PERSONA.personajuridica)AS chkPersonaJuridica, 
                      dbo.getDocumentoIdentidadPrincipalPersona(dbo.ADM_PERSONA.personaId) AS documento, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 
                      1) AS TFIJO, dbo.getTelefonoPorTipo(dbo.ADM_PERSONA.personaId, 3) AS TFAX, dbo.ADM_DIRECCIONPERSONA.direccion, 
                      dbo.ADM_DIRECCIONPERSONA.ubigeoId, dbo.dameDistrito(dbo.ADM_DIRECCIONPERSONA.ubigeoId) AS ubigeo, 
                      dbo.ADM_TDOCID.tdocid, isNull(dbo.ADM_DOCID.tdocidId,-1) as tdocidId, dbo.ADM_DOCID.docid, dbo.ADM_PERSONA.estado
FROM         dbo.ADM_PERSONA LEFT OUTER JOIN
                      dbo.ADM_DOCID ON dbo.ADM_PERSONA.personaId = dbo.ADM_DOCID.personaId LEFT OUTER JOIN
                      dbo.ADM_TDOCID ON dbo.ADM_DOCID.tdocidId = dbo.ADM_TDOCID.tdocidId LEFT OUTER JOIN
                      dbo.ADM_DIRECCIONPERSONA ON dbo.ADM_PERSONA.personaId = dbo.ADM_DIRECCIONPERSONA.personaId
WHERE     (dbo.ADM_PERSONA.tpersonaid =2) AND (dbo.ADM_PERSONA.personaId = @personaId)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_datosgenerales_select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_datosgenerales_select](@ajusteId numeric(8,0))
as

declare @contratante varchar(1000)
declare @asegurado varchar(1000)
declare @aseguradoid numeric(8,0)
declare @gruponegocio varchar(8000)
declare @grupoeconomico varchar(8000)
declare @aseguradora varchar(1000)
declare @aseguradoraid numeric(8,0)
declare @respAseguradora varchar (250)
declare @broker varchar(1000)
declare @brokerid numeric(8,0)
declare @respBroker varchar(250) 

BEGIN

 SELECT top 1  @contratante=dbo.RGN_POLIZA.contratante,
	       @gruponegocio=dbo.RGN_POLIZA.giroNegocio,
	       @grupoeconomico=dbo.RGN_POLIZA.grupoEconomico
 FROM         dbo.RGN_POLIZA_AJUSTE INNER JOIN
             dbo.RGN_POLIZA ON dbo.RGN_POLIZA_AJUSTE.polizaId = dbo.RGN_POLIZA.polizaId AND 
              dbo.RGN_POLIZA_AJUSTE.aseguradoraId = dbo.RGN_POLIZA.aseguradoraId
 where dbo.RGN_POLIZA_AJUSTE.ajusteId=@ajusteid

 set @asegurado=dbo.dameAsegurado(@ajusteId)

SELECT top 1 @aseguradoid= dbo.RGN_POLIZA.aseguradoId
FROM        dbo.RGN_POLIZA INNER JOIN
            dbo.RGN_POLIZA_AJUSTE ON dbo.RGN_POLIZA.polizaId = dbo.RGN_POLIZA_AJUSTE.polizaId AND 
            dbo.RGN_POLIZA.aseguradoraId = dbo.RGN_POLIZA_AJUSTE.aseguradoraId
where dbo.RGN_POLIZA_AJUSTE.ajusteid=@ajusteid

set @aseguradoid = isnull(@aseguradoid,0)

SELECT   top 1 @aseguradoraid=aseguradoraId FROM  dbo.RGN_POLIZA_AJUSTE where dbo.RGN_POLIZA_AJUSTE.ajusteid=@ajusteid

set @aseguradoraid = isnull(@aseguradoraid,0)

SELECT  top 1 @brokerid=brokerId FROM dbo.RGN_AJUSTE where dbo.RGN_AJUSTE.ajusteid=@ajusteid

set @brokerid = isnull(@brokerid,0)

/* set @gruponegocio=dbo.damegironegocio(@ajusteid)
 set @grupoeconomico=dbo.dameactividad(@ajusteid)
*/
 set @aseguradora =dbo.dameaseguradora(@ajusteid)
 set @respAseguradora =dbo.damerespaseguradora(@ajusteid)
 set @broker =dbo.damebroker(@ajusteid)
 set @respbroker =dbo.damerespbroker(@ajusteid)

select  @contratante as contratante, 
 @asegurado as asegurado, 
 @gruponegocio as gruponegocio, 
 @grupoeconomico as grupoeconomico, 
 @aseguradora as aseguradora, 
 @respAseguradora as respaseguradora, 
 @broker as broker, 
 @respBroker as respbroker,
 @ajusteid as ajusteid,
 @aseguradoid as aseguradoid,
 @aseguradoraid as aseguradoraid,
 @brokerid as brokerid

END 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_SolicitudDocumentosInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_SolicitudDocumentosInsert]
(
	@AjusteId numeric(8,0),
	@solDocId numeric(8,0) output,
	@ucrea varchar(250),
	@uupdate varchar(250)
	
)
as
begin
	insert into RGN_SOLICITUDDOCUMENTOS(ajusteId,numeroSolicitud,Fecha,fcrea,fupdate,estado,ucrea,uupdate)
	values (@AjusteId,dbo.sp_rgen_dameUltimaSolicitud(@AjusteId),getDate(),getDate(),getDate(),''A'',@ucrea,@uupdate)
	
	set @solDocId = SCOPE_IDENTITY()
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ReclamoSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ReclamoSelect] 
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;

	SELECT 
		RGN_AJUSTE.ajusteId,
 	
		dbo.UltimoReclamoAjuste(@AjusteId) AS Reclamo,
		isNull(dbo.UltimaMonedaReclamoAjuste(@AjusteId),1) AS monedaReclamo

	FROM RGN_AJUSTE
	where AjusteId = @AjusteId;



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_FinalizarCaso]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_FinalizarCaso]
(
	@ajusteId numeric(8, 0),
	@frecepcion datetime,
	@nombrearchivo varchar(255)= null,
	@descripcion varchar(250) =null,
	@archivoFisico image =null,
	@imagenthumb image =null,
	@uupdate varchar(20)
)
AS


	SET NOCOUNT OFF;

	if @archivoFisico is not null
	
	BEGIN
		INSERT INTO  [RGN_ANEXO]([ajusteId], [nombrearchivo], [descripcion], [fechaRegistro], [archivoFisico], [imagen], [imagenthumb], [mostrarEnInformes] ) 
		VALUES (@ajusteId, @nombrearchivo, @descripcion, getDate(), @archivoFisico, 1, @imagenthumb, 1);
	END

	
	update RGN_AJUSTE set fcargoInformeFinal=@frecepcion
	where ajusteId=@ajusteId


--cambiando el estado al caso de ajuste
	declare @fecha datetime
	set @fecha=getdate()
	
	exec dbo.sp_rgen_cambiaEstadoAjuste @fecha,@ajusteId,21,@uupdate


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_informebasicoReclamoRimac]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_informebasicoReclamoRimac](@ajusteid int)
as

SELECT  
		RGN_AJUSTE.ajusteId,
		RGN_RECLAMO.monto AS reclamoasegurado, 
		RGN_RECLAMO.monedaId as reclamoMonedaId,
		dbo.dameSimboloMoneda(RGN_RECLAMO.monedaId)AS monedaReclamo,
		RGN_RESERVA.monto AS reservaestimada, 
		RGN_RESERVA.monedaId AS reservaMonedaId, 
		dbo.dameSimboloMoneda(RGN_RESERVA.monedaId)AS monedaReserva,
		RGN_AJUSTE.situacionajuste, 
		RGN_AJUSTE.notas,
		RGN_AJUSTE.enviarNumSiniestro,
		RGN_AJUSTE.enviarCopiaPoliza
FROM    RGN_RECLAMO INNER JOIN
              RGN_AJUSTE ON RGN_RECLAMO.ajusteId = RGN_AJUSTE.ajusteId INNER JOIN
              RGN_RESERVA ON RGN_AJUSTE.ajusteId = RGN_RESERVA.ajusteId

where RGN_AJUSTE.ajusteid = @ajusteid AND
      RGN_RECLAMO.reclamoId= (select max(reclamoId) from RGN_RECLAMO where RGN_RECLAMO.ajusteId=@ajusteId) and
      RGN_RESERVA.reservaId= (select max(reservaId) from RGN_RESERVA where RGN_RESERVA.ajusteId=@ajusteId)	



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_InformacionComplementariaSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_InformacionComplementariaSelect]
	@ajusteId numeric(8, 0)
AS
	SET NOCOUNT ON;
	Select 
		RGN_AJUSTE.ajusteId,
		dbo.UltimoEstimadoReservaAjuste(@ajusteId) AS Reserva,
		isNull(dbo.UltimaMonedaReservaAjuste(@ajusteId),1) AS monedaReserva,
                RGN_AJUSTE.situacionajuste,
		RGN_AJUSTE.verificaciongarantias,
		RGN_AJUSTE.siniestrosanteriores,
		RGN_AJUSTE.salvamentoyrecupero,
		RGN_AJUSTE.opinionAjustador,
		RGN_AJUSTE.recomendaciones
	


	FROM RGN_AJUSTE
       
	WHERE (RGN_AJUSTE.ajusteId=@ajusteId)

	
	

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajustador_AjusteUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_Ajustador_AjusteUpdate]
(
	@ajusteId numeric(8, 0),
	@ajustadorId numeric(8, 0),
	@ejecutivoSiniestrosId numeric (8,0),
	@usuario varchar(250)
)
AS
	SET NOCOUNT OFF;
UPDATE  RGN_AJUSTE SET ajustadorId = @ajustadorId, 
					   ejecutivoSiniestrosId = @ejecutivoSiniestrosId,
						situacionAjustelistados = ''Ajustador Asignado '' + Convert(varchar(30),getDate(),103)
WHERE RGN_AJUSTE.ajusteId=@ajusteId

-- 13 es el estado iniciado (debe reemplazarse por el id adecuado si es que se hace algun cambio a la tabla de estados
declare @fechaAux datetime
set @fechaAux = getDate()
exec sp_rgen_cambiaEstadoAjuste @fechaAux, @ajusteId, 13, @usuario

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Total_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Total_Insert]
(
	
	@numeroAjuste varchar(30) = NULL output,	
	@ajusteId numeric (8,0)=NULL output,

	@quienNotifico varchar(250),
	@NombreDelNotificante varchar(250),
	@faviso datetime,
	@medioDeNotificacionId numeric(8,0), 

	@NombreQuienConfirma varchar(250), 
	@FechayHoraConfirmacion datetime, 
	@medioConfirmacionId numeric(8,0),
	@cargoconfirmante varchar(250), 

	@aseguradoraid numeric(8,0),
	@nombreresponsable varchar(250),
	@telefonoresponsable varchar(20),
	@emailresponsable varchar(250),

	@brokerId numeric(8,0),
	@nombreresponsableBroker varchar(250),
	@telefonoresponsableBroker varchar(20),
	@emailresponsableBroker varchar(250),
	@numeroSiniestroCia varchar(100),
	@numeroSiniestroBroker varchar(100),

	@fsiniestro datetime,
	@lugarsiniestro varchar(250),
	@ubigeoid varchar(6),	
	@tiposiniestro_id numeric(8,0),
	@nombreresponsableSiniestro varchar(250),
	@telefonoresponsableSiniestro varchar(20),
	@emailresponsableSiniestro varchar(250),
	@descripcion varchar(250),

	@usuario varchar(100),
	@polizaid numeric(8,0),

	@ajustadorid numeric(8,0),
    @ejecutivosiniestrosid numeric(8,0),
	@FechaHoraCoordinacion datetime, 
	@FechaHoraCoordinacionInspeccion datetime,
	@FechaHoraReunion datetime, 
	@ubigeoidInspeccion varchar(6),
	@personacontacto varchar(250),
	@tajusteid numeric(8,0),
	@lugarDeReunion varchar(250), 
	@referencia varchar(250),
	@telefonoPersonaContacto varchar(20) 
)
AS
--declare @ajusteId numeric (8,0)
declare @numajustepasa varchar(30)
declare @anno varchar(4)
declare @estadoajusteid numeric(8,0)



 if (@medioDeNotificacionId = -1)
	begin
		set @medioDeNotificacionId = 3
	end

 if (@medioConfirmacionId = -1)
	begin
		set @medioConfirmacionId = 3
	end
 
insert into RGN_AJUSTE(quienNotifico, 
		 nombredelNotificante, 
		 faviso, 
		 mediodeNotificacionid, 
 		 NombrequienConfirma, 
		 FechayHoraConfirmacion, 
		 medioConfirmacion,
	 	 cargoconfirmante, 
		 brokerid, 
		 NumeroSiniestroCia,
		 NumeroSiniestroBroker,
		 tajusteid,
		 ajustadorid, 
		 ejecutivosiniestrosid,
		 fcrea,
		 fupdate,
		 estado,
		 ucrea,
		 uupdate,
		fechaHoraProgramacion)
 values ( @quienNotifico,
		 @NombreDelNotificante,
		 @faviso,
		 @medioDeNotificacionId, 
		 @NombreQuienConfirma, 
		 @FechayHoraConfirmacion, 
		 @medioConfirmacionId,
		 @cargoconfirmante, 
		 @brokerId,
		 @NumeroSiniestroCia,
		 @NumeroSiniestroBroker,
		 @tajusteid,
 		 @ajustadorid,
	     @ejecutivosiniestrosid,
		 getdate(),
		 getdate(),
		 ''A'',
		 @usuario,
		 @usuario,
		 @FechaHoraCoordinacionInspeccion
	 )	 

set @ajusteId = SCOPE_IDENTITY()

select @ajusteId


/*
insertando el numero de poliza que se debe generar...
*/
set @anno = year(getdate())

select @anno


--set @numajustepasa = dbo.generaNumeroAjustepasa(@ajusteid,@anno)

	--declare @numajustepasa varchar(20)
 declare @aux2 varchar(250)
	
	set @aux2 = '''';
	select top 1 @aux2=valorParametro from ADM_PARAMETRO where nombreparametro = ''NUMEROAJUSTEACTUAL''
	
 --convert(varchar(10),@ajusteid)

 set @numajustepasa=''PA-''+@aux2+''-''+@anno

	if (@aux2 != '''') 
	begin 
		declare @numAux numeric(8,0) 
		set @numAux = convert(numeric(8,0),@aux2)
		set @numAux= @numAux + 1
		update ADM_PARAMETRO set valorParametro = convert(varchar(10),@numAux)
		where (NombreParametro = ''NUMEROAJUSTEACTUAL'')
	end	


set @numeroAjuste = @numAjustePasa

update RGN_AJUSTE set numajustepasa=@numajustepasa where ajusteid=@ajusteid



--Insertando contacto de la ASEGURADORA
insert into RGN_CONTACTOS_AJUSTE (TipoContactoid,ajusteid,nombreContacto, telefonocontacto,emailcontacto,fcrea,fupdate,estado,ucrea,uupdate)
	values (1,
					@ajusteid,
					@nombreresponsable, 
					@telefonoresponsable, 
					@emailresponsable,
					getdate(),
					getdate(),
			 ''A'',
			 @usuario,
			 @usuario 
  
)

--Insertando contacto del BROKER
insert into RGN_CONTACTOS_AJUSTE (TipoContactoid,ajusteid,nombreContacto, telefonocontacto,emailcontacto,fcrea,fupdate,estado,ucrea,uupdate)
	values (2,
		@ajusteid,
		@nombreresponsableBroker, 
		@telefonoresponsableBroker, 
		@emailresponsableBroker,
		getdate(),
		getdate(),
		 ''A'',
		 @usuario,
		 @usuario 
	)




--Insertando contactos del SINIESTRO

insert into RGN_CONTACTOS_AJUSTE (TipoContactoid,ajusteid,nombreContacto, telefonocontacto,emailcontacto,fcrea,fupdate,estado,ucrea,uupdate)
	values (5,
		@ajusteid,
		@nombreresponsableSiniestro, 
		@telefonoresponsableSiniestro, 
		@emailresponsableSiniestro,
		getdate(),
		getdate(),
		''A'',
		@usuario,
		@usuario 
	)

--Insertando datos del SINIESTRO

insert into RGN_SINIESTRO (descripcion, fsiniestro, tiposiniestroid, lugarsiniestro, ubigeoid,fcrea,fupdate,estado,ucrea,uupdate) 
 values(@descripcion, 
	 @fsiniestro, 
	 @tiposiniestro_id, 
	 @lugarsiniestro,
	 @ubigeoid, 
	 getdate(),
	 getdate(),
	 ''A'',
	 @usuario,
	 @usuario 
	)
declare @siniestroNumero numeric (8,0) 
set @siniestroNumero = scope_identity()

update RGN_AJUSTE set siniestroid=@siniestroNumero where ajusteid=@ajusteid

IF NOT @polizaid IS NULL
	insert into RGN_POLIZA_AJUSTE (polizaid, aseguradoraid, ajusteid, numsiniestro, fcrea,fupdate,estado,ucrea,uupdate) 
	 values (@polizaid,
		 @aseguradoraid, 
		 @ajusteid,
		 @numeroSiniestroCia,
	 	 getdate(),
		 getdate(),
	 ''A'',
	 @usuario,
	 @usuario 
	 )
--insertando datos de la inspeccion
insert into RGN_ACTIVIDAD (ajusteid, FechaHoraCoordinacion, lugardeReunion, referencia, personacontacto, 
	 FechaHoraReunion, ubigeoID, telefonoPersonaContacto, tipoactividadId, fcrea,fupdate,estado,ucrea,uupdate) 	 
 values(
				@ajusteid,
				@FechaHoraCoordinacion, 
				@lugarDeReunion,
				@referencia,
				@personacontacto,
				@FechaHoraReunion, 
				@ubigeoidInspeccion,
				@telefonoPersonaContacto, 
				5,
				getdate(),
				getdate(),
				''A'',
				@usuario,
				@usuario 
		)

--insertando estados

set @estadoajusteId = 13

IF (@FechaHoraCoordinacion is not NULL) 
begin
	set @estadoajusteid = 14
end


if (@FechaHoraReunion is not NULL) 
begin
	set @estadoajusteid=15
end

declare @estadoIndice numeric(8,0)

set @estadoIndice = 12

declare @fechaAux datetime

WHILE (@estadoIndice <= @estadoAjusteId) 
BEGIN
	if (@estadoIndice = 12) set @fechaAux = @faviso;
	if (@estadoIndice = 13) set @fechaAux = isNull(@FechayHoraConfirmacion,getDate())
	if (@estadoIndice = 14) set @fechaAux = isNull(@FechaHoraCoordinacion,getDate())	
	if (@estadoIndice = 15) set @fechaAux = isNull(@FechaHoraReunion,getDate())
	exec sp_rgen_cambiaEstadoAjuste @fechaAux, @ajusteid, @estadoIndice ,@usuario
	set @estadoIndice = @estadoIndice + 1;
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delreclamo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--sp_rgen_informebasico_delreclamo 231

CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delreclamo](@ajusteid int)
as

SELECT  RGN_RECLAMO.monto AS reclamoasegurado, 
		dbo.dameSimboloMoneda(RGN_RECLAMO.monedaId)AS monedaReclamo,
		RGN_RESERVA.monto AS reservaestimada, 
		dbo.dameSimboloMoneda(RGN_RESERVA.monedaId)AS monedaReserva,
		RGN_AJUSTE.situacionajuste, 
		RGN_AJUSTE.verificaciongarantias, 
		RGN_AJUSTE.siniestrosanteriores, 
		RGN_AJUSTE.salvamentoyrecupero, 
		RGN_AJUSTE.opinionAjustador,
		RGN_AJUSTE.recomendaciones
FROM    RGN_RECLAMO INNER JOIN
              RGN_AJUSTE ON RGN_RECLAMO.ajusteId = RGN_AJUSTE.ajusteId INNER JOIN
              RGN_RESERVA ON RGN_AJUSTE.ajusteId = RGN_RESERVA.ajusteId

where RGN_AJUSTE.ajusteid = @ajusteid AND
      RGN_RECLAMO.reclamoId= (select max(reclamoId) from RGN_RECLAMO where RGN_RECLAMO.ajusteId=@ajusteId) and
      RGN_RESERVA.reservaId= (select max(reservaId) from RGN_RESERVA where RGN_RESERVA.ajusteId=@ajusteId)	


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_Ajuste_Parcial_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_Ajuste_Parcial_Insert]
    (
      @numeroAjuste varchar(50) OUTPUT,
      @quienNotifico varchar(250),
      @NombreDelNotificante varchar(250),
      @faviso datetime,
      @medioDeNotificacionId numeric(8, 0),
      @NombreQuienConfirma varchar(250),
      @FechayHoraConfirmacion datetime,
      @medioConfirmacionId numeric(8, 0),
      @cargoconfirmante varchar(250),
      @aseguradoraid numeric(8, 0),
      @nombreresponsable varchar(250),
      @telefonoresponsable varchar(20),
      @emailresponsable varchar(250),
      @brokerId numeric(8, 0),
      @nombreresponsableBroker varchar(250),
      @telefonoresponsableBroker varchar(20),
      @emailresponsableBroker varchar(250),
      @numeroSiniestroCia varchar(100),
      @numeroSiniestroBroker varchar(100),
      @fsiniestro datetime,
      @lugarsiniestro varchar(250),
      @ubigeoid varchar(6),
      @tiposiniestro_id numeric(8, 0),
      @nombreresponsableSiniestro varchar(250),
      @telefonoresponsableSiniestro varchar(20),
      @emailresponsableSiniestro varchar(250),
      @descripcion varchar(250),
      @polizaid numeric(8, 0),
      @usuario varchar(100),
      @ajuId numeric(8, 0) output
    )
AS 
    declare @ajusteid numeric(8, 0)
    declare @numajustepasa varchar(30)
    declare @anno varchar(4)
    declare @estadoajusteid numeric(8, 0)
    
     if ( @medioDeNotificacionId = -1 ) 
        begin
            set @medioDeNotificacionId = 3
        end

    if ( @medioConfirmacionId = -1 ) 
        begin
            set @medioConfirmacionId = 3
        end

--Insertando datos del AJUSTE

    insert  into RGN_AJUSTE
            (
              quienNotifico,
              nombredelNotificante,
              faviso,
              mediodeNotificacionid,
              NombrequienConfirma,
              FechayHoraConfirmacion,
              medioConfirmacion,
              cargoconfirmante,
              brokerid,
              NumeroSiniestroCia,
              tajusteid,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate,
              situacionAjustelistados,
              numeroSiniestroBroker			
		)
    values  (
              @quienNotifico,
              @NombreDelNotificante,
              @faviso,
              @medioDeNotificacionId,
              @NombreQuienConfirma,
              @FechayHoraConfirmacion,
              @medioConfirmacionId,
              @cargoconfirmante,
              @brokerId,
              @NumeroSiniestroCia,
              1, --por defecto porque no admite nulos 
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario,
              ''pendiente de atención'',
              @numeroSiniestroBroker
	       
            )	 

    set @ajusteId = SCOPE_IDENTITY()

/*
insertando el numero de Ajuste que se debe generar...
*/
    set @anno = year(getdate())

    select  @anno


--set @numajustepasa = dbo.generaNumeroAjustepasa(@ajusteid,@anno)

	--declare @numajustepasa varchar(20)
    declare @aux2 varchar(250)
	
    set @aux2 = '''' ;
    select top 1
            @aux2 = valorParametro
    from    ADM_PARAMETRO
    where   nombreparametro = ''NUMEROAJUSTEACTUAL''
	
                                     --convert(varchar(10),@ajusteid)

    set @numajustepasa = ''PA-'' + @aux2 + ''-'' + @anno

    if ( @aux2 != '''' ) 
        begin 
            declare @numAux numeric(8, 0) 
            set @numAux = convert(numeric(8, 0), @aux2)
            set @numAux = @numAux + 1
            update  ADM_PARAMETRO
            set     valorParametro = convert(varchar(10), @numAux)
            where   ( NombreParametro = ''NUMEROAJUSTEACTUAL'' )
        end	


    set @numeroAjuste = @numAjustePasa

    update  RGN_AJUSTE
    set     numajustepasa = @numajustepasa
    where   ajusteid = @ajusteid


--Insertando contacto de la ASEGURADORA
    insert  into RGN_CONTACTOS_AJUSTE
            (
              TipoContactoid,
              ajusteid,
              nombreContacto,
              telefonocontacto,
              emailcontacto,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate
            )
    values  (
              ''1'',
              @ajusteid,
              @nombreresponsable,
              @telefonoresponsable,
              @emailresponsable,
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario 
            )

--Insertando contacto del BROKER
    insert  into RGN_CONTACTOS_AJUSTE
            (
              TipoContactoid,
              ajusteid,
              nombreContacto,
              telefonocontacto,
              emailcontacto,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate
            )
    values  (
              ''2'',
              @ajusteid,
              @nombreresponsableBroker,
              @telefonoresponsableBroker,
              @emailresponsableBroker,
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario 
            )

--Insertando contactos del SINIESTRO
    insert  into RGN_CONTACTOS_AJUSTE
            (
              TipoContactoid,
              ajusteid,
              nombreContacto,
              telefonocontacto,
              emailcontacto,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate
            )
    values  (
              ''5'',
              @ajusteid,
              @nombreresponsableSiniestro,
              @telefonoresponsableSiniestro,
              @emailresponsableSiniestro,
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario 
            )

--Insertando datos del SINIESTRO

    insert  into RGN_SINIESTRO
            (
              descripcion,
              fsiniestro,
              tiposiniestroid,
              lugarsiniestro,
              ubigeoid,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate
            )
    values  (
              @descripcion,
              @fsiniestro,
              @tiposiniestro_id,
              @lugarsiniestro,
              @ubigeoid,
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario 
	      )
    declare @siniestroNumero numeric(8, 0) 
    set @siniestroNumero = scope_identity()

    update  RGN_AJUSTE
    set     siniestroid = @siniestroNumero
    where   ajusteid = @ajusteid

/* CORRECCION 
26/04/2006
*/
    select  @polizaid = polizaid
    from    rgn_poliza
    where   aseguradoraid = @aseguradoraid
            and sistema = ''S''

    insert  into RGN_POLIZA_AJUSTE
            (
              polizaid,
              aseguradoraid,
              ajusteid,
              numsiniestro,
              fcrea,
              fupdate,
              estado,
              ucrea,
              uupdate
            )
    values  (
              @polizaid,
              @aseguradoraid,
              @ajusteid,
              @numeroSiniestroCia,
              getdate(),
              getdate(),
              ''A'',
              @usuario,
              @usuario 
            )


    set @estadoajusteid = 12
    declare @fechaAux datetime 
    if ( @faviso is Null ) 
        begin
            set @fechaAux = getDate()
        end
    else 
        begin
            set @fechaAux = @faviso
        end
    exec sp_rgen_cambiaEstadoAjuste @fechaAux, @ajusteid, @estadoAjusteId,
        @usuario


    set @ajuId = @ajusteId
    select  @numeroAjuste



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_ajuste_Insert_rapido]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_ajuste_Insert_rapido] --2645, ''eder'',2,NULL,NULL,NULL,NULL
    (
      @numeroAjuste varchar(30) = NULL output,
      @ajusteId numeric(8, 0) = NULL output,
      @AseguradoId NUMERIC(8, 0),
      @Asegurado VARCHAR(1000),
      @AseguradoraId NUMERIC(8, 0),
      @TipoSiniestroId NUMERIC(8, 0),
      @FechaSiniestro DATETIME,
      @lugarsiniestro varchar(250),
      @ucrea VARCHAR(20),
      @ramoId NUMERIC(8, 0),
	  @productoId NUMERIC(8, 0),
	  @riesgoId NUMERIC(8, 0),
      @descripcion varchar(250),
      @AjustadorId NUMERIC(8, 0)
    )
AS 
    BEGIN
	
	--Insertamos la poliza
        INSERT  INTO [RGN_POLIZA]
                (
                  [contratante],
                  [beneficiario],
                  [aseguradoId],
                  [productoId],
                  [ramoId],
                  [riesgoId],
                  [finicio],
                  [ffin],
                  [numeroPoliza],
                  [aseguradoraId],
                  [fcrea],
                  [fupdate],
                  [estado],
                  [ucrea],
                  [uupdate],
                  [archivo],
                  [sistema],
                  [giroNegocio],
                  [grupoEconomico]
	          )
        VALUES  (
                  /* contratante - varchar(250) */
                  SUBSTRING(@Asegurado, 1, 250),
		/* beneficiario - varchar(1000) */
                  @Asegurado,
		/* aseguradoId - numeric(8, 0) */
                  @AseguradoId,
		/* productoId - numeric(8, 0) */
                  @productoId,
		/* ramoId - numeric(8, 0) */
                  @ramoId,
		/* riesgoId - numeric(8, 0) */
                  @riesgoId,
		/* finicio - datetime */
                  NULL,
		/* ffin - datetime */
                  null,
		/* numeroPoliza - varchar(100) */
                  ''SIN NÚMERO'',
		/* aseguradoraId - numeric(8, 0) */
                  @AseguradoraId,
		/* fcrea - datetime */
                  GETDATE(),
		/* fupdate - datetime */
                  GETDATE(),
		/* estado - varchar(1) */
                  ''A'',
		/* ucrea - varchar(20) */
                  @ucrea,
		/* uupdate - varchar(20) */
                  @ucrea,
		/* archivo - varchar(100) */
                  null,
		/* sistema - varchar(1) */
                  ''N'',
		/* giroNegocio - varchar(500) */
                  null,
		/* grupoEconomico - varchar(500) */
                  null 
                ) 
	
        DECLARE @polizaId NUMERIC(8, 0)
	
        SET @polizaId = SCOPE_IDENTITY()
	
	
	
        INSERT  INTO [RGN_AJUSTE]
                (
                  [fcrea],
                  [fupdate],
                  [estado],
                  [ucrea],
                  [uupdate],
                  [tajusteid],
                  [ajustadorId]
                  
		
	          )
        VALUES  (
                  /* fcrea - datetime */
                  GETDATE(),
		/* fupdate - datetime */
                  GETDATE(),
		/* estado - varchar(2) */
                  ''A'',
		/* ucrea - varchar(100) */
                  @ucrea,
		/* uupdate - varchar(100) */
                  @ucrea,
                  1,
                  @AjustadorId
                  
		    ) 
        --DECLARE @ajusteId NUMERIC(8, 0)
	
        SET @ajusteId = SCOPE_IDENTITY()
	
        
        DECLARE @anno VARCHAR(4)
        declare @numajustepasa varchar(30)

        declare @estadoajusteid numeric(8, 0)
	
/*
insertando el numero de poliza que se debe generar...
*/
        set @anno = year(getdate())




--set @numajustepasa = dbo.generaNumeroAjustepasa(@ajusteid,@anno)

	--declare @numajustepasa varchar(20)
        declare @aux2 varchar(250)
	
        set @aux2 = '''' ;
        select top 1
                @aux2 = valorParametro
        from    ADM_PARAMETRO
        where   nombreparametro = ''NUMEROAJUSTEACTUAL''
	
 --convert(varchar(10),@ajusteid)

        set @numajustepasa = ''PA-'' + @aux2 + ''-'' + @anno

        if ( @aux2 != '''' ) 
            begin 
                declare @numAux numeric(8, 0) 
                set @numAux = convert(numeric(8, 0), @aux2)
                set @numAux = @numAux + 1
                update  ADM_PARAMETRO
                set     valorParametro = convert(varchar(10), @numAux)
                where   ( NombreParametro = ''NUMEROAJUSTEACTUAL'' )
            end	

		
        set @numeroAjuste = @numAjustePasa

        update  RGN_AJUSTE
        set     numajustepasa = @numajustepasa
        where   ajusteid = @ajusteid
	
        IF NOT @polizaid IS NULL 
            insert  into RGN_POLIZA_AJUSTE
                    (
                      polizaid,
                      aseguradoraid,
                      ajusteid,
                      numsiniestro,
                      fcrea,
                      fupdate,
                      estado,
                      ucrea,
                      uupdate
                    )
            values  (
                      @polizaid,
                      @aseguradoraid,
                      @ajusteid,
                      null,
                      getdate(),
                      getdate(),
                      ''A'',
                      @ucrea,
                      @ucrea 
	              )
	              
	              
        insert  into RGN_SINIESTRO
                (
                  descripcion,
                  fsiniestro,
                  tiposiniestroid,
                  lugarsiniestro,
                  ubigeoid,
                  fcrea,
                  fupdate,
                  estado,
                  ucrea,
                  uupdate
                )
        values  (
                  @descripcion,
                  @FechaSiniestro,
                  @TipoSiniestroId,
                  @lugarsiniestro,
                  null,
                  getdate(),
                  getdate(),
                  ''A'',
                  @ucrea,
                  @ucrea 
	          )	
	          
	     
        declare @siniestroId numeric(8, 0) 
        set @siniestroId = scope_identity()

        update  RGN_AJUSTE
        set     siniestroid = @siniestroId
        where   ajusteid = @ajusteid

        DECLARE @fechaaux DATETIME
		
        SET @fechaaux = GETDATE()
			
        exec sp_rgen_cambiaEstadoAjuste @fechaAux, @ajusteid, 12, @ucrea
        exec sp_rgen_cambiaEstadoAjuste @fechaAux, @ajusteid, 13, @ucrea

    END




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ConvenioAjusteSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ConvenioAjusteSelect]
	@ajusteId numeric
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

-- sacamos primero la moneda con la cual se esta trabajando los montos

	DECLARE @reserva numeric
	DECLARE @monedaId numeric
	DECLARE @simboloMonedaReserva varchar(3)
	
	SET @reserva = dbo.UltimoEstimadoReservaAjuste(@ajusteid)
	SET @monedaId =dbo.UltimaMonedaReservaAjuste(@ajusteId)
	SET @simboloMonedaReserva = dbo.dameSimboloMoneda(@monedaId)
		
	SELECT	
		RGN_AJUSTE.ajusteId,
		RGN_CONVENIOAJUSTE.totalDeducible,
		RGN_CONVENIOAJUSTE.totalIndemnizacion,
		RGN_CONVENIOAJUSTE.totalPerdida,
		RGN_CONVENIOAJUSTE.montoIndemnizacion,
		RGN_CONVENIOAJUSTE.representante,
		RGN_CONVENIOAJUSTE.fconvenio,
		RGN_CONVENIOAJUSTE.fcrea,
		RGN_CONVENIOAJUSTE.fupdate,
		RGN_CONVENIOAJUSTE.ucrea,
		RGN_CONVENIOAJUSTE.uupdate,
		@monedaId as monedaId,
		@simboloMonedaReserva as simbolo
		
	FROM 	RGN_AJUSTE LEFT OUTER JOIN 
		RGN_CONVENIOAJUSTE ON RGN_CONVENIOAJUSTE.ajusteId = RGN_AJUSTE.ajusteId
	WHERE	RGN_AJUSTE.ajusteId = @ajusteId

	SET @Err = @@Error

	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_EstadoAjusteActual_Select]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[sp_rgen_EstadoAjusteActual_Select] ( @ajusteid numeric(8, 0) )
as 
    select  dbo.f_rgen_DameCodigoEstadoAjuste(@ajusteid) as ''codigoEstado''

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_AjustesListaFiltrosReporte]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgn_AjustesListaFiltrosReporte]
(
	@asegurado nvarchar(50),
	@fInicio datetime,
	@fFin datetime,	
	@Idcia	numeric,
	@Idliquidacion numeric,
	@siniestro nvarchar(100) ,
	@Idajustador numeric,
	@Idramo	numeric,
	@IdProducto numeric,
	@IdCobertura numeric,
	@Idestado numeric,
	@Idbroker numeric,
	@numsiniestroCia  nvarchar(20),
	@numsiniestroBroker nvarchar(20),
	@numAjuste nvarchar(20),
	@numpoliza nvarchar(20),
	@ejecutivo nvarchar(100),
	@minreserva nvarchar(10),
	@maxreserva nvarchar(10),
	@mindia nvarchar(10),
	@maxdia nvarchar(10),
	@ejecutivoBroker nvarchar(100),
	@mindiaCambioEstado nvarchar(10),
	@maxdiaCambioEstado nvarchar(10)
)
AS
DECLARE @sqlSentencia nvarchar(4000)
DECLARE @sqlCondicion nvarchar(4000)
Declare @strini varchar(22)
declare @strfin varchar(22)
	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	SET NOCOUNT ON;
	select * into #lajuste from ListaAjusteReportes
	
	SET @sqlSentencia = ''   SELECT *
				FROM #lajuste
				where 1=1 
				''
			        
	IF (LEN(@fInicio) > 0 and LEN(@fFin) > 0)
	begin
		select @strini = dbo.QStr(dbo.FechaAnsiString(@fInicio))
		select @strfin = dbo.QStr(dbo.FechaAnsiString(@fFin))
		set @sqlCondicion = @sqlCondicion + 
			'' and (  fsiniestro <= '' + @strfin  + 
			'' ) AND  ( fsiniestro >= '' + @strini +  '') ''				
	end	
	IF (LEN(@asegurado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (Asegurado  like''''%'' + @asegurado + ''%'''' ) ''				
	end
	
	IF (@Idcia > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( aseguradoraId ='' +   convert(varchar(15),@Idcia) + '' ) ''				
	end
	
	IF (@Idliquidacion > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (tajusteId ='' +   convert(varchar(15),@Idliquidacion) + '' ) ''				
	end
	
	if (LEN(@siniestro) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( siniestro  like ''''%'' + @siniestro + ''%'''' ) ''				
	end
	
	IF (@Idajustador > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ajustadorId  ='' +   convert(varchar(15),@Idajustador) + '' ) ''				
	end
	
	IF (@Idramo > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( ramoId ='' +   convert(varchar(15),@Idramo) + '' ) ''				
	end

	IF (@IdProducto > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( productoId ='' +   convert(varchar(15),@IdProducto) + '' ) ''				
	end

	IF (@IdCobertura > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( riesgoId ='' +   convert(varchar(15),@IdCobertura) + '' ) ''				
	end
	
	IF (@Idestado > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( StatusId ='' +   convert(varchar(15),@Idestado) + '' ) ''				
	end

	IF (@Idestado = -1)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( StatusId !=20 and StatusId !=21  ) ''				
	end	


	IF (@Idbroker > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( brokerId ='' +   convert(varchar(15),@Idbroker) + '' ) ''				
	end	
	IF (LEN(@numsiniestroCia) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numeroSiniestroCia  like''''%'' + @numsiniestroCia + '''''' ) ''				
	end
	IF (LEN(@numAjuste) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numAjustePASA  like''''%'' + @numAjuste + ''%'''' ) ''				
	end
	IF (LEN(@numpoliza) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numeroPoliza  like ''''%'' + @numpoliza + ''%'''' ) ''				
	end


	IF (LEN(@ejecutivo) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( Contactoaseguradora  like ''''%'' + @ejecutivo + ''%'''' ) ''				
	end

	IF (LEN(@ejecutivoBroker) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( ContactoBroker  like ''''%'' + @ejecutivoBroker + ''%'''' ) ''				
	end

	IF (LEN(@minreserva) > 0 and LEN(@maxreserva) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (Reserva <= '' + convert(varchar(15),@maxreserva) + '' AND Reserva >= '' + convert(varchar(15),@minreserva) + '') ''				
	end
	
	IF (LEN(@mindia) > 0 and LEN(@maxdia) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (NroDias <= '' + convert(varchar(15),@maxdia) + '' AND NroDias >= '' + convert(varchar(15),@mindia) + '') ''				
	end


	IF (LEN(@mindiaCambioEstado) > 0 and LEN(@mindiaCambioEstado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (Dias <= '' + convert(varchar(15),@mindiaCambioEstado) + '' AND Dias >= '' + convert(varchar(15),@mindiaCambioEstado) + '') ''				
	end

	IF (LEN(@numsiniestroBroker) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (numeroSiniestroBroker  like''''%'' + @numsiniestroBroker + '''''' ) ''				
	end

	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion + '' order by Asegurado''
	exec (@sqlSentencia)




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_setpropertybyid_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		uvalue -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
CREATE PROCEDURE [dbo].[dt_setpropertybyid_u]
	@id int,
	@property varchar(64),
	@uvalue nvarchar(255),
	@lvalue image
as
	set nocount on
	-- 
	-- If we are writing the name property, find the ansi equivalent. 
	-- If there is no lossless translation, generate an ansi name. 
	-- 
	declare @avalue varchar(255) 
	set @avalue = null 
	if (@uvalue is not null) 
	begin 
		if (convert(nvarchar(255), convert(varchar(255), @uvalue)) = @uvalue) 
		begin 
			set @avalue = convert(varchar(255), @uvalue) 
		end 
		else 
		begin 
			if ''DtgSchemaNAME'' = @property 
			begin 
				exec dbo.dt_generateansiname @avalue output 
			end 
		end 
	end 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@avalue, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @avalue, @uvalue, @lvalue)
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_removefromsourcecontrol]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  procedure [dbo].[dt_removefromsourcecontrol]

as

    set nocount on

    declare @iPropertyObjectId int
    select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = ''VCSProjectID'')

    exec dbo.dt_droppropertiesbyid @iPropertyObjectId, null

    /* -1 is returned by dt_droppopertiesbyid */
    if @@error <> 0 and @@error <> -1 return 1

    return 0
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_getpropertiesbyid_vcs_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  procedure [dbo].[dt_getpropertiesbyid_vcs_u]
    @id       int,
    @property varchar(64),
    @value    nvarchar(255) = NULL OUT

as

    -- This procedure should no longer be called;  dt_getpropertiesbyid_vcsshould be called instead.
	-- Calls are forwarded to dt_getpropertiesbyid_vcs to maintain backward compatibility.
	set nocount on
    exec dbo.dt_getpropertiesbyid_vcs
		@id,
		@property,
		@value output
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_addtosourcecontrol_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_addtosourcecontrol_u]
    @vchSourceSafeINI nvarchar(255) = '''',
    @vchProjectName   nvarchar(255) ='''',
    @vchComment       nvarchar(255) ='''',
    @vchLoginName     nvarchar(255) ='''',
    @vchPassword      nvarchar(255) =''''

as
	-- This procedure should no longer be called;  dt_addtosourcecontrol should be called instead.
	-- Calls are forwarded to dt_addtosourcecontrol to maintain backward compatibility
	set nocount on
	exec dbo.dt_addtosourcecontrol 
		@vchSourceSafeINI, 
		@vchProjectName, 
		@vchComment, 
		@vchLoginName, 
		@vchPassword

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_checkinobject_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_checkinobject_u]
    @chObjectType  char(4),
    @vchObjectName nvarchar(255),
    @vchComment    nvarchar(255)='''',
    @vchLoginName  nvarchar(255),
    @vchPassword   nvarchar(255)='''',
    @iVCSFlags     int = 0,
    @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
    @txStream1     text = '''',  /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
    @txStream2     text = '''',  /* alter  stream */
    @txStream3     text = ''''   /* grant stream  */

as	
	-- This procedure should no longer be called;  dt_checkinobject should be called instead.
	-- Calls are forwarded to dt_checkinobject to maintain backward compatibility.
	set nocount on
	exec dbo.dt_checkinobject
		@chObjectType,
		@vchObjectName,
		@vchComment,
		@vchLoginName,
		@vchPassword,
		@iVCSFlags,
		@iActionFlag,   
		@txStream1,		
		@txStream2,		
		@txStream3		


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_checkoutobject_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_checkoutobject_u]
    @chObjectType  char(4),
    @vchObjectName nvarchar(255),
    @vchComment    nvarchar(255),
    @vchLoginName  nvarchar(255),
    @vchPassword   nvarchar(255),
    @iVCSFlags     int = 0,
    @iActionFlag   int = 0/* 0 => Checkout, 1 => GetLatest, 2 => UndoCheckOut */

as

	-- This procedure should no longer be called;  dt_checkoutobject should be called instead.
	-- Calls are forwarded to dt_checkoutobject to maintain backward compatibility.
	set nocount on
	exec dbo.dt_checkoutobject
		@chObjectType,  
		@vchObjectName, 
		@vchComment,    
		@vchLoginName,  
		@vchPassword,  
		@iVCSFlags,    
		@iActionFlag 

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_isundersourcecontrol_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_isundersourcecontrol_u]
    @vchLoginName nvarchar(255) = '''',
    @vchPassword  nvarchar(255) = '''',
    @iWhoToo      int = 0 /* 0 => Just check project; 1 => get list of objs */

as
	-- This procedure should no longer be called;  dt_isundersourcecontrol should be called instead.
	-- Calls are forwarded to dt_isundersourcecontrol to maintain backward compatibility.
	set nocount on
	exec dbo.dt_isundersourcecontrol
		@vchLoginName,
		@vchPassword,
		@iWhoToo 


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_validateloginparams_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_validateloginparams_u]
    @vchLoginName  nvarchar(255),
    @vchPassword   nvarchar(255)
as

	-- This procedure should no longer be called;  dt_validateloginparams should be called instead.
	-- Calls are forwarded to dt_validateloginparams to maintain backward compatibility.
	set nocount on
	exec dbo.dt_validateloginparams
		@vchLoginName,
		@vchPassword 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dt_whocheckedout_u]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  proc [dbo].[dt_whocheckedout_u]
        @chObjectType  char(4),
        @vchObjectName nvarchar(255),
        @vchLoginName  nvarchar(255),
        @vchPassword   nvarchar(255)

as

	-- This procedure should no longer be called;  dt_whocheckedout should be called instead.
	-- Calls are forwarded to dt_whocheckedout to maintain backward compatibility.
	set nocount on
	exec dbo.dt_whocheckedout
		@chObjectType, 
		@vchObjectName,
		@vchLoginName, 
		@vchPassword  

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_TipoActividadUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgn_TipoActividadUpdate](	
	@tipoActividadId numeric (8,0),
	@TipoActividad varchar(250),
	@Descripcion varchar(250)
)
AS
	SET NOCOUNT ON;
	
	if (@tipoActividadId is not null) 
	begin	
		update RGN_TIPOACTIVIDAD
		set	
			TipoActividad =@TipoActividad ,
			Descripcion = @Descripcion
		where tipoActividadId = @tipoActividadId
	end	
	else 
	begin	
		exec sp_rgn_TipoActividadInsert @tipoActividad,@Descripcion
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgn_AjustesListaFiltros]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgn_AjustesListaFiltros]
(
	@asegurado nvarchar(50),
	@fInicio datetime,
	@fFin datetime,	
	@Idcia	numeric,
	@Idliquidacion numeric,
	@siniestro nvarchar(100) ,
	@Idajustador numeric,
	@IdejecutivoSiniestros numeric,
	@Idramo	numeric,
	@Idestado numeric,
	@Idbroker numeric,
	@numsiniestroCia  nvarchar(20),
	@numsiniestroBroker nvarchar(20),
	@numAjuste nvarchar(20),
	@numpoliza nvarchar(20),
	@ejecutivo nvarchar(100),
	@minreserva nvarchar(10),
	@maxreserva nvarchar(10),
	@mindia nvarchar(10),
	@maxdia nvarchar(10),
	@ejecutivoBroker nvarchar(100),
	@mindiaCambioEstado nvarchar(10),
	@maxdiaCambioEstado nvarchar(10)
)
AS
DECLARE @sqlSentencia nvarchar(4000)
DECLARE @sqlCondicion nvarchar(4000)
Declare @strini varchar(22)
declare @strfin varchar(22)
	
	SET @sqlSentencia = ''''
	SET @sqlCondicion = ''''
	
	SET NOCOUNT ON;
	/*select * into #lajuste from ListaAjuste*/

	SET @sqlSentencia = '' 
	SELECT  ADM_PERSONA_3.persona AS Asegurado,
        dbo.fn_rgen_dameTipoSiniestro(dbo.RGN_SINIESTRO.tipoSiniestroId) AS siniestro,
        dbo.RGN_SINIESTRO.fsiniestro,
        dbo.TiempoTranscurrido(dbo.RGN_AJUSTE.faviso, GETDATE()) AS NroDias,
        ADM_PERSONA_2.persona AS Aseguradora,
        dbo.RGN_AJUSTE.numAjustePASA,
        dbo.RGN_AJUSTE.numAjusteAseguradora AS NumeroAjuste,
        dbo.RGN_POLIZA.numeroPoliza,
        dbo.RGN_RAMO.nombre AS Ramo,
        dbo.UltimoEstimadoReservaAjuste(dbo.RGN_AJUSTE.ajusteId) AS Reserva,
        dbo.UltimoEstadoAjuste(dbo.RGN_AJUSTE.ajusteId) AS Status,
        dbo.TiempoTranscurrido(dbo.FechaUltimoEstadoAjuste(dbo.RGN_AJUSTE.ajusteId),
                               GETDATE()) AS Dias,
        dbo.RGN_AJUSTE.situacionAjustelistados AS observaciones,
        ADM_PERSONA_4.persona AS Ajustador,
        ADM_PERSONA_1.persona AS Broker,
        dbo.RGN_AJUSTE.ajusteId,
        dbo.RGN_AJUSTE.siniestroid,
        dbo.RGN_AJUSTE.ajustadorId,
		dbo.RGN_AJUSTE.ejecutivoSiniestrosId,
        dbo.RGN_AJUSTE.brokerId,
        dbo.RGN_POLIZA.aseguradoId,
        dbo.RGN_POLIZA.ramoId,
        dbo.ContactoAjuste(dbo.RGN_AJUSTE.ajusteId) AS Contactoaseguradora,
        dbo.RGN_AJUSTE.tajusteid,
        ADM_PERSONA_4.persona,
        dbo.RGN_POLIZA.aseguradoraId,
        dbo.UltimoEstadoAjusteId(dbo.RGN_AJUSTE.ajusteId) AS StatusId,
        dbo.RGN_AJUSTE.estado,
        dbo.UltimoEstimadoReservaAjusteMoneda(dbo.RGN_AJUSTE.ajusteId) AS simbolo,
        dbo.ContactoAjusteBroker(dbo.RGN_AJUSTE.ajusteId) AS ContactoBroker,
        dbo.RGN_POLIZA_AJUSTE.polizaId,
        dbo.RGN_AJUSTE.numeroSiniestroCia,
        dbo.RGN_AJUSTE.numeroSiniestroBroker
FROM    dbo.RGN_POLIZA
        LEFT OUTER JOIN dbo.RGN_RAMO ON dbo.RGN_POLIZA.ramoId = dbo.RGN_RAMO.ramoId
        LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_2 ON dbo.RGN_POLIZA.aseguradoraId = ADM_PERSONA_2.personaId
        LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_3 ON dbo.RGN_POLIZA.aseguradoId = ADM_PERSONA_3.personaId
        RIGHT OUTER JOIN dbo.RGN_SINIESTRO
        RIGHT OUTER JOIN dbo.RGN_AJUSTE
        LEFT OUTER JOIN dbo.RGN_POLIZA_AJUSTE ON dbo.PrimeraPoliza(dbo.RGN_AJUSTE.ajusteId) = dbo.RGN_POLIZA_AJUSTE.polizaId
             AND dbo.RGN_AJUSTE.ajusteId = dbo.RGN_POLIZA_AJUSTE.ajusteId ON dbo.RGN_SINIESTRO.siniestroid = dbo.RGN_AJUSTE.siniestroid ON dbo.RGN_POLIZA.polizaId = dbo.RGN_POLIZA_AJUSTE.polizaId
        LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_1 ON dbo.RGN_AJUSTE.brokerId = ADM_PERSONA_1.personaId
        LEFT OUTER JOIN dbo.ADM_PERSONA ADM_PERSONA_4 ON dbo.RGN_AJUSTE.ajustadorId = ADM_PERSONA_4.personaId
WHERE   ( dbo.RGN_AJUSTE.estado = ''''A'''' )
				''
			        
	IF (LEN(@fInicio) > 0 and LEN(@fFin) > 0)
	begin
		select @strini = dbo.FechaAnsiString(@fInicio)
		select @strfin = dbo.FechaAnsiString(@fFin)
		set @sqlCondicion = @sqlCondicion + 
			'' and (  fsiniestro <= '' + @strfin  + 
			'' ) and  ( fsiniestro >= '' + @strini +  '') ''				
	end	
	IF (LEN(@asegurado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ADM_PERSONA_3.persona  like''''%'' + @asegurado + ''%'''' ) ''				
	end
	
	IF (@Idcia > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( dbo.RGN_POLIZA.aseguradoraId ='' +   convert(varchar(15),@Idcia) + '' ) ''				
	end
	
	IF (@Idliquidacion > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (tajusteId ='' +   convert(varchar(15),@Idliquidacion) + '' ) ''				
	end
	
	if (LEN(@siniestro) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( dbo.fn_rgen_dameTipoSiniestro(dbo.RGN_SINIESTRO.tipoSiniestroId)  like ''''%'' + @siniestro + ''%'''' ) ''				
	end
	
	IF (@Idajustador > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ajustadorId  ='' +   convert(varchar(15),@Idajustador) + '' ) ''				
	end

	IF (@IdejecutivoSiniestros > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (ajustadorId  ='' +   convert(varchar(15),@IdejecutivoSiniestros) + '' ) ''				
	end

	IF (@Idramo > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (  dbo.RGN_POLIZA.ramoId ='' +   convert(varchar(15),@Idramo) + '' ) ''				
	end
	
	IF (@Idestado > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( dbo.UltimoEstadoAjusteId(dbo.RGN_AJUSTE.ajusteId) ='' +   convert(varchar(15),@Idestado) + '' ) ''				
	end	
	IF (@Idbroker > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( brokerId ='' +   convert(varchar(15),@Idbroker) + '' ) ''				
	end	
	IF (LEN(@numsiniestroCia) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numeroSiniestroCia  like''''%'' + @numsiniestroCia + '''''' ) ''				
	end
	IF (LEN(@numAjuste) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numAjustePASA  like''''%'' + @numAjuste + ''%'''' ) ''				
	end
	IF (LEN(@numpoliza) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( numeroPoliza  like ''''%'' + @numpoliza + ''%'''' ) ''				
	end


	IF (LEN(@ejecutivo) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( Contactoaseguradora  like ''''%'' + @ejecutivo + ''%'''' ) ''				
	end

	IF (LEN(@ejecutivoBroker) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND ( ContactoBroker  like ''''%'' + @ejecutivoBroker + ''%'''' ) ''				
	end

	IF (LEN(@minreserva) > 0 and LEN(@maxreserva) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (Reserva <= '' + convert(varchar(15),@maxreserva) + '' AND Reserva >= '' + convert(varchar(15),@minreserva) + '') ''				
	end
	
	IF (LEN(@mindia) > 0 and LEN(@maxdia) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (NroDias <= '' + convert(varchar(15),@maxdia) + '' AND NroDias >= '' + convert(varchar(15),@mindia) + '') ''				
	end


	IF (LEN(@mindiaCambioEstado) > 0 and LEN(@mindiaCambioEstado) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (Dias <= '' + convert(varchar(15),@mindiaCambioEstado) + '' AND Dias >= '' + convert(varchar(15),@mindiaCambioEstado) + '') ''				
	end

	IF (LEN(@numsiniestroBroker) > 0)
	begin
		set @sqlCondicion = @sqlCondicion + 
			'' AND (numeroSiniestroBroker  like''''%'' + @numsiniestroBroker + '''''' ) ''				
	end

	set @sqlSentencia = @sqlSentencia + '' '' + @sqlCondicion
	exec (@sqlSentencia)



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_informebasico_delaocurrencia_detalle]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[sp_rgen_informebasico_delaocurrencia_detalle](@ajusteid int)
as

SELECT     --bienafectadoid as Item,
	   item as bienes, 
	   descripcion, 
	   montorep as estimacion, 
	   dbo.dameSimboloMoneda(monedaId)AS moneda,
	   LocalDelBien
FROM         RGN_BIENAFECTADO
WHERE     (ajusteId = @ajusteid)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ConvenioAjusteUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[sp_rgen_ConvenioAjusteUpdate]
(
	@ajusteId numeric(8,0),
	@totalDeducible numeric(18,2),
	@totalIndemnizacion numeric(18,2),
	@totalPerdida numeric(18,2),
	@montoIndemnizacion varchar (100),
	@representante varchar (100),
	@usuario varchar(20),
	@monedaId numeric(5,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int, @conAjuste int

	SELECT 	@conAjuste = COUNT(*) FROM RGN_CONVENIOAJUSTE
	WHERE		ajusteId = @ajusteId

	IF @conAjuste > 0
		UPDATE	RGN_CONVENIOAJUSTE
		SET
			totalDeducible = @totalDeducible,
			totalIndemnizacion = @totalIndemnizacion,
			totalPerdida = @totalPerdida,
			montoIndemnizacion = @montoIndemnizacion,
			representante = @representante,
			fupdate	= GETDATE(),
			uupdate	= @usuario,
			monedaId = @monedaId
		WHERE	ajusteId = @ajusteId
	ELSE
		INSERT INTO RGN_CONVENIOAJUSTE 
		(	
			ajusteId,
			totalDeducible,
			totalIndemnizacion,
			totalPerdida,
			montoIndemnizacion,
			representante,
			fconvenio,
			fcrea,
			fupdate,
			ucrea,
			uupdate,
			monedaId
		)
		VALUES
		(
			@ajusteId,
			@totalDeducible,
			@totalIndemnizacion,
			@totalPerdida,
			@montoIndemnizacion,
			@representante,
			getdate(),
			getdate(),
			getdate(),
			@usuario,
			@usuario,
			@monedaId
		)

	declare @fecha datetime
	set @fecha=getdate()
	
	exec dbo.sp_rgen_cambiaEstadoAjuste @fecha,@ajusteId,19,@usuario
	


	SET @Err = @@Error
	
	RETURN @Err
END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_ConvenioAjusteInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_ConvenioAjusteInsert]
(
	@ajusteId numeric(8,0),
	@totalDeducible numeric(18,2),
	@totalIndemnizacion numeric(18,2),
	@totalPerdida numeric(18,2),
	@montoIndemnizacion varchar (100),
	@representante varchar (100),
	@usuario varchar(20),
	@monedaId numeric (5,0)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int
		
	INSERT INTO RGN_CONVENIOAJUSTE 
	(	
		ajusteId,
		totalDeducible,
		totalIndemnizacion,
		totalPerdida,
		montoIndemnizacion,
		representante,
		fconvenio,
		fcrea,
		fupdate,
		ucrea,
		uupdate,
		monedaId
	)
	VALUES
	(
		@ajusteId,
		@totalDeducible,
		@totalIndemnizacion,
		@totalPerdida,
		@montoIndemnizacion,
		@representante,
		getdate(),
		getdate(),
		getdate(),
		@usuario,
		@usuario,
		@monedaId
		
	)

	declare @fecha datetime
	set @fecha=getdate()
	
	exec dbo.sp_rgen_cambiaEstadoAjuste @fecha,@ajusteId,19,@usuario
	

	SET @Err = @@Error
	
	RETURN @Err
END










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getRamoWhereAjusteIdIs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[getRamoWhereAjusteIdIs]
(
	@ajusteId numeric(8, 0)
)
AS
	SET NOCOUNT ON;
SELECT     ramoId
FROM         ListaAjustesAjax
WHERE     (ajusteId = @ajusteId)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_AjaxDatosCabeceraAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_AjaxDatosCabeceraAjuste]( @ajusteId numeric(8,0))
as
begin
	select * from ListaAjustesAjax where ajusteid = @ajusteId
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rgen_getRiesgoIdAjuste]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_rgen_getRiesgoIdAjuste](@ajusteId numeric(8,0)) 
as

select dbo.dameRiesgoIdPolizaPrincipal(@ajusteId) as ''RamoId''
' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__asegu__04CFADEC]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__asegu__04CFADEC] FOREIGN KEY([aseguradoraId])
REFERENCES [dbo].[ADM_CLIENTE] ([aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__asegu__04CFADEC]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__asegu__08A03ED0]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__asegu__08A03ED0] FOREIGN KEY([aseguradoId])
REFERENCES [dbo].[ADM_ASEGURADO] ([personaId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__asegu__08A03ED0]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__asegu__1CB22475]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH CHECK ADD  CONSTRAINT [FK__RGN_POLIZ__asegu__1CB22475] FOREIGN KEY([aseguradoraId])
REFERENCES [dbo].[ADM_CLIENTE] ([aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__asegu__1CB22475]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__asegu__2082B559]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH CHECK ADD  CONSTRAINT [FK__RGN_POLIZ__asegu__2082B559] FOREIGN KEY([aseguradoId])
REFERENCES [dbo].[ADM_ASEGURADO] ([personaId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__asegu__2082B559]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__produ__07AC1A97]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__produ__07AC1A97] FOREIGN KEY([productoId])
REFERENCES [dbo].[RGN_PRODUCTO] ([productoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__produ__07AC1A97]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__produ__1F8E9120]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__produ__1F8E9120] FOREIGN KEY([productoId])
REFERENCES [dbo].[RGN_PRODUCTO] ([productoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__produ__1F8E9120]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__ramoI__06B7F65E]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__ramoI__06B7F65E] FOREIGN KEY([ramoId])
REFERENCES [dbo].[RGN_RAMO] ([ramoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__ramoI__06B7F65E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__ramoI__1E9A6CE7]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__ramoI__1E9A6CE7] FOREIGN KEY([ramoId])
REFERENCES [dbo].[RGN_RAMO] ([ramoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__ramoI__1E9A6CE7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__riesg__05C3D225]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__riesg__05C3D225] FOREIGN KEY([riesgoId])
REFERENCES [dbo].[RGN_RIESGO_COBERTURA] ([riesgoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__riesg__05C3D225]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__riesg__1DA648AE]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA]'))
ALTER TABLE [dbo].[RGN_POLIZA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__riesg__1DA648AE] FOREIGN KEY([riesgoId])
REFERENCES [dbo].[RGN_RIESGO_COBERTURA] ([riesgoId])
GO
ALTER TABLE [dbo].[RGN_POLIZA] CHECK CONSTRAINT [FK__RGN_POLIZ__riesg__1DA648AE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ATRIB__ajust__01FE2E39]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ATRIB__ajust__01FE2E39] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_ATRIB__ajust__01FE2E39]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ATRIB__ajust__6A1BB7B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ATRIB__ajust__6A1BB7B0] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_ATRIB__ajust__6A1BB7B0]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ATRIBUTOPOLI__02F25272]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]  WITH CHECK ADD FOREIGN KEY([atributoId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_ATRIBUTOPOLIZA] ([atributoId], [polizaId], [aseguradoraId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ATRIBUTOPOLI__6B0FDBE9]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ATRIBUTOPOLI__6B0FDBE9] FOREIGN KEY([atributoId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_ATRIBUTOPOLIZA] ([atributoId], [polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_ATRIBUTOPOLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_ATRIBUTOPOLI__6B0FDBE9]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SINIE__tipoS__2823D721]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SINIESTRO]'))
ALTER TABLE [dbo].[RGN_SINIESTRO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SINIE__tipoS__2823D721] FOREIGN KEY([tipoSiniestroId])
REFERENCES [dbo].[RGN_TIPOSINIESTRO] ([tipoSiniestroId])
GO
ALTER TABLE [dbo].[RGN_SINIESTRO] CHECK CONSTRAINT [FK__RGN_SINIE__tipoS__2823D721]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SINIE__tipoS__30CE2BBB]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SINIESTRO]'))
ALTER TABLE [dbo].[RGN_SINIESTRO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SINIE__tipoS__30CE2BBB] FOREIGN KEY([tipoSiniestroId])
REFERENCES [dbo].[RGN_TIPOSINIESTRO] ([tipoSiniestroId])
GO
ALTER TABLE [dbo].[RGN_SINIESTRO] CHECK CONSTRAINT [FK__RGN_SINIE__tipoS__30CE2BBB]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCES__rolId__1229A90A]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCES__rolId__2B0043CC]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCES__rolId__5BD88551]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCESO__113584D1]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH NOCHECK ADD  CONSTRAINT [FK__SYS_ACCESO__113584D1] FOREIGN KEY([funcionalidadId], [moduloId], [appId])
REFERENCES [dbo].[SYS_FUNCIONALIDAD] ([funcionalidadId], [moduloId], [appId])
GO
ALTER TABLE [dbo].[SYS_ACCESO] CHECK CONSTRAINT [FK__SYS_ACCESO__113584D1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCESO__2A0C1F93]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH CHECK ADD FOREIGN KEY([funcionalidadId], [moduloId], [appId])
REFERENCES [dbo].[SYS_FUNCIONALIDAD] ([funcionalidadId], [moduloId], [appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ACCESO__5AE46118]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ACCESO]'))
ALTER TABLE [dbo].[SYS_ACCESO]  WITH CHECK ADD FOREIGN KEY([funcionalidadId], [moduloId], [appId])
REFERENCES [dbo].[SYS_FUNCIONALIDAD] ([funcionalidadId], [moduloId], [appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_SUBAC__usuar__03275C9C]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_SUBACCESO]'))
ALTER TABLE [dbo].[SYS_SUBACCESO]  WITH NOCHECK ADD  CONSTRAINT [FK__SYS_SUBAC__usuar__03275C9C] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[SYS_USUARIO] ([usuarioId])
GO
ALTER TABLE [dbo].[SYS_SUBACCESO] CHECK CONSTRAINT [FK__SYS_SUBAC__usuar__03275C9C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_SUBACCESO__041B80D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_SUBACCESO]'))
ALTER TABLE [dbo].[SYS_SUBACCESO]  WITH NOCHECK ADD  CONSTRAINT [FK__SYS_SUBACCESO__041B80D5] FOREIGN KEY([funcionalidadId], [moduloId], [appId])
REFERENCES [dbo].[SYS_FUNCIONALIDAD] ([funcionalidadId], [moduloId], [appId])
GO
ALTER TABLE [dbo].[SYS_SUBACCESO] CHECK CONSTRAINT [FK__SYS_SUBACCESO__041B80D5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_AJUST__perso__6379A719]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_AJUSTADOR]'))
ALTER TABLE [dbo].[ADM_AJUSTADOR]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_AJUST__perso__6379A719] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ADM_AJUSTADOR] CHECK CONSTRAINT [FK__ADM_AJUST__perso__6379A719]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_ASEGU__perso__646DCB52]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_ASEGURADO]'))
ALTER TABLE [dbo].[ADM_ASEGURADO]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_ASEGU__perso__646DCB52] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ADM_ASEGURADO] CHECK CONSTRAINT [FK__ADM_ASEGU__perso__646DCB52]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_BROKE__perso__6561EF8B]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_BROKER]'))
ALTER TABLE [dbo].[ADM_BROKER]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_BROKE__perso__6561EF8B] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ADM_BROKER] CHECK CONSTRAINT [FK__ADM_BROKE__perso__6561EF8B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_DIREC__perso__683E5C36]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_DIRECCIONPERSONA]'))
ALTER TABLE [dbo].[ADM_DIRECCIONPERSONA]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_DIREC__perso__683E5C36] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
GO
ALTER TABLE [dbo].[ADM_DIRECCIONPERSONA] CHECK CONSTRAINT [FK__ADM_DIREC__perso__683E5C36]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_DOCID__perso__6932806F]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_DOCID]'))
ALTER TABLE [dbo].[ADM_DOCID]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_DOCID__perso__6932806F] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
GO
ALTER TABLE [dbo].[ADM_DOCID] CHECK CONSTRAINT [FK__ADM_DOCID__perso__6932806F]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_DOCID__tdoci__52442E1F]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_DOCID]'))
ALTER TABLE [dbo].[ADM_DOCID]  WITH CHECK ADD FOREIGN KEY([tdocidId])
REFERENCES [dbo].[ADM_TDOCID] ([tdocidId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_DOCID__tdoci__6A26A4A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_DOCID]'))
ALTER TABLE [dbo].[ADM_DOCID]  WITH CHECK ADD FOREIGN KEY([tdocidId])
REFERENCES [dbo].[ADM_TDOCID] ([tdocidId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_TELEF__perso__6EEB59C5]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_TELEFONOXPERSONA]'))
ALTER TABLE [dbo].[ADM_TELEFONOXPERSONA]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_TELEF__perso__6EEB59C5] FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
GO
ALTER TABLE [dbo].[ADM_TELEFONOXPERSONA] CHECK CONSTRAINT [FK__ADM_TELEF__perso__6EEB59C5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_TELEF__ttele__5708E33C]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_TELEFONOXPERSONA]'))
ALTER TABLE [dbo].[ADM_TELEFONOXPERSONA]  WITH CHECK ADD FOREIGN KEY([ttelefonoid])
REFERENCES [dbo].[ADM_TTELEFONO] ([ttelefonoid])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_TELEF__ttele__6FDF7DFE]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_TELEFONOXPERSONA]'))
ALTER TABLE [dbo].[ADM_TELEFONOXPERSONA]  WITH CHECK ADD FOREIGN KEY([ttelefonoid])
REFERENCES [dbo].[ADM_TTELEFONO] ([ttelefonoid])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_EJECU__perso__76776CF4]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_EJECUTIVOSINIESTROS]'))
ALTER TABLE [dbo].[ADM_EJECUTIVOSINIESTROS]  WITH CHECK ADD FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_PERSONA] ([personaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__ajust__7A5D0C71]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__ajust__7A5D0C71] FOREIGN KEY([ajustadorId])
REFERENCES [dbo].[ADM_AJUSTADOR] ([personaId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__ajust__7A5D0C71]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__broke__7B5130AA]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__broke__7B5130AA] FOREIGN KEY([brokerId])
REFERENCES [dbo].[ADM_BROKER] ([personaId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__broke__7B5130AA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__ejecu__7953D99F]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH CHECK ADD FOREIGN KEY([ejecutivoSiniestrosId])
REFERENCES [dbo].[ADM_EJECUTIVOSINIESTROS] ([personaId])
ON DELETE SET NULL
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__medio__768C7B8D]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__medio__768C7B8D] FOREIGN KEY([medioConfirmacion])
REFERENCES [dbo].[RGN_TIPOCOMUNICACION] ([tcomunicacionId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__medio__768C7B8D]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__medio__77809FC6]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__medio__77809FC6] FOREIGN KEY([medioDeNotificacionId])
REFERENCES [dbo].[RGN_TIPOCOMUNICACION] ([tcomunicacionId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__medio__77809FC6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__sinie__7874C3FF]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__sinie__7874C3FF] FOREIGN KEY([siniestroid])
REFERENCES [dbo].[RGN_SINIESTRO] ([siniestroid])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__sinie__7874C3FF]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__tajus__7968E838]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE]'))
ALTER TABLE [dbo].[RGN_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__tajus__7968E838] FOREIGN KEY([tajusteid])
REFERENCES [dbo].[RGN_TIPOAJUSTE] ([tajusteid])
GO
ALTER TABLE [dbo].[RGN_AJUSTE] CHECK CONSTRAINT [FK__RGN_AJUST__tajus__7968E838]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__parra__000AF8CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_ASEGURADO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_ASEGURADO]  WITH CHECK ADD FOREIGN KEY([parrafoId])
REFERENCES [dbo].[RGN_PARRAFO] ([parrafoId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__parra__17ED6F58]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_ASEGURADO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_ASEGURADO]  WITH CHECK ADD FOREIGN KEY([parrafoId])
REFERENCES [dbo].[RGN_PARRAFO] ([parrafoId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__perso__16F94B1F]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_ASEGURADO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_ASEGURADO]  WITH CHECK ADD FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_ASEGURADO] ([personaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__perso__7F16D496]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_ASEGURADO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_ASEGURADO]  WITH CHECK ADD FOREIGN KEY([personaId])
REFERENCES [dbo].[ADM_ASEGURADO] ([personaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__ajust__09946309]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__ajust__09946309] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_POLIZ__ajust__09946309]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZ__ajust__2176D992]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZ__ajust__2176D992] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_POLIZ__ajust__2176D992]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZA_AJUST__0A888742]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_POLIZA_AJUST__0A888742] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_POLIZA_AJUST__0A888742]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_POLIZA_AJUST__226AFDCB]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_POLIZA_AJUSTE]'))
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE]  WITH CHECK ADD  CONSTRAINT [FK__RGN_POLIZA_AJUST__226AFDCB] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_POLIZA_AJUSTE] CHECK CONSTRAINT [FK__RGN_POLIZA_AJUST__226AFDCB]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CLAUSULAS__05CEBF1D]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_CLAUSULAS]  WITH CHECK ADD  CONSTRAINT [FK__RGN_CLAUSULAS__05CEBF1D] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_CLAUSULAS] CHECK CONSTRAINT [FK__RGN_CLAUSULAS__05CEBF1D]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CLAUSULAS__6DEC4894]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_CLAUSULAS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CLAUSULAS__6DEC4894] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_CLAUSULAS] CHECK CONSTRAINT [FK__RGN_CLAUSULAS__6DEC4894]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMA__moned__1328BA3B]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMA__moned__1328BA3B] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO] CHECK CONSTRAINT [FK__RGN_ITEMA__moned__1328BA3B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMA__moned__7B4643B2]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMA__moned__7B4643B2] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO] CHECK CONSTRAINT [FK__RGN_ITEMA__moned__7B4643B2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMASEGURAD__141CDE74]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMASEGURAD__141CDE74] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO] CHECK CONSTRAINT [FK__RGN_ITEMASEGURAD__141CDE74]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMASEGURAD__7C3A67EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMASEGURAD__7C3A67EB] FOREIGN KEY([polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_POLIZA] ([polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO] CHECK CONSTRAINT [FK__RGN_ITEMASEGURAD__7C3A67EB]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RGN_CONFIGURACIONXASEGURADORA_RGN_CONFIGURACIONXASEGURADORA]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONFIGURACIONXASEGURADORA]'))
ALTER TABLE [dbo].[RGN_CONFIGURACIONXASEGURADORA]  WITH NOCHECK ADD  CONSTRAINT [FK_RGN_CONFIGURACIONXASEGURADORA_RGN_CONFIGURACIONXASEGURADORA] FOREIGN KEY([aseguradoraId])
REFERENCES [dbo].[ADM_CLIENTE] ([aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_CONFIGURACIONXASEGURADORA] CHECK CONSTRAINT [FK_RGN_CONFIGURACIONXASEGURADORA_RGN_CONFIGURACIONXASEGURADORA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__requi__2A212E2C]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]'))
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__requi__2A212E2C] FOREIGN KEY([requisitoId])
REFERENCES [dbo].[RGN_REQUISITOS] ([requisitoId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO] CHECK CONSTRAINT [FK__RGN_AJUST__requi__2A212E2C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__requi__7F21C18E]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]'))
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__requi__7F21C18E] FOREIGN KEY([requisitoId])
REFERENCES [dbo].[RGN_REQUISITOS] ([requisitoId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO] CHECK CONSTRAINT [FK__RGN_AJUST__requi__7F21C18E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUSTE_RGN_R__292D09F3]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]'))
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUSTE_RGN_R__292D09F3] FOREIGN KEY([solicitudDocumentosId], [ajusteId])
REFERENCES [dbo].[RGN_SOLICITUDDOCUMENTOS] ([solicitudDocumentosId], [ajusteId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO] CHECK CONSTRAINT [FK__RGN_AJUSTE_RGN_R__292D09F3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUSTE_RGN_R__7E2D9D55]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]'))
ALTER TABLE [dbo].[RGN_AJUSTE_RGN_REQUERIMIENTO]  WITH CHECK ADD FOREIGN KEY([solicitudDocumentosId], [ajusteId])
REFERENCES [dbo].[RGN_SOLICITUDDOCUMENTOS] ([solicitudDocumentosId], [ajusteId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PERDI__ajust__03DB89B3]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PERDIDA]'))
ALTER TABLE [dbo].[RGN_PERDIDA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_PERDI__ajust__03DB89B3] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_PERDIDA] CHECK CONSTRAINT [FK__RGN_PERDI__ajust__03DB89B3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PERDI__ajust__1BBE003C]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PERDIDA]'))
ALTER TABLE [dbo].[RGN_PERDIDA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_PERDI__ajust__1BBE003C] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_PERDIDA] CHECK CONSTRAINT [FK__RGN_PERDI__ajust__1BBE003C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PERDI__moned__02E7657A]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PERDIDA]'))
ALTER TABLE [dbo].[RGN_PERDIDA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_PERDI__moned__02E7657A] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_PERDIDA] CHECK CONSTRAINT [FK__RGN_PERDI__moned__02E7657A]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PERDI__moned__1AC9DC03]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PERDIDA]'))
ALTER TABLE [dbo].[RGN_PERDIDA]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RESER__ajust__0E591826]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RESERVA]'))
ALTER TABLE [dbo].[RGN_RESERVA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RESER__ajust__0E591826] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_RESERVA] CHECK CONSTRAINT [FK__RGN_RESER__ajust__0E591826]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RESER__ajust__263B8EAF]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RESERVA]'))
ALTER TABLE [dbo].[RGN_RESERVA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RESER__ajust__263B8EAF] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_RESERVA] CHECK CONSTRAINT [FK__RGN_RESER__ajust__263B8EAF]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RESER__moned__0D64F3ED]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RESERVA]'))
ALTER TABLE [dbo].[RGN_RESERVA]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RESER__moned__0D64F3ED] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_RESERVA] CHECK CONSTRAINT [FK__RGN_RESER__moned__0D64F3ED]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RESER__moned__25476A76]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RESERVA]'))
ALTER TABLE [dbo].[RGN_RESERVA]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__ajust__104C4D90]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORMACIONRELEVANTE]'))
ALTER TABLE [dbo].[RGN_INFORMACIONRELEVANTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__ajust__104C4D90] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_INFORMACIONRELEVANTE] CHECK CONSTRAINT [FK__RGN_INFOR__ajust__104C4D90]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__ajust__7869D707]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORMACIONRELEVANTE]'))
ALTER TABLE [dbo].[RGN_INFORMACIONRELEVANTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__ajust__7869D707] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_INFORMACIONRELEVANTE] CHECK CONSTRAINT [FK__RGN_INFOR__ajust__7869D707]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMA__ajust__151102AD]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMA__ajust__151102AD] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE] CHECK CONSTRAINT [FK__RGN_ITEMA__ajust__151102AD]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMA__ajust__7D2E8C24]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMA__ajust__7D2E8C24] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE] CHECK CONSTRAINT [FK__RGN_ITEMA__ajust__7D2E8C24]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMASEGURAD__160526E6]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMASEGURAD__160526E6] FOREIGN KEY([itemAseguradosId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_ITEMASEGURADO] ([itemAseguradosId], [polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE] CHECK CONSTRAINT [FK__RGN_ITEMASEGURAD__160526E6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ITEMASEGURAD__7E22B05D]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ITEMASEGURADO_AJUSTE]'))
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ITEMASEGURAD__7E22B05D] FOREIGN KEY([itemAseguradosId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_ITEMASEGURADO] ([itemAseguradosId], [polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_ITEMASEGURADO_AJUSTE] CHECK CONSTRAINT [FK__RGN_ITEMASEGURAD__7E22B05D]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ESTAD__ajust__0D6FE0E5]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOSAJUSTE]'))
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ESTAD__ajust__0D6FE0E5] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE] CHECK CONSTRAINT [FK__RGN_ESTAD__ajust__0D6FE0E5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ESTAD__ajust__758D6A5C]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOSAJUSTE]'))
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ESTAD__ajust__758D6A5C] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE] CHECK CONSTRAINT [FK__RGN_ESTAD__ajust__758D6A5C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ESTAD__estad__0C7BBCAC]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOSAJUSTE]'))
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE]  WITH CHECK ADD FOREIGN KEY([estadoajusteid])
REFERENCES [dbo].[RGN_ESTADOAJUSTE] ([estadoajusteid])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ESTAD__estad__74994623]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ESTADOSAJUSTE]'))
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ESTAD__estad__74994623] FOREIGN KEY([estadoajusteid])
REFERENCES [dbo].[RGN_ESTADOAJUSTE] ([estadoajusteid])
GO
ALTER TABLE [dbo].[RGN_ESTADOSAJUSTE] CHECK CONSTRAINT [FK__RGN_ESTAD__estad__74994623]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_EQUIP__ajust__0B879873]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_EQUIPO]'))
ALTER TABLE [dbo].[RGN_EQUIPO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_EQUIP__ajust__0B879873] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_EQUIPO] CHECK CONSTRAINT [FK__RGN_EQUIP__ajust__0B879873]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_EQUIP__ajust__73A521EA]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_EQUIPO]'))
ALTER TABLE [dbo].[RGN_EQUIPO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_EQUIP__ajust__73A521EA] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_EQUIPO] CHECK CONSTRAINT [FK__RGN_EQUIP__ajust__73A521EA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_GASTO__ajust__0F582957]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_GASTO]'))
ALTER TABLE [dbo].[RGN_GASTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_GASTO__ajust__0F582957] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_GASTO] CHECK CONSTRAINT [FK__RGN_GASTO__ajust__0F582957]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_GASTO__ajust__7775B2CE]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_GASTO]'))
ALTER TABLE [dbo].[RGN_GASTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_GASTO__ajust__7775B2CE] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_GASTO] CHECK CONSTRAINT [FK__RGN_GASTO__ajust__7775B2CE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_GASTO__moned__0E64051E]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_GASTO]'))
ALTER TABLE [dbo].[RGN_GASTO]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_GASTO__moned__76818E95]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_GASTO]'))
ALTER TABLE [dbo].[RGN_GASTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_GASTO__moned__76818E95] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_GASTO] CHECK CONSTRAINT [FK__RGN_GASTO__moned__76818E95]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SOLIC__ajust__2838E5BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SOLICITUDDOCUMENTOS]'))
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SOLIC__ajust__2838E5BA] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS] CHECK CONSTRAINT [FK__RGN_SOLIC__ajust__2838E5BA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SOLIC__ajust__2917FB5A]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SOLICITUDDOCUMENTOS]'))
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SOLIC__ajust__2917FB5A] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS] CHECK CONSTRAINT [FK__RGN_SOLIC__ajust__2917FB5A]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SOLIC__ajust__6AE5BEB7]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SOLICITUDDOCUMENTOS]'))
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SOLIC__ajust__6AE5BEB7] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_SOLICITUDDOCUMENTOS] CHECK CONSTRAINT [FK__RGN_SOLIC__ajust__6AE5BEB7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SECCI__ajust__272FB2E8]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SECCIONESAJUSTE]'))
ALTER TABLE [dbo].[RGN_SECCIONESAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SECCI__ajust__272FB2E8] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_SECCIONESAJUSTE] CHECK CONSTRAINT [FK__RGN_SECCI__ajust__272FB2E8]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_SECCI__ajust__2744C181]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_SECCIONESAJUSTE]'))
ALTER TABLE [dbo].[RGN_SECCIONESAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_SECCI__ajust__2744C181] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_SECCIONESAJUSTE] CHECK CONSTRAINT [FK__RGN_SECCI__ajust__2744C181]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ANEXO__ajust__0015E5C7]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ANEXO]'))
ALTER TABLE [dbo].[RGN_ANEXO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ANEXO__ajust__0015E5C7] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ANEXO] CHECK CONSTRAINT [FK__RGN_ANEXO__ajust__0015E5C7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ANEXO__ajust__673F4B05]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ANEXO]'))
ALTER TABLE [dbo].[RGN_ANEXO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ANEXO__ajust__673F4B05] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ANEXO] CHECK CONSTRAINT [FK__RGN_ANEXO__ajust__673F4B05]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_COMUN__ajust__07B7078F]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_COMUNICACION]'))
ALTER TABLE [dbo].[RGN_COMUNICACION]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_COMUN__ajust__07B7078F] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_COMUNICACION] CHECK CONSTRAINT [FK__RGN_COMUN__ajust__07B7078F]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_COMUN__ajust__6FD49106]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_COMUNICACION]'))
ALTER TABLE [dbo].[RGN_COMUNICACION]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_COMUN__ajust__6FD49106] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_COMUNICACION] CHECK CONSTRAINT [FK__RGN_COMUN__ajust__6FD49106]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_COMUN__tcomu__06C2E356]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_COMUNICACION]'))
ALTER TABLE [dbo].[RGN_COMUNICACION]  WITH CHECK ADD FOREIGN KEY([tcomunicacionId])
REFERENCES [dbo].[RGN_TIPOCOMUNICACION] ([tcomunicacionId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_COMUN__tcomu__6EE06CCD]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_COMUNICACION]'))
ALTER TABLE [dbo].[RGN_COMUNICACION]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_COMUN__tcomu__6EE06CCD] FOREIGN KEY([tcomunicacionId])
REFERENCES [dbo].[RGN_TIPOCOMUNICACION] ([tcomunicacionId])
GO
ALTER TABLE [dbo].[RGN_COMUNICACION] CHECK CONSTRAINT [FK__RGN_COMUN__tcomu__6EE06CCD]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__ajust__6462DE5A]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__ajust__6462DE5A] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS] CHECK CONSTRAINT [FK__RGN_AJUST__ajust__6462DE5A]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUST__ajust__7D39791C]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUST__ajust__7D39791C] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS] CHECK CONSTRAINT [FK__RGN_AJUST__ajust__7D39791C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUSTE_CLAUS__636EBA21]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_AJUSTE_CLAUS__636EBA21] FOREIGN KEY([clausulasId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_CLAUSULAS] ([clausulasId], [polizaId], [aseguradoraId])
GO
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS] CHECK CONSTRAINT [FK__RGN_AJUSTE_CLAUS__636EBA21]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_AJUSTE_CLAUS__7C4554E3]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_AJUSTE_CLAUSULAS]'))
ALTER TABLE [dbo].[RGN_AJUSTE_CLAUSULAS]  WITH CHECK ADD FOREIGN KEY([clausulasId], [polizaId], [aseguradoraId])
REFERENCES [dbo].[RGN_CLAUSULAS] ([clausulasId], [polizaId], [aseguradoraId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ADELA__ajust__5CC1BC92]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ADELANTO]'))
ALTER TABLE [dbo].[RGN_ADELANTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ADELA__ajust__5CC1BC92] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ADELANTO] CHECK CONSTRAINT [FK__RGN_ADELA__ajust__5CC1BC92]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ADELA__ajust__75985754]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ADELANTO]'))
ALTER TABLE [dbo].[RGN_ADELANTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ADELA__ajust__75985754] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ADELANTO] CHECK CONSTRAINT [FK__RGN_ADELA__ajust__75985754]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ADELA__moned__5BCD9859]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ADELANTO]'))
ALTER TABLE [dbo].[RGN_ADELANTO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ADELA__moned__5BCD9859] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_ADELANTO] CHECK CONSTRAINT [FK__RGN_ADELA__moned__5BCD9859]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ADELA__moned__74A4331B]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ADELANTO]'))
ALTER TABLE [dbo].[RGN_ADELANTO]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RECLA__ajust__0C70CFB4]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RECLAMO]'))
ALTER TABLE [dbo].[RGN_RECLAMO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RECLA__ajust__0C70CFB4] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_RECLAMO] CHECK CONSTRAINT [FK__RGN_RECLA__ajust__0C70CFB4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RECLA__ajust__2453463D]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RECLAMO]'))
ALTER TABLE [dbo].[RGN_RECLAMO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RECLA__ajust__2453463D] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_RECLAMO] CHECK CONSTRAINT [FK__RGN_RECLA__ajust__2453463D]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RECLA__moned__0B7CAB7B]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RECLAMO]'))
ALTER TABLE [dbo].[RGN_RECLAMO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_RECLA__moned__0B7CAB7B] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_RECLAMO] CHECK CONSTRAINT [FK__RGN_RECLA__moned__0B7CAB7B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_RECLA__moned__235F2204]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_RECLAMO]'))
ALTER TABLE [dbo].[RGN_RECLAMO]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RGN_CONVENIOAJUSTE_RGN_AJUSTE]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONVENIOAJUSTE]'))
ALTER TABLE [dbo].[RGN_CONVENIOAJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK_RGN_CONVENIOAJUSTE_RGN_AJUSTE] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_CONVENIOAJUSTE] CHECK CONSTRAINT [FK_RGN_CONVENIOAJUSTE_RGN_AJUSTE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_BIENA__ajust__04DA9AE4]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_BIENAFECTADO]'))
ALTER TABLE [dbo].[RGN_BIENAFECTADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_BIENA__ajust__04DA9AE4] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_BIENAFECTADO] CHECK CONSTRAINT [FK__RGN_BIENA__ajust__04DA9AE4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_BIENA__ajust__6CF8245B]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_BIENAFECTADO]'))
ALTER TABLE [dbo].[RGN_BIENAFECTADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_BIENA__ajust__6CF8245B] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_BIENAFECTADO] CHECK CONSTRAINT [FK__RGN_BIENA__ajust__6CF8245B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_BIENA__moned__03E676AB]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_BIENAFECTADO]'))
ALTER TABLE [dbo].[RGN_BIENAFECTADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_BIENA__moned__03E676AB] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_BIENAFECTADO] CHECK CONSTRAINT [FK__RGN_BIENA__moned__03E676AB]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_BIENA__moned__6C040022]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_BIENAFECTADO]'))
ALTER TABLE [dbo].[RGN_BIENAFECTADO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_BIENA__moned__6C040022] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[RGN_BIENAFECTADO] CHECK CONSTRAINT [FK__RGN_BIENA__moned__6C040022]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__ajust__12349602]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORME]'))
ALTER TABLE [dbo].[RGN_INFORME]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__ajust__12349602] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_INFORME] CHECK CONSTRAINT [FK__RGN_INFOR__ajust__12349602]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__ajust__7A521F79]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORME]'))
ALTER TABLE [dbo].[RGN_INFORME]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__ajust__7A521F79] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_INFORME] CHECK CONSTRAINT [FK__RGN_INFOR__ajust__7A521F79]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__tinfo__114071C9]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORME]'))
ALTER TABLE [dbo].[RGN_INFORME]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__tinfo__114071C9] FOREIGN KEY([tinformeId])
REFERENCES [dbo].[RGN_TINFORME] ([tinformeId])
GO
ALTER TABLE [dbo].[RGN_INFORME] CHECK CONSTRAINT [FK__RGN_INFOR__tinfo__114071C9]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_INFOR__tinfo__795DFB40]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_INFORME]'))
ALTER TABLE [dbo].[RGN_INFORME]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_INFOR__tinfo__795DFB40] FOREIGN KEY([tinformeId])
REFERENCES [dbo].[RGN_TINFORME] ([tinformeId])
GO
ALTER TABLE [dbo].[RGN_INFORME] CHECK CONSTRAINT [FK__RGN_INFOR__tinfo__795DFB40]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ACTIV__ajust__5AD97420]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ACTIVIDAD]'))
ALTER TABLE [dbo].[RGN_ACTIVIDAD]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ACTIV__ajust__5AD97420] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ACTIVIDAD] CHECK CONSTRAINT [FK__RGN_ACTIV__ajust__5AD97420]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ACTIV__ajust__73B00EE2]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ACTIVIDAD]'))
ALTER TABLE [dbo].[RGN_ACTIVIDAD]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ACTIV__ajust__73B00EE2] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_ACTIVIDAD] CHECK CONSTRAINT [FK__RGN_ACTIV__ajust__73B00EE2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ACTIV__tipoA__58F12BAE]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ACTIVIDAD]'))
ALTER TABLE [dbo].[RGN_ACTIVIDAD]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_ACTIV__tipoA__58F12BAE] FOREIGN KEY([tipoActividadId])
REFERENCES [dbo].[RGN_TIPOACTIVIDAD] ([tipoActividadId])
GO
ALTER TABLE [dbo].[RGN_ACTIVIDAD] CHECK CONSTRAINT [FK__RGN_ACTIV__tipoA__58F12BAE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_ACTIV__tipoA__71C7C670]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_ACTIVIDAD]'))
ALTER TABLE [dbo].[RGN_ACTIVIDAD]  WITH CHECK ADD FOREIGN KEY([tipoActividadId])
REFERENCES [dbo].[RGN_TIPOACTIVIDAD] ([tipoActividadId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONTA__ajust__099F5001]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONTACTOS_AJUSTE]'))
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CONTA__ajust__099F5001] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE] CHECK CONSTRAINT [FK__RGN_CONTA__ajust__099F5001]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONTA__ajust__71BCD978]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONTACTOS_AJUSTE]'))
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CONTA__ajust__71BCD978] FOREIGN KEY([ajusteId])
REFERENCES [dbo].[RGN_AJUSTE] ([ajusteId])
GO
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE] CHECK CONSTRAINT [FK__RGN_CONTA__ajust__71BCD978]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONTA__tipoC__0A93743A]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONTACTOS_AJUSTE]'))
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE]  WITH CHECK ADD FOREIGN KEY([tipoContactoId])
REFERENCES [dbo].[RGN_TIPOCONTACTO] ([tipoContactoId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONTA__tipoC__72B0FDB1]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONTACTOS_AJUSTE]'))
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CONTA__tipoC__72B0FDB1] FOREIGN KEY([tipoContactoId])
REFERENCES [dbo].[RGN_TIPOCONTACTO] ([tipoContactoId])
GO
ALTER TABLE [dbo].[RGN_CONTACTOS_AJUSTE] CHECK CONSTRAINT [FK__RGN_CONTA__tipoC__72B0FDB1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__parra__01F34141]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_RIESGO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO]  WITH CHECK ADD FOREIGN KEY([parrafoId])
REFERENCES [dbo].[RGN_PARRAFO] ([parrafoId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__parra__19D5B7CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_RIESGO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO]  WITH CHECK ADD FOREIGN KEY([parrafoId])
REFERENCES [dbo].[RGN_PARRAFO] ([parrafoId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__riesg__00FF1D08]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_RIESGO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_PARRA__riesg__00FF1D08] FOREIGN KEY([riesgoId])
REFERENCES [dbo].[RGN_RIESGO_COBERTURA] ([riesgoId])
GO
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO] CHECK CONSTRAINT [FK__RGN_PARRA__riesg__00FF1D08]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_PARRA__riesg__18E19391]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_PARRAFO_RIESGO]'))
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_PARRA__riesg__18E19391] FOREIGN KEY([riesgoId])
REFERENCES [dbo].[RGN_RIESGO_COBERTURA] ([riesgoId])
GO
ALTER TABLE [dbo].[RGN_PARRAFO_RIESGO] CHECK CONSTRAINT [FK__RGN_PARRA__riesg__18E19391]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_TIPOC__moned__57FD0775]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_TIPOCAMBIO]'))
ALTER TABLE [dbo].[ADM_TIPOCAMBIO]  WITH NOCHECK ADD  CONSTRAINT [FK__ADM_TIPOC__moned__57FD0775] FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
ALTER TABLE [dbo].[ADM_TIPOCAMBIO] CHECK CONSTRAINT [FK__ADM_TIPOC__moned__57FD0775]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ADM_TIPOC__moned__70D3A237]') AND parent_object_id = OBJECT_ID(N'[dbo].[ADM_TIPOCAMBIO]'))
ALTER TABLE [dbo].[ADM_TIPOCAMBIO]  WITH CHECK ADD FOREIGN KEY([monedaId])
REFERENCES [dbo].[ADM_MONEDA] ([monedaId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_MODUL__appId__1411F17C]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_MODULO]'))
ALTER TABLE [dbo].[SYS_MODULO]  WITH CHECK ADD FOREIGN KEY([appId])
REFERENCES [dbo].[SYS_APP] ([appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_MODUL__appId__2CE88C3E]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_MODULO]'))
ALTER TABLE [dbo].[SYS_MODULO]  WITH CHECK ADD FOREIGN KEY([appId])
REFERENCES [dbo].[SYS_APP] ([appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_MODUL__appId__5DC0CDC3]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_MODULO]'))
ALTER TABLE [dbo].[SYS_MODULO]  WITH CHECK ADD FOREIGN KEY([appId])
REFERENCES [dbo].[SYS_APP] ([appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_FUNCIONALIDA__131DCD43]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_FUNCIONALIDAD]'))
ALTER TABLE [dbo].[SYS_FUNCIONALIDAD]  WITH NOCHECK ADD  CONSTRAINT [FK__SYS_FUNCIONALIDA__131DCD43] FOREIGN KEY([moduloId], [appId])
REFERENCES [dbo].[SYS_MODULO] ([moduloId], [appId])
GO
ALTER TABLE [dbo].[SYS_FUNCIONALIDAD] CHECK CONSTRAINT [FK__SYS_FUNCIONALIDA__131DCD43]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_FUNCIONALIDA__2BF46805]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_FUNCIONALIDAD]'))
ALTER TABLE [dbo].[SYS_FUNCIONALIDAD]  WITH CHECK ADD FOREIGN KEY([moduloId], [appId])
REFERENCES [dbo].[SYS_MODULO] ([moduloId], [appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_FUNCIONALIDA__5CCCA98A]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_FUNCIONALIDAD]'))
ALTER TABLE [dbo].[SYS_FUNCIONALIDAD]  WITH CHECK ADD FOREIGN KEY([moduloId], [appId])
REFERENCES [dbo].[SYS_MODULO] ([moduloId], [appId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__rolId__15FA39EE]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__rolId__2ED0D4B0]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__rolId__5FA91635]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[SYS_ROL] ([rolId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__usuar__150615B5]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[SYS_USUARIO] ([usuarioId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__usuar__2DDCB077]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[SYS_USUARIO] ([usuarioId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SYS_ROLUS__usuar__5EB4F1FC]') AND parent_object_id = OBJECT_ID(N'[dbo].[SYS_ROLUSUARIO]'))
ALTER TABLE [dbo].[SYS_ROLUSUARIO]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[SYS_USUARIO] ([usuarioId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONDI__ramoI__08AB2BC8]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONDICIONES]'))
ALTER TABLE [dbo].[RGN_CONDICIONES]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CONDI__ramoI__08AB2BC8] FOREIGN KEY([ramoId])
REFERENCES [dbo].[RGN_RAMO] ([ramoId])
GO
ALTER TABLE [dbo].[RGN_CONDICIONES] CHECK CONSTRAINT [FK__RGN_CONDI__ramoI__08AB2BC8]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__RGN_CONDI__ramoI__70C8B53F]') AND parent_object_id = OBJECT_ID(N'[dbo].[RGN_CONDICIONES]'))
ALTER TABLE [dbo].[RGN_CONDICIONES]  WITH NOCHECK ADD  CONSTRAINT [FK__RGN_CONDI__ramoI__70C8B53F] FOREIGN KEY([ramoId])
REFERENCES [dbo].[RGN_RAMO] ([ramoId])
GO
ALTER TABLE [dbo].[RGN_CONDICIONES] CHECK CONSTRAINT [FK__RGN_CONDI__ramoI__70C8B53F]
