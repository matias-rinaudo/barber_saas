// Cargar jQuery
//= require jquery
//= require jquery_ujs

// Cargar Popper (requerido por Bootstrap 5)
//= require popper
//= require bootstrap

// Tu JS personalizado
//= require_tree .

// Handle data-method links (for DELETE, PUT, PATCH)
$(document).ready(function() {
    $('a[data-method]').on('click', function(e) {
        var link = $(this);
        var method = link.data('method');
        var confirm_message = link.data('confirm');
        
        if (confirm_message && !confirm(confirm_message)) {
            e.preventDefault();
            return false;
        }
        
        if (method && method.toLowerCase() !== 'get') {
            e.preventDefault();
            
            var form = $('<form>')
                .attr('method', 'POST')
                .attr('action', link.attr('href'))
                .hide();
            
            // Add CSRF token
            var csrf_token = $('meta[name="csrf-token"]').attr('content');
            if (csrf_token) {
                form.append($('<input>').attr('type', 'hidden').attr('name', 'authenticity_token').attr('value', csrf_token));
            }
            
            // Add method override for non-GET requests
            if (method.toLowerCase() !== 'post') {
                form.append($('<input>').attr('type', 'hidden').attr('name', '_method').attr('value', method));
            }
            
            $('body').append(form);
            form.submit();
        }
    });
});