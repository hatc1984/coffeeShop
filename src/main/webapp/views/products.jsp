<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Product
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="products">
				<h3>Product Management</h3>
				<sec:authorize access="hasRole('ADMIN')">
					<a href="/product/add" id="addLnk"
						class="btn btn-primary pull-right"><strong>+</strong> Add
						Product</a>
				</sec:authorize>
				<c:choose>
					<c:when test="${products.size() == 0}">
						<h1 class="productNotExist">Don't have any products</h1>
					</c:when>
					<c:otherwise>
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
											<td class="action"><a
												href="/product?action=update&productId=${product.id}"
												id="updateLnk" class="btn btn-info"><span
													class="glyphicon glyphicon-edit"></span> Edit</a></td>
											<td class="action"><a
												data-href="/product?action=delete&productId=${product.id}"
												id="deleteLnk" class="btn btn-danger" data-toggle="modal"
												data-target="#confirm-delete"><span
													class="glyphicon glyphicon-remove"></span> Del</a></td>
										</sec:authorize>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<div class="modal fade" id="confirm-delete" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">

									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">Confirm Delete</h4>
									</div>

									<div class="modal-body">
										<p>You are about to delete one product</p>
										<p>Do you want to proceed?</p>
										<p class="debug-url"></p>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Cancel</button>
										<a class="btn btn-danger btn-delete">Delete</a>
									</div>
								</div>
							</div>
						</div>


						<c:url var="firstUrl" value="list?index=1" />
						<c:url var="lastUrl"
							value="list?index=${deploymentLog.totalPages}" />
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
								<c:when
									test="${deploymentLog.totalPages == 0 || currentIndex == deploymentLog.totalPages}">
									<li class="disabled"><a href="#">Next</a></li>
									<li class="disabled"><a href="#">Last</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${nextUrl}">Next</a></li>
									<li><a href="${lastUrl}">Last</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


