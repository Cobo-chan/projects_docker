$(document).on('turbolinks:load', function() {

  if ($('.flash-messages')) {
    setTimeout("$('.flash-messages').fadeOut('slow')", 4000);
  };

});