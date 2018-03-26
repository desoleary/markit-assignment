// Regular Expression to test whether the value is valid
var $j = jQuery.noConflict();
$j.tools.validator.fn("[type=time]", "Please supply a valid time", function(input, value) {
    return /^\d\d:\d\d$/.test(value);
});

$j.tools.validator.fn("[data-equals]", "Value not equal with the $1 field", function(input) {
    var name = input.attr("data-equals"),
            field = this.getInputs().filter("[name=" + name + "]");
    return input.val() == field.val() ? true : [name];
});

$j.tools.validator.fn("[minlength]", function(input, value) {
    var min = input.attr("minlength");

    return value.length >= min ? true : {
        en: "Please provide at least " + min + " character" + (min > 1 ? "s" : ""),
        fi: "KentÔøΩn minimipituus on " + min + " merkkiÔøΩ"
    };
});

$j.tools.validator.localizeFn("[type=time]", {
    en: 'Please supply a valid time',
    fi: 'Virheellinen aika'
});