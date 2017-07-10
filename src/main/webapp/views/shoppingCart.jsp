<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Shopping Cart
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="shoppingCart">

			<c:if test="${empty cartForm or empty cartForm.cartLines}">
				<h2>There is no items in Cart</h2>
				<div class="form-group back">
					<a href="/home" class="backToHome"><span><i
							class="fa fa-reply"></i>Back to: Home</span></a>
				</div>
			</c:if>

			<c:if test="${not empty cartForm and not empty cartForm.cartLines}">
				<div class="container">
					<div class="row">
						<div class="col-sm-12 col-md-10 col-md-offset-1">
							<form:form method="POST" modelAttribute="cartForm"
								action="${pageContext.request.contextPath}/shoppingCart">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Product</th>
											<th>Quantity</th>
											<th class="text-center">Price</th>
											<th class="text-center">Total</th>
											<th> </th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cartForm.cartLines}" var="cartLineInfo"
											varStatus="varStatus">
											<tr>
												<td class="col-sm-8 col-md-6">
													<div class="media">
														<a class="thumbnail pull-left" href="#"> <img
															class="media-object"
															src="${cartLineInfo.productInfo.getImage().get(0).getImageLink()}"
															style="width: 72px; height: 72px;">
														</a>
														<form:hidden
															path="cartLines[${varStatus.index}].productInfo.id" />

														<div class="media-body">
															<h4 class="media-heading">
																<a href="#">${cartLineInfo.productInfo.getProductName()}</a>
															</h4>
															<h5 class="media-heading">
																by <a href="#">${cartLineInfo.productInfo.productType}</a>
															</h5>
															<c:choose>
																<c:when test="${cartLineInfo.productInfo.quantity > 0}">
																	<span>Status: </span>
																	<span class="text-success"><strong>In
																			Stock</strong></span>
																</c:when>
																<c:otherwise>
																	<span>Status: </span>
																	<span class="text-success"><strong>Out
																			of Stock</strong></span>
																</c:otherwise>
															</c:choose>
														</div>
													</div>
												</td>
												<td class="col-sm-1 col-md-1" style="text-align: center">
													<form:input class="form-control"
														path="cartLines[${varStatus.index}].quantity" />
												<td class="col-sm-1 col-md-1 text-center"><strong><fmt:formatNumber
															value="${cartLineInfo.productInfo.getPrice()}"
															type="currency"></fmt:formatNumber></strong></td>
												<td class="col-sm-1 col-md-1 text-center"><strong><fmt:formatNumber
															value="${cartLineInfo.amount}" type="currency"></fmt:formatNumber></strong></td>
												<td class="col-sm-1 col-md-1"><a type="button"
													class="btn btn-danger"
													href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.getId()}">
														<span class="glyphicon glyphicon-remove"></span> Remove
												</a></td>
											</tr>
										</c:forEach>
										<tr>
											<td> </td>
											<td> </td>
											<td> </td>
											<td><h5>Subtotal</h5></td>
											<td class="text-right"><h5>
													<strong>$${cartForm.calculateMoney()}</strong>
												</h5></td>
										</tr>
										<tr>
											<td> </td>
											<td> </td>
											<td> </td>
											<td><h5>Tax + Free Shipping</h5></td>
											<td class="text-right"><h5>
													<strong>$${cartForm.calculateTax()}</strong>
												</h5></td>
										</tr>
										<tr>
											<td> </td>
											<td> </td>
											<td> </td>
											<td><h3>Total</h3></td>
											<td class="text-right"><h3>
													<strong>$${cartForm.calculateMoney() +
														cartForm.calculateTax()}</strong>
												</h3></td>
										</tr>
										<tr>
											<td> </td>
											<td> </td>
											<td><input class="btn btn-info" type="submit"
												value="Update Quantity" /></td>
											<td><a type="button" class="btn btn-default"
												href="/home"> <span
													class="glyphicon glyphicon-shopping-cart"></span> Continue
													Shopping
											</a></td>
											<td><a type="button" class="btn btn-success"
												href="${pageContext.request.contextPath}/checkout">
													Checkout <span class="glyphicon glyphicon-play"></span>
											</a></td>
										</tr>
									</tbody>
								</table>
							</form:form>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
