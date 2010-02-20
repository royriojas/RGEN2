function MakeClear(img,flag){
	if (flag==0){ img.style.filter='alpha(opacity=100,enabled=1)'}
	else{ img.style.filter='alpha(opacity=75,enabled=1)'}
}

function txtCuenta(Control, Maximo){
	if(Control.value.length > Maximo){
		Control.value = Control.value.substring(0, Maximo);
	}
}

function WinPopUp(Url,WinNombre,WinWidth,WinHeight){
	var Xpos = (screen.width/2) - (WinWidth/2);
	var Ypos = (screen.height/2) - (WinHeight/2);
	window.open(Url,WinNombre,'width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+', toolbar=no,scrollbars=0,resizable=0,menubar=0,status=yes,directories=no,location=no');
}

function WinPopUpMax(Url){
	window.open(Url,'','toolbar=1,scrollbars=1,resizable=1,menubar=0,status=1,directories=0,location=0');
}

function ShowReport(Url){

	var WinWidth = 700;
	var WinHeight = 450;
	var Xpos = (screen.width/2) - (WinWidth/2);
	var Ypos = (screen.height/2) - (WinHeight/2);
	//window.open('vInformePDF.aspx?'+Url,'vInformePDF','width=700,height=450,toolbar=no,scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
	window.open(Url,'','width='+WinWidth+',height='+WinHeight+', left='+Xpos+', top='+Ypos+',scrollbars=0,resizable=1,menubar=no,status=yes,directories=no,location=no');
}

function rtrim(argvalue) {
  while (1) {
    if (argvalue.substring(argvalue.length - 1, argvalue.length) != " ")
      break;
    argvalue = argvalue.substring(0, argvalue.length - 1);
  }
  return argvalue;
}

function MouseOver(elemento)
{
    //    eval(elemento + ".className = 'HeaderStyle'");
    var fila = document.getElementById(elemento);
    fila.className = 'ItemStyleOver';
    
}

function MouseOut(elemento)
{
//    eval(elemento + ".className = 'ItemStyle'");
    var fila = document.getElementById(elemento);
    fila.className = 'ItemStyle';

}

function Redirect(url)
{
    document.location.href = url;
}
function reload() {
    var anterior = document.location.href;
    document.location.href = anterior;
}

function loadScript(file)
        {
	        // Create script DOM element
	        var script = document.createElement('script');
	        script.type = 'text/javascript';
	        script.src = file;

	        // Alert when the script is loaded
	        if (typeof(script.onreadystatechange) == 'undefined') // W3C
		        script.onload = function(){ this.onload = null; alert('Script loaded'); };
	        else // IE
		        script.onreadystatechange = function(){ if (this.readyState != 'loaded' && this.readyState != 'complete') return; this.onreadystatechange = null; alert('Script loaded'); }; // Unset onreadystatechange, leaks mem in IE

	        // Add script DOM element to document tree
	        document.getElementsByTagName('head')[0].appendChild(script);
        };
        
function muestraVentanaPopUrl(urlName) {
    WinPopUpMax(urlName);
    return false;
}
function muestraVentanaPop(ele) {
	WinPopUpMax(ele.href);
	return false;
}
        
//llamada al metodo winOnLoad de la página vEditorCasoAjuste    
function recargaVentanaPadre() {
    //alert('llamando al padre');
    try {
        window.parent.winOnLoad();
    }
    catch (e) {
        alert(e.message);
    }
}

//RRRM 15-05-2006
function $(name_ele) {
            var ele;
            try {
                ele = document.getElementById(name_ele);
            }
            catch(e) {
                ele = null;
            }
            return ele;
}

function deshabilitaEnterKeyFromForms(evt) {
	        xeve = new xEvent(evt);
	        if (xeve.keyCode == 13) {
				//si no esta sobre un elemento cuyo nombre comienza con btn
	            var re = new RegExp('\\bbtn[a-z]*\\b','i');	            
	            if (xeve.target.id.search(re)!= -1) {
	                return true;
	            }
	            else {
	                return false;
	            }
	        }
	    }
	   
function xclose() {
    try {
         window.parent.hidePopWin(false);    
    }
    catch(ex) {
        
    }
}
function separar() {

	var actualLocation = document.location.href;
	if (actualLocation.indexOf('?') > -1) {
		WinPopUpMax(actualLocation +'&noShowSeparateBtn=true');
	}
	else {
		WinPopUpMax(actualLocation+'?noShowSeparateBtn=true');
	}
    
    //setTimeout(xclose,3000);
    return false;
}

function replaceAll( str, replacements ) {
        for ( i = 0; i < replacements.length; i++ ) {
            var idx = str.indexOf( replacements[i][0] );

            while ( idx > -1 ) {
                str = str.replace( replacements[i][0], replacements[i][1] ); 
                idx = str.indexOf( replacements[i][0] );
            }
        }
        return str;
}

// number formatting function
// copyright Stephen Chapman 24th March 2006
// permission to use this function is granted provided
// that this copyright notice is retained intact

function formatNumber(num,dec,thou,pnt,curr1,curr2,n1,n2) {
	var x = Math.round(num * Math.pow(10,dec));
	if (x >= 0) n1=n2='';
	var y = (''+Math.abs(x)).split('');
	var z = y.length - dec;y.splice(z, 0, pnt);
	while (z > 3) {
		z-=3; y.splice(z,0,thou);
	}
	var r = curr1+n1+y.join('')+n2+curr2;
	return r;
}


//var string = "{6} 123 Main St {7} Vancouver CA {3}";

//string = replaceAll( string, [["{6}", "#"], [ "{7}", "," ],["{3}", " "]]  );

//alert( string );
    
//añadiendo a la clase String un metodo similar al de C#
String.format = function(s){
		for(var i=1; i<arguments.length; i++){
			//s = s.replace("{" + (i -1) + "}", arguments[i]);
			s = replaceAll(s,[["{"+(i -1)+ "}", arguments[i]]]);
			
		}
		return s;
	}
	
////addNamespaces (para evitar conflictos de nombres en las funciones y clases a crear;
//RRRM
if(!window.addNamespace) {
	window.addNamespace = function(ns) 
	{		
		var nsParts = ns.split(".");
		var root = window;

		for(var i=0; i<nsParts.length; i++) 
		{
			if(typeof root[nsParts[i]] == "undefined") 
				root[nsParts[i]] = {};
			root = root[nsParts[i]];				
		}
	}
}

window.addNamespace("CCSOL.Utiles");

CCSOL.Utiles = {
    //Imprime una cadena al estilo C#
    StringFormat : function (s) {
                    for(var i=1; i<arguments.length; i++){
			            //s = s.replace("{" + (i -1) + "}", arguments[i]);
			            s = replaceAll(s,[["{"+(i -1)+ "}", arguments[i]]]);
            			
		            }
		            return s;
    },
    //RRRM funcion a usar dentro de los traces
    TraceError : function (e) {
                      if (!e) return 'no object find';
                      var msg = '';
                      msg += 'Error    : {0},\n';
                      msg += 'Number   : {1}';                                                                                                                             
                      //msg += 'Error : {0}\n,';
                      return CCSOL.Utiles.StringFormat(msg,e.message,e.number);
                 }
   
};