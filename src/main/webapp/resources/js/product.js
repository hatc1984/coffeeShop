$(document).ready(function() {
	  $('#confirm-delete').on('show.bs.modal', function(e) {
          $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
          
          $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-delete').attr('href') + '</strong>');
      });
	  
	 $("#productDetail .col-sm-2 > div").click(function() {
			 var image = $(this).children().first();
			 var linkOfImage = $(image).attr("src");
			 $("#productImage").attr("src",linkOfImage);
	 });
	 $("#productImage").elevateZoom({tint:true, tintColour:'#F90', tintOpacity:0.5});
})