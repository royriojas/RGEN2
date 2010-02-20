var text;
function CheckLength(val)
{
	if (text == null) text = val.innerHTML;
	var value = ValidatorTrim(ValidatorGetValue(val.controltovalidate));
	document.all[val.controltovalidate].style.backgroundColor="#FFFFFF";//CAY (Codigo de Aldo Yoplac) 12/05/2005 14:40
	if (value.length > val.maxLength)
	{
		val.innerHTML = text;
		document.all[val.controltovalidate].style.backgroundColor="#FFEBEB";//CAY (Codigo de Aldo Yoplac) 12/05/2005 14:40
		if (val.displayEntered.toLowerCase() == "true")
			val.innerHTML += " (" + value.length + " characters entered)";
		return false;
	}else{
		return true;
	} 
}
