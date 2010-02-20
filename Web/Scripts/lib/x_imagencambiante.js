function xImagenCambiante(str_imagen_id,str_url_imagen_cambiante,boolean_rollOver) {
		var imagen = xGetElementById(str_imagen_id);
		var str_url_antigua = imagen.src;
		var str_url_nueva = str_url_imagen_cambiante;
		var div_dias_internos = xGetElementById(str_imagen_id + '_div');
		
		if (boolean_rollOver) {
		    xAddEventListener(imagen,'mouseover',rotaImagenes,true);
		    xAddEventListener(imagen,'mouseout',rotaImagenes,true);
		}
		function rotaImagenes(evt) {
			var myEvent = new xEvent(evt);
			myEvent.target.src =(myEvent.target.src == str_url_antigua)? str_url_nueva:str_url_antigua;
		}
		this.imgActiva= function () {
			imagen.src = str_url_nueva;
		}
		this.imgInactiva = function () {
			imagen.src = str_url_antigua;
		}
		
		this.isActive = function () {
		    //se asume que cuando la imagen normal es reemplazada por la imagen nueva, se encuentra activa
		    /*alert(imagen.src == str_url_imagen_cambiante);
		    alert(imagen.src + ' ' + str_url_imagen_cambiante);*/
		    var imagensrc = imagen.src;
		     var re = new RegExp(str_url_imagen_cambiante+'[a-z]*\\b','i');	
		     //alert(str_url_imagen_cambiante+'[a-z]*\\b');
		     //alert(imagensrc.search(re));
		    return (imagensrc.search(re) != -1);
		}
		
		this.setDiasEstado= function(num_dias) {
		    if (div_dias_internos != null) div_dias_internos.innerHTML = ''+num_dias;	
		}
	}
