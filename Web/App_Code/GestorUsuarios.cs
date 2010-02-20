using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace RGen.Gestores
{
    /// <summary>
    /// Summary description for GestorUsuarios
    /// </summary>
    /// 
    public class GestorUsuarios
    {
        public GestorUsuarios()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static Boolean validaUsuario(String User, String Password,out RGen.Utiles.AtribucionesUsuario au)
        {
          
            dsUsuariosTableAdapters.UsuariosListaByNameAndPasswordTableAdapter usersTA = new dsUsuariosTableAdapters.UsuariosListaByNameAndPasswordTableAdapter();
            dsUsuarios.UsuariosListaByNameAndPasswordDataTable userTD = usersTA.UsuarioByNameAndPassword(User,Password);

            RGen.Utiles.AtribucionesUsuario sessioUsuario = null;

            if (userTD.Rows.Count > 0)
            {
                //existe el usuario
                dsUsuarios.UsuariosListaByNameAndPasswordRow usuario = (dsUsuarios.UsuariosListaByNameAndPasswordRow)userTD.Rows[0];
                //creamos el objeto que contendra las propiedades del usuario
                sessioUsuario = new RGen.Utiles.AtribucionesUsuario(usuario.persona, null, Convert.ToString(usuario.personaId));
                
                //sacamos el tipo de persona creadora
                sessioUsuario.TipoUsuarioCreador = usuario.tipoPersonaCreador;
				sessioUsuario.UsuarioCreadorId = Convert.ToString(usuario.creadorId);
                dsUsuariosTableAdapters.RolNameFromUserIdTableAdapter RolNameTA = new dsUsuariosTableAdapters.RolNameFromUserIdTableAdapter();
                dsUsuarios.RolNameFromUserIdDataTable RolNameDT = RolNameTA.GetData(usuario.usuarioId);

                if (RolNameDT.Rows.Count > 0)
                {
                    //asumo que en este momento sale un solo valor de la tabla pero no siempre es cierto
                    dsUsuarios.RolNameFromUserIdRow RolRow = (dsUsuarios.RolNameFromUserIdRow) RolNameDT.Rows[0];
                    sessioUsuario.setTipoUsuario(RolRow.rol);

                    dsUsuariosTableAdapters.AccesoAFuncionalidadesTableAdapter funcionalidadesTA = new dsUsuariosTableAdapters.AccesoAFuncionalidadesTableAdapter();
                    dsUsuarios.AccesoAFuncionalidadesDataTable funcionalidadDT = funcionalidadesTA.GetData(RolRow.rolId);

                    foreach (dsUsuarios.AccesoAFuncionalidadesRow funcionRow in funcionalidadDT) 
                    {
                        sessioUsuario.addAtributos(funcionRow.codigo, funcionRow.codigo);
                    }
                }
                sessioUsuario.UserName = User;
            }
          
            au = sessioUsuario;
            return userTD.Rows.Count > 0;
        }

        public static String getUserEmail(decimal personaId)
        {
            string correo = "";
            dsUsuariosTableAdapters.correoPersonaTableAdapter cpTA = new dsUsuariosTableAdapters.correoPersonaTableAdapter();
            dsUsuarios.correoPersonaDataTable dt = cpTA.GetData(personaId);
            if (dt.Rows.Count > 0)
            {
                dsUsuarios.correoPersonaRow row = (dsUsuarios.correoPersonaRow)dt.Rows[0];
                correo = row.email;
            }
            return correo;
        }

      public static String getCompania(decimal userId)
      {
        string companiaId = "";
        dsUsuariosTableAdapters.UsuarioEditorTableAdapter companiaTA = new dsUsuariosTableAdapters.UsuarioEditorTableAdapter();
        companiaId = Convert.ToString(companiaTA.dameCompaniaUsuario(userId));
        return companiaId;
      }
      public static String getCompaniaNombre(decimal companiaId)
      {
        string compania = "";
        dsUsuariosTableAdapters.NombreCompaniaTableAdapter companiaTA = new dsUsuariosTableAdapters.NombreCompaniaTableAdapter();
        dsUsuarios.NombreCompaniaDataTable dt = companiaTA.GetData(companiaId);
        if (dt.Rows.Count > 0)
        {
          dsUsuarios.NombreCompaniaRow row = (dsUsuarios.NombreCompaniaRow)dt.Rows[0];
          compania=row.persona;
        }
        return compania;
        
      }

    }
}
