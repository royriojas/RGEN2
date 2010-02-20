function CheckTime(str)
{
hora=str.value
if (hora=='') {return}
if (hora.length>5) {alert("Introdujo una cadena mayor a 5 caracteres");return}
if (hora.length!=5) {alert("Introducir HH:MM");return}
a=hora.charAt(0) //<=2
b=hora.charAt(1) //<4
c=hora.charAt(2) //:
d=hora.charAt(3) //<=5
e=hora.charAt(5) //:
f=hora.charAt(6) //<=5
if ((a==2 && b>3) || (a>2)) {alert("El valor que introdujo en la Hora no corresponde, introduzca un digito entre 00 y 23");return}
if (d>5) {alert("El valor que introdujo en los minutos no corresponde, introduzca un digito entre 00 y 59");return}
if (c!=':') {alert("Introduzca el caracter ':' para separar la hora, los minutos y los segundos");return}
}