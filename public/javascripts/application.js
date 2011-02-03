// focus on the first text input field in the first field on the page
$(function(){
  if($(".error").text() == "") {
    $(":text:visible:enabled:first").focus();
  }
});

function add_fields(link, association, content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_"+association,"g")
  $(link).parent().before(content.replace(regexp,new_id));
}



