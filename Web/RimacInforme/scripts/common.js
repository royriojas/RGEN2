/**
* @author Roy
*/
//http://phrogz.net/JS/Classes/OOPinJS2.html

/**
 * Enables the Object inheritance
 * 
 * @param {Object}
 *            parentClassOrObject
 */
Function.prototype.inherits = function(classOrObject) {
    if (classOrObject.constructor == Function) {
        var instance = new classOrObject;
        var instancePrototype = instance.constructor.prototype;
        $.extend(instancePrototype, instance);

        this.prototype = instance;
        this.prototype.constructor = this;

        this.prototype.parent = instancePrototype;
        this.prototype.parent.constructor = classOrObject;
    }
    else {
        this.prototype = classOrObject;
        this.prototype.constructor = this;
        this.prototype.parent = classOrObject;
    }
    return this;
};

jQuery.extend(
    {	getResourceString: function(resourceKey, defaultMessage) 
    	{
	        if (typeof (__resources) != 'undefined' && __resources[resourceKey] && __resources[resourceKey] !== "") {
	            return __resources[resourceKey];
	        }
	        else {
	            return defaultMessage;
	        }
    	},
        ellipsis: function(str, opts) {
            var options =
                {
                    ellipsisText: "...",
                    max: 150,
                    truncateWords: true
                };

            $.extend(options, opts);

            // TODO: check that options.max > options.ellipsisText
            if ((str.length <= options.max) || (options.max - options.ellipsisText.length < 0)) {
                return str;
            }

            str = str.substring(0, options.max - options.ellipsisText.length) + options.ellipsisText;

            return str;
        },
		roundNumber : function (num, dec) {
	        var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	        return result;
        },
        onDomReady: function(fn) {
            if (typeof (Sys) != 'undefined') {
                Sys.Application.add_load(fn);
                return;
            }
            $(document).ready(fn);
        },

        arrayIndexOf: function(array, element, options) {
            if (!$.isArray(array)) {
                return -1;
            }
            var opts =
                {
                    fEquals: null,
                    startIndex: 0
                };

            $.extend(opts, options);

            if (!$.isFunction(opts.fEquals)) {
                if (Array.prototype.indexOf) {
                    return array.indexOf(element, opts.startIndex);
                }
            }
            var comparer = opts.fEquals ||
            function(eleA, eleB) {
                return (eleB === eleA);
            };
            var ini = opts.startIndex;
            if (ini < 0) {
                ini = array.length + ini;
            }
            for (var ix = ini; ix < array.length; ix++) {
                if (comparer(array[ix], element)) {
                    return ix;
                }
            }
            return -1;
        },
        arrayMergeUnique: function(arrayA, arrayB, fEquals) {
            var tempArrA, tempArrB, returnArr;
            if ($.isArray(arrayA) && $.isArray(arrayB)) {
                var isALonger = (arrayA.length >= arrayB.length);
                tempArrA = isALonger ? arrayA : arrayB;
                tempArrB = isALonger ? arrayB : arrayA;

                returnArr = $.map(tempArrA, function(val, i) {
                    return val;
                });

                $.each(tempArrB, function(i, val) {
                    if (!$.arrayContains(tempArrA, val, fEquals)) {
                        returnArr.push(val);
                    }
                });
                return returnArr;
            }
            return null;
        },

        arrayRemove: function(array, element, fEquals) {
            var index = $.arrayIndexOf(array, element,
                {
                    "fEquals": fEquals
                });
            if (index > -1) {
                array.splice(index, 1);
            }
        },
        arrayContains: function(array, element, fEquals) {
            return $.arrayIndexOf(array, element, {
                "fEquals": fEquals
            }) >
            -1;
        },
        arrayUnique: function(array, fEquals) {
            var unique = [];
            $.each(array, function(i, ele) {
                if (!$.arrayContains(unique, ele, fEquals)) {
                    unique.push(ele);
                }
            });
            return unique;
        },

        arrayFilter: function(array, testFunction) {
            if (!$.isFunction(testFunction)) {
                return array;
            }
            if (Array.prototype.filter) {
                return array.filter(testFunction);
            }
            var arr = [];
            $.each(array, function(i, val) {
                if (testFunction(val, i)) {
                    arr.push(val);
                }
            });
            return arr;
        },

        arrayFind: function(array, testFunction) {
            var value = null;
            if ($.isFunction(testFunction)) {
                $.each(array, function(i, val) {
                    if (testFunction(val)) {
                        value = val;
                        return false;
                    }
                });
            }

            return value;

        },      
         

        /**
		 * Obtains the Current Time
		 */
        getCurrentTime: function() {
            return (new Date()).getTime();
        },

        TimeSpan:
            {
                timeElapsed: null,
                start: function() {
                    $.TimeSpan.timeElapsed = $.getCurrentTime();
                },
                end: function() {
                    return ($.getCurrentTime() - $.TimeSpan.timeElapsed);
                }
            },
        /**
		 * Creates a DummyConsole object in case the user doesn't have the
		 * firebug plugin or is using IE
		 */
        console: { verboseMode : true },
        createDummyConsole: function() {
            try {
                var names = ["debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd", "log"];
                if (!window.console || !console.firebug) {
                    window.console = {};
                    for (var i = 0; i < names.length; ++i) {
                        window.console[names[i]] = function() {

                        };
                    }
                }

                var oldConsoleLog = window.console.log;

                window.console.log = function() {
                    if ($.console.verboseMode) {
                        oldConsoleLog.apply(window.console, arguments);
                    }
                };
            }
            catch (ex) {

            }

        },
        /**
		 * erase the new lines characters from the string
		 * 
		 * @param {Object}
		 *            str
		 */
        stripNewLineCharacters: function(str) {
            return str.replace(/\r|\n|\r\n/g, "");
        },       
        createDelegate: function(obj, func) {
            arguments.slice = Array.prototype.slice;
            var f = function() {
                var args = [];
                for (var ix = 0; ix < arguments.length; ix++) {
                    args.push(arguments[ix]);
                }
                args = args.concat(f.args);

                return f.func.apply(f.target, args);
            };

            f.args = (arguments.length > 2) ? arguments.slice(2) : [];
            f.target = obj;
            f.func = func;
            return f;

        },        
        /**
		 * Create a namespace with the provided string
		 * 
		 * @param {String}
		 *            str_ns
		 */
        Namespace: function(str_ns) {
            var nsParts = str_ns.split(".");
            var root = window;
            for (var i = 0; i < nsParts.length; i++) {
                if (typeof root[nsParts[i]] == "undefined") {
                    root[nsParts[i]] = {};
                }
                root = root[nsParts[i]];
            }
			return root;
        },
        stringFormat: function(s) {
            for (var i = 1; i < arguments.length; i++) {
                var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
                s = s.replace(re, arguments[i]);
            }
            return s;
        },        

        formatNumber: function(number, deep, decimalSeparator) {
            var numberFixed = number.toFixed(deep);
            return numberFixed.replace(/\./, decimalSeparator);
        },
        formatNumberWithSeparator: function(number, separator) {
            function pad(n, length) {
                n = n.toString();
                while (n.length < length) {
                    n = '0' + n;
                }
                return n;
            }
            if (!separator) separator = ',';
            var formattedNumberString = pad(number % 1000, 3);
            var x = parseInt(number / 1000);
            while (x > 0) {
                formattedNumberString = pad(x % 1000, 3) + separator + formattedNumberString;
                x = parseInt(x / 1000);
            }
            var triples = formattedNumberString.split(separator);
            if (triples.length) {
                triples[0] = new Number(triples[0]);
            }
            return triples.join(separator);
        },
        traceError: function(e, funcName, msg) {
        	if (!e) e = { message : null };
        	var exception = e.message || "";
        	if (exception != "") {
        		exception =" | Original Exception message : " + e.message;
        	}
        	funcName = funcName || "";
        	msg = msg || "";
        	// TODO: use console.error instead?
        	console.log($.stringFormat('[Error : {0}] {1}{2}', funcName, msg, exception)); 
        }
    });

    jQuery.fn.extend(
    {
        alignTo: function(selector, options) {
            var opts = {
                horizontal: 'LEFT', // 'LEFT', 'RIGHT'
                vertical: 'BOTTOM', // 'BOTTOM', 'TOP',
                offsetHorizontal: 0,
                offsetVertical: 0
            };
            $.extend(opts, options);
            var pos = $(selector).position();

            var h, v;

            if (opts.horizontal == 'LEFT') {
                h = { left: pos.left + opts.offsetHorizontal };
            }

            if (opts.horizontal == 'RIGHT') {
                var excess = 0;
                var cWidth = this.outerWidth();
                var oWidth = $(selector).outerWidth();
                excess = cWidth - oWidth;
                if (excess < 0) {
                    excess = 0;
                }
                h = { left: pos.left - excess + opts.offsetHorizontal };
            }


            if (opts.vertical == 'TOP') {
                v = { top: pos.top + opts.offsetVertical };
            }

            if (opts.vertical == 'BOTTOM') {
                v = { top: pos.top + $(selector).outerHeight() + opts.offsetVertical };
            }

            if (h) this.css(h);
            if (v) this.css(v);
            return this;
        },
        disableTextSelection: function() {
            return this.each(function() {
                var target = this;
                if ($(target).data('disable_text_selection_applied')) return;
                if (typeof target.onselectstart != "undefined") {// IE route
                    target.onselectstart = function() { return false; };
                }
                else if (typeof target.style.MozUserSelect != "undefined") { // Firefox
																				// route
                    target.style.MozUserSelect = "none";
                }
                else { // All other route (ie: Opera)
                    target.onmousedown = function() { return false; };
                    target.style.cursor = "default";
                }
                $(target).data('disable_text_selection_applied', true);
            });
        },
        fixTabIndex: function(opts) {
            var options = {
				forceTabIndex : true,
				excludeSelector : null				
            };
            $.extend(options, opts);

            var elements = this;
            $.R3M = $.R3M || {};
            $.R3M.tabIndex = $.R3M.tabIndex || 1;            
            return elements.each(function() {
                var ele = $(this);
				if (!ele.is(':visible')) return;
				if (options.excludeSelector && ele.is(options.excludeSelector)) return true; // continue
				var autoTab = options.forceTabIndex || !ele.attr('tabindex');								
									
				if (autoTab) {
					ele.attr('tabindex', $.R3M.tabIndex++);
				}
            });
        },		
		checkAllBehavior : function (options) {
			var opts = {
				chkSelector : 'span.Chk input[type=checkbox]',
				chkAllSelector : 'span.ChkAll input[type=checkbox]',
                triggerChange : true
			};
			
			$.extend(opts, options);
			
			return this.each(function() {
                var grid = $(this);                
                grid.find(opts.chkAllSelector).click(function() {
                    var childChecks = grid.find(opts.chkSelector);
                    var checked = $(this).attr('checked');
                    childChecks.attr('checked', checked ? 'checked' : '');
                    childChecks.trigger('change');
                });
			});			
		},	
		disableFocus : function () 
		{		
			return this.each(function() {
                if ($(this).attr('disabled_focus') == 'true') return;
                $(this).focus(function() {
                    $(this).blur();
                    return false;
                });
                $(this).attr('disabled_focus', 'true');
            });
		},		
        useWidthFromWidestDescendant: function(selector, options) {
            var opts = {
                excess: 0,
                useOuterWidth: false,
                includeMargin: true,
                forceEvaluateIfHidden: false
            };

            $.extend(opts, options);
            if (selector) {
                var originalMargin = this.css('marginLeft');
                if (opts.forceEvaluateIfHidden && this.is(':hidden')) {
                    this
                        .css('marginLeft', -20000)
                        .show();
                }
                var maxWidth = 0;
                var elements = this
                    .find(selector)
                    .each(function(i, val) {
                        var w = opts.useOuterWidth ? $(this).width() : $(this).outerWidth(opts.includeMargin);
                        if (w > maxWidth) maxWidth = w;
                    });

                if (maxWidth > 0 && maxWidth > $(this).width()) {
                    this.setAbsoluteWidth(maxWidth + opts.excess);
                }

                if (opts.forceEvaluateIfHidden) {
                    this
                        .css('marginLeft', originalMargin)
                        .hide();
                }
            }

            return this;

        },
        fitToChildrenWidth: function(options) {
            var opts = {
                excess: 0,
                useAnimation: true
            };

            $.extend(opts, options);

            return this.each(function() {			
                var ele = $(this);
                if (ele.hasClass('NoForce')) {
                    $(ele).show();
                    return;
                }                
                if (!ele.parent().is(':visible')) return;
                if (ele.data('sizeCalculated') == 'true') return;
                
                var children = ele.children();

                ele.css({ marginLeft: '-20000px' });
                ele.show();
                var widthForEle = 0;

                if (children.is('ul')) {
                    children.find('>li').each(function() {
                        widthForEle += $(this).outerWidth(true);
                    });
                }
                else {
                    widthForEle = children.width();
                }

                ele.css({ marginLeft: 'auto' });
                if (opts.useAnimation) children.hide();

                ele.width(widthForEle + opts.excess);

                if (opts.useAnimation) children.fadeIn();
                
                ele.data('sizeCalculated','true');

            });
        },
        useMaximumWidth: function(hasMinWidth) {
            var maxChoiceWidth = 0;
            var elementsObject = $(this);
            var minWidth = 0;
            if (hasMinWidth == true) {
                minWidth = elementsObject.css('min-width') ? elementsObject.css('min-width').replace(/\D/g, '') : 0;
            }
            $.each(elementsObject, function(i, val) {
                var choiceWidth = $(val).outerWidth(true);
                if (choiceWidth > maxChoiceWidth) {
                    maxChoiceWidth = choiceWidth;
                }
            });
            if (maxChoiceWidth > minWidth)
                elementsObject.width(maxChoiceWidth);
            return this;
        },        

        blockContent: function(options) {
            var opts = {
                opacity: .5,
                bgColor: '#fff'
            };
            $.extend(opts, options);

            return this.each(function(i, val) {
                var ele = $(this);                
                if (ele.data('IsBlocked') && (ele.find('>.BlockUI').is(':visible'))) return
                //ele.addClass('Blocking');
                var bUI = ele.find('>.BlockUI');
                
                ele.find(':input[tabindex]').each(function() {
                	$(this).attr('old_tab_index', $(this).attr('tabindex'));
                	$(this).attr('tabindex',''); 
                });
                
                if (bUI.length === 0) {
                    bUI = $('<div class="BlockUI">&nbsp;</div>').appendTo(ele);
                }
                try {
                    bUI.css({
                        'display': 'none',
                        'position': 'absolute',
                        'background-color': opts.bgColor,
                        //'z-index': 10000,
                        'opacity': opts.opacity,
                        'top': 0,
                        'left': 0
                    });
                    bUI.setAbsoluteWidth(ele.outerWidth(true));
                    bUI.setAbsoluteHeight(ele.outerHeight(true));
                    bUI.show();                                        
                    var pos = ele.position();
                    if (ele.css('position') == 'relative' || ele.css('position') == 'absolute') {
                    	pos = { left: 0, top : 0 };
                    }
                    bUI.css({ 'left': pos.left, 'top': pos.top });

                    ele.data('IsBlocked', true);
                    $(window)
					    .bind('resize.blockContent', function () {
					        var pos = ele.position();
							if (ele.css('position') == 'relative' || ele.css('position') == 'absolute') {
								pos = { left: 0, top : 0 };
							}
                            bUI.css({ 'left': pos.left, 'top': pos.top });
					        bUI.setAbsoluteWidth(ele.outerWidth(true));
                            bUI.setAbsoluteHeight(ele.outerHeight(true));   
					     } );
                }
                catch (e) {
                	$.traceError(e);                                           	                	
                }
            });
        },        
        unblockContent: function() {
            return this.each(function(i, val) {
                var ele = $(this);
                //ele.removeClass('Blocking');
                if(ele.data('IsBlocked')) {
                	 ele.find(':input[old_tab_index]').each(function() {
                     	$(this).attr('tabindex', $(this).attr('old_tab_index'));
                     });
                }
                ele
					.find('.BlockUI')
					.hide()
					.end()
					.removeData('IsBlocked', false);
				$(window)
					    .unbind('resize.blockContent');
            });
        },

        toCSV: function(opts) {
            var options =
                {
                    separator: ',',
                    noInclude: '.NotCSV',
                    stripSpaceCharacters: true,
					wrapperCharacter : '"'
                };

            $.extend(options, opts);

            var rows = [];
            this.find('tr').each(function(i) {
                var tds = [];
                $(this).find('th, td').not(options.noInclude).each(function(j) {
                    var text = $(this).text();
                    text = options.stripSpaceCharacters ? text.replace(/\s\s+/gi, '') : text;
                    tds.push(options.wrapperCharacter + text + options.wrapperCharacter);
                });
                rows.push(tds.join(options.separator));
            });

            return rows.join('\n');

        },
        getSelectedItem: function() {
            var item = null;                                                            
            if (this.length && this[0].options) {
                item = this[0].options[this[0].selectedIndex];
            }
            return item;
        },
        getItemsCount: function() {
            var count = 0;
            if (this.length && this[0].options) {
                count = this[0].options.length;
            }

            return count;
        },
        enterPressed: function(callBackEnter, CallBackEsc, data, discriminator) {
            var _enterCallBack = function(e) {
                var callbackResult = true;
				var args = { doBlur : false};
                if (e.keyCode == 13) {
                    if (typeof (callBackEnter) == 'function') {
                        callbackResult = callBackEnter(e, args);
                    }
                    if (args.doBlur) $(e.target).blur();

                }
                if (e.keyCode == 27) {
                    if (typeof (CallBackEsc) == 'function') {
                        callbackResult = CallBackEsc(e, args);
                    }
                    if (args.doBlur) $(e.target).blur();
                }
                return callbackResult;
            };
			if (!discriminator) 
				return this.bind('keypress.enterPressed', data, _enterCallBack);
			else 
				return this.bind('keypress.enterPressed_' + discriminator, data, _enterCallBack);
        },

        unbindEnterPressed: function(discriminator) {
			if (!discriminator)
				return this.unbind('keypress.enterPressed');
			else 
				return this.unbind('keypress.enterPressed_' + discriminator);
        },

        findById: function(str_id) {
            var parent_id = this[0].id;
            return $.byId(this[0].id + '_' + str_id);
        },

        mergeCells: function() {
            if (this.length > 1) {
                this.css('display', 'none');
                $(this[0]).attr('rowspan', this.length).css('display', '');
            }

            return this;
        },

        enableIfChangeHappens: function(area, opts) {

            if (this.length == 0)
                return;

            var options =
                {
                    disableClass: "DisabledButton",
                    onCalculate: function() {
                    }
                };

            options = $.extend(options, opts);

            var buttonForActivation = this;

            this.disable(true, options);

            var sw = new StateWatcher(area);

            sw.addEventListener('OnMD5Calculate', function(args) {
                options.onCalculate(args);
            });

            sw.addEventListener('ReturnedToInitialState', function() {
                buttonForActivation.disable(true, options);
            });
            sw.addEventListener('StateChanged', function(args) {
                buttonForActivation.disable(false);
            });

            return sw;
        },

        setAbsoluteWidth: function(w) {
            var dif = this.outerWidth() - this.width();
            return this.width(w - dif);
        },

        setAbsoluteHeight: function(h) {
            var dif = this.outerHeight() - this.height();
            return this.height(h - dif);
        }


    });

$(document).ready(function() {
    $.createDummyConsole();
});

/* MOZILLA OUTER_HTML */


if (typeof (HTMLElement) != 'undefined') {
    var _emptyTags =
        {
            "IMG": true,
            "BR": true,
            "INPUT": true,
            "META": true,
            "LINK": true,
            "PARAM": true,
            "HR": true
        };

    HTMLElement.prototype.__defineGetter__("outerHTML", function() {
        var attrs = this.attributes;
        var str = "<" + this.tagName;
        for (var i = 0; i < attrs.length; i++) {
            str += " " + attrs[i].name + "=\"" + attrs[i].value + "\"";
        }

        if (_emptyTags[this.tagName]) {
            return str + ">";
        }

        return str + ">" + this.innerHTML + "</" + this.tagName + ">";
    });

    HTMLElement.prototype.__defineSetter__("outerHTML", function(sHTML) {
        var r = this.ownerDocument.createRange();
        r.setStartBefore(this);
        var df = r.createContextualFragment(sHTML);
        this.parentNode.replaceChild(df, this);
    });
}


jQuery.extend(
    {
        EventDispatcher: function() {
        }
    });

jQuery.extend($.EventDispatcher.prototype,
    {
        buildListenerChain: function() {
            if (!this.listenerChain) {
                this.listenerChain = {};
            }
        },
        addEventListener: function(type, listener) {
            if (!listener instanceof Function) {
                throw (
                    {
                        message: "Listener isn't a function"
                    });
            }

            this.buildListenerChain();

            if (!this.listenerChain[type]) {
                this.listenerChain[type] = [listener];
            }
            else {
                this.listenerChain[type].push(listener);
            }

        },
        hasEventListener: function(type) {
            return (this.listenerChain && this.listenerChain[type] != null);
        },
        removeEventListener: function(type, listener) {
            if (!this.hasEventListener(type)) {
                return false;
            }

            for (var i = 0; i < (this.listenerChain[type].length || 0); i++) {
                if (this.listenerChain[type][i] == listener) {
                    this.listenerChain.splice(i, 1);
                }
            }

        },
        removeEventsOfType: function(type) {
            if (!this.hasEventListener(type)) {
                return false;
            }

            for (var i = 0; i < this.listenerChain[type].length; i++) {
                this.listenerChain[type][i] = null;
            }
            this.listenerChain[type] = null;

        },
        dispatchEvent: function(o) {
            this.buildListenerChain();

            if (!this.hasEventListener(o.type)) {
                return false;
            }
            if (this.listenerChain[o.type] && this.listenerChain[o.type].length) {
                $.each(this.listenerChain[o.type], function(i, f) {
                    return (f(o) === false ? false : true);
                });
            }

        }
    });



function StateWatcher(str_selector) {
    var me = this;
    // only saves the val!!!!! not other properties!!!!
    var initialMD5 = getMD5FromValues();
    var checkInterval = null;

    var atLeastOnceHasChanged = false;

    $(str_selector).find(':input').bind('change keypress click', function(e) {
        if (e.type == 'change') {
            checkChanges();
        }
        else {
            clearTimeout(checkInterval);
            checkInterval = setTimeout(function() {
                checkChanges();
            }, 200);
        }
    });

    function getMD5FromValues() {
        values = "";
        $(str_selector).find(':input').each(function() {
            var val = $(this).val();
            if ($(this).is(':checkbox')) {
                val = $(this).attr('checked');
            }
            values += val;
        });

        var args =
            {
                type: 'OnMD5Calculate',
                extraValue: '',
                target: me
            };
        me.dispatchEvent(args);
        return $.md5(values + args.extraValue);
    }
    function checkChanges() {
        var newMD5 = getMD5FromValues();
        if (newMD5 != initialMD5) {
            atLeastOnceHasChanged = true;
            me.dispatchEvent(
                {
                    type: 'StateChanged',
                    target: me
                });
        }
        else {
            if (atLeastOnceHasChanged) {
                atLeastOnceHasChanged = false;
                me.dispatchEvent(
                {
                    type: 'ReturnedToInitialState',
                    target: me
                });
            }
        }

    }
    this.doCheckChanges = function() {
        checkChanges();
    };
    this.acceptChanges = function() {
        initialMD5 = getMD5FromValues();
    };
}

StateWatcher.inherits($.EventDispatcher);

(function ($) {
    $.fn.extend({
        collapsePanel: function (options) {
            var opts = {
                headerElement : '.Legend',
                contentElement : '.CollapsibleArea',
                useAnimation : false
            };
            
            $.extend(opts, options);                                                            
            
            return this.each(function () {            
                var me = $(this);
                me
                    .find(opts.headerElement)
                    .hover(function() {
                        if (!me.find(opts.contentElement).is(':visible')) {
                            $(this).addClass('Highlight');
                        }
                    }, function() {                
                         $(this).removeClass('Highlight');                
                    })
                    .click(function() {
                        var cte = me.find(opts.contentElement);
                        if (cte.is(':visible')) {
                            if (opts.useAnimation) {
                                cte.hide("blind", 
                                    {
                                        direction: "vertical"
                                    }, 500, function() { me.toggleClass('Collapsed'); });                          
                            }
                            else {
                                cte.hide();                                
                                me.toggleClass('Collapsed');
                            }
                        }
                        else {
                            if (opts.useAnimation) {
                                cte.show("blind", 
                                    {
                                        direction: "vertical"
                                    }, 500, function() { me.toggleClass('Collapsed');});
                            }
                            else {
                                cte.show();
                                me.toggleClass('Collapsed');
                            }
                        }
                    });
                
            });
            
        }
    });
})(jQuery);



(function($) {
    $.fn.extend(
        {
            disable: function(disable, opts) {
                if (arguments.length === 0) {
                    disable = true;
                }
                var options =
                    {
                        disableClass: 'DisabledButton'
                    };

                $.extend(options, opts);

                if (disable && !this.data("disabledClass")) {
                    this.addClass(options.disableClass);
                    this.each(function() {
                        var evts = {};
                        var events = $(this).data('events') ||
                        {};
                        for (var type in events) {
                            evts[type] = {};
                            for (var handler in events[type]) {
                                evts[type][handler] = events[type][handler];
                                evts[type][handler].data = events[type][handler].data;
                            }
                        }
						var tbIndex = $(this).attr('tabindex');
						if (tbIndex) {
	                        $(this).data("_old_tabindex", tbIndex);
							$(this).removeAttr('tabindex');
						}
                        $(this).data("_old_events", evts);
                        $(this).data("disabledClass", options.disableClass);
                        $.event.remove(this);
                        $(this).bind('click keydown', function() {
                            return false;
                        });
                    });
                }
                else {
                    if (!this.data("disabledClass") || disable) {
                        return;
                    }

                    this.removeClass(this.data('disabledClass') || options.disableClass);
                    this.each(function() {
                        $.event.remove(this);
                        var events = $(this).data('_old_events') ||
                        {};
						var tbIndex = $(this).data("_old_tabindex");
						if (tbIndex) {
							$(this).attr('tabindex',tbIndex);
							$(this).removeData("_old_tabindex");
						}
						
                        for (var type in events) {
                            for (var handler in events[type]) {
                                $.event.add(this, type, events[type][handler], events[type][handler].data);
                            }
                        }
                    });

                    this.removeData('_old_events');
                    this.removeData("disabledClass");
                }
                return this;
            }
        });
})(jQuery);


jQuery.delegate = function(rules) {
    return function(e) {
        var target = $(e.target);
        for (var selector in rules)
            if (target.is(selector))
            return rules[selector].apply(this, $.makeArray(arguments));
    };
};

jQuery.fn.parseSWF = function() {
	return this
		.find('.FlashContent:not(.flash-replaced)')
		.each(function (i, val) {
			var ele = $(this);
			var source = ele.attr('flash_source');
			var nc = (source.indexOf('?') > -1)? '&nc=' : '?nc=';
			source += (nc + (new Date()).getUTCDate());					
			
			ele.flash({
					id : ele.attr('flash_id') || 'flash_replaced_'+ i,
					name : ele.attr('flash_id') || 'flash_replaced_' + i,
					src: source,
					width: ele.attr('flash_width'),
					height: ele.attr('flash_height'),
					scale: "noscale",
					wmode: (!ele.attr('wmode'))? "transparent" : ele.attr('wmode'),
					flashvars: jQuery.param2ToJSON(ele.attr('flash_vars'))
				},
				{ expressInstall: false  });
	});
};

jQuery(function () {		
	
	$(document).parseSWF();
});

jQuery.form2JSON = function (selector, opts) {
	var _opts = {
		convertBoolToInt : true
	};
	$.extend(_opts, opts);
	var obj = {};	
	selector = $(selector);
	selector
		.find(':input[keyname], div.RadioGroup[keyname], div.CheckGroup[keyname]')
		.each(function() {            
            
			var ele = $(this);
			
			if (ele.is('.NoSerialize')) return true; //continue 
			
            var keyname = ele.attr('keyname') || ele.attr('id');
            var val = '';
            
            if (ele.is('.RadioGroup')) {
                val = ele.find('input[type=radio]:checked').val();                               
            }
            else if (ele.is(':checkbox')) {
            	var checked = ele.is(':checked');
                val = _opts.convertBoolToInt? (checked ? 1 : 0) : checked ;
            }
            else {
                val = ele.val();
            }
            
            if (keyname.indexOf('.') > -1) {
                var parts = keyname.split('.');
                var _obj = obj;
                var prev = null;
                for (var i = 0; i < parts.length; i++) {
                    _obj[parts[i]] = _obj[parts[i]] || {};
                    prev = _obj;
                    _obj = _obj[parts[i]];                    
                }
                if (prev && (parts.length > 0)) { prev[parts[parts.length - 1]] = val; }
                 
            }
            else {
                obj[keyname] = val;
            }
		});	
	return obj;
};

jQuery.GetObjectValueByKey = function(row, token) {
    var expression, pattern, numberFormat, numberReadable = null;
    // The idea is to extract both the default value expression and stringFormat
	// Expression, StringFormat must be
    // once the above regular expression is applied using match we get up to two
	// strings, so we have to parse and
    // try to obtain the command and to assing it to expression an to pattern
	// vars
    // The next expression is lazy, so it will match as few characters as
	// possible before satisfying the next token.
    var re = /\|\w+:'.*?'/g;
    var m = token.match(re);

    if (m) {
        // save its values into expression and pattern
        for (var i = 0; i < m.length; i++) {
            // var reAux = m[i].match(/'([\w\s\.\[\]\?-]*)'/);
            var reAux = m[i].match(/'(.*?)'/);
            if (m[i].match(/\|default:'/) && reAux !== null) {
                expression = reAux[1];
            } else if (m[i].match(/\|format:'/) && reAux !== null) {
                pattern = reAux[1];
            } else if (m[i].match(/\|numberFormat:'/) && reAux !== null) {
                numberFormat = reAux[1];
            } else if (m[i].match(/\|numberReadable:'/) && reAux !== null) {
                    numberReadable = reAux[1];
                }
        }
        // clean the token
        token = token.replace(re, '');
    }
    
    var tokens = token.replace(/\{|\}/g, '').split(".") || [];
    var obj = row;

    for (var ix = 0; ix < tokens.length; ix++) {
        try {
            obj = obj[tokens[ix]];
        }
        catch (ex) {        	
            console.log('[Error _getMatchkey token ' + tokens[ix] +'] : ' + ex.message);
            obj = null;
            break;
        }
    }
    // if the object has no value, then the default expression will be used
    if (expression != null && (!obj || obj === '' || obj === 0)) {
        obj = expression || "";
        // if there is a pattern, we have to fit the obj to it
    }
    else
        if (obj != null) {
        if (numberFormat) {
            obj = $.formatNumber(obj, numberFormat, '.');
        }
        if ( numberReadable) {
            obj = $.formatNumberWithSeparator(obj, numberReadable);
        }    
        if (pattern) {
            obj = pattern.replace(/\[0\]/, obj);
        }
        
    }
    return obj;
};


jQuery.JSON2form = function (selector, obj, callback, dontClear) {

    var selector = $(selector);
    if (!obj) return;
    
	if (!dontClear) 
		selector.clearForm();
    
    selector
        .find(':input[keyname], div.RadioGroup[keyname], span[keyname]')
        .each(function() {
            var ele = $(this);
            var keyname = ele.attr('keyname');           
            
            if (!keyname) return true;            
            var val = ($.GetObjectValueByKey(obj,keyname));
            
            var doBind = true;
            if (callback) {
            	doBind = callback(ele, val);
            }
            
            if (doBind) {
	            if (ele.is('.RadioGroup')) {
	                var _sel = "input[value='{0}']";
	                _sel = _sel.replace('{0}', val);                
	                var selected = ele.find(_sel);
	                selected.attr('checked','checked');
	            }
	            
	            if (ele.is(':checkbox')) {            	
	            	if (val === true) {
	            		ele.attr('checked','checked');            		
	            	}
	            	else {
	            		ele.attr('checked','');
	            	}
	            }
	            else {	 
	              if (ele.is('span')) {            	
	            	  ele.text(val);
	              }
	              else {
	            	  ele.val(val);
	              }
	            }
            }
        });
};

jQuery.fn.clearForm = function () {
    return this
        .find(':input[keyname]:not(.NotClearIt), div.RadioGroup[keyname]:not(.NotClearIt)')
        .each(function () { 
             var ele = $(this);                         
             
             if (ele.is('.RadioGroup')) {
                 ele.find('input[type=radio]').attr('checked', '');
             }
             else 
                 if (ele.is('select')) {
                     ele.val('-1');
                 }
                 else {
                	 if (ele.is(':checkbox')) {
                		 ele.attr('checked', '');
                	 }
                	 else {
                		 ele.val('');
                	 }
                 }
         })
        .end();
};

jQuery.param2ToJSON = function(parms) {
		parms = parms || '';
		var pairs = parms.split('&');
		var data = {};
		$.each(pairs, function (i, value) {
			var arr = this.split('=');
			if (arr.length == 2) 
				data[arr[0]] = arr[1];
		});
		
		return data;
};	

jQuery.fn.bindDefaultActionOnEnter = function() {
	return this.each(function(){
		var me = $(this);
		me.enterPressed(function (){ me.find('.DefaultAction').trigger('click'); });
	});
};

 jQuery.extend( {
	hideInLineMessage: function(ele)
    {
        try 
        {
			ele = $(ele);
            if (!ele[0] || !ele[0].opts) 
            {
                return;
            }
            var divToHide = ele.find('div.' + ele[0].opts.className);
            if (divToHide.length > 0) {              
				if (divToHide.is(':visible')) {
					divToHide.hide('blind', 
					{
						direction: "vertical"
					}, 500);
				}
				else {
					divToHide.hide();
				}
            }
        } 
        catch (ex) 
        {
            console.log(ex);
        }
    },
    showInlineMessage: function(ele, msg, opts)
    {
    	ele = $(ele);    	
        if (!ele || !ele[0]) 
        {
            return;
        }
        
        var options = 
        {
            fadeTimeout: 2500,
            sticky: false,            
            className: "InlineErrorMessage",
            highlight: true,
            highlightColor: "#BF9F30",
			onHide : function () {}
        };
        
        $.extend(options, opts);
        
        var template = '<div style="display:none;" class="' + options.className + '"><div class="InlineWrapper"><div class="message"></div><a class="CloseInlineMessage"><span>[ x ]</span><a></div>';
        
        // ele.find('div.' + options.className).remove();
        
        ele[0].opts = options;
        
        // template = template.replace(/\{Message\}/g, msg);
        
        if (!ele.find('div.' + options.className).length) {
        	ele.append(template);
        	ele.find('a.CloseInlineMessage').click(function(evt)
        	        {
        	            $.hideInLineMessage(ele);
        	        });
        }
        
        ele.find('div.' + options.className + ' div.message').html( msg );       
        
        
        if (!ele.find('div.' + options.className).is(':visible')) {	
	        ele.find('div.' + options.className).fadeIn(500, function()
	        {        				
	        	    if (options.highlight) 
	        	    {        	            	
	        	    	$(this).effect("highlight", 
	        	    		{
	        	            	color: options.highlightColor
	        	            }, 500);
	        	    }
	        
	        });
        }
        
        
        
        clearInterval($.lastInterval);
        if (!options.sticky) 
        {
            $.lastInterval = setTimeout(function()
			{				
            	$.hideInLineMessage(ele);
				if (options.onHide) {
					options.onHide();
				}
			}, options.fadeTimeout);
        }
    }
 });
 
 jQuery.fn.monitorHeight = function(options) {
	 var opts = {
		heightPadding : 0,
		intervalTime : 1000
	 };
	 $.extend(opts, options);
	 function _monitorEle(ele) {
		 var t = window.setInterval(function() {			 
			 if (!ele.is(':visible') || !ele[0]) return;			 
			 try {
				 var h = ele[0].contentWindow.document.body.offsetHeight; 
				 h += opts.heightPadding;
				 
				 ele.height(h); 
				 
			 }
			 catch(ex) {
				 
			 }
		 }, opts.intervalTime);
		 ele.data('ResizeTimer', t);
	 }
	 return this.each(function() {
		 var ele = $(this);
		 if (ele.is('iframe')) {			 
			 _monitorEle(ele);
		 }
	 });
 };

 $.RegisterAPI = function(opts){
	 
	$.each(opts.ApiObjects, function () {
		var apiObject = this;
		var namespace = $.Namespace(apiObject.objName);
	    
	    $.each(apiObject.funcs.split(','), function(i, val){
	    	val = $.trim(val);
	        namespace[val] = function(obj, callback){			
				
				if (obj != null && !callback) {
					callback = obj;
					obj = null;
				}
	            callback = callback || function(result){};
				
				var _json  = null;
				if (obj != null){
					_json = JSON.stringify(obj);									
				}
				
	            var _data = { className : apiObject.className };
				
				if (_json) {
					_data.json = _json;
				}						
	            _data.method = val;
				
	            var ajaxOpts = {
	                url: $.stringFormat('{0}/{1}/{2}', opts.urlHanlder, _data.className, _data.method),
	                dataType: "jsonp",
	                data: _data,
	                success: function(dt){
	            		var sc = dt != null;	            		
	            		if (dt != null && dt.Error) {
	            			sc = false;	            			
	            		}
	                    callback({
	                        success: sc,
	                        "data": dt
	                    });
	                },
	                error: function(statu, e){
	                    // TODO: Add message;
	                    callback({
	                        success: false,

	                        reason: 'Error',
                                status: statu,
                                excep: e
	                    });
	                },

	                timeout: opts.timeout,
	                type: "POST"
	            };
	            
	            return $.ajax(ajaxOpts);
	        };
	    });
	});
	    
};

 
 