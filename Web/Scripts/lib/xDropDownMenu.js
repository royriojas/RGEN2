/*
		TODO: agregar un tercer parametro que reciba un array asociativo, con los titulos de los menus, 
		y sus respectivas llamadas a funciones o urls to show
		
		var arrMenuItems = xGetElementsByClassName('MenuItem',menu_contextual,null,null);
		for(var i = 0; i < arrMenuItems.length; i++) {			
		}*/
		//alert(arrMenuItems.length);
/*
str_menu_id 	: id del elemento div que se mostrará como menu dropdown
str_trigger_id  : elemento sobre el cual se debe mostrar el menu, 
				  null = window, es decir se mostraría como un menu contextual en cualquier parte de la ventana.
str_tipo_menu	: tipo de menu a mostrar dropDownMenu o Contextual
				  d = dropDownMenu
				  c = Contextual
str_event_name	: nombre del evento que desencadena la aparicion del menu cuando el tipo es dropDownMenu


*/

function xGetAbsolutePos (el) {
	var SL = 0, ST = 0;
	var is_div = /^div$/i.test(el.tagName);
	if (is_div && el.scrollLeft)
		SL = el.scrollLeft;
	if (is_div && el.scrollTop)
		ST = el.scrollTop;
	var r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };
	if (el.offsetParent) {
		var tmp = xGetAbsolutePos(el.offsetParent);
		r.x += tmp.x;
		r.y += tmp.y;
	}
	return r;
};


function xDropDownMenu (str_menu_id,str_trigger_id,str_tipo_menu,str_event_name,position) {
		var menu_contextual, trigger_element;
		var doEventBinding = true;
		 try {
			menu_contextual = $(str_menu_id);
			trigger_element = document;
			if (str_trigger_id!=null) {
				trigger_element = $(str_trigger_id);
			}
		 }
		 catch(e) {
		 	alert(e.message);
			doEventBinding = false;
		 }
		var me = this;
		
		
		if (doEventBinding) {
			xAddEventListener(document,'click',hideMenu,false);
			if ((str_tipo_menu != null) && (str_tipo_menu == 'd')) {
				if (str_event_name) {
					//alert(str_event_name);
					xAddEventListener($(str_trigger_id),str_event_name,showContextMenu,true);		
					xAddEventListener($(str_trigger_id),'mouseout',hideContexMenu,false);
				}
				else {
					xAddEventListener($(str_trigger_id),'mouseover',showContextMenu,false);		
					xAddEventListener($(str_trigger_id),'mouseout',hideContexMenu,false);
				}
			}
			else {
				xAddEventListener(trigger_element,'contextmenu',showMenu,true);
			}
		}
		function showMenu(evt) {
			var ev = new xEvent(evt);			
			menu_contextual.style.display = 'block';						
			var posy = ev.pageY;
			if (ev.pageY - xHeight(menu_contextual) > 0)  {
				posy = 	ev.pageY - xHeight(menu_contextual);				
			}
			xMoveTo(menu_contextual,ev.pageX,posy); 						
			return false;		
		}
		
		function hideMenu(evt) {
			var ev = new xEvent(evt);
			if (!ev) {
				menu_contextual.style.display = 'none';
				return;
			}
			var posx, posy;
			if (!xDef(ev.pageX)) {
				var pos = xGetAbsolutePosition($(ev.target.id));
				posx = pos.x;
				posy = pos.y;
			}
			else {
				posx = ev.pageX;
				posy = ev.pageY;
			}
			if ((str_event_name != 'click') || (ev.target.id != trigger_element.id )) {
				if (!xHasPoint(menu_contextual,posx,posy)) {	
					menu_contextual.style.display = 'none';
				}
			}
			
		}
		
		this.show = function (x,y) {
			//var ev = new xEvent(evt);			
			menu_contextual.style.display = 'block';
			var posy = y;
			if (y - xHeight(menu_contextual) > 0)  {
				posy = 	y - xHeight(menu_contextual);				
			}
			xMoveTo(menu_contextual,x,posy); 
			return false;	
		}
		this.hide = function() {
			hideMenu();
		}
		function showContextMenu(evt) {		
			var ev = new xEvent(evt);		
			var pos = xGetAbsolutePos($(ev.target.id));
			var posx = pos.x; //xLeft($(ev.target.id));
			var posy = pos.y;//xTop($(ev.target.id));
			
			if (xDef(position)) {
				//alert(position);
				if (position == 'right') {
					//alert(menu_contextual);
					menu_contextual.style.display = 'block';
					var menuWidth = xWidth(menu_contextual);
					var itemTriggerWidth = xWidth(trigger_element);
					//alert(menuWidth + ' ' + itemTriggerWidth );
					
					posx = posx - (menuWidth - itemTriggerWidth);
					//alert(posx);
					
				}
			}								
			
			
			
			me.show(posx,posy + xHeight($(ev.target.id)));
		}
		function hideContexMenu() {
			me.hide();			
		}
}
	
	