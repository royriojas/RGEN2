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
                    ajusteDto.NumeroIfb = row.IsnumeroIFBNull()? 0 : row.numeroIFB;
                    ajusteDto.NumeroAjuste = row.IsnumajusteNull() ? "" : row.numajuste; //RGen.GestorAjuste.dameNumeroAjuste(ajusteId);
                    ajusteDto.InfoAsegurado.Asegurado = row.IsaseguradoNull() ? "": row.asegurado;
                    ajusteDto.InfoAsegurado.Broker = row.IsbrokerNull() ? "" : row.broker;
                    ajusteDto.InfoAsegurado.Contratante = row.IscontratanteNull() ? "" : row.contratante;
                    ajusteDto.InfoAsegurado.EjecutivoBroker = row.IsrespbrokerNull() ? "" : row.respbroker;
                    ajusteDto.GiroNegocio = row.IsgruponegocioNull()? "" : row.gruponegocio;
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
                    ajusteDto.Poliza.PolizaNumber = polizaRow.IsnumeroPolizaNull() ? "" : polizaRow.numeroPoliza;
                    ajusteDto.Poliza.Ramo = polizaRow.IsramoNull() ? "" : polizaRow.ramo;
                    ajusteDto.Poliza.Tipo = polizaRow.IsproductoNull() ? "" : polizaRow.producto;
                    ajusteDto.Poliza.Vigencia = string.Format("{0:dd/MM/yyyy} - {1:dd/MM/yyyy}",
                                                                                      polizaRow.IsfinicioNull() ? default(DateTime?) : polizaRow.finicio, polizaRow.IsffinNull() ? default(DateTime?) : polizaRow.ffin);

                    ajusteDto.Poliza.Cobertura = polizaRow.IscoberturaNull() ? "" : polizaRow.cobertura;

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
                    ajusteDto.Recepcion.Recepcion = recepcionRow.IsFechayHoraConfirmacionNull() ?  default(DateTime?) : recepcionRow.FechayHoraConfirmacion;
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
                    ajusteDto.FechaYHoraSiniestro = oRow.IsfsiniestroNull() ?  default(DateTime?) : oRow.fsiniestro;
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
                    ajusteDto.MonedaReclamoSimbolo = situacionActualRow.IsmonedaReclamoNull() ? "" : situacionActualRow.monedaReclamo;
                    ajusteDto.MonedaReservaSimbolo = situacionActualRow.IsmonedaReservaNull() ? "" : situacionActualRow.monedaReserva;
                    ajusteDto.ReclamoMonedaId = situacionActualRow.reclamoMonedaId;
                    ajusteDto.ReservaMonedaId = situacionActualRow.reservaMonedaId;
                    ajusteDto.Reclamo = situacionActualRow.IsreclamoaseguradoNull() ? 0 : situacionActualRow.reclamoasegurado;
                    ajusteDto.Reserva = situacionActualRow.IsreservaestimadaNull() ? 0 : situacionActualRow.reservaestimada;
                    ajusteDto.Notas = situacionActualRow.IsnotasNull() ? "" : situacionActualRow.notas;
                    ajusteDto.EnviarCopiaPoliza = situacionActualRow.IsenviarCopiaPolizaNull() ? default(Boolean) : Convert.ToBoolean(situacionActualRow.enviarCopiaPoliza);
                    ajusteDto.EnviaNumeroSiniestro = situacionActualRow.IsenviarNumSiniestroNull() ? default(Boolean) : Convert.ToBoolean(situacionActualRow.enviarNumSiniestro);
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
                    ajusteDto.DescripcionDamage = informacionAjusteRow.IsdescripcionDamageNull() ? "" : informacionAjusteRow.descripcionDamage;
                    
                    ajusteDto.LocalAsegurado = informacionAjusteRow.IslocalAseguradoNull() ? "" : informacionAjusteRow.localAsegurado;
                    ajusteDto.MateriaAsegurada = informacionAjusteRow.IsmateriaAseguradaNull() ? "" : informacionAjusteRow.materiaAsegurada;
                    ajusteDto.Seccion = informacionAjusteRow.IsseccionNull() ? "" : informacionAjusteRow.seccion;
                }

            }

            sp_rgen_EmisionInformesRimacTableAdapter informacionReportesTA = new sp_rgen_EmisionInformesRimacTableAdapter();
            DataSet1.sp_rgen_EmisionInformesRimacDataTable informacionReportesDT = informacionReportesTA.GetData(Convert.ToInt32(ajusteId));

            if (informacionReportesDT.Rows.Count > 0)
            {

                DataSet1.sp_rgen_EmisionInformesRimacRow informacionReportesRow;

                for (int i = 0; i < informacionReportesDT.Rows.Count; i++)
                {

                    informacionReportesRow = informacionReportesDT.Rows[i] as DataSet1.sp_rgen_EmisionInformesRimacRow;

                    if (informacionReportesRow != null)
                    {

                        decimal tipoInforme = informacionReportesRow.tinformeId;

                        switch (Convert.ToInt32(tipoInforme))
                        {
                            case 15: ajusteDto.FechaEnvioIB = informacionReportesRow.fecha;
                                break;

                            case 17: ajusteDto.FechaEnvioIP = informacionReportesRow.fecha;
                                break;

                            case 21: ajusteDto.FechaEnvioIF = informacionReportesRow.fecha;
                                break;

                        }

                    }

                }
            }

            sp_rgen_ConvenioAjusteRimacTableAdapter convenioAjusteTA = new sp_rgen_ConvenioAjusteRimacTableAdapter();
            DataSet1.sp_rgen_ConvenioAjusteRimacDataTable convenioAjusteDT = convenioAjusteTA.GetData(Convert.ToInt32(ajusteId));

            if (convenioAjusteDT.Rows.Count > 0)
            {

                DataSet1.sp_rgen_ConvenioAjusteRimacRow convenioAjusteRow = convenioAjusteDT.Rows[0] as DataSet1.sp_rgen_ConvenioAjusteRimacRow;

                if (convenioAjusteRow != null)
                {
                
                    ajusteDto.InfoConvenioAjuste.FechaConvenio = convenioAjusteRow.IsfconvenioNull() ? default(DateTime?) : convenioAjusteRow.fconvenio;
                    ajusteDto.InfoConvenioAjuste.FechaRecepcionConvenioFirmado = convenioAjusteRow.IsfRecepcionConvenioFirmadoNull() ? default(DateTime?) : convenioAjusteRow.fRecepcionConvenioFirmado;
                    ajusteDto.InfoConvenioAjuste.TotalDeducible = convenioAjusteRow.IstotalDeducibleNull() ? default(decimal) : convenioAjusteRow.totalDeducible;
                    ajusteDto.InfoConvenioAjuste.TotalIndemnizacion = convenioAjusteRow.IstotalIndemnizacionNull() ? default(decimal) : convenioAjusteRow.totalIndemnizacion;
                    ajusteDto.InfoConvenioAjuste.TotalPerdida = convenioAjusteRow.IstotalPerdidaNull() ? default(decimal) : convenioAjusteRow.totalPerdida;

                }
            }


            sp_rgen_SublimitesAfectadosTableAdapter sumaAseguradaTA = new sp_rgen_SublimitesAfectadosTableAdapter();
            DataSet1.sp_rgen_SublimitesAfectadosDataTable sumaAseguradaDT = sumaAseguradaTA.GetData(Convert.ToInt32(ajusteId));

            if (sumaAseguradaDT.Rows.Count > 0)
            {

                DataSet1.sp_rgen_SublimitesAfectadosRow sumaAseguradaRow;
                decimal sumaAsegurada = 0;

                for (int i = 0; i < sumaAseguradaDT.Rows.Count; i++)
                {
                    sumaAseguradaRow = sumaAseguradaDT.Rows[i] as DataSet1.sp_rgen_SublimitesAfectadosRow;

                    if (sumaAseguradaRow != null)
                    {
                        if (sumaAseguradaRow.concepto == "Suma Asegurada")
                        {
                            sumaAsegurada += sumaAseguradaRow.monto;
                            ajusteDto.MonedaSumaAsegurada = sumaAseguradaRow.simbolo;

                        }
                        else if (sumaAseguradaRow.concepto2 == "Suma Asegurada")
                        {
                            sumaAsegurada +=  sumaAseguradaRow.montoAsegurado2;
                            ajusteDto.MonedaSumaAsegurada = sumaAseguradaRow.simbolo;
                        }
                    }
                }

                ajusteDto.SumaAsegurada = sumaAsegurada;
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
                DataSet1.proc_informacionAjusteRimacRow informacionAjusteRow = informacionAjusteDT.Rows[0] as DataSet1.proc_informacionAjusteRimacRow;

                if (informacionAjusteRow != null)
                {
                    if (ajusteDto.Antecedentes != null)
                        informacionAjusteRow.antecedentes = ajusteDto.Antecedentes;
                    if (ajusteDto.CausasSiniestro != null)
                        informacionAjusteRow.causasiniestro = ajusteDto.CausasSiniestro;
                    if (ajusteDto.DescripcionBienesAfectados != null)
                        informacionAjusteRow.descripcionBienesAfectados = ajusteDto.DescripcionBienesAfectados;

                    if (ajusteDto.DescripcionDamage != null)
                        informacionAjusteRow.descripcionDamage = ajusteDto.DescripcionDamage;

                    if (ajusteDto.DescripcionLugarSiniestro != null)
                        informacionAjusteRow.descripcionLugarSiniestro = ajusteDto.DescripcionLugarSiniestro;
                    if (ajusteDto.DescripcionReclamo != null)
                        informacionAjusteRow.descripcionReclamo = ajusteDto.DescripcionReclamo;
                    if (ajusteDto.DescripcionReserva != null)
                        informacionAjusteRow.descripcionReserva = ajusteDto.DescripcionReserva;
                    if (ajusteDto.DescripcionRiesgo != null)
                        informacionAjusteRow.descripcionRiesgo = ajusteDto.DescripcionRiesgo;
                    if (ajusteDto.Investigaciones != null)
                        informacionAjusteRow.investigaciones = ajusteDto.Investigaciones;
                    if (ajusteDto.Observaciones != null)
                        informacionAjusteRow.observaciones = ajusteDto.Observaciones;
                    if (ajusteDto.OpinionAjustador != null)
                        informacionAjusteRow.opinionAjustador = ajusteDto.OpinionAjustador;
                    if (ajusteDto.Recomendaciones != null)
                        informacionAjusteRow.recomendaciones = ajusteDto.Recomendaciones;
                    if (ajusteDto.Salvamentoyrecupero != null)
                        informacionAjusteRow.salvamentoyrecupero = ajusteDto.Salvamentoyrecupero;
                    if (ajusteDto.SiniestrosAnteriores != null)
                        informacionAjusteRow.siniestrosanteriores = ajusteDto.SiniestrosAnteriores;
                    if (ajusteDto.SituacionSiniestro != null)
                        informacionAjusteRow.situacionajuste = ajusteDto.SituacionSiniestro;
                    if (ajusteDto.VerificacionGarantias != null)
                        informacionAjusteRow.verificaciongarantias = ajusteDto.VerificacionGarantias;
                    if (ajusteDto.LocalAsegurado != null)
                        informacionAjusteRow.localAsegurado = ajusteDto.LocalAsegurado;
                    if (ajusteDto.MateriaAsegurada != null)
                        informacionAjusteRow.materiaAsegurada = ajusteDto.MateriaAsegurada;
                    if (ajusteDto.Seccion != null)
                        informacionAjusteRow.seccion = ajusteDto.Seccion;

                    informacionAjusteTA.Update(informacionAjusteRow);


                }
            }

        }
    }
}