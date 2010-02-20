using System;
using System.Collections.Generic;
using System.Web;

namespace App_Code.RimacInforme.Domain
{

    public class InformacionAsegurado
    {
        private string _contratante;
        public string Contratante
        {
            get { return _contratante; }
            set { _contratante = value; }
        }

        private string _asegurado;
        public string Asegurado
        {
            get { return _asegurado; }
            set { _asegurado = value; }
        }

        
        private string _broker;
        public String Broker
        {
            get { return _broker; }
            set { _broker = value; }
        }

        private string _ejecutivoBroker;
        public String EjecutivoBroker
        {
            get { return _ejecutivoBroker; }
            set { _ejecutivoBroker = value; }
        }
    }
}