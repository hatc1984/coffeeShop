$(document).ready(function() {
	$("#productImage").elevateZoom();
	$("#productDetail .col-sm-2 > div").click(function() {
		var image = $(this).children().first();
		var linkOfImage = $(image).attr("src");
		$("#productImage").attr("src", linkOfImage);
		$(".zoomWindow").css("background-image", "url(" + linkOfImage + ")");
	});
	
	$("#checkoutAddressBtn").click(function() {
		$("#checkoutAddressBtn").hide();
		$("#checkoutAddress").show(1000);
	});
	
	$('#input-1').rating({min: 0, max: 5, step: 0.1, stars: 5});
	
	function getCurrentUrl(url, data) {
		if (!$.isEmptyObject(data)) {
			url += (url.indexOf('?') >= 0 ? '&' : '?') + $.param(data);
		}

		return url;
	}
	
	$(".user-icon").hover(function() {
		$(".userInfo").show('slow');
	});
	
	$('body').click(function() {
	    $(".userInfo").hide('slow');
	});
	
	$('.userInfo').click(function(e) {
	    e.stopPropagation();
	});
	
})