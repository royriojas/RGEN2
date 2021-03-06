/*
   Domingo, 21 de Febrero de 201001:52:42 a.m.
   User: 
   Server: PE-AVANTICA1
   Database: rgen2
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RGN_AJUSTE ADD
	NumeroIFB int NULL
GO
COMMIT

alter PROCEDURE sp_rgen_datosgenerales_ifb_select(@ajusteId numeric(8,0))
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
declare @numajuste varchar(30)
declare @numIFB int

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

SELECT  top 1 @brokerid=brokerId, @numajuste = numAjustePASA, @numIFB = NumeroIFB FROM dbo.RGN_AJUSTE where dbo.RGN_AJUSTE.ajusteid=@ajusteid

set @brokerid = isnull(@brokerid,0)
set @numIFB = isnull(@numIFB, 1)

if @numIFB <= 0
begin 
 set @numIFB = 1
end
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
 @brokerid as brokerid,
 @numajuste as numajuste,
 @numIFB as numeroIFB

END 



CREATE PROCEDURE sp_rgen_datosgenerales_ifb_update(
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
 @brokerid numeric(8,0),
 @numajuste varchar(30),
 @numeroIFB int
)
as

BEGIN
/*
update  dbo.ADM_ASEGURADO set  dbo.ADM_ASEGURADO.actividad=@GrupoNegocio,
				dbo.ADM_ASEGURADO.grupoEconomico=@Grupoeconomico
where   dbo.ADM_ASEGURADO.personaid=@aseguradoid
*/

update dbo.rgn_ajuste 
set  numAjustePASA = @numajuste,
	numeroIFB = @numeroIFB
where dbo.rgn_ajuste.ajusteId = @ajusteId;

update dbo.RGN_POLIZA 
set giroNegocio=@gruponegocio,
    grupoEconomico=@grupoEconomico			      
where  dbo.RGN_POLIZA.aseguradoId=@aseguradoid
 
END 



