//= require jquery
//= require jquery_ujs
//= require datetimepicker
//= require tether
//= require drop
//= require tether-tooltip
//= require d3
//= require labella
//= require_tree ./components/
//= require_self

$(function(){
  $('.datetimepicker').each(function(){
    $(this).datetimepicker();
  });

  $('.timeline').each(function(){
    new Timeline(this);
  })
});
