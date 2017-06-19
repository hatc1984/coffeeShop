<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Product Management</title>
		<jsp:include page="layout.jsp"></jsp:include>
	</head>
	<body>
		<div id="products">
				<h3>Product Management</h3>
				<sec:authorize access="hasRole('ADMIN')">
					<a href="/product/add" id="addLnk" class="btn btn-primary pull-right"><strong>+</strong> Add Product</a>
				</sec:authorize>
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th>Product Name</th>
							<th>Price</th>
							<th>Description</th>
							<th>Type</th>
							<sec:authorize access="hasRole('ADMIN')">
								<th colspan="2" id="action">Action</th>
							</sec:authorize>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="product" items="${products}">
							<tr>
								<td>${product.id}</td>
								<td>${product.productName}</td>
								<td>${product.price}</td>
								<td>${product.description}</td>
								<td>${product.productType}</td>
								<sec:authorize access="hasRole('ADMIN')">
									<td class="action"><a href="/product?action=update&productId=${product.id}" id="updateLnk" class="btn btn-info"><span class="glyphicon glyphicon-edit"></span> Edit</a></td>
									<td class="action"><a href="/product?action=delete&productId=${product.id}" id="deleteLnk" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
								</sec:authorize>
							</tr>
						</c:forEach>
					</tbody>
				</table>

		<c:url var="firstUrl" value="list?index=1" />
		<c:url var="lastUrl" value="list?index=${deploymentLog.totalPages}" />
		<c:url var="prevUrl" value="list?index=${currentIndex - 1}" />
		<c:url var="nextUrl" value="list?index=${currentIndex + 1}" />
		<ul class="pagination">
				<c:choose>
					<c:when test="${currentIndex == 1}">
						<li class="disabled"><a href="#">First</a></li>
						<li class="disabled"><a href="#">Prev</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${firstUrl}">First</a></li>
						<li><a href="${prevUrl}">Prev</a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
					<c:url var="pageUrl" value="list?index=${i}" />
					<c:choose>
						<c:when test="${i == currentIndex}">
							<li class="active"><a href="${pageUrl}"><c:out
										value="${i}" /></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${deploymentLog.totalPages == 0 || currentIndex == deploymentLog.totalPages}">
						<li class="disabled"><a href="#">Next</a></li>
						<li class="disabled"><a href="#">Last</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${nextUrl}">Next</a></li>
						<li><a href="${lastUrl}">Last</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</body>
</html>