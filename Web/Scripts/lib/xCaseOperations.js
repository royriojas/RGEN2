/*
	xTextBoxCaseOperatos : convierte al case especificado en el atributo stringcase del textbox
	si no se especifica el stringcase el case por defecto es ORACION
	
	stringcase puede ser
	
	"ORACION" = Tipo oraci�n
	"MINUSC" = minusculas
	"MAYUSC" = MAYUSCULAS
	"CAMELCASE" = Oraci�n Tipo Camello
	
	y se coloca como una clase m�s en el CLASSNAME del textbox
		
*/
xAddEventListener(window,'load',OnLoadFunctionCaseOperations,true);

function OnLoadFunctionCaseOperations() { 
	var x = new xTextBoxCaseOperators();
}



function xTextBoxCaseOperators() {
		var arrTextBoxsUpper = xGetElementsByClassName('FormText',null);
		//alert(arrTextBoxsUpper.length);
		
		for (var i = 0; i < arrTextBoxsUpper.length; i++) {
			var doValidations = false;
			var doCase = false;
			if (arrTextBoxsUpper[i].className.indexOf("MAYUSC") > 0) {
				doCase = true;	
			}
			if (arrTextBoxsUpper[i].className.indexOf("MINUSC") > 0) {
				doCase = true;
			}
			if (arrTextBoxsUpper[i].className.indexOf("ORACION") > 0) {
				doCase = true;
			}
			if (arrTextBoxsUpper[i].className.indexOf("CAMELCASE") > 0) {				
				doCase = true;
			}
			if (arrTextBoxsUpper[i].className.indexOf("NUMBERS") > 0) {
				doValidations = true;
			}
			if (arrTextBoxsUpper[i].className.indexOf("NATURAL") > 0) {
        xAddEventListener(arrTextBoxsUpper[i],'keyPress',onlyNumbers,true);
				xAddEventListener(arrTextBoxsUpper[i],'blur',formatAsNatural,false);				
			}
			
			
			if (doCase) xAddEventListener(arrTextBoxsUpper[i],'blur',evaluateCase,true); 
			if (doValidations) { 
				xAddEventListener(arrTextBoxsUpper[i],'keyPress',onlyNumbers,true);
				xAddEventListener(arrTextBoxsUpper[i],'blur',formatAsNumber,false);
			}
			
			
			//alert(arrTextBoxsUpper[i].className);
		}	
		function formatAsNatural(evt) {
			var myEvent = new xEvent(evt);
			if (formatNumber) {
				myEvent.target.value = formatNumber(myEvent.target.value,0,'','','','','-','');
			}
			else {
				alert('failed to find formatNumberFunction... file: functions.js');
			}
		}
		
		function formatAsNumber(evt) {
			var myEvent = new xEvent(evt);
			if (formatNumber) {
				myEvent.target.value = formatNumber(myEvent.target.value,2,'','.','','','-','');
			}
			else {
				alert('failed to find formatNumberFunction... file: functions.js');
			}
		}
		
		function onlyNumbers(evt) {
			var myEvent = new xEvent(evt);

			if (myEvent.keyCode < 45 || myEvent.keyCode > 57) { 
				myEvent.returnValue = false;
				xPreventDefault(evt);     
				return false;
			}					
		}
		function evaluateCase(evt) {
			try {
				var myEvent = new xEvent(evt);
				var ele = myEvent.target;
				//alert (ele.className);
				
				var typeOfCase = "ORACION";
				if (ele.className.indexOf("MAYUSC") > 0) {
					typeOfCase = "MAYUSC";					
					ele.value = StringCase(ele.value,typeOfCase);
				}
				if (ele.className.indexOf("MINUSC") > 0) {
					typeOfCase = "MINUSC";
					ele.value = StringCase(ele.value,typeOfCase);
				}
				if (ele.className.indexOf("ORACION") > 0) {
					typeOfCase = "ORACION";
					ele.value = StringCase(ele.value,typeOfCase);
				}
				if (ele.className.indexOf("CAMELCASE") > 0) {
					typeOfCase = "CAMELCASE";
					ele.value = StringCase(ele.value,typeOfCase);
				}
				//ele.value = StringCase(ele.value,typeOfCase);
			}
			catch(ex) {
				alert(ex.message);
			}
			
		}
		 
		function StringCase(str_cadena,str_type) {
			
			var out_cadena = "";
			//alert(str_type);
			switch (str_type) {
				
				case 'MAYUSC' : 
					out_cadena = str_cadena.toUpperCase();
					break;
				case 'MINUSC' : 
					out_cadena = str_cadena.toLowerCase();
					break;
				
				case 'ORACION' : 				
					out_cadena = str_cadena.toLowerCase();
					out_cadena = out_cadena.charAt(0).toUpperCase() + out_cadena.substring(1,out_cadena.length);
					break;
				case 'CAMELCASE' :
					//alert(xCapitalize);
					out_cadena = xCapitalizeInt(str_cadena);
				default :
					break;
				
			}
			return out_cadena;		
		}
		// xCapitalize, Copyright 2001-2005 Michael Foster (Cross-Browser.com)
		// Part of X, a Cross-Browser Javascript Library, Distributed under the terms of the GNU LGPL

		// Capitalize the first letter of every word in str.
		function xCapitalizeInt(str)
		{
		  var i, c, wd, s='', cap = true;
		  
		  for (i = 0; i < str.length; ++i) {
		    c = str.charAt(i);
		    wd = isWordDelim(c);
		    if (wd) {
		      cap = true;
		    }  
		    if (cap && !wd) {
		      c = c.toUpperCase();
		      cap = false;
		    }
		    s += c;
		  }
		  return s;

		  function isWordDelim(c)
		  {
		    // add other word delimiters as needed
		    // (for example '-' and other punctuation)
		    return c == ' ' || c == '\n' || c == '\t';
		  }
		}
		
	}