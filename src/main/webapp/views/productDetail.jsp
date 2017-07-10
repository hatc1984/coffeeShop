<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Product Detail
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="productDetail">
			<div class="col-sm-8">
				<div class="col-sm-2">
					<c:forEach items="${product.image}" var="item" begin="0" end="3">
						<div>
							<img src="resources/image/${item.imageName}"
								alt="${item.imageName}" />
						</div>
					</c:forEach>
				</div>
				<div class="col-sm-10">
					<div>
						<img id="productImage" alt="${product.image.get(0).imageName}"
							src="resources/image/${product.image.get(0).imageName}"
							data-zoom-image="resources/image/${product.image.get(0).imageName}" />
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="statusProduct">
					<div>
						Product Code: <span>${product.id}</span>
					</div>
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
				<input id="input-1" name="input-1" value="4.3"
					class="rating-loading">
				<hr />
				<div>
					<strong>Type: </strong> ${product.productType}
				</div>
				<div>
					<strong>Made in: </strong> ${product.manufacturer}
				</div>
				<div>
					<strong>Detail Stock: </strong>${product.quantity}</div>
				<div class="detail">${product.description}</div>
				<sec:authorize access="hasRole('USER')">
					<button type="button" class="button-search"
						onclick="location.href='/buyProduct?code=${product.id}';"
						<c:if test="${product.quantity == 0}">disabled</c:if>>
						<span class="glyphicon glyphicon-shopping-cart"></span> Add to
						cart
					</button>
				</sec:authorize>
				<div style="margin-top: 5px;">Viet Nam Coffee: Our story is
					very simple and we are sure that it might be familiar to you. We
					are small company of like-minded people who can't imagine their
					existence without a coffee flow in it. In our shop you can find
					many unique recipes that were carefully polished during almost 20
					years of experience.</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer" value="/views/footer.jsp" />
		
</tiles:insertDefinition>


