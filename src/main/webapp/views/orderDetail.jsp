<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Detail Order</title>
		<jsp:include page="layout.jsp"></jsp:include>
	</head>
	<body id="orderDetail">
		<jsp:include page="header.jsp"></jsp:include>	
		<div>
			<div class="orderList">
				<h3>All Order Items</h3>
						<table class="table">
							<thead>
								<tr>
									<th>#</th>
									<th>Product</th>
									<th>Name</th>
									<th>Price</th>
									<th>Description</th>
									<th>Quantity</th>
									<th>Shiping Info</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orderLines}" var="orderLine">
									<tr>
										<td>${orderLine.product.id}</td>
										<td><a><img alt="productImage"
											src="<c:url value="${orderLine.product.image.get(0).imageLink}"/>"></a></td>
										<td>${orderLine.product.productName}</td>
										<td>${orderLine.product.description}</td>
										<td>${orderLine.product.price}</td>
										<td>${orderLine.quantity}</td>
										<td>${orderLine.order.shippingInfo}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
			</div>
		</div>
	</body>
</html>