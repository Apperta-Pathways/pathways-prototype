$(document).ready(function(){
  $('#date-picker').datepicker({
    format: 'dd/mm/yyyy'
  });
})

var confirm_submit = function(){
  var modules = []
  $("input:checkbox:checked").each(function(i){
    modules.push($(this).parent().text());
  })
  console.log(modules)

  return confirm('You are changing the modules for:\n' + modules.join('\n'));
}
