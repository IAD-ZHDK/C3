//= require jquery
//= require jquery_ujs
//= require datetimepicker
//= require d3
//= require labella
//= require_tree ./components/
//= require_self

$(function(){
  $('input[type="datetime-local"]').each(function(){
    $(this).datetimepicker({
      inline: true
    });
  });

  $('.timeline').each(function(){
    new Timeline(this);
  })
});
