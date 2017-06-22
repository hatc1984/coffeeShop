$(document).ready(function() {
	  $('#confirm-delete').on('show.bs.modal', function(e) {
          $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
          
          $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-delete').attr('href') + '</strong>');
      });
})