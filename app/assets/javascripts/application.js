//= require jquery
//= require jquery_ujs
//= require datetimepicker
//= require_tree .

$(function(){
  $('input[type="datetime-local"]').each(function(el){
    $(this).datetimepicker({
      inline: true
    });
  });
});
