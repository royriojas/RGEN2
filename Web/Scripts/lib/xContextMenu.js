/*
		TODO: agregar un tercer parametro que reciba un array asociativo, con los titulos de los menus, 
		y sus respectivas llamadas a funciones o urls to show
		
		var arrMenuItems = xGetElementsByClassName('MenuItem',menu_contextual,null,null);
		for(var i = 0; i < arrMenuItems.length; i++) {			
		}*/
		//alert(arrMenuItems.length);

function xContextMenu (str_menu_id,str_trigger_id,tipo,position) {
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
			if (tipo == 'd') {
				xAddEventListener($(str_trigger_id),'mouseover',showContextMenu,false);		
				xAddEventListener($(str_trigger_id),'mouseout',hideContexMenu,false);
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
			var posx, posy;
			if (!xDef(ev.pageX)) {
				posx = xLeft($(ev.target.id));
				posy = xTop($(ev.target.id));
			}
			else {
				posx = ev.pageX;
				posy = ev.pageY;
			}
			if (!xHasPoint(menu_contextual,posx,posy)) {	
				menu_contextual.style.display = 'none';
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
			//alert(ev.target.id);
			var posx = xLeft($(ev.target.id));
			var posy = xTop($(ev.target.id));
			
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
	
	