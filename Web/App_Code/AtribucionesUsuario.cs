using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace RGen.Utiles
{
    /// <summary>
    /// Summary description for atribucionesUsuario
    /// </summary>
    public class AtribucionesUsuario
    {

      
        private String usuarioCreadorId = null;
        public String UsuarioCreadorId
        {
            get { return usuarioCreadorId; }
            set { usuarioCreadorId = value; }
        }

        private String usuario;
        public String Usuario
        {
            get { return usuario; }
            set { usuario = value; }
        }
        private String tipoUsuario;
        public String TipoUsuario
        {
            get { return tipoUsuario; }
            set { tipoUsuario = value;}
        }
        private String tipoUsuarioCreador;
        public String TipoUsuarioCreador
        {
            get { return tipoUsuarioCreador; }
            set { tipoUsuarioCreador = value; }
        }
        private String userId;
        public String UserId
        {
            get { return userId; }
            set { userId = value; }
        }
        private String userName;
        public String UserName
        {
          get { return userName; }
          set { userName = value; }
        }
        private ListItemCollection propiedades;

        public AtribucionesUsuario(string usuario,string TipoUsuario,string UserId)
        {
            this.usuario = usuario;
            this.tipoUsuario = TipoUsuario;
            this.userId = UserId;

            propiedades = new ListItemCollection();
        }
        public void setTipoUsuario(string tipoUsuario)
        {
            this.tipoUsuario = tipoUsuario;
        }
        
        public void addAtributos(string key, string value)
        {
            ListItem myActualItem = new ListItem(key, value);
            propiedades.Add(myActualItem);
        }
        public Boolean verificaAtributoConValor(string keyToFind, string valueToCompare)
        {
            Boolean hubo = false;
            ListItem myTempItem = propiedades.FindByText(keyToFind);
            if (myTempItem == null)
            {
                hubo = false;
            }
            else
            {
                hubo = (myTempItem.Value == valueToCompare);
            }
            return hubo;
        }
        public Boolean verificaAtributo(string keyToFind)
        {
            Boolean hubo = false;
            ListItem myTempItem = propiedades.FindByText(keyToFind);
            if (myTempItem != null)
            {
                hubo = true;
            }            
            return hubo;
        }
    }

}