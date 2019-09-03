// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require application
//= require plugins/jquery-validation/jquery.validate.min

var BasePagesRegister = function() {
    // Init Register Form Validation, for more examples you can check out https://github.com/jzaefferer/jquery-validation
    var initValidationRegister = function(){
        jQuery('.js-validation-register').validate({
            errorClass: 'help-block text-right animated fadeInDown',
            errorElement: 'div',
            errorPlacement: function(error, e) {
                jQuery(e).parents('.form-group .form-material').append(error);
            },
            highlight: function(e) {
                jQuery(e).closest('.form-group').removeClass('has-error').addClass('has-error');
                jQuery(e).closest('.help-block').remove();
            },
            success: function(e) {
                jQuery(e).closest('.form-group').removeClass('has-error');
                jQuery(e).closest('.help-block').remove();
            },
            rules: {
                'user[first_name]': {
                    required: true,
                    minlength: 2
                },
                'user[last_name]': {
                    required: true,
                    minlength: 2
                },
                'user[email]': {
                    required: true,
                    email: true
                },
                'user[account_attributes][account_type_id]': {
                    required: true
                },
                'user[password]': {
                    required: true,
                    minlength: 8
                },
                'user[password_confirmation]': {
                    required: true,
                    equalTo: '#user_password'
                }
            },
            messages: {
                'user[first_name]': {
                    required: 'Please enter a first name',
                    minlength: 'Your first name must consist of at least 2 characters'
                },
                'user[last_name]': {
                    required: 'Please enter a last name',
                    minlength: 'Your last name must consist of at least 2 characters'
                },
                'user[email]': 'Please enter a valid email address',
                'user[account_attributes][account_type_id]': {
                    required: 'Please select account type',
                },
                'user[password]': {
                    required: 'Please provide a password',
                    minlength: 'Your password must be at least 8 characters long'
                },
                'user[password_confirmation]': {
                    required: 'Please provide a password',
                    minlength: 'Your password must be at least 8 characters long',
                    equalTo: 'Please enter the same password as above'
                }
            }
        });
    };

    // Init Bootstrap Forms Validation, for more examples you can check out https://github.com/jzaefferer/jquery-validation
    var initValidationBootstrap = function(){
        jQuery('.js-validation-bootstrap').validate({
            errorClass: 'help-block animated fadeInDown',
            errorElement: 'div',
            errorPlacement: function(error, e) {
                jQuery(e).parents('.form-group > div').append(error);
            },
            highlight: function(e) {
                jQuery(e).closest('.form-group').removeClass('has-error').addClass('has-error');
                jQuery(e).closest('.help-block').remove();
            },
            success: function(e) {
                jQuery(e).closest('.form-group').removeClass('has-error');
                jQuery(e).closest('.help-block').remove();
            },
            rules: {
                'user[terms_of_service]': {
                    required: true
                }
            },
            messages: {
                'user[terms_of_service]': 'You must agree to the service terms!'
            }
        });
    };

    return {
        init: function () {
            // Init Register Form Validation
            initValidationRegister();

            initValidationBootstrap();
            
        }
    };
}();

// Initialize when page loads
jQuery(function(){ BasePagesRegister.init(); });