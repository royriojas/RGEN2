using System;
using System.Collections.Generic;
using R3M.Common;

namespace App_Code.RimacInforme.Domain
{
    /// <summary>
    /// Summary description for IFBasico
    /// </summary>
    public class AjusteDto
    {
        private decimal _ajusteId;
        public decimal AjusteId
        {
            get { return _ajusteId; }
            set { _ajusteId = Util.XDefault(value, default(decimal)); }
        }

        private string _numeroAjuste;
        public string NumeroAjuste
        {
            get { return _numeroAjuste; }
            set { _numeroAjuste = Util.XDefault(value, String.Empty); }
        }

        public AjusteDto()
        {
            Poliza = new Poliza();
            InfoAsegurado = new InformacionAsegurado();
            Recepcion = new RecepcionCaso();
            InfoInspeccion = new InfoInspeccion();
        }

        private InformacionAsegurado _infoAsegurado;
        public InformacionAsegurado InfoAsegurado
        {
            get { return _infoAsegurado; }
            set { _infoAsegurado = value; }
        }

        private Poliza _poliza;
        public Poliza Poliza
        {
            get { return _poliza; }
            set { _poliza = value; }
        }

        private string _giroNegocio;
        public String GiroNegocio
        {
            get { return _giroNegocio; }
            set { _giroNegocio = Util.XDefault(value, String.Empty); }
        }

        private RecepcionCaso _recepcion;
        public RecepcionCaso Recepcion
        {
            get
            {
                return _recepcion;
            }
            set
            {
                _recepcion = value;
            }
        }

        private DateTime? _fechaYHoraSiniestro;
        public DateTime? FechaYHoraSiniestro
        {
            get
            {
                return _fechaYHoraSiniestro;
            }
            set
            {
                _fechaYHoraSiniestro = Util.XDefault<DateTime?>(value, null);
            }
        }

        private String _lugarDeSiniestro;
        public String LugarDeSiniestro
        {
            get
            {
                return _lugarDeSiniestro;
            }
            set
            {
                _lugarDeSiniestro = Util.XDefault(value, String.Empty); ;
            }
        }
        private string _descripcionSiniestro;
        public String DescripcionSiniestro
        {
            get
            {
                return _descripcionSiniestro;
            }
            set
            {
                _descripcionSiniestro = Util.XDefault(value, String.Empty); ;
            }
        }

        private string _ocurrencia;
        public String Ocurrencia
        {
            get
            {
                return _ocurrencia;
            }
            set
            {
                _ocurrencia = Util.XDefault(value, String.Empty); ;
            }
        }

        private InfoInspeccion _infoInspeccion;
        public InfoInspeccion InfoInspeccion
        {
            get { return _infoInspeccion; }
            set { _infoInspeccion = value; }
        }

        private String _situacionSiniestro;
        public String SituacionSiniestro
        {
            get
            {
                return _situacionSiniestro;
            }
            set
            {
                _situacionSiniestro = Util.XDefault(value, String.Empty); ;
            }
        }

        private String _monedaReclamoSimbolo;
        public String MonedaReclamoSimbolo
        {
            get
            {
                return _monedaReclamoSimbolo;
            }
            set
            {
                _monedaReclamoSimbolo = Util.XDefault(value, String.Empty); ;
            }
        }

        private decimal _reservaMonedaId;

        public decimal ReservaMonedaId
        {
            get { return _reservaMonedaId; }
            set { _reservaMonedaId = Util.XDefault(value, default(decimal)); ; }
        }
        private decimal _reclamoMonedaId;

        public decimal ReclamoMonedaId
        {
            get { return _reclamoMonedaId; }
            set { _reclamoMonedaId = Util.XDefault(value, default(decimal)); ; }
        }

        private String _monedaReservaSimbolo;
        public String MonedaReservaSimbolo
        {
            get
            {
                return _monedaReservaSimbolo;
            }
            set
            {
                _monedaReservaSimbolo = Util.XDefault(value, String.Empty); ;
            }
        }

        private decimal _reclamo;
        public decimal Reclamo
        {
            get { return _reclamo; }
            set { _reclamo = Util.XDefault(value, default(decimal)); ; }
        }

        private decimal _reserva;
        public decimal Reserva
        {
            get { return _reserva; }
            set { _reserva = Util.XDefault(value, default(decimal)); }
        }

        private bool? _enviarCopiaPoliza;
        public bool? EnviarCopiaPoliza
        {
            get
            {
                return _enviarCopiaPoliza;
            }
            set
            {
                _enviarCopiaPoliza = Util.XDefault(value, default(bool));
            }
        }
        private bool? _enviaNumeroSiniestro;
        public bool? EnviaNumeroSiniestro
        {
            get
            {
                return _enviaNumeroSiniestro;
            }
            set
            {
                _enviaNumeroSiniestro = Util.XDefault(value, default(bool));
            }
        }

        private string _notas;
        public string Notas
        {
            get { return _notas; }
            set { _notas = Util.XDefault(value, String.Empty); }
        }

        private int _numeroIfb;
        public int NumeroIfb
        {
            get { return _numeroIfb; }
            set { _numeroIfb = Util.XDefault(value, default(int)); }
        }

        private string _descripcionRiesgo;
        public string DescripcionRiesgo
        {
            get { return _descripcionRiesgo; }
            set { _descripcionRiesgo = Util.XDefault(value, String.Empty); }
        }

        private string _observaciones;
        public string Observaciones
        {
            get { return _observaciones; }
            set { _observaciones = Util.XDefault(value, String.Empty); }
        }

        private string _causasSiniestro;
        public string CausasSiniestro
        {
            get { return _causasSiniestro; }
            set { _causasSiniestro = Util.XDefault(value, String.Empty); }
        }

        private string _verificacionGarantias;
        public string VerificacionGarantias
        {
            get { return _verificacionGarantias; }
            set { _verificacionGarantias = Util.XDefault(value, String.Empty); }
        }

        private string _siniestrosAnteriores;
        public string SiniestrosAnteriores
        {
            get { return _siniestrosAnteriores; }
            set { _siniestrosAnteriores = Util.XDefault(value, String.Empty); }
        }

        private string _salvamentoyrecupero;
        public string Salvamentoyrecupero
        {
            get { return _salvamentoyrecupero; }
            set { _salvamentoyrecupero = Util.XDefault(value, String.Empty); }
        }

        private string _recomendaciones;
        public string Recomendaciones
        {
            get { return _recomendaciones; }
            set { _recomendaciones = Util.XDefault(value, String.Empty); }
        }

        private string _investigaciones;
        public string Investigaciones
        {
            get { return _investigaciones; }
            set { _investigaciones = Util.XDefault(value, String.Empty); }
        }

        private string _opinionAjustador;
        public string OpinionAjustador
        {
            get { return _opinionAjustador; }
            set { _opinionAjustador = Util.XDefault(value, String.Empty); }
        }

        private string _descripcionLugarSiniestro;
        public string DescripcionLugarSiniestro
        {
            get { return _descripcionLugarSiniestro; }
            set { _descripcionLugarSiniestro = Util.XDefault(value, String.Empty); }
        }

        private string _descripcionBienesAfectados;
        public string DescripcionBienesAfectados
        {
            get { return _descripcionBienesAfectados; }
            set { _descripcionBienesAfectados = Util.XDefault(value, String.Empty); }
        }

        private string _antecedentes;
        public string Antecedentes
        {
            get { return _antecedentes; }
            set { _antecedentes = Util.XDefault(value, String.Empty); }
        }

        private string _descripcionReclamo;
        public string DescripcionReclamo
        {
            get { return _descripcionReclamo; }
            set { _descripcionReclamo = Util.XDefault(value, String.Empty); }
        }

        private string _descripcionReserva;
        public string DescripcionReserva
        {
            get { return _descripcionReserva; }
            set { _descripcionReserva = Util.XDefault(value, String.Empty); }
        }
                
    }

    public class InfoInspeccion
    {
        private string _personaContacto;
        public String PersonaContacto
        {
            get { return _personaContacto; }
            set { _personaContacto = Util.XDefault(value, String.Empty); ; }
        }

        private DateTime? _fechaInspeccion;
        public DateTime? FechaInspeccion
        {
            get { return _fechaInspeccion; }
            set { _fechaInspeccion = Util.XDefault<DateTime?>(value, null); }
        }

        private string _lugarInspeccion;
        public String LugarInspeccion
        {
            get { return _lugarInspeccion; }
            set { _lugarInspeccion = Util.XDefault(value, String.Empty); ; }
        }

        private string _personaEntrevistada;
        public String PersonaEntrevistada
        {
            get { return _personaEntrevistada; }
            set { _personaEntrevistada = Util.XDefault(value, String.Empty); ; }
        }

    }


    public class RecepcionCaso
    {
        private string _numeroAseguradora;
        public String NumeroAseguradora
        {
            get { return _numeroAseguradora; }
            set { _numeroAseguradora = Util.XDefault(value, String.Empty); ; }
        }
        private DateTime? _recepcion;
        public DateTime? Recepcion
        {
            get { return _recepcion; }
            set { _recepcion = Util.XDefault<DateTime?>(value, null); }
        }
        private string _confirmadoCon;
        public String ConfirmadoCon
        {
            get { return _confirmadoCon; }
            set { _confirmadoCon = Util.XDefault(value, String.Empty); ; }
        }

        private string _ajustador;
        public String Ajustador
        {
            get { return _ajustador; }
            set { _ajustador = Util.XDefault(value, String.Empty); ; }
        }
    }


    public class Poliza
    {
        private decimal _idPoliza;
        public decimal IdPoliza
        {
            get { return _idPoliza; }
            set { _idPoliza = Util.XDefault(value, default(decimal)); }
        }

        private string _polizaNumber;
        public String PolizaNumber
        {
            get { return _polizaNumber; }
            set { _polizaNumber = Util.XDefault(value, String.Empty); ; }
        }
        private string _vigencia;
        public String Vigencia
        {
            get { return _vigencia; }
            set { _vigencia = Util.XDefault(value, String.Empty); ; }
        }

        private string _tipo;
        public String Tipo
        {
            get { return _tipo; }
            set { _tipo = Util.XDefault(value, String.Empty); ; }
        }

        private string _ramo;
        public String Ramo
        {
            get { return _ramo; }
            set { _ramo = Util.XDefault(value, String.Empty); ; }
        }

        private string _materiaAsegurada;
        public String MateriaAsegurada
        {
            get { return _materiaAsegurada; }
            set { _materiaAsegurada = Util.XDefault(value, String.Empty); ; }
        }

        private string _localAsegurado;
        public String LocalAsegurado
        {
            get { return _localAsegurado; }
            set { _localAsegurado = Util.XDefault(value, String.Empty); ; }
        }

        private string _seccion;
        public String Seccion
        {
            get { return _seccion; }
            set { _seccion = Util.XDefault(value, String.Empty); ; }
        }

    }
}