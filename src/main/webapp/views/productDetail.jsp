<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>product detail</title>
<link rel="stylesheet" href="<c:url value="../resources/css/main.css" />">

<jsp:include page="layout.jsp"></jsp:include>

<script type="text/javascript" src="../resources/js/product.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="productDetail">
		<div class="col-sm-8">
			<div class="col-sm-2">
				<div><img src="resources/image/${product.image.get(0).imageName}"/></div>
				<div><img src="resources/image/${product.image.get(0).imageName}"/></div>
				<div><img src="resources/image/${product.image.get(0).imageName}"/></div>
				<div><img src="resources/image/${product.image.get(0).imageName}"/></div>
			</div>
			<div class="col-sm-10">
				<div><img id="productImage" alt="${product.image.get(0).imageName}" src="resources/image/product1.png" data-zoom-image="resources/image/product1.png"/></div>
			</div>
		</div>
		<div class="col-sm-4">
			<h3>${product.productName}</h3>
			<h4>${product.price}$</h4>
			<div><strong>Brand: </strong> ${product.productType}</div>
			<div><strong>ProductCode: </strong> ${product.id}</div>
			<div class="available"><strong>Availability: </strong>
				<c:choose>
					<c:when test="${product.quantity > 0}">
						<label>In Stock</label>
					</c:when>
					<c:otherwise>
						<label>Out Of Stock</label>
					</c:otherwise>
				</c:choose>
			</div>
			<div><strong>Detail Stock: </strong></div>
			<div class="detail">${product.description}</div>
			<button type="button" class="button-search" onclick="location.href='/buyProduct?code=${product.id}';" 
					<c:if test="${product.quantity == 0}">disabled</c:if>>
					<span class="glyphicon glyphicon-shopping-cart"></span>
					Add to cart
			</button>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>