



    function mozOpacity(){
	    if(ns6){
		    opacity = opak + 7;
		    opak = opacity;
		    timerID = setTimeout("mozOpacity()", 70);
		    obj.style.MozOpacity = opacity + '%';
	    }
    }

    function stopMozOpacity(){
	    if(ns6){
		    if(timerID!=null){
			    clearTimeout(timerID);
			    timerID=null;
		    }
		    obj.style.MozOpacity = '0%';
		    opak = 0;
	    }
    }

    function changeMsg(index){
        try {
	    if(ie5){
	     obj = document.getElementById('tooltipContent');
		    obj.style.filter="blendTrans(Duration=0.25)";
		    obj.filters[0].Apply();
		    obj.style.visibility = "visible";
		    obj.filters[0].Play();
		    obj.innerHTML = msg[index];
	    }
	    else if(ns6){
	     obj = document.getElementById('tooltipContent');
		    obj.style.visibility = "visible";
		    obj.innerHTML = msg[index];
		    if (opak < 100){
			    mozOpacity();
		    }
	    }
	    }
	    catch(e) {
	    }
    }

    function hideMsg(){
	    if(ie5){
		    obj.style.visibility="hidden";
	    }
	    if (ns6) {
		    obj.style.visibility="hidden";
	    }
    }

    function getMouseMove(e){
     try {
	    if(ie5){
		    obj.style.left = document.body.scrollLeft + event.clientX + mouseX;
		    obj.style.top = document.body.scrollTop + event.clientY + mouseY;
	    /*
	    }
	    else if(ns6){
		    obj.style.left = window.pageXOffset + e.clientX + mouseX;
		    obj.style.top = window.pageYOffset + e.clientY + mouseY;
		    */
	    }
	 }
	 catch (e) {
	 }
    }

    function fadingTooltipsInit(){
        try {   
	    if(ie5 || ns6){
		    obj = document.getElementById('tooltipContent');
		    lnk = document.links;
		    for(var i=0;i<lnk.length;i++){
			    if(ie5){
				    lnk[i].attachEvent("onmouseout", hideMsg);				
			    }
			    else if(ns6){
				    lnk[i].addEventListener("mouseout", stopMozOpacity, false);
			    }
		    }
	    }	
	    buscaCabecera();		     
	    }
	    catch(e) {
	    }
    }
