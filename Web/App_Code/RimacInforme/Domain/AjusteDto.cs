using System;
using System.Collections.Generic;

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
            set { _ajusteId = value; }
        }

        public AjusteDto()
        {
            this.Poliza = new Poliza();
            this.InfoAsegurado = new InformacionAsegurado();
            this.Recepcion = new RecepcionCaso();
            this.InfoInspeccion = new InfoInspeccion();
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
            set { _giroNegocio = value; }
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
                _fechaYHoraSiniestro = value;
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
                _lugarDeSiniestro = value;
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
                _descripcionSiniestro = value;
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
                _ocurrencia = value;
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
                _situacionSiniestro = value;
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
                _monedaReclamoSimbolo = value;
            }
        }

        private decimal _reservaMonedaId;

        public decimal ReservaMonedaId
        {
            get { return _reservaMonedaId; }
            set { _reservaMonedaId = value; }
        }
        private decimal _reclamoMonedaId;

        public decimal ReclamoMonedaId
        {
            get { return _reclamoMonedaId; }
            set { _reclamoMonedaId = value; }
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
                _monedaReservaSimbolo = value;
            }
        }

        private decimal _reclamo;
        public decimal Reclamo
        {
            get { return _reclamo; }
            set { _reclamo = value; }
        }

        private decimal _reserva;
        public decimal Reserva
        {
            get { return _reserva; }
            set { _reserva = value; }
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
                _enviarCopiaPoliza = value;
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
                _enviaNumeroSiniestro = value;
            }
        }

        private string _notas;
        public string Notas
        {
            get { return _notas; }
            set { _notas = value; }
        }







    }

    public class InfoInspeccion
    {
        private string _personaContacto;
        public String PersonaContacto
        {
            get { return _personaContacto; }
            set { _personaContacto = value; }
        }

        private DateTime? _fechaInspeccion;
        public DateTime? FechaInspeccion
        {
            get { return _fechaInspeccion; }
            set { _fechaInspeccion = value; }
        }

        private string _lugarInspeccion;
        public String LugarInspeccion
        {
            get { return _lugarInspeccion; }
            set { _lugarInspeccion = value; }
        }

        private string _personaEntrevistada;
        public String PersonaEntrevistada
        {
            get { return _personaEntrevistada; }
            set { _personaEntrevistada = value; }
        }

    }


    public class RecepcionCaso
    {
        private string _numeroAseguradora;
        public String NumeroAseguradora
        {
            get { return _numeroAseguradora; }
            set { _numeroAseguradora = value; }
        }
        private DateTime? _recepcion;
        public DateTime? Recepcion
        {
            get { return _recepcion; }
            set { _recepcion = value; }
        }
        private string _confirmadoCon;
        public String ConfirmadoCon
        {
            get { return _confirmadoCon; }
            set { _confirmadoCon = value; }
        }

        private string _ajustador;
        public String Ajustador
        {
            get { return _ajustador; }
            set { _ajustador = value; }
        }
    }


    public class Poliza
    {
        private decimal _idPoliza;
        public decimal IdPoliza
        {
            get { return _idPoliza; }
            set { _idPoliza = value; }
        }

        private string _polizaNumber;
        public String PolizaNumber
        {
            get { return _polizaNumber; }
            set { _polizaNumber = value; }
        }
        private string _vigencia;
        public String Vigencia
        {
            get { return _vigencia; }
            set { _vigencia = value; }
        }

        private string _tipo;
        public String Tipo
        {
            get { return _tipo; }
            set { _tipo = value; }
        }

        private string _ramo;
        public String Ramo
        {
            get { return _ramo; }
            set { _ramo = value; }
        }
    }
}