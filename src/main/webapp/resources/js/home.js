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
})