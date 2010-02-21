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

update dbo.RGN_POLIZA set giroNegocio=@gruponegocio,
		    	  grupoEconomico=@grupoEconomico,
				      
where  dbo.RGN_POLIZA.aseguradoId=@aseguradoid
 
END 


