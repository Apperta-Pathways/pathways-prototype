$(document).ready(function() {
  $('#exampleModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget)
    var recipient = button.data('member')
    var modal = $(this)
    modal.find('#member').empty()
    modal.find('#member').append("<i class=\"glyphicon glyphicon-plus\"></i>")
    modal.find('#member').append('Add ' + recipient)
    $('#member').on('click', function() {
      modal.find('#typeAdded').val(recipient);
      $('#myForm').submit(); 
    });
  });
});