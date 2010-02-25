using System;
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
            sp_rgen_datosgenerales_selectTableAdapter ta =
                new sp_rgen_datosgenerales_selectTableAdapter();

            DataSet1.sp_rgen_datosgenerales_selectDataTable dt = ta.GetData(ajusteId);

            Domain.AjusteDto ajusteDto = new Domain.AjusteDto();

            if (dt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosgenerales_selectRow row = dt.Rows[0] as DataSet1.sp_rgen_datosgenerales_selectRow;
                ajusteDto.AjusteId = ajusteId;
                if (row != null)
                {
                    ajusteDto.NumeroIfb = row.numeroIFB;
                    ajusteDto.NumeroAjuste = row.numajuste; //RGen.GestorAjuste.dameNumeroAjuste(ajusteId);
                    ajusteDto.InfoAsegurado.Asegurado = row.asegurado;
                    ajusteDto.InfoAsegurado.Broker = row.broker;
                    ajusteDto.InfoAsegurado.Contratante = row.contratante;
                    ajusteDto.InfoAsegurado.EjecutivoBroker = row.respbroker;
                    ajusteDto.GiroNegocio = row.gruponegocio;
                }
            }

            sp_rgen_polizaPrincipalRimacTableAdapter tp = new sp_rgen_polizaPrincipalRimacTableAdapter();
            DataSet1.sp_rgen_polizaPrincipalRimacDataTable dtP = tp.GetData(ajusteId);

            if (dtP.Rows.Count > 0)
            {
                DataSet1.sp_rgen_polizaPrincipalRimacRow polizaRow = dtP.Rows[0] as DataSet1.sp_rgen_polizaPrincipalRimacRow;
                if (polizaRow != null)
                {
                    ajusteDto.Poliza.IdPoliza = polizaRow.polizaId;
                    ajusteDto.Poliza.PolizaNumber = polizaRow.numeroPoliza;
                    ajusteDto.Poliza.Ramo = polizaRow.ramo;
                    ajusteDto.Poliza.Tipo = polizaRow.producto;
                    ajusteDto.Poliza.Vigencia = string.Format("{0:dd/MM/yyyy} - {1:dd/MM/yyyy}",
                                                              polizaRow.IsfinicioNull() ? default(DateTime?) : polizaRow.finicio, polizaRow.IsffinNull() ? default(DateTime?) : polizaRow.ffin);
                }
                //ajusteDto.Poliza.
            }

            sp_rgen_datosRecepcionCasoRimacTableAdapter tr = new sp_rgen_datosRecepcionCasoRimacTableAdapter();
            DataSet1.sp_rgen_datosRecepcionCasoRimacDataTable rdt = tr.GetData(ajusteId);
            if (rdt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosRecepcionCasoRimacRow recepcionRow = rdt.Rows[0] as DataSet1.sp_rgen_datosRecepcionCasoRimacRow;
                if (recepcionRow != null)
                {
                    ajusteDto.Recepcion.NumeroAseguradora = recepcionRow.IsnumeroSiniestroCiaNull() ? "" : recepcionRow.numeroSiniestroCia;
                    ajusteDto.Recepcion.Recepcion = recepcionRow.FechayHoraConfirmacion;
                    ajusteDto.Recepcion.ConfirmadoCon = recepcionRow.IsNombreQuienConfirmaNull() ? "" : recepcionRow.NombreQuienConfirma;
                    ajusteDto.Recepcion.Ajustador = recepcionRow.IsajustadorNull() ? "" : recepcionRow.ajustador;
                }
            }

            sp_rgen_Ocurrencia_selectTableAdapter oTa = new sp_rgen_Ocurrencia_selectTableAdapter();
            DataSet1.sp_rgen_Ocurrencia_selectDataTable dto = oTa.GetData(ajusteId);
            if (dto.Rows.Count > 0)
            {
                DataSet1.sp_rgen_Ocurrencia_selectRow oRow = dto.Rows[0] as DataSet1.sp_rgen_Ocurrencia_selectRow;
                if (oRow != null)
                {
                    ajusteDto.FechaYHoraSiniestro = oRow.fsiniestro;
                    ajusteDto.LugarDeSiniestro = String.Format("{0}, {1}", oRow.lugarsiniestro, oRow.ubigeosiniestro); //+ ", " + ;
                    ajusteDto.DescripcionSiniestro = !oRow.IscausasNull() ? oRow.causas : "";
                    ajusteDto.Ocurrencia = !oRow.IsdetalleNull() ? oRow.detalle : "";
                }
            }

            sp_rgen_informacionInspeccionRimacTableAdapter oIPTa = new sp_rgen_informacionInspeccionRimacTableAdapter();
            DataSet1.sp_rgen_informacionInspeccionRimacDataTable dtIP = oIPTa.GetData(ajusteId);
            if (dtIP.Rows.Count > 0)
            {
                DataSet1.sp_rgen_informacionInspeccionRimacRow IIRow = dtIP.Rows[0] as DataSet1.sp_rgen_informacionInspeccionRimacRow;
                if (IIRow != null)
                {
                    ajusteDto.InfoInspeccion.FechaInspeccion = IIRow.FechaHoraReunion;
                    ajusteDto.InfoInspeccion.PersonaContacto = IIRow.IspersonaContactoNull() ? "" : IIRow.personaContacto;
                    ajusteDto.InfoInspeccion.LugarInspeccion = IIRow.IslugarDeReunionNull() ? "" : IIRow.lugarDeReunion;
                    ajusteDto.InfoInspeccion.PersonaEntrevistada = IIRow.IsPersonaEntrevistadaNull() ? "" : IIRow.PersonaEntrevistada;
                }
            }

            proc_informebasicoReclamoRimacTableAdapter situacionActualTA = new proc_informebasicoReclamoRimacTableAdapter();
            DataSet1.proc_informebasicoReclamoRimacDataTable situacionActualDT = situacionActualTA.GetData(Convert.ToInt32(ajusteId));
            if (situacionActualDT.Rows.Count > 0)
            {
                DataSet1.proc_informebasicoReclamoRimacRow situacionActualRow = situacionActualDT.Rows[0] as DataSet1.proc_informebasicoReclamoRimacRow;
                if (situacionActualRow != null)
                {
                    ajusteDto.SituacionSiniestro = situacionActualRow.IssituacionajusteNull() ? "" : situacionActualRow.situacionajuste;
                    ajusteDto.ReclamoMonedaId = situacionActualRow.reclamoMonedaId;
                    ajusteDto.ReservaMonedaId = situacionActualRow.reservaMonedaId;
                    ajusteDto.Reclamo = situacionActualRow.IsreclamoaseguradoNull() ? 0 : situacionActualRow.reclamoasegurado;
                    ajusteDto.Reserva = situacionActualRow.IsreservaestimadaNull() ? 0 : situacionActualRow.reservaestimada;
                    ajusteDto.Notas = situacionActualRow.IsnotasNull() ? "" : situacionActualRow.notas;
                    ajusteDto.EnviarCopiaPoliza = situacionActualRow.IsenviarCopiaPolizaNull() ? false : Convert.ToBoolean(situacionActualRow.enviarCopiaPoliza);
                    ajusteDto.EnviaNumeroSiniestro = situacionActualRow.IsenviarNumSiniestroNull() ? false : Convert.ToBoolean(situacionActualRow.enviarNumSiniestro);
                }
            }

            proc_informacionAjusteRimacTableAdapter informacionAjusteTA = new proc_informacionAjusteRimacTableAdapter();
            DataSet1.proc_informacionAjusteRimacDataTable informacionAjusteDT = informacionAjusteTA.GetData(Convert.ToInt32(ajusteId));

            if (informacionAjusteDT.Rows.Count > 0) 
            {
                DataSet1.proc_informacionAjusteRimacRow informacionAjusteRow = informacionAjusteDT.Rows[0] as DataSet1.proc_informacionAjusteRimacRow;
                if (informacionAjusteRow != null) 
                {

                    ajusteDto.Antecedentes = informacionAjusteRow.IsantecedentesNull() ? "" : informacionAjusteRow.antecedentes;
                    ajusteDto.CausasSiniestro = informacionAjusteRow.IscausasiniestroNull() ? "" : informacionAjusteRow.causasiniestro;
                    ajusteDto.DescripcionBienesAfectados = informacionAjusteRow.IsdescripcionBienesAfectadosNull() ? "" : informacionAjusteRow.descripcionBienesAfectados;
                    ajusteDto.DescripcionLugarSiniestro = informacionAjusteRow.IsdescripcionLugarSiniestroNull() ? "" : informacionAjusteRow.descripcionLugarSiniestro;
                    ajusteDto.DescripcionReclamo = informacionAjusteRow.IsdescripcionReclamoNull() ? "" : informacionAjusteRow.descripcionReclamo;
                    ajusteDto.DescripcionReserva = informacionAjusteRow.IsdescripcionReservaNull() ? "" : informacionAjusteRow.descripcionReserva;
                    ajusteDto.DescripcionRiesgo = informacionAjusteRow.IsdescripcionRiesgoNull() ? "" : informacionAjusteRow.descripcionRiesgo;
                    ajusteDto.Investigaciones = informacionAjusteRow.IsinvestigacionesNull() ? "" : informacionAjusteRow.investigaciones;
                    ajusteDto.Observaciones = informacionAjusteRow.IsobservacionesNull() ? "" : informacionAjusteRow.observaciones;
                    ajusteDto.OpinionAjustador = informacionAjusteRow.IsopinionAjustadorNull() ? "" : informacionAjusteRow.opinionAjustador;
                    ajusteDto.Recomendaciones = informacionAjusteRow.IsrecomendacionesNull() ? "" : informacionAjusteRow.recomendaciones;
                    ajusteDto.Salvamentoyrecupero = informacionAjusteRow.IssalvamentoyrecuperoNull() ? "" : informacionAjusteRow.salvamentoyrecupero;
                    ajusteDto.SiniestrosAnteriores = informacionAjusteRow.IssiniestrosanterioresNull() ? "" : informacionAjusteRow.siniestrosanteriores;
                    ajusteDto.SituacionSiniestro = informacionAjusteRow.IssituacionajusteNull() ? "" : informacionAjusteRow.situacionajuste;
                    ajusteDto.VerificacionGarantias = informacionAjusteRow.IsverificaciongarantiasNull() ? "" : informacionAjusteRow.verificaciongarantias;

                    ajusteDto.Poliza.LocalAsegurado = informacionAjusteRow.IslocalAseguradoNull() ? "" : informacionAjusteRow.localAsegurado;
                    ajusteDto.Poliza.MateriaAsegurada = informacionAjusteRow.IsmateriaAseguradaNull() ? "" : informacionAjusteRow.materiaAsegurada;
                    ajusteDto.Poliza.Seccion = informacionAjusteRow.IsseccionNull() ? "" : informacionAjusteRow.seccion;
                }

            }



            return ajusteDto;
        }



        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Update)]
        public void Update(Domain.AjusteDto ajusteDto)
        {
            sp_rgen_datosgenerales_selectTableAdapter ta = new sp_rgen_datosgenerales_selectTableAdapter();

            DataSet1.sp_rgen_datosgenerales_selectDataTable dt = ta.GetData(ajusteDto.AjusteId);
            if (dt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_datosgenerales_selectRow row = dt.Rows[0] as DataSet1.sp_rgen_datosgenerales_selectRow;
                if (row != null)
                {
                    row.numeroIFB = ajusteDto.NumeroIfb;
                    row.gruponegocio = ajusteDto.GiroNegocio;
                    ta.Update(row);
                }
            }

            sp_rgen_Ocurrencia_selectTableAdapter oTa = new sp_rgen_Ocurrencia_selectTableAdapter();

            DataSet1.sp_rgen_Ocurrencia_selectDataTable oDt = oTa.GetData(ajusteDto.AjusteId);
            if (oDt.Rows.Count > 0)
            {
                DataSet1.sp_rgen_Ocurrencia_selectRow oRow = oDt.Rows[0] as DataSet1.sp_rgen_Ocurrencia_selectRow;
                oRow.detalle = ajusteDto.Ocurrencia;
                oRow.causas = ajusteDto.DescripcionSiniestro;
                oTa.Update(oRow);
            }

            proc_informebasicoReclamoRimacTableAdapter situacionActualTA = new proc_informebasicoReclamoRimacTableAdapter();

            DataSet1.proc_informebasicoReclamoRimacDataTable situacionActualDt = situacionActualTA.GetData(Convert.ToInt32(ajusteDto.AjusteId));

            if (situacionActualDt.Rows.Count > 0)
            {
                DataSet1.proc_informebasicoReclamoRimacRow situacionActualRow = situacionActualDt.Rows[0] as DataSet1.proc_informebasicoReclamoRimacRow;
                if (situacionActualRow != null)
                {
                    situacionActualRow.enviarCopiaPoliza = Convert.ToByte(((ajusteDto.EnviarCopiaPoliza != null && ajusteDto.EnviarCopiaPoliza.Value) ? 1 : 0));
                    situacionActualRow.enviarNumSiniestro = Convert.ToByte(((ajusteDto.EnviaNumeroSiniestro != null && ajusteDto.EnviaNumeroSiniestro.Value) ? 1 : 0));
                    situacionActualRow.notas = ajusteDto.Notas;
                    situacionActualRow.situacionajuste = ajusteDto.SituacionSiniestro;
                    situacionActualRow.reclamoMonedaId = ajusteDto.ReclamoMonedaId;
                    situacionActualRow.reservaMonedaId = ajusteDto.ReservaMonedaId;
                    situacionActualRow.reclamoasegurado = ajusteDto.Reclamo;
                    situacionActualRow.reservaestimada = ajusteDto.Reserva;
                    situacionActualTA.Update(situacionActualRow);
                }
            }


            proc_informacionAjusteRimacTableAdapter informacionAjusteTA = new proc_informacionAjusteRimacTableAdapter();

            DataSet1.proc_informacionAjusteRimacDataTable informacionAjusteDT = informacionAjusteTA.GetData(Convert.ToInt32(ajusteDto.AjusteId));

            if (informacionAjusteDT.Rows.Count > 0)
            {
                DataSet1.proc_informacionAjusteRimacDataTable informacionAjusteRow = informacionAjusteDT.Rows[0] as DataSet1.proc_informacionAjusteRimacRow;

                if (informacionAjusteRow != null) 
                {
                    //informacionAjusteRow.antecedentesColumn = ajusteDto.Antecedentes;
                    
                }
            }

        }
    }
}