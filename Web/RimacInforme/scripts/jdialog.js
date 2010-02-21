function showModalDialog(url, options) {
    window.open(url, '', 'toolbar=1,scrollbars=1,resizable=1,menubar=0,status=1,directories=0,location=0');    
}

$.fn.toggleWithoutPrevent =  function(fn) {
            // Save reference to arguments for access in closure
            var args = arguments, i = 1;

            // link all the functions, so any of them can unbind this click handler
            while (i < args.length) {
                jQuery.proxy(fn, args[i++]);
            }

            return this.click(jQuery.proxy(fn, function(event) {
                // Figure out which function to execute
                var lastToggle = (jQuery.data(this, "lastToggle" + fn.guid) || 0) % i;
                jQuery.data(this, "lastToggle" + fn.guid, lastToggle + 1);

                // Make sure that clicks stop
                //event.preventDefault();

                // and execute the function
                return args[lastToggle].apply(this, arguments) || false;
            }));
        };