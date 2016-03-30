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

  //return confirm('You are changing the modules for:\n' + modules.join('\n'));
  return false;
}

function test(){
        return true;
    };

$(document).ready(function(){
    //modal delete confirm
    $('button[data-toggle="modal-confirm"]').click(function(event) {
        event.preventDefault();
        var self = $(this);
        var message = self.data('message');
        var title = self.data('title');
        var target = $(self.data('target'));
        var condition = self.data('condition');
        if( target.length == 1) {
            target.find('.modal-title').html(title);
            target.find('.modal-body').html(message);
            var showModal = true;
            var fn = window[condition];
            if(typeof fn === 'function') {
                showModal = fn(condition);
            }
            if( showModal ) {
                target.on('shown.bs.modal', function(e) {
                    target.find('button[data-submit="modal"]').click(function(e){
                        var parentForm = self.closest('form');
                        console.log(parentForm.html());
                        if( parentForm.length == 1 ) {
                            parentForm.submit();
                        }
                    });
                });
                target.modal({ show: true });
            };
        };
    });
});