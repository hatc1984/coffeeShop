<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>product detail</title>
<jsp:include page="layout.jsp"></jsp:include>
<script type="text/javascript" src="../resources/js/home.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="productDetail">
		<div class="form-group">
			<a href="/home" class="backToHome"><span><i class="fa fa-reply"></i>Back to: Home</span></a>
		</div>
		<div class="col-sm-8">
			<div class="col-sm-2">
				<c:forEach items="${product.image}" var="item" begin="0" end="3">
					<div><img src="resources/image/${item.imageName}" alt="${item.imageName}"/></div>
				</c:forEach>
			</div>
			<div class="col-sm-10">
				<div><img id="productImage" alt="${product.image.get(0).imageName}" src="resources/image/${product.image.get(0).imageName}" data-zoom-image="resources/image/${product.image.get(0).imageName}"/></div>
			</div>
		</div>
		<div class="col-sm-4">
			<div class="statusProduct">
				<div>Product Code:  <span>${product.id}</span></div>
				<div>
					Product Availability
					<c:choose>
						<c:when test="${product.quantity > 0}">
							<label>In Stock</label>
						</c:when>
						<c:otherwise>
							<label>Out Of Stock</label>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<h3>${product.productName}</h3>
			<h4>$${product.price}</h4>
			<hr/>
			<div><strong>Brand: </strong> ${product.productType}</div>
			<div><strong>Manufacturer: </strong> ${product.manufacturer}</div>
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
			<div><strong>Detail Stock: </strong>${product.quantity}</div>
			<div class="detail">${product.description}</div>
			<sec:authorize access="hasRole('USER')">
			<button type="button" class="button-search" onclick="location.href='/buyProduct?code=${product.id}';" 
					<c:if test="${product.quantity == 0}">disabled</c:if>>
					<span class="glyphicon glyphicon-shopping-cart"></span>
					Add to cart
			</button>
			</sec:authorize>
			<div style="margin-top: 5px;">
				Viet Nam Coffee: Our story is very simple and we are sure that it might be familiar to you. We are small company of like-minded people who can't imagine their existence without a coffee flow in it. In our shop you can find many unique recipes that were carefully polished during almost 20 years of experience.
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>