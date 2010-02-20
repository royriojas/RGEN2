<!-- RichDatePicker ver. 1.6.0.0 -->
var CalendarPopup_curCalendar = '';
var CalendarPopup_curCalendarID = '';
var CalendarPopup_curMonthYear = '';
var CalendarPopup_selMonth = '';
var CalendarPopup_selYear = '';
var MONTH_ARRAY = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var MONTH_NAMES = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

var CalendarPopup_CurrentCalendar=window;
var CalendarPopup_CurrentMonthYear;
var CalendarPopup_CurrentCalendarRelatedControl;

//if (navigator.appName == 'Netscape') { document.captureEvents(Event.CLICK); }

function CalendarPopup_Up_LostFocus(e) { CalendarPopup_Up_HideNonCurrentCalendar('', ''); }

function CalendarPopup_Up_Holiday(month, day, year, span,desc,style) {
	this.Month = month;
	this.Day = day;
	this.Year = year;
	this.Span = span;
	this.Desc = desc;
	this.Style = style;
}

function CalendarPopup_Up_IsHoliday(month, day, year, dateArray) {
	var returnVal = false;
	
	if(dateArray == null) {
		returnVal = false;
	} else {
		for(var i=0; i<dateArray.length; i++) {
			if(dateArray[i].Month == (month + 1) && dateArray[i].Day == day && (dateArray[i].Year == year || dateArray[i].Span)) {
				returnVal = true;
				i = dateArray.length;
			} else {
				returnVal = false;
			}
		}
	}
	return returnVal;
}

function CalendarPopup_Up_GetDescHoliday(month, day, year, dateArray) {
	var returnVal;
	if(dateArray == null) {
		returnVal = "";
	} else {
		for(var i=0; i<dateArray.length; i++) {
			if(dateArray[i].Month == (month + 1) && dateArray[i].Day == day && (dateArray[i].Year == year || dateArray[i].Span)) {
				returnVal = "title=\""+dateArray[i].Desc+"\"";
				i = dateArray.length;
			} else {
				returnVal = "";
			}
		}
	}
	return returnVal;
}

function CalendarPopup_Up_GetStyleHoliday(month, day, year, dateArray, defaultStyle) {
	var returnVal;
	
	if(dateArray == null) {
		returnVal = "";
	} else {
		for(var i=0; i<dateArray.length; i++) {
			if((dateArray[i].Month == (month + 1) && dateArray[i].Day == day && (dateArray[i].Year == year || dateArray[i].Span))&&(dateArray[i].Style!="")) {
				returnVal = " class="+dateArray[i].Style+" ";
				i = dateArray.length;
			} else {
				returnVal = defaultStyle;
			}
		}
	}
	return returnVal;
}

function CalendarPopup_Up_findPosX(obj)
{
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curleft += obj.offsetLeft;
			obj = obj.offsetParent;
		}
	}
	else if (obj.x) {
		curleft += obj.x;
	}
	return curleft;
}

function CalendarPopup_Up_findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop;
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;
	return curtop;
}

function CalendarPopup_Up_DisplayCalendar(calIdFlag, tbName, lblName, lblTemp, divName, myName, funcName, myFuncName, wdStyle, weStyle, omStyle, sdStyle, mhStyle, dhStyle, cdStyle, tdStyle, gttStyle, holStyle, formatNum, monthnames, daynames, fdweek, sunNum, satNum, enableHide, includeYears, lBound, uBound, btnName, locQuad, pad, postbackFunc, offsetX, offsetY, showClear, clearText, showGoToToday, goToTodayText, arrowUrl, customFunc, calWidth, visibleKey, nullText, dateArray, nextMonthImgUrl, prevMonthImgUrl, nextYearImgUrl, prevYearImgUrl, cellspacing, cellpadding) {
	eval(tbName+"_offsetX="+offsetX+";");
	eval(tbName+"_offsetY="+offsetY+";");
	var div, tb;
	var  mainObject = document.getElementById(tbName + "_outer");
	var datePeriod = mainObject.getAttribute("datePeriod");
	var controlDisplay = mainObject.getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")!=-1) controlDisplay="InPage";
	CalendarPopup_curCalendarID = calIdFlag;
	div = document.getElementById(divName);
	if(div.style.visibility != 'hidden' && controlDisplay!="InPage") {
		div.style.visibility = 'hidden';
	} else {
			var todayDate = CalendarPopup_Up_GetDate(tbName, formatNum,monthnames);
			eval('var stringDate = ' + visibleKey + ';');
		if (controlDisplay!="InPage") {
			CalendarPopup_Up_HideNonCurrentCalendar(divName, myName);
			CalendarPopup_CurrentCalendarRelatedControl = CalendarPopup_GetOffsetControl(tbName, lblName);
			switch(locQuad) {
				case 1:
					eval(tbName+"_offsetY +=" +(CalendarPopup_CurrentCalendarRelatedControl.offsetHeight + 1)+";");
					eval(tbName+"_offsetX -=" +(CalendarPopup_CurrentCalendarRelatedControl.offsetWidth - 2)+";");
					break;
				case 2:
					eval(tbName+"_offsetX -=" +(CalendarPopup_CurrentCalendarRelatedControl.offsetWidth - 2)+";");
					break;			
				case 4:
					eval(tbName+"_offsetX -=" +(CalendarPopup_CurrentCalendarRelatedControl.offsetWidth - 2)+";");
					break;
			} 
			offsetX=eval(tbName+"_offsetX");
			offsetY=eval(tbName+"_offsetY");
		}else {
			//CalendarPopup_CurrentCalendarRelatedControl=div;
			eval(tbName+"_RelatedControl=div");
			eval(tbName+"_offsetY=0;");
			eval(tbName+"_offsetX=0;");
			offsetX=0;
			offsetY=0;
		}		
		switch(datePeriod) {
			case "MonthAndYear":
			case "QuarterYears":
			case "HalfYears":
				if (controlDisplay!="InPage") {
					try {
						if (CalendarPopup_CurrentCalendar != window)
							CalendarPopup_CurrentCalendar.hide();
					} catch(e) {}
					CalendarPopup_CurrentCalendar = window.createPopup();
					CalendarPopup_CurrentCalendar.document.write( "<head>"+getCSS()+"</"+"head>");
					var calendarDiv = CalendarPopupDisplay(tbName,datePeriod,monthnames,customFunc,sdStyle);
					CalendarPopup_CurrentCalendar.document.write("<body style='OVERFLOW: hidden;BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px;PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px'>"+calendarDiv.innerHTML+"</"+"body>");
					switch(locQuad) {
						case 2:
							CalendarPopup_CurrentCalendar.show(
								CalendarPopup_CurrentCalendarRelatedControl.offsetWidth+offsetX-calendarDiv.offsetWidth,
								offsetY, 
								calendarDiv.offsetWidth - 4, 
								calendarDiv.offsetHeight - 4,
								CalendarPopup_CurrentCalendarRelatedControl);
								break;
						case 4:
							CalendarPopup_CurrentCalendar.show(
								CalendarPopup_CurrentCalendarRelatedControl.offsetWidth+offsetX,
								offsetY-calendarDiv.offsetHeight, 
								calendarDiv.offsetWidth - 4, 
								calendarDiv.offsetHeight - 4,
								CalendarPopup_CurrentCalendarRelatedControl);
								break;
						default:
							CalendarPopup_CurrentCalendar.show(
								CalendarPopup_CurrentCalendarRelatedControl.offsetWidth+offsetX,
								offsetY, 
								calendarDiv.offsetWidth - 4, 
								calendarDiv.offsetHeight - 4,
								CalendarPopup_CurrentCalendarRelatedControl);
								break;
					}
				} else {
					CalendarPopup_CurrentCalendar=window;
					CalendarPopupDisplay(tbName,datePeriod,monthnames,customFunc,sdStyle);
				}
				break;
			case "StartOfWeek":
				CalendarPopup_Up_DisplayCalendarByWeek(tbName, lblName, divName, myName, funcName, myFuncName, stringDate, wdStyle, weStyle, omStyle, sdStyle, mhStyle, dhStyle, cdStyle, tdStyle, gttStyle, holStyle, formatNum, monthnames, daynames, fdweek, sunNum, satNum, enableHide, includeYears, lBound, uBound, pad, postbackFunc, showClear, clearText, showGoToToday, goToTodayText, arrowUrl, customFunc, calWidth, visibleKey, nullText, dateArray, nextMonthImgUrl, prevMonthImgUrl, nextYearImgUrl, prevYearImgUrl, cellspacing, cellpadding,locQuad);
				break;
			default:
				CalendarPopup_Up_DisplayCalendarByDate(tbName, lblName, divName, myName, funcName, myFuncName, stringDate, wdStyle, weStyle, omStyle, sdStyle, mhStyle, dhStyle, cdStyle, tdStyle, gttStyle, holStyle, formatNum, monthnames, daynames, fdweek, sunNum, satNum, enableHide, includeYears, lBound, uBound, pad, postbackFunc, showClear, clearText, showGoToToday, goToTodayText, arrowUrl, customFunc, calWidth, visibleKey, nullText, dateArray, nextMonthImgUrl, prevMonthImgUrl, nextYearImgUrl, prevYearImgUrl, cellspacing, cellpadding,locQuad);
				break;
		}
	}
}

function CalendarPopup_Up_ChangeMonth(selMonth, lbDate, ubDate) {
	if(CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + selMonth).style.color == 'black') {
		for(var i=0; i<12; i++) {
			if(i != selMonth)
				CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + i).style.background='white';
			else
				CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + i).style.background='lightgrey';
		}
		CalendarPopup_selMonth = selMonth++;
	}
}

function CalendarPopup_Up_ChangeYear(selYear, yearNum, lbDate, ubDate,offsetX,offsetY) {
	var lowerDate = new Date(lbDate);
	var upperDate = new Date(ubDate);
	lowerDate = new Date((lowerDate.getMonth() + 1) + '/1/' + lowerDate.getFullYear());
	for(var i=0; i<10; i++) {
		if(i != selYear)
			CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_yearname' + i).style.background='white';
		else
			CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_yearname' + i).style.background='lightgrey';
	}
	for(var i=0; i<12; i++) {
		var curDate = new Date((i + 1) + '/1/' + yearNum);
		if(curDate < lowerDate || curDate > upperDate)
			CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + i).style.color = 'gray';
		else
			CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + i).style.color = 'black';
		CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + i).style.background = 'white';
	}
	var curDate = new Date((CalendarPopup_selMonth + 1) + '/1/' + yearNum);
	if(curDate <= lowerDate)
		CalendarPopup_selMonth = lowerDate.getMonth();
	else if(curDate >= upperDate)
		CalendarPopup_selMonth = upperDate.getMonth();
	CalendarPopup_CurrentMonthYear.document.getElementById('CalendarPopup_monthname' + CalendarPopup_selMonth).style.background = 'lightgrey';
	CalendarPopup_selYear = yearNum;
}

function CalendarPopup_Up_ChangeMonthYear(divName, funcName, isCancel,offsetX,offsetY,locQuad,win) {
	var spanName = divName.replace("_monthYear","_outer");
	var controlDisplay = document.getElementById(spanName).getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")!=-1) controlDisplay="InPage";
	CalendarPopup_CurrentMonthYear.hide();
	CalendarPopup_CurrentMonthYear = null;
	if (controlDisplay!="InPage") {
		if(!isCancel) {
			eval(funcName + "('" + (CalendarPopup_selMonth + 1) + "/1/" + CalendarPopup_selYear + "',"+offsetX+","+offsetY+","+locQuad+");");
		} else {
			CalendarPopup_CurrentCalendar.show(
				CalendarPopup_CurrentCalendarRelatedControl.offsetWidth + offsetX,
				offsetY , 
				document.getElementById(CalendarPopup_curCalendar).offsetWidth - 4, 
				document.getElementById(CalendarPopup_curCalendar).offsetHeight - 4,
				CalendarPopup_CurrentCalendarRelatedControl);		
		}
		document.onmousedown = CalendarPopup_Up_LostFocus;
	} else {
		if(!isCancel) {
			eval(funcName + "('" + (CalendarPopup_selMonth + 1) + "/1/" + CalendarPopup_selYear + "',"+offsetX+","+offsetY+","+locQuad+");");
		}
	}
}

function CalendarPopupDisplay(currentCalendarControl,type,monthnames,customFunc,sdStyle) {
	//currentCalendarControl
	var mainObject = document.getElementById(currentCalendarControl + "_outer");
	var formatNumber = parseInt(mainObject.getAttribute("formatNumber"));
	var controlDisplay = mainObject.getAttribute("controlDisplay");
	var inPageDisplay = (controlDisplay.indexOf("InPage")!=-1);
	var isMultiple = (controlDisplay.indexOf("Multiple")!=-1);
	var currentDate = CalendarPopup_Up_GetDate(currentCalendarControl,formatNumber,monthnames);
	
	var rez;
	switch (type) {
		case "QuarterYears":
			rez = CreateQuarterYearBody(currentCalendarControl,currentDate,customFunc,sdStyle,inPageDisplay,isMultiple);
			break;
		case "HalfYears":	
			rez = CreateHalfYearBody(currentCalendarControl,currentDate,customFunc,sdStyle,inPageDisplay,isMultiple);
			break;
		case "MonthAndYear":
			rez = CreateMonthYearBody(currentCalendarControl,currentDate,monthnames,customFunc,sdStyle,inPageDisplay,isMultiple);
			break;
	}
	var calendarDiv = document.getElementById(currentCalendarControl + "_div");
	calendarDiv.innerHTML  = rez;
	return calendarDiv;
}


function CreateLink(id, text, click, selected) {
	var commonStyle = "font-family:verdana; font-size:xx-small; color: black; cursor:hand;";
	var selectedStyle = "font-family:verdana; font-size:xx-small; color: black; cursor:hand;background:lightgrey;";
	
	var output = "<a ";
	output += "id='" + id + "' ";
	output += "href='#' ";
	output += "onclick=\"" + click + ";return false;\" ";
	output += "style='";
	if (selected) {
		output += selectedStyle;
	} else {
		output += commonStyle;
	}
	output += "'>" + text + "</a>";
	return output;
}

function CalendarPopupGetQuarter(date) {
	switch (date.getMonth()) {
		case 0:
		case 1:
		case 2:
			return 1;
		case 3:
		case 4:
		case 5:
			return 2;
		case 6:
		case 7:
		case 8:
			return 3;
		default:
			return 4;
	}
}

function CalendarPopupCreateYearsSelector(currentDate,func,currentCalendar,sdStyle,monthnames) {
	currentDate=new Date(currentDate);
	if (monthnames!=null) {
		if (monthnames.length!=12) {
			monthnames=monthnames.split(",");
		}
	}	else monthnames="no";
	var output = "<!-- year -->";
	var currentYear = currentDate.getFullYear();
	var year = currentYear - 5;
	var text;
	var m=1+currentDate.getMonth();
	var elem = currentCalendar +"_left";
	output += "<table>";
	for (var y = 1; y <= 10; y += 2) {		
		output += "<tr><td align='center'>";
		text=func+"('"+m+"/1/"+(year + y-1)+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');";
		text=text.replace(/"/g,'"');
		text=text.replace(/'/g,'~');
		
		output += CreateLink(currentCalendar+"_year" + y, year + y-1, "parent.CalendarPopupSelectYear(this,'"+elem+"','"+text+"','"+currentCalendar+"')" , currentYear == (year + y - 1) );
		
		output += "</td><td align='center'>";
		text=func+"('"+m+"/1/"+(year + y)+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');";
		text=text.replace(/"/g,'"');
		text=text.replace(/'/g,'~');
		output += CreateLink(currentCalendar+"_year" + (y+1), year + y, "parent.CalendarPopupSelectYear(this,'"+elem+"','"+text+"','"+currentCalendar+"')", currentYear == (year + y));
		output += "</td></tr>";
	}
		
	text=func+"('"+m+"/1/"+(currentYear-10)+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');"
	text=text.replace(/"/g,'"');
	text=text.replace(/'/g,'~');
	var text2="parent.CalendarPopupCreateYearsSelector('"+m+"/1/"+(currentYear -10)+"','"+func+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');"
	text2=text2.replace(/"/g,'"');
	text2=text2.replace(/'/g,"~");
	output += "<tr><td align='center'>";
	output += CreateLink("prev", "<<<", "parent.CalendarPopupMoveYears('"+text2+"','"+currentCalendar+"','"+text+"',"+(currentYear-10)+");", false);

	text=func+"('"+m+"/1/"+(currentYear+10)+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');"
	text=text.replace(/"/g,'"');
	text=text.replace(/'/g,"~");	
	output += "</td><td align='center'>";
	text2="parent.CalendarPopupCreateYearsSelector('"+m+"/1/"+(currentYear +10)+"','"+func+"','"+currentCalendar+"',\""+sdStyle+"\",'"+monthnames+"');"
	text2=text2.replace(/"/g,'"');
	text2=text2.replace(/'/g,"~");
	output += CreateLink("next", ">>>", "parent.CalendarPopupMoveYears('"+text2+"','"+currentCalendar+"','"+text+"',"+(currentYear+10)+");", false);
	output += "</td></tr>";	
	output += "</table>";
	return output;
}


function FillMonthY(currentDate,currentCalendar,sdStyle,monthnames) {
	currentDate= new Date(currentDate);
	for(var i = 0; i < 12; i++) {
		var Obj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_mn" + i);
		if (Obj!=null)	{
			if (Obj.style.background == "lightgrey") {
				currentDate.setMonth(i);
				break;
			}
		}
	}
	if (monthnames.length!=12)
	{
		monthnames = monthnames.split(",");
	}
	var currM = currentDate.getMonth();
	var output="<table>";
	var i = 0;
	while (i<12)
	{
		if (chekMulti(1,i,currentDate.getFullYear(),currentCalendar))
			output += "<tr><td align='center' "+sdStyle+">";
		else
			output += "<tr><td align='center'>";
		output += CreateLink(currentCalendar+"_mn" + i, monthnames[i].substring(0,3), "parent.CalendarPopupSelectMonth(this,'"+currentCalendar+"');",currM == i);
		i++;

		if (chekMulti(1,i,currentDate.getFullYear(),currentCalendar))
			output += "</td><td align='center' "+sdStyle+">";
		else
			output += "</td><td align='center'>";
		output += CreateLink(currentCalendar+"_mn" + i, monthnames[i].substring(0,3), "parent.CalendarPopupSelectMonth(this,'"+currentCalendar+"');",currM == i);
		output += "</td></tr>";
		i++;
	}
	output+="</table>";
	return output;	
}

function CreateMonthYearBody(currentCalendar,currentDate,monthnames,customFunc,sdStyle,inPageDisplay,isMultiple) {
	var formatNum = document.getElementById(currentCalendar + "_outer").getAttribute("formatNumber");
	var output = "<table style='border: black 1px solid;background: white;' border=0 cellspacing=0 cellpadding=0>";
	output += "<tr>";
	output += "<td width='50%' align='center'>";
	output += "<!-- MonthYear -->";
	output += "<p id='"+currentCalendar+"_left'>"
	output += FillMonthY(currentDate,currentCalendar,sdStyle,monthnames);
	output += "</p>"
	output += "</td>";
	output += "<td width='50%' align='center'>";
	output += "<p id='"+currentCalendar+"_right'>";
	output += CalendarPopupCreateYearsSelector(currentDate,'parent.FillMonthY',currentCalendar,sdStyle,monthnames);
	output += "</p>";
	output += "</td>";
	output += "</tr>";
	output += "<tr>";
	output += "<td colspan='2' align='center'>";
	var onclick="";
	if (isMultiple&&inPageDisplay)
		onclick="onclick='parent.CalendarPopupMonthYear(\"" + currentCalendar + "\",\""+monthnames+"\",\""+customFunc+"\");"+currentCalendar+"_Up_CallClick();'";
	else
		onclick="onclick='parent.CalendarPopupMonthYear(\"" + currentCalendar + "\",\""+monthnames+"\",\""+customFunc+"\");'";
	output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_apply")+"' "+onclick+" />";
	if (!inPageDisplay) {
		output += " ";
		output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_cancel")+"' onclick='parent.CalendarPopup_CurrentCalendar.hide();parent.CalendarPopup_CurrentCalendar=null;'/>";
	}
	output += "</td></tr></table>";
	
	return output;
}

function FillHalfYear(currentDate,currentCalendar,sdStyle,monthnames) {
	currentDate= new Date(currentDate);
	for(var i = 1; i <= 2; i++) {
		var Obj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_h" + i);
		if (Obj!=null)	{
			if (Obj.style.background == "lightgrey") {
				currentDate.setMonth(i*6-5);
				break;
			}
		}
	}
	var output="<table>";
	var currentHalf = 1;
	if (currentDate.getMonth() > 5) {
		currentHalf = 2;
	}

	for (var h = 1; h <= 2; h++) {
		if (chekMulti(1,h*6-6,currentDate.getFullYear(),currentCalendar))
			output += "<tr><td align='center' "+sdStyle+">";
		else
			output += "<tr><td align='center'>";
		output += CreateLink(currentCalendar+"_h" + h, "H" + h, "parent.CalendarPopupSelectHalfYear(this,'"+currentCalendar+"');",currentHalf == h);
		output += "</td></tr>";
	}
	output+="</table>";
	return output;	
}
function CreateHalfYearBody(currentCalendar,currentDate,customFunc,sdStyle,inPageDisplay,isMultiple) {
	var output = "<table style='border: black 1px solid;background: white;' border=0 cellspacing=0 cellpadding=0>";
	output += "<tr>";
	output += "<td width='50%' align='center'>";
	
	output += "<!-- halfs -->";
	output += "<p id='"+currentCalendar+"_left'>"
	output += FillHalfYear(currentDate,currentCalendar,sdStyle);
	output += "</p>"
	output += "</td>";
	output += "<td width='50%' align='center'>";
	output += "<p id='"+currentCalendar+"_right'>";
	output += CalendarPopupCreateYearsSelector(currentDate,'parent.FillHalfYear',currentCalendar,sdStyle,null);
	output += "</p>";
	output += "</td>";
	output += "</tr>";
	output += "<tr>";
	output += "<td colspan='2' align='center'>";
	var onclick="";
	if (isMultiple&&inPageDisplay)
		onclick="onclick='parent.CalendarPopupSetHalfYear(\"" + currentCalendar + "\",\""+customFunc+"\");"+currentCalendar+"_Up_CallClick();'";
	else
		onclick="onclick='parent.CalendarPopupSetHalfYear(\"" + currentCalendar + "\",\""+customFunc+"\");'";
	output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_apply")+"' "+onclick+"/>";
	if (!inPageDisplay) {
		output += " ";
		output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_cancel")+"' onclick='parent.CalendarPopup_CurrentCalendar.hide();parent.CalendarPopup_CurrentCalendar=null;'/>";
	}
	output += "</td></tr></table>";
	return output;
}

function FillQYear(currentDate,currentCalendar,sdStyle,monthnames) {
	currentDate= new Date(currentDate);
	for(var i = 1; i <= 4; i++) {
		var qObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_q" + i);
		if (qObj!=null)	{
			if (qObj.style.background == "lightgrey") {
				currentDate.setMonth(i*3-2);
				break;
			}
		}
	}
	
	var currentQuarter = CalendarPopupGetQuarter(currentDate);
	var output= "<table>";
		for (var q = 1; q <= 4; q++) {
		if (chekMulti(1,q*3-3,currentDate.getFullYear(),currentCalendar))
			output += "<tr><td align='center' "+sdStyle+">";
		else
			output += "<tr><td align='center'>";
		output += CreateLink(currentCalendar+"_q" + q, "Q" + q, "parent.CalendarPopupSelectQuarter(this,'"+currentCalendar+"');",currentQuarter == q);
		output += "</td></tr>";
	}
	output += "</table>";
	return output;	
}

function CreateQuarterYearBody(currentCalendar,currentDate,customFunc,sdStyle,inPageDisplay,isMultiple) {
	var output = "<table style='border: black 1px solid;background: white;' border=0 cellspacing=0 cellpadding=0>";
	var currentQuarter = CalendarPopupGetQuarter(currentDate);
	
	output += "<tr>";
	output += "<td width='50%' align='center'>";
	output += "<!-- quarters -->";
	
	output += "<p id='"+currentCalendar+"_left'>"
	output += FillQYear(currentDate,currentCalendar,sdStyle);		
	output += "</p>";
	
	output += "</td>";
	output += "<td width='50%' align='center'>";
	output += "<p id='"+currentCalendar+"_right'>";
	output += CalendarPopupCreateYearsSelector(currentDate,'parent.FillQYear',currentCalendar,sdStyle,null);
	output += "</p>";
	output += "</td>";
	output += "</tr>";
	output += "<tr>";
	output += "<td colspan='2' align='center'>";
	var onclick="";
	if (isMultiple&&inPageDisplay)
		onclick="onclick='parent.CalendarPopupSetQuarter(\"" + currentCalendar + "\",\""+customFunc+"\");"+currentCalendar+"_Up_CallClick();'";
	else
		onclick="onclick='parent.CalendarPopupSetQuarter(\"" + currentCalendar + "\",\""+customFunc+"\");'";
	output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_apply")+"' "+onclick+"/>";
	if (!inPageDisplay) {
		output += " ";
		output += "<input type='button' style='font-family:verdana; font-size:xx-small;' value='"+eval(currentCalendar+"_outer_cancel")+"' onclick='parent.CalendarPopup_CurrentCalendar.hide();parent.CalendarPopup_CurrentCalendar=null;'/>";
	}
	output += "</td></tr></table>";
	
	return output;
}

function CalendarPopupSelectHalfYear(obj,currentCalendar) {
	for(var i = 1; i <= 2; i++) {
		var hObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_h" + i);
		if (hObj.id == obj.id) {
			hObj.style.background = "lightgrey";
		} else {
			hObj.style.background = "";
		}
	}

}

function CalendarPopupSelectQuarter(obj,currentCalendar) {
	for(var i = 1; i <= 4; i++) {
		var qObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_q" + i);
		if (qObj.id == obj.id) {
			qObj.style.background = "lightgrey";
		} else {
			qObj.style.background = "";
		}
	}
}

function CalendarPopupMoveYears(text2,currentCalendar,text,year) {
	var i;	
	for(i = 1; i <= 10; i++) {
		var yearObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_year" + i);
		if (yearObj.style.backgroundColor == "lightgrey")
			break;
	}
	var elem=CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_right");
	text2=text2.replace(/~/g,"'");
	elem.innerHTML=eval(text2);
	SetSelection(yearObj,currentCalendar+"_year",1,10);
	text=text.replace("/"+year,"/"+(year+i-6));
	elem=CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_left");
	text=text.replace(/~/g,"'");
	elem.innerHTML=eval(text);
}

function SetSelection(obj,prefix,from,to) {
	for(var i = from; i <= to; i++) {
		var Obj = CalendarPopup_CurrentCalendar.document.getElementById(prefix + i);
		if (Obj.id == obj.id) {
			Obj.style.background = "lightgrey";
		} else {
			Obj.style.background = "";
		}
	}
}

function CalendarPopupSelectYear(obj,elem,text,currentCal) {
	text=text.replace(/~/g,"'");
	SetSelection(obj,currentCal+"_year",1,10);
	CalendarPopup_CurrentCalendar.document.getElementById(elem).innerHTML=eval(text);	
}

function CalendarPopupSelectMonth(obj,currentCalendar) {
	for(var i = 0; i <12; i++) {
		var mounthObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_mn" + i);
		if (mounthObj.id == obj.id) {
			mounthObj.style.background = "lightgrey";
		} else {
			mounthObj.style.background = "";
		}
	}
}

function CalendarPopupMonthYear(currentCalendar,monthnames,customFunc) {
	var month = 1;
	var year = 1900;
	for(var i = 0; i < 12; i++) {
		var hObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_mn" + i);
		if (hObj.style.background == "lightgrey") {
			month = i + 1; 
		}
	}
	for(var j = 1; j <= 10; j++) {
		var yearObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_year" + j);
		if (yearObj.style.background == "lightgrey") {
			year = parseFloat(yearObj.innerText);;
		}
	}
	
	CalendarPopupSelectDate(currentCalendar, month + "/1/" + year,customFunc,monthnames);
	var controlDisplay = document.getElementById(currentCalendar + "_outer").getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")==-1) {
		if (CalendarPopup_CurrentCalendar!=window)
			CalendarPopup_CurrentCalendar.hide();
		CalendarPopup_CurrentCalendar=window;
	}
	eval(currentCalendar + "_Up_PostBack();");
}

function CalendarPopupSetHalfYear(currentCalendar,customFunc) {
	var month = 1;
	var year = 1900;
	for(var i = 1; i <= 2; i++) {
		var hObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_h" + i);
		if (hObj.style.background == "lightgrey") {
			month = ((i - 1) *6) + 1 ; 
		}
	}
	for(var i = 1; i <= 10; i++) {
		var yearObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_year" + i);
		if (yearObj.style.background == "lightgrey") {
			year = parseFloat(yearObj.innerText);;
		}
	}
	CalendarPopupSelectDate(currentCalendar, month + "/1/" + year,customFunc);
	var controlDisplay = document.getElementById(currentCalendar + "_outer").getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")==-1) {	
		if (CalendarPopup_CurrentCalendar!=window)
			CalendarPopup_CurrentCalendar.hide();
		CalendarPopup_CurrentCalendar=window;
	}	
	eval(currentCalendar + "_Up_PostBack();");
}

function CalendarPopupSetQuarter(currentCalendar,customFunc) {
	var month = 1;
	var year = 1900;
	for(var i = 1; i <= 4; i++) {
		var qObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_q" + i);
		if (qObj.style.background == "lightgrey") {
			month = ((i - 1) *3) + 1 ; 
		}
	}
	for(var i = 1; i <= 10; i++) {
		var yearObj = CalendarPopup_CurrentCalendar.document.getElementById(currentCalendar+"_year" + i);
		if (yearObj.style.background == "lightgrey") {
			year = parseFloat(yearObj.innerText);
		}
	}	
	CalendarPopupSelectDate(currentCalendar, month + "/1/" + year,customFunc);
	var controlDisplay = document.getElementById(currentCalendar + "_outer").getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")==-1) {
		if (CalendarPopup_CurrentCalendar!=window)
			CalendarPopup_CurrentCalendar.hide();
		CalendarPopup_CurrentCalendar=window;
	}
	eval(currentCalendar + "_Up_PostBack();");
}

function CalendarPopupSelectDate(currentCalendar, date, customFunc, monthnames) {
	var formatNum = parseFloat(document.getElementById(currentCalendar + "_outer").getAttribute("formatNumber"));
	var datePeriod = document.getElementById(currentCalendar + "_outer").getAttribute("datePeriod");
	var multi = document.getElementById(currentCalendar + "_outer").getAttribute("displayType");
	var val = CalendarPopup_Up_DetermineDateString(date, formatNum, false, datePeriod,monthnames);	
	var tb = document.getElementById(currentCalendar+"_tb");
	var label = document.getElementById(currentCalendar + "_label");
	
	document.getElementById(currentCalendar).value = val;
	
	if(tb != null) {
		tb.value = val;
	}		
	if(label != null) {
		label.innerHTML = val;
	}		
	
	if (multi.substring(0,8)=="Multiple") {
		AddToList(currentCalendar,val,date);
	} 
	
	if(customFunc != "")
		eval(customFunc + "('" + date + "', '" + currentCalendar + "');");
	
	eval(currentCalendar + "_Up_PostBack();");
}


function CalendarPopup_Up_DisplayMonthYear(calDivName, myDivName, funcName, myFuncName, monthnames, theDate, applyText, cancelText, lbDate, ubDate,offsetX,offsetY,locQuad,win) {
	var spanName = calDivName.substring(0,calDivName.length-4) + "_outer";
	var datePeriod = document.getElementById(spanName).getAttribute("datePeriod");
	var controlDisplay = document.getElementById(spanName).getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")!=-1) controlDisplay="InPage";
	var calDIV = document.getElementById(calDivName);
	var myDIV = document.getElementById(myDivName);
	var curDate = new Date(theDate);
	var lowerDate = new Date(lbDate);
	var upperDate = new Date(ubDate);
	lowerDate = new Date((lowerDate.getMonth() + 1) + '/1/' + lowerDate.getFullYear());
	if (controlDisplay!="InPage") {
		if (win!=null)
		{
			switch(locQuad)
			{
			case 2:
				offsetX-=win.document.body.offsetWidth;
				break;
			case 4:
				offsetY-=win.document.body.offsetHeight;
				break;
			}
		}
	}
	CalendarPopup_selMonth = curDate.getMonth();
	if(curDate < lowerDate)
		CalendarPopup_selMonth = lowerDate.getMonth();
	else if(curDate > upperDate)
		CalendarPopup_selMonth = upperDate.getMonth();
	CalendarPopup_selYear = curDate.getFullYear();
	var colspan = 1;
	outputString = '<table style=\"border: black 1px solid;background: white;\" border=0 cellspacing=0 cellpadding=0>';
	outputString = outputString + '<tr><td valign=top align=center><table border=0 cellspacing=0 cellpadding=2 width=50%>';
	for(var i=0; i<12; i++) {
		if(i % 2 == 0)
			outputString = outputString + '<tr>';
		var tempDate = new Date((i + 1) + '/1/' + CalendarPopup_selYear);
		if(tempDate >= lowerDate  && tempDate <= upperDate) {
			if (datePeriod != "DayAndMonth") {
				if(i == CalendarPopup_selMonth)
					outputString = outputString + "<td id=\"CalendarPopup_monthname" + i + "\" onclick=\"parent.CalendarPopup_Up_ChangeMonth(" + i + ", '" + lbDate + "', '" + ubDate + "')\" align=left nowrap style=\"font-family:verdana; font-size:xx-small; color: black;background:lightgrey; cursor:hand;\">" + monthnames[i] + "</td>";
				else
					outputString = outputString + "<td id=\"CalendarPopup_monthname" + i + "\" onclick=\"parent.CalendarPopup_Up_ChangeMonth(" + i + ", '" + lbDate + "', '" + ubDate + "')\" align=left nowrap style=\"font-family:verdana; font-size:xx-small; color: black; cursor:hand;\">" + monthnames[i] + "</td>";
			} else {
				if(i == CalendarPopup_selMonth)
					outputString = outputString + "<td id=\"CalendarPopup_monthname" + i + "\" onclick=\"parent.CalendarPopup_selMonth="+i+";parent.CalendarPopup_Up_ChangeMonthYear('" + myDivName + "', '" + funcName + "', false);\" align=left nowrap style=\"font-family:verdana; font-size:xx-small; color: black;background:lightgrey; CURSOR:hand;\">" + monthnames[i] + "</td>";
				else
					outputString = outputString + "<td id=\"CalendarPopup_monthname" + i + "\" onclick=\"parent.CalendarPopup_selMonth="+i+";parent.CalendarPopup_Up_ChangeMonthYear('" + myDivName + "', '" + funcName + "', false,"+offsetX+","+offsetY+","+locQuad+");\" align=left nowrap style=\"font-family:verdana; font-size:xx-small; color: black; cursor:hand;\">" + monthnames[i] + "</td>";
			}
		} else {
			outputString = outputString + "<td id=\"CalendarPopup_monthname" + i + "\" onclick=\"parent.CalendarPopup_Up_ChangeMonth(" + i + ", '" + i + lbDate + "', '" + ubDate + "')\" align=left nowrap style=\"font-family:verdana; font-size:xx-small; color: gray; cursor:hand;\">" + monthnames[i] + "</td>";
		}
		if(i % 2 != 0)
			outputString = outputString + '</tr>';
	}
	outputString = outputString + '</table></td>';
	if (datePeriod != "DayAndMonth") {
		colspan += 1;
		outputString += '<td valign=top><table border=0 cellspacing=0 cellpadding=2 width=100%>';
		var j = 0;
		for(var i=(curDate.getFullYear() - 5); i<(curDate.getFullYear() + 5); i++) {
			if(j % 2 == 0)
				outputString = outputString + '<tr>';
			if(i >= lowerDate.getFullYear() && i <= upperDate.getFullYear()) {
				if(i == curDate.getFullYear())
					outputString = outputString + "<td id=\"CalendarPopup_yearname" + j + "\" onclick=\"parent.CalendarPopup_Up_ChangeYear(" + j + ", " + i + ", '" + lbDate + "', '" + ubDate + "',"+offsetX+","+offsetY+","+locQuad+")\" align=left nowrap style=\"font-family:verdana; font-size:xx-small;color: black;background: lightgrey; cursor:hand;\">" + i + "</td>";
				else
					outputString = outputString + "<td id=\"CalendarPopup_yearname" + j + "\" onclick=\"parent.CalendarPopup_Up_ChangeYear(" + j + ", " + i + ", '" + lbDate + "', '" + ubDate + "',"+offsetX+","+offsetY+","+locQuad+")\" align=left nowrap style=\"font-family:verdana; font-size:xx-small;color: black; cursor:hand;\">" + i + "</td>";
			} else {
				outputString = outputString + "<td id=\"CalendarPopup_yearname" + j + "\" align=left nowrap style=\"font-family:verdana; font-size:xx-small;color: gray; cursor:hand;\">" + i + "</td>";
			}
			if(j % 2 != 0)
				outputString = outputString + '</tr>';
			j++;
		}
		outputString = outputString + "<tr><td align=left><a style=\"font-family:verdana; font-size:xx-small; color: black;\" href='#' onclick=\"parent." + myFuncName + "((parent.CalendarPopup_selMonth + 1) + '/" + curDate.getDate() + "/" + (curDate.getFullYear() - 10) + "',"+offsetX+","+offsetY+","+locQuad+")\"><<</a></td>";
		outputString = outputString + "<td align=right><a style=\"font-family:verdana; font-size:xx-small; color: black;\" href='#' onclick=\"parent." + myFuncName + "((parent.CalendarPopup_selMonth + 1) + '/" + curDate.getDate() + "/" + (curDate.getFullYear() + 10) + "',"+offsetX+","+offsetY+","+locQuad+")\">>></a></td></tr>";
		outputString += '</table></td>';
	}
	outputString += '</tr>';
	if (datePeriod != "DayAndMonth") {
		outputString = outputString + "<tr><td colspan='" + colspan + "' align=center nowrap><input onclick=\"parent.CalendarPopup_Up_ChangeMonthYear('" + myDivName + "', '" + funcName + "', false,"+offsetX+","+offsetY+","+locQuad+");\" type=button value=\"" + applyText + "\" style=\"font-family:verdana; font-size:xx-small\"><input onclick=\"parent.CalendarPopup_Up_ChangeMonthYear('" + myDivName + "', '" + funcName + "', true,"+offsetX+","+offsetY+","+locQuad+");\" type=button value=\"" + cancelText + "\" style=\"font-family:verdana; font-size:xx-small\"></td></tr>";
	}
	CalendarPopup_CurrentMonthYear = window.createPopup();
	var oPopupBody = CalendarPopup_CurrentMonthYear.document.body;
	oPopupBody.innerHTML = outputString;
	
	//var obj = CalendarPopup_GetOffsetControl();
	myDIV.innerHTML = outputString;
	if (controlDisplay!="InPage") {
		if (CalendarPopup_CurrentCalendar != window)
			CalendarPopup_CurrentCalendar.hide();
		CalendarPopup_CurrentMonthYear.show(
			CalendarPopup_CurrentCalendarRelatedControl.offsetWidth+offsetX,
			offsetY, 
			myDIV.offsetWidth, 
			myDIV.offsetHeight,
			CalendarPopup_CurrentCalendarRelatedControl);
	} else {
		CalendarPopup_CurrentMonthYear.show(
			offsetX+(calDIV.offsetWidth-myDIV.offsetWidth)/2,offsetY, 
			myDIV.offsetWidth, 
			myDIV.offsetHeight,
			calDIV);
			//eval(calDivName.replace("_div","_RelatedControl")));
	}
}

function CalendarPopup_Up_HideNonCurrentCalendar(divName, myName) {
	if(CalendarPopup_curMonthYear != '') {
		document.getElementById(CalendarPopup_curMonthYear).style.visibility = 'hidden';
		document.getElementById(CalendarPopup_curMonthYear).innerHTML = '';
	}
	if(CalendarPopup_curCalendar != '') {
		document.getElementById(CalendarPopup_curCalendar).innerHTML = '';
		if(eval(CalendarPopup_curCalendarID) == true)
			CalendarPopup_Up_ShowHideDDL('visible');
	}
	
	//gib
	try {
		if (CalendarPopup_CurrentCalendar != window) {
			CalendarPopup_CurrentCalendar.hide();
			CalendarPopup_CurrentCalendar = window;
		}
	} catch(e) {}
	
	if(divName != '')
		CalendarPopup_curCalendar = divName;
	if(myName != '')
		CalendarPopup_curMonthYear = myName;
}

function CalendarPopup_Up_GetMultipleDate(tbName, formatNum) {
	var todayDate;
	if(document.getElementById(tbName).value != '') {
		var theDate;
		var theDateArr = document.getElementById(tbName).value.split("/");
		theDate = theDateArr[0].concat("/").concat(theDateArr[1]).concat("/").concat(theDateArr[2]);
		todayDate = new Date(theDate);
		if(isNaN(todayDate)) {
			todayDate = new Date();
		}
	}else {
		todayDate = new Date();
	}
	return todayDate;
}

function CalendarPopup_Up_GetStandartDate(tbName, formatNum) {
	var todayDate;
	var theDate;
	var theDateArr;
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText.split("/");
		if(theDateArr.length != 3) {
			theDateArr = document.getElementById(tbName).innerText.split(".");
			if(theDateArr.length != 3) {			
				theDateArr = document.getElementById(tbName).innerText.split("-");
			}
		}
	} else {
		theDateArr = document.getElementById(tbName).value.split("/");
		if(theDateArr.length != 3) {
			theDateArr = document.getElementById(tbName).value.split(".");
			if(theDateArr.length != 3) {
				theDateArr = document.getElementById(tbName).value.split("-");
			}
		}
	}
	
	if(theDateArr.length == 3) {
			switch(formatNum) {
				case 1: // In: MM/DD/YYYY Out: MM/DD/YYYY
					theDate = theDateArr[0].concat("/").concat(theDateArr[1]).concat("/").concat(theDateArr[2]);
					break;
				case 2: // In: DD/MM/YYYY Out: MM/DD/YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[0]).concat("/").concat(theDateArr[2]);
					break;
				case 3: // In: YYYY/MM/DD Out: MM/DD/YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[2]).concat("/").concat(theDateArr[0]);
					break;
				case 4: // In MM.DD.YYYY Out: MM.DD.YYYY
					theDate = theDateArr[0].concat("/").concat(theDateArr[1]).concat("/").concat(theDateArr[2]);
					break;
				case 5: // In DD.MM.YYYY Out: MM.DD.YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[0]).concat("/").concat(theDateArr[2]);
					break;
				case 6: // In YYYY.MM.DD Out: MM.DD.YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[2]).concat("/").concat(theDateArr[0]);
					break;
				case 7: // In MM-DD-YYYY Out: MM-DD-YYYY
					theDate = theDateArr[0].concat("/").concat(theDateArr[1]).concat("/").concat(theDateArr[2]);
					break;
				case 8: // In DD-MM-YYYY Out: MM-DD-YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[0]).concat("/").concat(theDateArr[2]);
					break;
				case 9: // In YYYY-MM-DD Out: MM-DD-YYYY
					theDate = theDateArr[1].concat("/").concat(theDateArr[2]).concat("/").concat(theDateArr[0]);
					break;
			}
			todayDate = new Date(theDate);
			if(todayDate == 'NaN'||isNaN(todayDate))
				todayDate = new Date();
	} 
	return todayDate;
}

function CalendarPopup_Up_GetMYDate(tbName, formatNum, monthnames)
{
	//monthnames = monthnames.split(",");
	var theDate = '';
	var theDateArr;
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText.split(" ");
	} else {
		theDateArr = document.getElementById(tbName).value.split(" ");
	}
	if (theDateArr.length>=2)
	{
		var i;
		var last = theDateArr.length-1;
		switch(formatNum) {
			case 1: // In:MM YYYY  Out:MM/DD/YYYY  
			case 2:
			case 4:
			case 5:
			case 7:
			case 8:
			case 9:
				for(i=0;i<12;i++) {
				  if (monthnames[i]==theDateArr[0])
					break;
				}
				theDate = (i+1)+"/1/"+theDateArr[last];
				break;
			case 6:
			case 3: // In: YYYY MM Out: MM/DD/YYYY 
				for(i=0;i<12;i++) {
				  if (monthnames[i]==theDateArr[last])
						break;
				}
				theDate = (i+1)+"/1/"+theDateArr[0];
				break;
		}
	}
	return theDate;
}
function CalendarPopup_Up_GetDMDate(tbName, formatNum,monthnames){
	var theDate = '';
	var theDateArr;
	var dateToday=new Date();
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText.split(" ");
	} else {
		theDateArr = document.getElementById(tbName).value.split(" ");
	}
	
	if (theDateArr.length>=2)
	{
		var i;
		var last = theDateArr.length-1;
		switch(formatNum) {
			case 1: // In:MM DD  Out:MM/DD/YYYY  
			case 3:
			case 4:
			case 6:
			case 7:
			case 9:				
				for(i=0;i<12;i++) {
				  if (monthnames[i]==theDateArr[0])
					break;
				}
				theDate=(i+1)+"/"+theDateArr[last]+"/"+dateToday.getFullYear();						
				break;
			case 2:
			case 5: // In: DD MM Out: MM/DD/YYYY
			case 8:
				for(i=0;i<12;i++) {
				  if (monthnames[i]==theDateArr[last])
					break;
				}	
				theDate=(i+1)+"/"+theDateArr[0]+"/"+dateToday.getFullYear();	
				break;
		}
	}
	return theDate;
}

function  CalendarPopup_Up_GetCustomDate(tbName, format,monthnames){
	var theDate = '';
	var theDateArr,tmpArr = new Array();
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText;
	} else {
		theDateArr = document.getElementById(tbName).value;
	}
	for(i=3;i<6;i++)
	{
	   if (format[i]!="")
	   	   theDateArr = theDateArr.replace(format[i], " ");
	}
	theDateArr=theDateArr.split(" ");
	for(i=0;i<3;i++) {
		switch(format[i]){
			case "D":
			case "DD":
				tmpArr[1]=theDateArr[i];
				break;
			case "M":
			case "MM":
				tmpArr[0]=theDateArr[i];
				break;
			case "MMM":
				for(j=0;j<12;j++){
					if (theDateArr[i]==monthnames[j].substring(0,3))
						tmpArr[0]=j+1;
				}
				break;
			case "MMMM":
				for(j=0;j<12;j++){
					if (theDateArr[i]==monthnames[j]){
						tmpArr[0]=j+1;
						break;
					}
				}
				break;
			case "YY":
				tmpArr[2]=theDateArr[i];
				if (tmpArr[2]>25)
					tmpArr[2]="19"+tmpArr[2];
				else
					tmpArr[2]="20"+tmpArr[2];
				break;
			case "YYYY":
				tmpArr[2]=theDateArr[i];
				break;
		}
	}
	theDate=tmpArr[0]+"/"+tmpArr[1]+"/"+tmpArr[2];
	return theDate;
}

function CalendarPopup_Up_GetQDate(tbName){
	var theDate = '';
	var theDateArr;
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText.split(" ");
	} else {
		theDateArr = document.getElementById(tbName).value.split(" ");
	}
	if (theDateArr.length>=2){
		if (theDateArr[0]=="Q1")
			i=1;
		else if (theDateArr[0]=="Q2")
				i=4;
			else if (theDateArr[0]=="Q3")
					i=7;
				else i=10;
		theDate = i+"/1/"+theDateArr[theDateArr.length-1];
	}
	return theDate;
}

function CalendarPopup_Up_GetHDate(tbName){
	var theDate = '';
	var theDateArr;
	if(document.getElementById(tbName).innerText != '') {
		theDateArr = document.getElementById(tbName).innerText.split(" ");
	} else {
		theDateArr = document.getElementById(tbName).value.split(" ");
	}
	if (theDateArr.length>=2){
		if (theDateArr[0]=="H1")
			i=1;
		else i=7;
		theDate = i+"/1/"+theDateArr[theDateArr.length-1];
	}
	return theDate;
}

function CalendarPopup_Up_GetDate(tbName, formatNum, monthnames) {
	var theDate;
	var customFormat = document.getElementById(tbName + "_outer").getAttribute("outFormat");
	var format = customFormat.split("\",");
	var datePeriod = document.getElementById(tbName + "_outer").getAttribute("datePeriod");
	var multi = document.getElementById(tbName + "_outer").getAttribute("displayType").substring(0,8);
		var format = customFormat.split("|,");
	if (format.length<=1)
		format = customFormat.split(",");
	if (format[0]!="")
		datePeriod="Custom";
	if (multi=="Multiple"){
		tbName+="_dates";
		theDate = CalendarPopup_Up_GetMultipleDate(tbName, formatNum);
	}
	else {
		if (document.getElementById(tbName + "_tb") != null) {
			tbName+="_tb";
		} else {
			if (document.getElementById(tbName + "_label")!=null)
				tbName+="_label";
		}
		switch(datePeriod) {
			case "HalfYears":
				theDate = CalendarPopup_Up_GetHDate(tbName);
				break;
			case "QuarterYears":
				theDate = CalendarPopup_Up_GetQDate(tbName);
				break;
			case "MonthAndYear": 
				theDate = CalendarPopup_Up_GetMYDate(tbName, formatNum, monthnames);
				break;
			case "DayAndMonth": 
				theDate = CalendarPopup_Up_GetDMDate(tbName, formatNum,monthnames);
				break;
			case "Custom":
				theDate = CalendarPopup_Up_GetCustomDate(tbName, format,monthnames);
				break;
			default: 
				theDate = CalendarPopup_Up_GetStandartDate(tbName, formatNum);
				break;
		}
	}
	theDate=new Date(theDate);
	if (theDate == 'NaN'||isNaN(theDate)){
		theDate = new Date();
		theDate.setHours(0,0);
	}
	return theDate;
}


function CalendarPopup_Up_ShowHideDDL(visibility) {
	for(j=0;j<document.forms.length; j++) {
		for(i=0;i<document.forms[j].elements.length;i++) {
			if(document.forms[j].elements[i].type != null) {
				if(document.forms[j].elements[i].type.indexOf('select') == 0)
					document.forms[j].elements[i].style.visibility = visibility;
			}
		}
	}
}

function CalendarPopup_GetOffsetControl(tbName,lblName) {
	var obj,tmpObj;
	if (lblName != '') {
		obj = document.getElementById(lblName);
	} else if (tbName != '') {
		if (obj==null)
			obj = document.getElementById(tbName+"_buttonS");
		if (obj==null)
			obj = document.getElementById(tbName+"_dates");	
		if (obj==null)
			obj=document.getElementById(tbName+"_tb");
		if (obj==null)
			obj=document.getElementById(tbName);
	} else {
		alert("Unable to find offset control");
	}
	return obj;
}

function CalendarPopup_Up_DisplayCalendarByWeek(tbName, lblName, divName, myName, funcName, myFuncName, stringDate, wdStyle, weStyle, omStyle, sdStyle, mhStyle, dhStyle, cdStyle, tdStyle, wssStyle, holStyle, formatNum, monthnames, daynames, fdweek, sunNum, satNum, enableHide, includeYears, lBound, uBound, pad, postbackFunc, showClear, clearText, showGoToToday, goToTodayText, arrowUrl, customFunc, calWidth, visibleKey, nullText, dateArray, nextMonthImgUrl, prevMonthImgUrl, nextYearImgUrl, prevYearImgUrl, cellspacing, cellpadding,locQuad) {
	var offsetX=eval(tbName+"_offsetX");
	var offsetY=eval(tbName+"_offsetY");
	var mainObject = document.getElementById(tbName + "_outer");
	var customFormat = mainObject.getAttribute("outFormat");
	var controlDisplay = mainObject.getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")!=-1) controlDisplay="InPage";
	var CallBack = "";
	if (controlDisplay=="InPage")
		 CallBack = tbName+"_Up_CallClick();";	
	var format = customFormat.split("|,");
	var datePeriod = mainObject.getAttribute("datePeriod");
	if (format.length<=1)
		format = customFormat.split(",");
	if (format[0]!="")
		datePeriod="Custom";
	var dateToday = new Date();
	var lowerDate = new Date(lBound);
	var upperDate = new Date(uBound);
	var todayDate = new Date(stringDate);
	var curDate = new Date(CalendarPopup_Up_GetDate(tbName, formatNum, monthnames));
	var monthdays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var dayNum = curDate.getDay();
	var dayDifference = fdweek-dayNum;
	if (dayDifference>0)
		dayDifference -= 7;
	dayNum = curDate.getDate()+dayDifference;
	var testMonth = curDate.getMonth();
	if (dayNum<=0) {
		dayNum+=monthdays[testMonth];
		testMonth--;
	}
	else if (dayNum>monthdays[testMonth]) {
		dayNum -= curDate.getDate();
		testMonth++;
	}
	curDate = new Date(curDate.getFullYear(),testMonth,dayNum);
	var curMonth = curDate.getMonth();
	var curYear = curDate.getFullYear();
	thisday=todayDate.getDay();
	thismonth=todayDate.getMonth();
	thisdate=todayDate.getDate();
	thisyear=todayDate.getFullYear();
	if ((((thisyear % 4 == 0) && !(thisyear % 100 == 0)) ||(thisyear % 400 == 0)))
		monthdays[1]++;
	var outputString = '';
	startspaces=thisdate;
	var prevMonth = thismonth;
	var prevDay = thisdate;
	var prevYear = thisyear;
	var thisPreviousYear = thisyear - 1;
	var thisNextYear = thisyear + 1;
	if(prevMonth < 1) {
		prevMonth = 12;
		prevYear = prevYear - 1;
	}
	if(thisdate > monthdays[prevMonth - 1])
		prevDay = monthdays[prevMonth - 1];
	var nextMonth = thismonth + 2;
	var nextDay = thisdate;
	var nextYear = thisyear;
	if(nextMonth > 12) {
		nextMonth = 1;
		nextYear = nextYear + 1;
	}
	if(thisdate > monthdays[nextMonth - 1])
		nextDay = monthdays[nextMonth - 1];
	while (startspaces > 7)
		startspaces-=7;
	startspaces = thisday - startspaces + 1;
	startspaces = startspaces - fdweek;
	while (startspaces < 0)
		startspaces+=7;
	outputString = outputString + '<table';
	if(calWidth > 0)
		outputString = outputString + ' width=\"' + calWidth + 'px\"';
	outputString = outputString + ' style=\"border: black 1px solid;\" border=0 cellspacing=' + cellspacing +' cellpadding='+cellpadding+'>';
	if(prevMonthImgUrl == '')
		outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay+ "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><</a><br>";
	else
		outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay+ "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + prevMonthImgUrl + "\" border=0></a><br>";
	if (includeYears)
		if(prevYearImgUrl == '')
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisPreviousYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><<</a></td>";
		else
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisPreviousYear +"',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + prevYearImgUrl + "\" border=0></a></td>";
	outputString = outputString + '<td colspan=6 nowrap align=center ' +mhStyle + "><a " + mhStyle + " href='#' onclick=\"parent." + myFuncName + "('" + (thismonth + 1) + "/1/" + thisyear + "',"+offsetX+","+offsetY+","+locQuad+",window);return false;\">" + monthnames[thismonth] + ' ' + thisyear;
	if(arrowUrl != "")
		outputString = outputString + ' <img src=\"' + arrowUrl + '\" border=0>';
	outputString = outputString + '</a></td>';
	if(nextMonthImgUrl == '')
		outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay+ "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\">></a><br>";
	else
		outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay+ "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + nextMonthImgUrl + "\" border=0></a><br>";
	if (includeYears)
		if(nextYearImgUrl == '')
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisNextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\">>></a></td></tr>";
		else
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisNextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + nextYearImgUrl + "\" border=0></a></td></tr>";
		
	outputString = outputString + '<tr>';
	outputString = outputString + '<td ' + dhStyle + ' align=center> </td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[0] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[1] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[2] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[3] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[4] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[5] + '</td>';
	outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[6] + '</td>';
	outputString = outputString + '</tr>';
	
	var onclickStr = "";
	var weekDay=0;
	for (s=0;s<startspaces;s++) {
		var theDate, month, year;
		if(thismonth == 0) {
			theDate = monthdays[11] - (startspaces - (s + 1));
			month = 12;
			year = thisyear - 1;
		} else {
			theDate = monthdays[thismonth - 1] - (startspaces - (s + 1));
			month = thismonth;
			year = thisyear;
		}
		var theCurDate = new Date(month + "/" + theDate + "/" + year);
		var lowerAmount = (lowerDate - theCurDate);
		var upperAmount = (theCurDate - upperDate);
		var style = ((theDate==curDate.getDate() && month==(curDate.getMonth()+1)) || chekMulti(theDate,month-1,year,tbName))?sdStyle:"";
		if (style != "") weekDay=7;
		if ((lowerAmount >0 && upperAmount<0) || (upperAmount>0 && lowerAmount<0)) {
			if(s == 0)
				outputString += "<tr "+style+"><td "+omStyle+" align=center><span "+omStyle+">></span></td>";
		} else {
			onclickStr = "\"parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + month + "/" + theDate + "/" + year +"', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"\"";
			if(s == 0)
				outputString += "<tr "+style+" onclick="+onclickStr+"><td "+wssStyle+" align=center><a "+wssStyle+" onclick=\"return false;\" href='#'>></a></td>";
		}
		if (weekDay) {
			outputString += "<td align=center " + sdStyle + "><span " + sdStyle + ">" + theDate + "</span></td>";
			weekDay--;
		} else
			outputString += "<td align=center " + omStyle + "><span " + omStyle + ">" + theDate + "</span></td>";
	}
	count=1;
	while (count <= monthdays[thismonth]) {
		for (b = startspaces;b<7;b++) {
			if(b == 0) {
				if ((lowerAmount >0 && upperAmount<0) || (upperAmount>0 && lowerAmount<0))
					onclickStr = "";
				else
					onclickStr = "\"parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + (thismonth+1) + "/" + count + "/" + thisyear +"', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"\"";
				if ((count==curDate.getDate() && thismonth == curMonth && thisyear == curYear)||chekMulti(count,thismonth,thisyear,tbName))
					if ((lowerAmount >0 && upperAmount<0) || (upperAmount>0 && lowerAmount<0)) 
						outputString += "<tr "+wssStyle+"><td "+omStyle+" align=center><span "+omStyle+">></span></td>"; 
					else {
						outputString += "<tr onclick="+onclickStr+" "+sdStyle+"><td "+wssStyle+" align=center><a "+wssStyle+" onclick=\"return false;\" href='#'>></a></td>"; 
						weekDay=7;
					}
				else
					if ((lowerAmount >0 && upperAmount<0) || (upperAmount>0 && lowerAmount<0))
						outputString += "<tr><td "+omStyle+" align=center><span "+omStyle+">></span></td>";
					else 
						outputString += "<tr onclick="+onclickStr+"><td align=center "+wssStyle+"><a "+wssStyle+" onclick=\"return false;\" href='#'>></a></td>";
			}
			if(weekDay) {
				if (weekDay){
					outputString = outputString + '<td align=center ' + sdStyle + '>';
				}
				else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray))
					outputString = outputString + '<td align=center ' + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + '>';
				else if(thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear())
						outputString = outputString + '<td align=center ' + tdStyle + '>';
			} else {
				if (count <= monthdays[thismonth]) {
					if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
						outputString = outputString + '<td align=center ' + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + '>';
					} else {
						if(b!=sunNum && b!=satNum) {
							outputString = outputString + '<td align=center ' + wdStyle + '>';
						} else {
							outputString = outputString + '<td align=center ' + weStyle + '>';
						}
					}
				} else {
					outputString = outputString + '<td align=center ' + omStyle + '>';
				}
			}
			if (count <= monthdays[thismonth]) {
				var theCurDate = new Date((thismonth + 1) + "/" + count + "/" + thisyear);
				var lowerAmount = (lowerDate - theCurDate);
				var upperAmount = (theCurDate - upperDate);
				if (weekDay) {
					if (weekDay) {
						weekDay--;						
						if (CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray))
							outputString = outputString + "<span " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ sdStyle + ">" + count + "</span>";
						else
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>";
					} else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>"; 
						else
							outputString = outputString + "<span " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>";
					} else 	
					if(thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear()) 
						outputString = outputString + "<span " + tdStyle + ">" + count + "</span>"; 
				} else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
					if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
						outputString = outputString + "<span " + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>"; 
					else
						outputString = outputString + "<span " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>";
				} else if(b!=sunNum && b!=satNum && count != thisdate) {
					outputString = outputString + "<span " + wdStyle + ">" + count + "</span>"; 
				} else if(b!=sunNum && b!=satNum) {
					outputString = outputString + "<span " + wdStyle + ">" + count + "</span>";
				} else {
					outputString = outputString + "<span " + weStyle + ">" + count + "</span>"; 
				}
			} else {
				var month, year;
				if(thismonth == 11) {
					month = 1;
					year = thisyear + 1;
				} else {
					month = thismonth + 2;
					year = thisyear;
				}
				var theCurDate = new Date(month + "/" + (count - monthdays[thismonth]) + "/" + year);
				var lowerAmount = (lowerDate - theCurDate);
				var upperAmount = (theCurDate - upperDate);
				if (weekDay) {
					outputString += "<span " + sdStyle + ">" + (count - monthdays[thismonth]) + "</span>";
					weekDay--;
				} else			
					outputString += "<span " + omStyle + ">" + (count - monthdays[thismonth]) + "</span>";
			}
			outputString = outputString + '</td>';
			count++;
		}
		outputString = outputString + '</tr>';
		startspaces=0;
		weekDay=0;
	}
	if(showClear && controlDisplay!="InPage")
		outputString = outputString + "<tr><td nowrap " + cdStyle + " colspan=\"8\" align=\"center\"><a " + cdStyle + " href='#' onclick=\"parent.CalendarPopup_Up_ClearDate('" + tbName + "','" + lblName + "','" + divName + "', '" + myName + "', " + enableHide + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "', '" + nullText + "');\">" + clearText + "</a></td></tr>";
	outputString = outputString + '</table>';
	document.getElementById(divName).innerHTML = outputString;
	switch (locQuad)
	{
		case 2:
			offsetX-=document.getElementById(divName).offsetWidth;
			break;
		case 4:
			offsetY-=document.getElementById(divName).offsetHeight;
			break;
	}
	if (controlDisplay!="InPage") {
		if (CalendarPopup_CurrentCalendar != window)
			CalendarPopup_CurrentCalendar.hide();
		CalendarPopup_CurrentCalendar = window.createPopup();
		CalendarPopup_CurrentCalendar.document.write( "<head>"+getCSS()+"</"+"head>");
		CalendarPopup_CurrentCalendar.document.write("<body style='OVERFLOW: hidden;BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px;PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px'>"+document.getElementById(divName).innerHTML+"</"+"body>");
		CalendarPopup_CurrentCalendar.show(
			CalendarPopup_CurrentCalendarRelatedControl.offsetWidth +offsetX,
			offsetY, 
			document.getElementById(divName).offsetWidth - 4, 
			document.getElementById(divName).offsetHeight - 4,
			CalendarPopup_CurrentCalendarRelatedControl);	
	} else {
		CalendarPopup_CurrentCalendar = window;
	}
}



function CalendarPopup_Up_DisplayCalendarByDate(tbName, lblName, divName, myName, funcName, myFuncName, stringDate, wdStyle, weStyle, omStyle, sdStyle, mhStyle, dhStyle, cdStyle, tdStyle, gttStyle, holStyle, formatNum, monthnames, daynames, fdweek, sunNum, satNum, enableHide, includeYears, lBound, uBound, pad, postbackFunc, showClear, clearText, showGoToToday, goToTodayText, arrowUrl, customFunc, calWidth, visibleKey, nullText, dateArray, nextMonthImgUrl, prevMonthImgUrl, nextYearImgUrl, prevYearImgUrl, cellspacing, cellpadding,locQuad) {
	var offsetX=eval(tbName+"_offsetX");
	var offsetY=eval(tbName+"_offsetY");
	var mainObject = document.getElementById(tbName + "_outer");
	var datePeriod = mainObject.getAttribute("datePeriod");
	var customFormat = mainObject.getAttribute("outFormat");
	var controlDisplay = mainObject.getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")!=-1) controlDisplay="InPage";
	var CallBack = "";
	if (controlDisplay=="InPage")
		 CallBack = tbName+"_Up_CallClick();";	
	var format = customFormat.split("|,");
	if (format.length<=1)
		format = customFormat.split(",");
	if (format[0]!="")
		datePeriod="Custom";
	var dayAndMonth = false;
	if (datePeriod=="DayAndMonth") {
		dayAndMonth = true;
	}
 	var dateToday = new Date();
	var lowerDate = new Date(lBound);
	var upperDate = new Date(uBound);
	var todayDate = new Date(stringDate);
	var curDate = new Date(CalendarPopup_Up_GetDate(tbName, formatNum, monthnames));
	var curMonth = curDate.getMonth();
	var curYear = curDate.getFullYear();
	var monthdays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	thisday=todayDate.getDay();
	thismonth=todayDate.getMonth();
	thisdate=todayDate.getDate();
	thisyear=todayDate.getFullYear();
	if (dayAndMonth) {
		temp = new Date();
		thisyear = temp.getFullYear();
		todayDate = new Date(thismonth+"/"+thisdate+"/"+thisyear);
	}
	if ((((thisyear % 4 == 0) && !(thisyear % 100 == 0)) ||(thisyear % 400 == 0))||(dayAndMonth))
		monthdays[1]++;
	var outputString = '';
	startspaces=thisdate;
	var prevMonth = thismonth;
	var prevDay = thisdate;
	var prevYear = thisyear;
	var thisPreviousYear = thisyear - 1;
	var thisNextYear = thisyear + 1;
	if(prevMonth < 1) {
		prevMonth = 12;
		if (!dayAndMonth) {		
			prevYear = prevYear - 1;
		}
	}
	if(thisdate > monthdays[prevMonth - 1])
		prevDay = monthdays[prevMonth - 1];
	var nextMonth = thismonth + 2;
	var nextDay = thisdate;
	var nextYear = thisyear;
	if(nextMonth > 12) {
		nextMonth = 1;
		if (!dayAndMonth) {		
			nextYear = nextYear + 1;
		}
	}
	if(thisdate > monthdays[nextMonth - 1])
		nextDay = monthdays[nextMonth - 1];
	if (!dayAndMonth) {		
		while (startspaces > 7)
			startspaces-=7;
		startspaces = thisday - startspaces + 1;
		startspaces = startspaces - fdweek;
		if (startspaces < 0)
			startspaces+=7;
	} else {
	startspaces=0;
	}
	outputString = outputString + '<table';
	if(calWidth > 0)
		outputString = outputString + ' width=\"' + calWidth + 'px\"';
	outputString = outputString + ' style=\"border: black 1px solid;\" border=0 cellspacing=' + cellspacing +' cellpadding='+cellpadding+'>';
	if (dayAndMonth) {
		includeYears==false;
	}
	if (includeYears == false) {
		if(prevMonthImgUrl == '')
			outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay + "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><</a></td>";
		else
			outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay + "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + prevMonthImgUrl + "\" border=0></a></td>";
	} else {
		if(prevMonthImgUrl == '')
			outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay+ "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><</a><br>";
		else
			outputString = outputString + "<tr " + mhStyle + "><td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + prevMonth + "/" + prevDay+ "/" + prevYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + prevMonthImgUrl + "\" border=0></a><br>";
		
		if(prevYearImgUrl == '')
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisPreviousYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><<</a></td>";
		else
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisPreviousYear +"',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + prevYearImgUrl + "\" border=0></a></td>";
	}
	if (!dayAndMonth) {	
		outputString = outputString + '<td colspan=5 nowrap align=center ' +mhStyle + "><a " + mhStyle + " href='#' onclick=\"parent." + myFuncName + "('" + (thismonth + 1) + "/1/" + thisyear + "',"+offsetX+","+offsetY+","+locQuad+",window);return false;\">" + monthnames[thismonth] + ' ' + thisyear;
	} else {
		outputString = outputString + '<td colspan=5 nowrap align=center ' +mhStyle + "><a " + mhStyle + " href='#' onclick=\"parent." + myFuncName + "('" + (thismonth + 1) + "/1/" + thisyear + "',"+offsetX+","+offsetY+","+locQuad+",window);return false;\">" + monthnames[thismonth];
	}
	if(arrowUrl != "")
		outputString = outputString + ' <img src=\"' + arrowUrl + '\" border=0>';
	outputString = outputString + '</a></td>';
	if (includeYears == false) {
		if(nextMonthImgUrl == '')
			outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay + "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\">></a></td></tr>";
		else
			outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay + "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + nextMonthImgUrl + "\" border=0></a></td></tr>";
	} else {
		if(nextMonthImgUrl == '')
			outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay+ "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\">></a><br>";
		else
			outputString = outputString + "<td align=center><a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + nextMonth + "/" + nextDay+ "/" + nextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + nextMonthImgUrl + "\" border=0></a><br>";
		
		if(nextYearImgUrl == '')
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisNextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\">>></a></td></tr>";
		else
			outputString = outputString + "<a " + mhStyle + " href='#' onclick=\"parent." + funcName + "('" + (thismonth + 1) + "/" + thisdate + "/" + thisNextYear + "',"+offsetX+","+offsetY+","+locQuad+");return false;\"><img src=\"" + nextYearImgUrl + "\" border=0></a></td></tr>";
	}
	if (!dayAndMonth)
	{
		outputString = outputString + '<tr>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[0] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[1] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[2] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[3] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[4] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[5] + '</td>';
		outputString = outputString + '<td ' + dhStyle + ' align=center>' + daynames[6] + '</td>';
		outputString = outputString + '</tr>';
	}
	for (s=0;s<startspaces;s++) {
		var theDate, month, year;
		if(thismonth == 0) {
			theDate = monthdays[11] - (startspaces - (s + 1));
			month = 12;
			year = thisyear - 1;
		} else {
			theDate = monthdays[thismonth - 1] - (startspaces - (s + 1));
			month = thismonth;
			year = thisyear;
		}
		var theCurDate = new Date(month + "/" + theDate + "/" + year);
		var lowerAmount = (lowerDate - theCurDate);
		var upperAmount = (theCurDate - upperDate);	
		if(s == 0)
			outputString = outputString + '<tr>';
		var click = "onclick = \"parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + month + "/" + theDate + "/" + year + "', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"return false;\"";
		if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
			outputString = outputString + "<td align=center " + omStyle + "\">" + theDate + "</td>";
		else if(s!=sunNum && s!=satNum)
			outputString = outputString + "<td align=center " + omStyle + "><a " + omStyle + " href='#' "+click+">" + theDate + "</a></td>";
		else
			outputString = outputString + "<td align=center " + omStyle + "><a " + omStyle + " href='#' "+click+">" + theDate + "</a></td>";
	}
	count=1;
	while (count <= monthdays[thismonth]) {
		for (b = startspaces;b<7;b++) {
			if(b == 0)
				outputString = outputString + '<tr>';	
			if((thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear()) || (count==curDate.getDate() && thismonth == curMonth && thisyear == curYear && document.getElementById(tbName).value != '')) {
				if (chekMulti(count,thismonth,thisyear,tbName)) {
						outputString = outputString + '<td align=center ' + sdStyle + '>';
				}else
				if (count==curDate.getDate() && (thismonth == curMonth) && thisyear == curYear && document.getElementById(tbName).value != '')
					outputString = outputString + '<td align=center ' + sdStyle + '>';
				else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray))
					outputString = outputString + '<td align=center ' + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + '>';
				else if(thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear())
					if (dayAndMonth)
						outputString = outputString + '<td align=center ' + wdStyle + '>';
					else
						outputString = outputString + '<td align=center ' + tdStyle + '>';
			} else {
				if (count <= monthdays[thismonth]) {
					//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						outputString = outputString + '<td align=center ' + sdStyle + '>';
						}else//
					if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
						outputString = outputString + '<td align=center ' + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + '>';
					} else {
						if(b!=sunNum && b!=satNum) {
							outputString = outputString + '<td align=center ' + wdStyle + '>';
						} else {
							if (!dayAndMonth) {
								outputString = outputString + '<td align=center ' + weStyle + '>';
							} else {
								outputString = outputString + '<td align=center ' + wdStyle + '>';
							}
						}
					}
				} else {
					outputString = outputString + '<td align=center ' + omStyle + '>';
				}
			}
			if (count <= monthdays[thismonth]) {
				var theCurDate = new Date((thismonth + 1) + "/" + count + "/" + thisyear);
				var lowerAmount = (lowerDate - theCurDate);
				var upperAmount = (theCurDate - upperDate);
				var onclickStr = "\"parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + (thismonth + 1) + "/" + count + "/" + thisyear +"', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"return false;\"";
				if ((thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear()) || (count==curDate.getDate() && thismonth == curMonth && thisyear == curYear && document.getElementById(tbName).value != '')) {
					if ((count==curDate.getDate() && thismonth == curMonth && thisyear == curYear && document.getElementById(tbName).value != '')) {							
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							if (CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray))
								outputString = outputString + "<a " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
							else
								outputString = outputString + "<a " + sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
					} else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + " href='#' onclick="+onclickStr+">" + count + "</a>";
					} else 	
					if(thismonth == dateToday.getMonth() && count == dateToday.getDate() && thisyear == dateToday.getFullYear()) {
						if (dayAndMonth) {
							if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
								outputString = outputString + "<span " + wdStyle + ">" + count + "</span>"; 
							else
								outputString = outputString + "<a " + wdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + tdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + tdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
					}
				} else if(CalendarPopup_Up_IsHoliday(thismonth, count, thisyear, dateArray)) {
					//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+" "+ sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else//
					if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
						outputString = outputString + "<span " + CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + ">" + count + "</span>"; 
					else
						outputString = outputString + "<a " +CalendarPopup_Up_GetDescHoliday(thismonth,count, thisyear, dateArray)+ CalendarPopup_Up_GetStyleHoliday(thismonth,count, thisyear, dateArray,holStyle) + " href='#' onclick="+onclickStr+">" + count + "</a>";
				} else if(b!=sunNum && b!=satNum && count != thisdate) {
					//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else//
					if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
						outputString = outputString + "<span " + wdStyle + ">" + count + "</span>"; 
					else
						outputString = outputString + "<a " + wdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
				} else if(b!=sunNum && b!=satNum) {
				//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else//
					if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
						outputString = outputString + "<span " + wdStyle + ">" + count + "</span>"; 
					else
						outputString = outputString + "<a " + wdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
				} else {
					if (!dayAndMonth) {
					//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else//
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + weStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + weStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
					} else {
					//
					if (chekMulti(count,thismonth,thisyear,tbName)) {
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + sdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + sdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
						}else//
						if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
							outputString = outputString + "<span " + wdStyle + ">" + count + "</span>"; 
						else
							outputString = outputString + "<a " + wdStyle + " href='#' onclick="+onclickStr+">" + count + "</a>";
					}
				}
			} else {
			if (!dayAndMonth){
			
				var month, year;
				if(thismonth == 11) {
					month = 1;
					year = thisyear + 1;
				} else {
					month = thismonth + 2;
					year = thisyear;
				}
				var theCurDate = new Date(month + "/" + (count - monthdays[thismonth]) + "/" + year);
				var lowerAmount = (lowerDate - theCurDate);
				var upperAmount = (theCurDate - upperDate);	
					onclickStr = "\"parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + (1+theCurDate.getMonth()) + "/" + theCurDate.getDate() + "/" + theCurDate.getFullYear() +"', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"return false;\"";
				if((lowerAmount > 0 && upperAmount < 0) || (upperAmount > 0 && lowerAmount < 0))
					outputString = outputString + "<span " + omStyle + ">" + (count - monthdays[thismonth]) + "</span>";
				else
					outputString = outputString + "<a " +omStyle + " href='#' onclick="+onclickStr+">" + (count - monthdays[thismonth]) + "</a>";
			}
			}
			outputString = outputString + '</td>';
			count++;
		}
		outputString = outputString + '</tr>';
		startspaces=0;
	}
	if(showGoToToday && !dayAndMonth) {
		var shortDate = (dateToday.getMonth() + 1) + "/" + dateToday.getDate() + "/" + dateToday.getFullYear();
		outputString = outputString + "<tr><td nowrap " + gttStyle + " colspan=\"7\" align=\"center\">" + goToTodayText + " <a " + gttStyle + " href='#' onclick=\"javascript:parent.CalendarPopup_Up_SelectDate('" + tbName + "','" + lblName + "','" + divName + "','" + myName + "','" + shortDate + "', " + formatNum + ", " + enableHide + ", " + pad + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "','"+monthnames+"');"+CallBack+"\">" + CalendarPopup_Up_DetermineDateString(shortDate, formatNum, pad, datePeriod, monthnames,format) + "</a></td></tr>";
	}
	if(showClear&& !dayAndMonth && controlDisplay!="InPage")
		outputString = outputString + "<tr><td nowrap " + cdStyle + " colspan=\"7\" align=\"center\"><a " + cdStyle + " href='#' onclick=\"parent.CalendarPopup_Up_ClearDate('" + tbName + "','" + lblName + "','" + divName + "', '" + myName + "', " + enableHide + ", '" + postbackFunc + "', '" + customFunc + "', '" + visibleKey + "', '" + nullText + "');\">" + clearText + "</a></td></tr>";
	outputString = outputString + '</table>';
	//gib
	document.getElementById(divName).innerHTML = outputString;
	switch (locQuad)
	{
		case 2:
			offsetX-=document.getElementById(divName).offsetWidth;
			break;
		case 4:
			offsetY-=document.getElementById(divName).offsetHeight;
			break;
	}
	if (controlDisplay!="InPage") {
		try {
			if (CalendarPopup_CurrentCalendar != window)
				CalendarPopup_CurrentCalendar.hide();
		} catch(e) {}
		CalendarPopup_CurrentCalendar = window.createPopup();
		CalendarPopup_CurrentCalendar.document.write( "<head>"+getCSS()+"</"+"head>");
		CalendarPopup_CurrentCalendar.document.write("<body style='OVERFLOW: hidden;BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px;PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px'>"+document.getElementById(divName).innerHTML+"</"+"body>");
		CalendarPopup_CurrentCalendar.show(
			CalendarPopup_CurrentCalendarRelatedControl.offsetWidth +offsetX,
			offsetY, 
			document.getElementById(divName).offsetWidth - 4, 
			document.getElementById(divName).offsetHeight - 4,
			CalendarPopup_CurrentCalendarRelatedControl);	
	} else {
		CalendarPopup_CurrentCalendar = window;
	}
}

function chekMulti(d,m,y,tbName)
{
	var multi=false;
	var multiMode = document.getElementById(tbName + "_outer").getAttribute("displayType");
	if (multiMode.substring(0,8)=="Multiple"){
		var list = document.getElementById(tbName + "_dates");
		var date = new Date((m+1)+"/"+d+"/"+y);
		for (i=0;i<list.options.length;i++)	{
			var mdate = new Date(list.options[i].value);
			if (mdate.getDate()==date.getDate()&&mdate.getMonth()==date.getMonth()&&mdate.getFullYear()==date.getFullYear())
			{
				multi=true;
				break;
			}
		}
	}
	return multi;
}

function getCSS(){
		var links = document.getElementsByTagName("link");
		var s = "";

		for(i = 0; i < links.length; i++){
			s += links[i].outerHTML;
		}
		var style = document.getElementsByTagName("style");
		for(i = 0; i < style.length; i++){
			s += style[i].outerHTML;
		}
		return s;
}

function CalendarPopup_Up_DetermineDateString(inDate, formatNum, pad, datePeriod, monthnames,format) {
	var theDate;
	switch(datePeriod) {
			case "HalfYears":
				theDate = CalendarPopup_Up_DetermineHDate(inDate);
				break;
			case "MonthAndYear": 
				theDate = CalendarPopup_Up_DetermineMYDate(inDate, formatNum, monthnames);
				break;
			case "DayAndMonth": 
				theDate = CalendarPopup_Up_DetermineDMDate(inDate, formatNum, pad,monthnames);
				break;
			case "QuarterYears":
				theDate = CalendarPopup_Up_DetermineQDate(inDate);
				break;
			case "Custom":
				theDate = CalendarPopup_Up_DetermineCustomDate(inDate, monthnames,format);
				break;
			default: 
				theDate = CalendarPopup_Up_DetermineDate(inDate, formatNum, pad);
				break;
		}
	return theDate;
}

function CalendarPopup_Up_DetermineCustomDate(inDate,monthnames,format){
	var theDate = '';
	var theDateArr = inDate.split("/");
	if (theDateArr.length==3) {
		theDateArr[2] =theDateArr[2].split(" ")[0]; 
		for(i=0;i<3;i++) {
			switch(format[i]){
				case "D":
					theDate+=(theDateArr[1]+format[i+3]);
					break;
				case "DD":
					if (theDateArr[1]<10)
						theDateArr[1]="0"+theDateArr[1];
					theDate+=(theDateArr[1]+format[i+3]);
					break;
				case "M":
					theDate+=(theDateArr[0]+format[i+3]);
					break;
				case "MM":
					if (theDateArr[0]<10)
						theDateArr[0]="0"+theDateArr[0];
					theDate+=(theDateArr[0]+format[i+3]);
					break;
				case "MMM":
					theDate+=(monthnames[theDateArr[0]-1].substring(0,3)+format[i+3]);
					break;
				case "MMMM":
					theDate+=(monthnames[theDateArr[0]-1]+format[i+3]);
					break;
				case "YY":
					theDate+=(theDateArr[2].substring(2,4)+format[i+3]);
					break;
				case "YYYY":
					theDate+=(theDateArr[2]+format[i+3]);
					break;
			}
		}
	}
	return theDate;	
}

function CalendarPopup_Up_DetermineHDate(inDate){
	var theDateArr = inDate.split("/");
	var theDate;
	if (theDateArr[0] <7)
		theDate = "H1";
	else 
		theDate = "H2";
	theDate +=" "+ theDateArr[2];
	return theDate;
}

function CalendarPopup_Up_DetermineQDate(inDate){
	var theDateArr = inDate.split("/");
	var theDate;
	if (theDateArr[0] <7)
		if  (theDateArr[0] <4)
			theDate = "Q1";
		else 
			theDate = "Q2";
	else if (theDateArr[0] <10)
			theDate="Q3";
		else
			theDate="Q4";		
	theDate +=" "+ theDateArr[2];
	return theDate;
}

function CalendarPopup_Up_DetermineDMDate(inDate, formatNum, pad, monthnames) {
	var theDateArr = inDate.split("/");
	var theDate;
	switch(formatNum) {
		case 1: // In:MM/DD/YYYY Out: MM DD
		case 3:
		case 4:
		case 6:
		case 7:
		case 9:		
			theDate = monthnames[theDateArr[0]-1];
			if (theDateArr[1]<10&&pad)
				theDate+=" 0"+theDateArr[1];
			else
				theDate+=" "+theDateArr[1];
			
			break;
		case 2:
		case 5: // In:MM/DD/YYYY  Out: DD MM
		case 8:
			if (theDateArr[1]<10&&pad)
				theDate="0"+theDateArr[1];
			else
				theDate=theDateArr[1];
			theDate +=" "+ monthnames[theDateArr[0]-1];
			break;
	}
	return theDate;
}

function CalendarPopup_Up_DetermineMYDate(inDate, formatNum, monthnames) {
	monthnames = monthnames.split(",");
	var theDateArr = inDate.split("/");
	var theDate;
		switch(formatNum) {
			case 1: // In: MM/DD/YYYY Out: MM YYYY
			case 2:
			case 4:
			case 5:
			case 7:
			case 8:
			case 9:
				theDate = monthnames[theDateArr[0]-1].concat(" ").concat(theDateArr[2]);
				break;
			case 6:
			case 3: // In: MM/DD/YYYY Out: YYYY/MM/DD
				theDate = theDateArr[2].concat(" ").concat(monthnames[theDateArr[0]-1]);
		}
	return theDate;
}

function CalendarPopup_Up_DetermineDate(inDate, formatNum, pad) {
	var theDateArr = inDate.split("/");
	if(theDateArr.length != 3) {
		theDateArr = document.getElementById(tbName).value.split(".");
		if(theDateArr.length != 3) {
			theDateArr = document.getElementById(tbName).value.split("-");
		}		
	}
	if(pad) {
		if(parseFloat(theDateArr[0]) < 10 && theDateArr[0].length == 1)
			theDateArr[0] = '0' + theDateArr[0];
		if(parseFloat(theDateArr[1]) < 10 && theDateArr[1].length == 1)
			theDateArr[1] = '0' + theDateArr[1];
		if(parseFloat(theDateArr[2]) < 10 && theDateArr[2].length == 1)
			theDateArr[2] = '0' + theDateArr[2];
	}

		var theDate;
		switch(formatNum) {
			case 1: // In: MM/DD/YYYY Out: MM/DD/YYYY
				theDate = theDateArr[0].concat("/").concat(theDateArr[1]).concat("/").concat(theDateArr[2]);
				break;
			case 2: // In: MM/DD/YYYY Out: DD/MM/YYYY
				theDate = theDateArr[1].concat("/").concat(theDateArr[0]).concat("/").concat(theDateArr[2]);
				break;
			case 3: // In: MM/DD/YYYY Out: YYYY/MM/DD
				theDate = theDateArr[2].concat("/").concat(theDateArr[0]).concat("/").concat(theDateArr[1]);
				break;
			case 4: // In MM.DD.YYYY Out: MM.DD.YYYY
				theDate = theDateArr[0].concat(".").concat(theDateArr[1]).concat(".").concat(theDateArr[2]);
				break;
			case 5: // In MM.DD.YYYY Out: DD.MM.YYYY
				theDate = theDateArr[1].concat(".").concat(theDateArr[0]).concat(".").concat(theDateArr[2]);
				break;
			case 6: // In MM.DD.YYYY Out: YYYY.MM.DD
				theDate = theDateArr[2].concat(".").concat(theDateArr[0]).concat(".").concat(theDateArr[1]);
				break;
			case 7: // In MM-DD-YYYY Out: MM-DD-YYYY
				theDate = theDateArr[0].concat("-").concat(theDateArr[1]).concat("-").concat(theDateArr[2]);
				break;
			case 8: // In MM-DD-YYYY Out: DD-MM-YYYY
				theDate = theDateArr[1].concat("-").concat(theDateArr[0]).concat("-").concat(theDateArr[2]);
				break;
			case 9: // In MM-DD-YYYY Out: YYYY-MM-DD
				theDate = theDateArr[2].concat("-").concat(theDateArr[0]).concat("-").concat(theDateArr[1]);
				break;
		}
	return theDate;
}

function CalendarPopup_Up_SelectDate(tbName, lblName, divName, myName, theDate, formatNum, enableHide, pad, postbackFunc, customFunc, visibleKey,monthnames) {
	monthnames = monthnames.split(",");
	var multi = document.getElementById(tbName + "_outer").getAttribute("displayType");
	var datePeriod = document.getElementById(tbName + "_outer").getAttribute("datePeriod");
	var customFormat = document.getElementById(tbName + "_outer").getAttribute("outFormat");
	var format = customFormat.split("|,");
	if (format.length<=1)
		format = customFormat.split(",");
	if (format[0]!="")
		datePeriod="Custom";
	var val = CalendarPopup_Up_DetermineDateString(theDate, formatNum, pad, datePeriod,monthnames,format);
	var tb = document.getElementById(tbName+"_tb");
	var label = document.getElementById(lblName);
	var theDateArr = val.split("/");;
	if(theDateArr.length != 3) {
		theDateArr = val.split(".");
		if(theDateArr.length != 3) {			
			val.split("-");
		}
	}
	if (datePeriod!="SpecificDate")
		document.getElementById(tbName).value = val;
	else
		document.getElementById(tbName).value = val.split(" ")[0];
	if (tb!=null) {
		tb.value = val;
	}
	if(label !=null) {
		label.innerHTML = val;
	}
	var controlDisplay = document.getElementById(tbName + "_outer").getAttribute("controlDisplay");
	if (controlDisplay.indexOf("InPage")==-1) {
		document.getElementById(divName).style.visibility = 'hidden';
		document.getElementById(myName).style.visibility = 'hidden';	
		//gib
		if (CalendarPopup_CurrentCalendar != window) {
			CalendarPopup_CurrentCalendar.hide();
			CalendarPopup_CurrentCalendar = window;
		}
	}				
	if (multi.substring(0,8)=="Multiple") {
		AddToList(tbName,val,theDate,visibleKey);
	}
	eval(postbackFunc + "();");
		
	if(enableHide)
		CalendarPopup_Up_ShowHideDDL('visible');
	if(customFunc != "")
		eval(customFunc + "('" + theDate + "', '" + tbName + "');");
	eval(visibleKey + ' = \"' + theDate + '\";');
}
/////------------
//Multi
/////==========
function AddToList(tbName,val,theDate,visibleKey){
	var elem = document.getElementById(tbName+"_dates");
	var mainObject = document.getElementById(tbName+"_outer");
	var isInPage = (mainObject.getAttribute("ControlDisplay").indexOf("InPage")!=-1);
	var rFlag=false;
	for (i=0;i<elem.options.length;i++) {
		if (elem.options[i].text==val)	{
			elem.options.remove(i);
			rFlag = true;
		}
	}
	if (!rFlag){
		var oOption = document.createElement("OPTION");
		elem.options.add(oOption,0);
		oOption.text = val;
		oOption.value = theDate;
		if (!isInPage)	ShakerSort(elem);
		elem.selectedIndex=0;
		if (visibleKey!="")
		{		
			Change(elem,visibleKey);
		} else {
			elem.fireEvent("onchange");
			}
	}
	document.getElementById(tbName).value=GetAllValues(elem);
}

function GetAllValues(elem) {
	var rez="";
	for (i=0;i<elem.options.length;i++) {
		rez+=elem.options[i].text;
		if (i!=elem.options.length-1)
			rez+=";";
	}
	return rez;
}

function Change(me,visibleKey)
{
	eval(visibleKey+"='"+me.options[me.selectedIndex].value+"';");
}

function ShakerSort(elem) {
	var l=1,r=elem.options.length-1,k,tval,ttext;
	k=r;
	do {
		for(j=r;j>=l;j--) {
			if (new Date(elem.options[j-1].value)>new Date(elem.options[j].value)) {
				tval=elem.options[j-1].value; ttext=elem.options[j-1].text;
				elem.options[j-1].value = elem.options[j].value;
				elem.options[j-1].text = elem.options[j].text;
				elem.options[j].value = tval;
				elem.options[j].text = ttext;
				k=j;
			}
		}
		l=k+1;
		for(j=l;j<=r;j++) {
			if (new Date(elem.options[j-1].value)>new Date(elem.options[j].value)) {
				tval=elem.options[j-1].value; ttext=elem.options[j-1].text;
				elem.options[j-1].value = elem.options[j].value;
				elem.options[j-1].text = elem.options[j].text;
				elem.options[j].value = tval;
				elem.options[j].text = ttext;
				k=j;
			}
		}
		r=k-1;
	} while (l<=r);
}
/////------------
//End Multi
/////==========


function CalendarPopup_Up_ClearDate(tbName, lblName, divName, myName, enableHide, postbackFunc, customFunc, visibleKey, nullText) {
	var todayDate = new Date();
	document.getElementById(tbName+"_tb").value = '';
	document.getElementById(tbName).value = '';
	if(lblName != '')
		document.getElementById(lblName).innerHTML = nullText;
	//gib
	CalendarPopup_CurrentCalendar.hide();
	CalendarPopup_CurrentCalendar = window;
	//if(enableHide)
	//	CalendarPopup_Up_ShowHideDDL('visible');
	eval(postbackFunc + "();");
	if(customFunc != "")
		eval(customFunc + "('', '" + tbName + "');");
	eval(visibleKey + ' = \"' + (todayDate.getMonth() + 1) + '/' + todayDate.getDate() + '/' + todayDate.getFullYear() + ' 0:0\";');
}
//Time Picker function
function check(box,min,max,oldV)
{
	var str = box.value.substring(0,1);
	if (str=="0"){
		box.value=box.value.substring(1,2);
	}
	if (isNaN(parseFloat(box.value)))
		box.value = oldV;
	if (box.value>max) box.value=max;
	if (box.value<min) box.value=min;
	if (box.value<10)
		box.value="0"+box.value;
}

function RDP_up(box, min, max, howmuch)
{
	check(box,min,max);
	var newvalue = parseFloat(box.value) + howmuch;
	if (newvalue<=max)
		box.value = newvalue;
	else
		box.value=newvalue-max-1;
	if (box.value<10)
		box.value="0"+box.value;
	box.fireEvent("onchange");
}

function RDP_down(box, min, max, howmuch) 
{
	check(box,min,max);
	var newvalue = parseFloat(box.value) - howmuch;
	if (newvalue>=min)
		box.value = newvalue;
	else
		box.value = max+newvalue+1;
	if (box.value<10)
		box.value="0"+box.value;
	box.fireEvent("onchange");
}