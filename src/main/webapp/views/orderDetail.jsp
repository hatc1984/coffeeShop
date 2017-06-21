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
		<div>
			<div class="orderList">
				<h1>All Order Items</h1>
				<c:forEach items="${orderLines}" var="orderLine">
					<div class="goodCheckout">
						<a><img alt="productImage"
							src="<c:url value="../resources/image/product1.png"/>"></a>
						<h3>${orderLine.product.productName}</h3>
						<p>${orderLine.product.description}</p>
						<p>$${orderLine.product.price}</p>
						<p>${orderLine.quantity}</p>
					</div>
				</c:forEach>
			</div>
			<div>
				<a href="/order/list" id="backBtn">Back</a>
			</div>
		</div>
	</body>
</html>