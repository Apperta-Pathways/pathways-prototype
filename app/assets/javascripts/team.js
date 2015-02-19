$(document).ready(function() {
  $('#exampleModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget)
    var recipient = button.data('member')
    var modal = $(this)
    modal.find('#submit').empty()
    modal.find('#submit').append("<i class=\"glyphicon glyphicon-plus\"></i>" + "Add" + recipient)
    $('#submit').on('click', function() {
      modal.find('#typeAdded').val(recipient);
      $('#myForm').submit(); 
    });
  });
});