using System;
using System.Collections.Generic;
using System.Web;
using DataSet1TableAdapters;

namespace App_Code.RimacInforme.Persistence
{
    /// <summary>
    /// Summary description for BasicoOds
    /// </summary>
    /// 
    [System.ComponentModel.DataObject]
    public class AjusteDtoOds
    {
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public Domain.AjusteDto GetInformeBasicoByAjusteId(decimal ajusteId)
        {
            DataSet1TableAdapters.sp_rgen_datosgenerales_selectTableAdapter ta =
                new sp_rgen_datosgenerales_selectTableAdapter();

            DataSet1.sp_rgen_datosgenerales_selectDataTable dt = ta.GetData(ajusteId);

            Domain.AjusteDto ajusteDto = new Domain.AjusteDto();

            if (dt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosgenerales_selectRow row = dt.Rows[0] as DataSet1.sp_rgen_datosgenerales_selectRow;
                ajusteDto.AjusteId = ajusteId;
                ajusteDto.InfoAsegurado.Asegurado = row.asegurado;
                ajusteDto.InfoAsegurado.Broker = row.broker;
                ajusteDto.InfoAsegurado.Contratante = row.contratante;
                ajusteDto.InfoAsegurado.EjecutivoBroker = row.respbroker;
                ajusteDto.GiroNegocio = row.gruponegocio;
            }

            DataSet1TableAdapters.sp_rgen_polizaPrincipalRimacTableAdapter tp = new sp_rgen_polizaPrincipalRimacTableAdapter();
            DataSet1.sp_rgen_polizaPrincipalRimacDataTable dtP = tp.GetData(ajusteId);

            if (dtP.Rows.Count > 0)
            {
                DataSet1.sp_rgen_polizaPrincipalRimacRow polizaRow = dtP.Rows[0] as DataSet1.sp_rgen_polizaPrincipalRimacRow;
                ajusteDto.Poliza.IdPoliza = polizaRow.polizaId;
                ajusteDto.Poliza.PolizaNumber = polizaRow.numeroPoliza;
                ajusteDto.Poliza.Ramo = polizaRow.ramo;
                ajusteDto.Poliza.Tipo = polizaRow.producto;
                ajusteDto.Poliza.Vigencia = string.Format("{0:dd/MM/yyyy} - {1:dd/MM/yyyy}", polizaRow.finicio, polizaRow.ffin);
                //ajusteDto.Poliza.
            }

            DataSet1TableAdapters.sp_rgen_datosRecepcionCasoRimacTableAdapter tr = new sp_rgen_datosRecepcionCasoRimacTableAdapter();
            DataSet1.sp_rgen_datosRecepcionCasoRimacDataTable rdt = tr.GetData(ajusteId);
            if (rdt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosRecepcionCasoRimacRow recepcionRow = rdt.Rows[0] as DataSet1.sp_rgen_datosRecepcionCasoRimacRow;
                ajusteDto.Recepcion.NumeroAseguradora = recepcionRow.numeroSiniestroCia;
                ajusteDto.Recepcion.Recepcion = recepcionRow.FechayHoraConfirmacion;
                ajusteDto.Recepcion.ConfirmadoCon = recepcionRow.NombreQuienConfirma;
                ajusteDto.Recepcion.Ajustador = recepcionRow.ajustador;
            }

            DataSet1TableAdapters.sp_rgen_Ocurrencia_selectTableAdapter oTa = new sp_rgen_Ocurrencia_selectTableAdapter();
            DataSet1.sp_rgen_Ocurrencia_selectDataTable dto = oTa.GetData(ajusteId);
            if (dto.Rows.Count > 0)
            {
                DataSet1.sp_rgen_Ocurrencia_selectRow oRow = dto.Rows[0] as DataSet1.sp_rgen_Ocurrencia_selectRow;
                ajusteDto.FechaYHoraSiniestro = oRow.fsiniestro;
                ajusteDto.LugarDeSiniestro = String.Format("{0}, {1}", oRow.lugarsiniestro, oRow.ubigeosiniestro); //+ ", " + ;
                ajusteDto.DescripcionSiniestro = !oRow.IscausasNull() ? oRow.causas : "";
                ajusteDto.Ocurrencia = !oRow.IsdetalleNull() ? oRow.detalle : "";
            }

            DataSet1TableAdapters.sp_rgen_informacionInspeccionRimacTableAdapter oIPTa = new sp_rgen_informacionInspeccionRimacTableAdapter();
            DataSet1.sp_rgen_informacionInspeccionRimacDataTable dtIP = oIPTa.GetData(ajusteId);
            if (dtIP.Rows.Count > 0)
            {
                DataSet1.sp_rgen_informacionInspeccionRimacRow IIRow = dtIP.Rows[0] as DataSet1.sp_rgen_informacionInspeccionRimacRow;
                ajusteDto.InfoInspeccion.FechaInspeccion = IIRow.FechaHoraReunion;
                ajusteDto.InfoInspeccion.PersonaContacto = IIRow.IspersonaContactoNull() ? "" : IIRow.personaContacto;
                ajusteDto.InfoInspeccion.LugarInspeccion = IIRow.IslugarDeReunionNull() ? "" : IIRow.lugarDeReunion;
                ajusteDto.InfoInspeccion.PersonaEntrevistada = IIRow.IsPersonaEntrevistadaNull() ? "" : IIRow.PersonaEntrevistada;
            }

            DataSet1TableAdapters.proc_informebasicoReclamoRimacTableAdapter situacionActualTA = new proc_informebasicoReclamoRimacTableAdapter();
            DataSet1.proc_informebasicoReclamoRimacDataTable situacionActualDT = situacionActualTA.GetData(Convert.ToInt32(ajusteId));
            if (situacionActualDT.Rows.Count > 0)
            {
                DataSet1.proc_informebasicoReclamoRimacRow situacionActualRow = situacionActualDT.Rows[0] as DataSet1.proc_informebasicoReclamoRimacRow;
                ajusteDto.SituacionSiniestro = situacionActualRow.IssituacionajusteNull() ? "" : situacionActualRow.situacionajuste;
                ajusteDto.ReclamoMonedaId = situacionActualRow.reclamoMonedaId;
                ajusteDto.ReservaMonedaId = situacionActualRow.reservaMonedaId;
                ajusteDto.Reclamo = situacionActualRow.IsreclamoaseguradoNull() ? 0 : situacionActualRow.reclamoasegurado;
                ajusteDto.Reserva = situacionActualRow.IsreservaestimadaNull() ? 0 : situacionActualRow.reservaestimada;
                ajusteDto.Notas = situacionActualRow.IsnotasNull() ? "" : situacionActualRow.notas;
                ajusteDto.EnviarCopiaPoliza = situacionActualRow.IsenviarCopiaPolizaNull() ? false : Convert.ToBoolean(situacionActualRow.enviarCopiaPoliza);
                ajusteDto.EnviaNumeroSiniestro = situacionActualRow.IsenviarNumSiniestroNull() ? false : Convert.ToBoolean(situacionActualRow.enviarNumSiniestro);

            }



            return ajusteDto;
        }



        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Update)]
        public void Update(Domain.AjusteDto ajusteDto)
        {
            DataSet1TableAdapters.sp_rgen_datosgenerales_selectTableAdapter ta = new sp_rgen_datosgenerales_selectTableAdapter();

            DataSet1.sp_rgen_datosgenerales_selectDataTable dt = ta.GetData(ajusteDto.AjusteId);
            if (dt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosgenerales_selectRow row = dt.Rows[0] as DataSet1.sp_rgen_datosgenerales_selectRow;
                row.gruponegocio = ajusteDto.GiroNegocio;
                ta.Update(row);
            }

            DataSet1TableAdapters.sp_rgen_Ocurrencia_selectTableAdapter oTa = new sp_rgen_Ocurrencia_selectTableAdapter();

            DataSet1.sp_rgen_Ocurrencia_selectDataTable oDt = oTa.GetData(ajusteDto.AjusteId);
            if (oDt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_Ocurrencia_selectRow oRow = oDt.Rows[0] as DataSet1.sp_rgen_Ocurrencia_selectRow;
                oRow.detalle = ajusteDto.Ocurrencia;
                oRow.causas = ajusteDto.DescripcionSiniestro;
                oTa.Update(oRow);
            }

            DataSet1TableAdapters.proc_informebasicoReclamoRimacTableAdapter situacionActualTA = new proc_informebasicoReclamoRimacTableAdapter();

            DataSet1.proc_informebasicoReclamoRimacDataTable situacionActualDt = situacionActualTA.GetData(Convert.ToInt32(ajusteDto.AjusteId));

            if (situacionActualDt.Rows.Count > 0)
            {
                DataSet1.proc_informebasicoReclamoRimacRow situacionActualRow = situacionActualDt.Rows[0] as DataSet1.proc_informebasicoReclamoRimacRow;
                situacionActualRow.enviarCopiaPoliza = Convert.ToByte(((ajusteDto.EnviarCopiaPoliza != null && ajusteDto.EnviarCopiaPoliza.Value) ? 1 : 0));
                situacionActualRow.enviarNumSiniestro = Convert.ToByte(((ajusteDto.EnviaNumeroSiniestro != null && ajusteDto.EnviaNumeroSiniestro.Value) ? 1 : 0));
                situacionActualRow.notas = ajusteDto.Notas;
                situacionActualRow.situacionajuste = ajusteDto.SituacionSiniestro;
                situacionActualRow.reclamoMonedaId = ajusteDto.ReclamoMonedaId;
                situacionActualRow.reservaMonedaId = ajusteDto.ReservaMonedaId;
                situacionActualRow.reclamoasegurado = ajusteDto.Reclamo;
                situacionActualRow.reservaestimada = ajusteDto.Reserva;
                try
                {
                    situacionActualTA.Update(situacionActualRow);
                }
                catch (Exception ex)
                {
                    throw;
                }
            }


        }
    }
}