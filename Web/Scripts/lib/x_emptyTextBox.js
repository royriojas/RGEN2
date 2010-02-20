

function seteaValoresCero(StyleToFind,StyleToReplace) {			
    //TODO: hacer parámetro solo el estilo al que se quiere cambiar cuando este vacio el campo
    //    : se puede guardar el nombre del estilo actual del campo para no alterarlo.
    if (!xDef(StyleToFind)) StyleToFind = 'FormText';
    if (!xDef(StyleToReplace)) StyleToReplace = 'FormTextVacio';
	var arr_textbox = xGetElementsByClassName(StyleToFind,document);
	
	xAddEventListener(window,'unload',onunload,false);
	
	
	for (i=0; i < arr_textbox.length; i++) {
		//if (arr_textbox[i].nodeType == 1) {
			var textbox = arr_textbox[i];
			
			//alert (arr_textbox[i].type + ' ' + arr_textbox[i].nodeType + ' value : ' + arr_textbox[i].value);
			
			textbox.classNameAnterior = arr_textbox[i].className;
			
			xAddEventListener(textbox,'blur',liberaEstiloVacio);
					
			if (textbox.value == "") {				
				textbox.className =  StyleToReplace;				
			}
			else {
			    //maybe is a select
//			    if (textbox.type == 'select-one') {
//			        textbox.className =  StyleToReplace;
//			    }
			}
			
		//}				
	}		
	function liberaEstiloVacio(e){
	    var evento = new xEvent(e);
	    var textbox = evento.target;
	    if (textbox.value == "") {				
		    textbox.className = StyleToReplace;				
	    }
	    else {
		    textbox.className = textbox.classNameAnterior;
	    }
    }	
    
    function onunload() {
        for (i=0; i < arr_textbox.length; i++) {
		//if (arr_textbox[i].nodeType == 1) {
			var textbox = arr_textbox[i];						
			xRemoveEventListener(textbox,'blur',liberaEstiloVacio);								
		}									    		
		arr_textbox = null;
    }
}	

function limpiaCamposLlenados() {
	var arr_textbox = xGetElementsByClassName('FormTextVacio',document);
	for (i=0; i < arr_textbox.length; i++) {
		//if (arr_textbox[i].nodeType == 1) {
			var textbox = arr_textbox[i];		
			
			if (textbox.value != "") {				
				try {
					textbox.className = textbox.classNameAnterior;
				}
				catch(e) {
					
				}
			}			
		//}				
	}
		
}

	