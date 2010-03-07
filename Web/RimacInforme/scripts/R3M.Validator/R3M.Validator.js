$.fn.initValidation = function() {
	$.validation = {
		NotEqual : 'NotEqual',
		Equal : 'Equal',
		GreaterThan : 'GreaterThan',
		LesserThan : 'LesserThan'
	};
	function getValueFrom(input) {
		return input.val();
	}
	function validate(ele, callback, lastResult) {
		var jEle = $(ele);
		var input = jEle.attr('field');
		var input = $(input);
		var trimmedInput = $.trim(input.val());
		var isValid = true;

		if (input.is(':visible') || input.attr('type') == 'hidden') {
			isValid = false;
			// Required Validator
			if (jEle.is('.Required')) {
				isValid = (trimmedInput && trimmedInput != '');
			}
			// Compare Validator
			if (jEle.is('.Compare')) {
				var compare_value = jEle.attr('compare_value');
				var comparison_type = jEle.attr('comparison_type')
						|| $.validation.NotEqual;

				if (compare_value) {
					var val = getValueFrom(input);

					switch (comparison_type) {
						case $.validation.NotEqual :
							isValid = compare_value != val;
							break;
						case $.validation.Equal :
							isValid = compare_value == val;
							break;
						case $.validation.GreaterThan :
							isValid = compare_value > val;
							break;
						case $.validation.LesserThan :
							isValid = compare_value < val;
							break;
						default :
							console
									.log('ComparisonType Not supported!, setting is valid to true');
							isValid = true;
							break;
					}
				} else { // Nothing to compare
					isValid = true;
				}
			}			
			//TODO include the other kind of Validators that could be used
			
			if (jEle.is('.RegularExpression')) {
				var exp = jEle.attr('regex');
				var rx = new RegExp(exp);
			    var matches = rx.exec(trimmedInput);
			    isValid = (matches != null && trimmedInput == matches[0]);
			}
			
			if (jEle.is('.RangeValidator')) {
				//TODO: check numbers
				var minVal = jEle.attr('min_value');
				var maxVal = jEle.attr('max_value');
				var numValue = null;
				try {
					numValue = parseFloat(trimmedInput);
				}
				catch(exc) {
					console.log('Error parsing number : ' + exc.message);
				}
				
				isValid = numValue != null && (numValue >= minVal) && (numValue <= maxVal); 
			}
			
			
			// Custom Validator
			if (jEle.is('.Custom')) {
				var func = jEle.attr('custom_function');
				if (typeof window[func] == 'function') {
					window[func](input, function(result) {
						evaluateVisibility(jEle, result, input);
						if (!callback) return;
						if (!ele.next) {
							callback(result && lastResult);
						} else {
							validate(ele.next, callback, lastResult && result);
						}

					});
				}
				return;
			}
		}

		
		evaluateVisibility(jEle, isValid, input);
		if (!callback) return;
		if (!ele.next) {
			callback(isValid && lastResult);
		} else {
			validate(ele.next, callback, lastResult && isValid);
		}
	}
	
	function evaluateVisibility(jEle, result, input) {
		if (!result) {
			jEle.fadeIn('fast');
			input.addClass('Fail');
		} else {
			jEle.fadeOut('fast');
			input.removeClass('Fail');
		}
	}
	
	function doValidate(me, callback) {
		var group = me.attr('validation_group');
		var validators = $('.Validator' + group);

		var current = null;
		var previous = null;
		var first = null;
		validators.each(function() {
			current = this;
			if (previous != null) {
				previous.next = current;
			} else {
				first = current;
			}
			previous = current;
		});

		if (first == null) {
			callback(true); // no validators found
			return;
		}
		validate(first, callback, true);
	}
	
	function setAutoValidator(me) {
		var group = me.attr('validation_group');
		var validators = $('.Validator' + group);		
		validators.each(function() {
			var validator = this;
			var field = $($(this).attr('field'));
			var event = $(this).attr('event');
			if (event) {
				field.bind(event, function() {
					validate(validator);
				});
			}
			else {
				field.bind('change, blur',function() {				
					validate(validator);
				});
			}
			
			if (field.is(':radio')) {
				field.bind('click', function() {
					validate(validator);
				});
			}
				
		});
	}

	$('.ValidatorTrigger').each(
			function() {
				var me = $(this);
				if (me.attr('validator_initialized') == 'true') {
					return true;
				}
				me.clone().attr('id', me.attr('id') + '__clone').addClass(
						'Clone').insertAfter(me).click(
						function() {
							var clone = $(this);
							var onValidate = function(result) {
								if (!result) {
									clone.addClass('Fail');
									return;
								}
								clone.removeClass('Fail');
								try {
									if (me.attr('onclick')) {
										if (!me[0].onclick.apply) {
											me[0].onclick = new Function(me
													.attr('onclick'));
										}
									}
								} catch (e) {

								}
								try {
									me.trigger('click');
								}
								catch(ex) {
									console.log(ex.message);
								}
							};							
							
							doValidate(me, onValidate);
							return false;
						});
				setAutoValidator(me);
				me.removeClass('DefaultAction'); //if this was the default action originally then the clone will have that class now
				me.hide().attr('validator_initialized', 'true');

				var isLink = me.attr("href");				
				if (isLink && isLink.indexOf('javascript:') > -1) {
					me.attr('onclick', isLink.replace('javascript:', ''));
				}							
			});	
	
};
jQuery.ClearValidators = function(selector, group) {
	selector = $(selector);
	linkSelector = 'a.ValidatorTrigger[validation_group={0}]';
	if (!group) { 
		group = '';
		linkSelector = 'a.ValidatorTrigger';
	}
	var validators = selector.find('.Validator' + group);
	
	validators.each(function() {
		var field = $(this).attr('field');
		$(field).removeClass('Fail');
	});
	
	validators.hide();

	selector.find($.stringFormat(linkSelector, group)).removeClass('Fail');
}
$(function() {
	//$(document).initValidation();
});