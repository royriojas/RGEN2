	/* x_dom.js compiled from X 4.0 with XC 0.27b. Distributed by GNU LGPL. For copyrights, license, documentation and more visit Cross-Browser.com */
function xAppendChild(oParent, oChild){
	if (oParent.appendChild) return oParent.appendChild(oChild);else return null;
}
function xCreateElement(sTag){
	if (document.createElement) return document.createElement(sTag);else return null;
}
function xFirstChild(e, t){var c = e ? e.firstChild : null;if (t) while (c && c.nodeName != t) { c = c.nextSibling; }else while (c && c.nodeType != 1) { c = c.nextSibling; }return c;}
function xGetComputedStyle(oEle, sProp, bInt){var s, p = 'undefined';var dv = document.defaultView;if(dv && dv.getComputedStyle){s = dv.getComputedStyle(oEle,'');if (s) p = s.getPropertyValue(sProp);}else if(oEle.currentStyle) {var a = sProp.split('-');sProp = a[0];for (var i=1; i<a.length; ++i) {c = a[i].charAt(0);sProp += a[i].replace(c, c.toUpperCase());}   p = oEle.currentStyle[sProp];}else return null;return bInt ? (parseInt(p) || 0) : p;}
function xGetElementsByAttribute(sTag, sAtt, sRE, fn){var a, list, found = new Array(), re = new RegExp(sRE, 'i');list = xGetElementsByTagName(sTag);for (var i = 0; i < list.length; ++i) {a = list[i].getAttribute(sAtt);if (!a) {a = list[i][sAtt];}if (typeof(a)=='string' && a.search(re) != -1) {found[found.length] = list[i];if (fn) fn(list[i]);}}return found;}
function xGetElementsByClassName(c,p,t,f){var found = new Array();var re = new RegExp('\\b'+c+'\\b', 'i');var list = xGetElementsByTagName(t, p);for (var i = 0; i < list.length; ++i) {if (list[i].className && list[i].className.search(re) != -1) {found[found.length] = list[i];if (f) f(list[i]);}}return found;}
function xGetElementsByTagName(t,p){var list = null;t = t || '*';p = p || document;if (xIE4 || xIE5) {if (t == '*') list = p.all;else list = p.all.tags(t);}else if (p.getElementsByTagName) list = p.getElementsByTagName(t);return list || new Array();}
function xInnerHtml(e,h){if(!(e=xGetElementById(e)) || !xStr(e.innerHTML)) return null;var s = e.innerHTML;if (xStr(h)) {e.innerHTML = h;}return s;}function xNextSib(e,t){var s = e ? e.nextSibling : null;if (t) while (s && s.nodeName != t) { s = s.nextSibling; }else while (s && s.nodeType != 1) { s = s.nextSibling; }return s;}function xPrevSib(e,t){var s = e ? e.previousSibling : null;if (t) while(s && s.nodeName != t) {s=s.previousSibling;}else while(s && s.nodeType != 1) {s=s.previousSibling;}return s;}function xWalkEleTree(n,f,d,l,b){if (typeof l == 'undefined') l = 0;if (typeof b == 'undefined') b = 0;var v = f(n,l,b,d);if (!v) return 0;if (v == 1) {for (var c = n.firstChild; c; c = c.nextSibling) {if (c.nodeType == 1) {if (!l) ++b;if (!xWalkEleTree(c,f,d,l+1,b)) return 0;}}}return 1;}function xWalkTree(n, f){f(n);for (var c = n.firstChild; c; c = c.nextSibling) {if (c.nodeType == 1) xWalkTree(c, f);}}


//HelperFunctions RRRM 13/06/2006
function xGetURLArguments() {
    var idx = location.href.indexOf('?');
    var params = new Array();
    if (idx != -1) {
        var pairs = location.href.substring(idx+1, location.href.length).split('&');
        for (var i=0; i<pairs.length; i++) {
            nameVal = pairs[i].split('=');
            params[i] = nameVal[1];
            params[nameVal[0]] = nameVal[1];
        }
    }
    return params;
}
        
function xIsNull(obj,isNull_value) {
    if (!xDef(isNull_value)) isNull_value = '';
    if (xDef(obj)) return obj;
    else return isNull_value;
}

