using System;
using R3M.Common;

namespace App_Code.RimacInforme.Domain
{

    public class InformacionAsegurado
    {
        private string _contratante;
        public string Contratante
        {
            get { return _contratante; }
            set { _contratante = Util.XDefault(value, String.Empty); }
        }

        private string _asegurado;
        public string Asegurado
        {
            get { return _asegurado; }
            set { _asegurado = Util.XDefault(value, String.Empty); ; }
        }


        private string _broker;
        public String Broker
        {
            get { return _broker; }
            set { _broker = Util.XDefault(value, String.Empty); ; }
        }

        private string _ejecutivoBroker;
        public String EjecutivoBroker
        {
            get { return _ejecutivoBroker; }
            set { _ejecutivoBroker = Util.XDefault(value, String.Empty); ; }
        }
    }
}