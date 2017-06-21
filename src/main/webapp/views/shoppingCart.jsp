<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shopping Cart Page</title>
	<jsp:include page="layout.jsp"></jsp:include>
	<link rel="stylesheet"
		href="<c:url value="../resources/css/slideshow.css" />">
		<link rel="stylesheet" href="<c:url value="../resources/css/bootstrap.css" />">
</head>
<body>
  	<jsp:include page="header.jsp"></jsp:include>

	<div style="height: 90px; display: inline-block;">
		<div class="logo">
			<img alt="logo" src="../resources/image/logo.png">
		</div>
	</div>
	
	<c:if test="${empty cartForm or empty cartForm.cartLines}">
       <h2>There is no items in Cart</h2>
       <a href="${pageContext.request.contextPath}/productList">Show
           Product List</a>
   </c:if>
 
   <c:if test="${not empty cartForm and not empty cartForm.cartLines   }">
       <form:form method="POST" modelAttribute="cartForm"
           action="${pageContext.request.contextPath}/shoppingCart">
 
           <c:forEach items="${cartForm.cartLines}" var="cartLineInfo"
               varStatus="varStatus">
               <div class="product-preview-container">
                   <ul>
                   		<c:forEach items="${cartLineInfo.productInfo.getImage()}" var="image">
                   			<li style="display: inline-block"><img class="product-image" src="${image.getImageLink()}" height="60"/></li>
						</c:forEach>
                       <li>Code: ${cartLineInfo.productInfo.getId()} <form:hidden
                               path="cartLines[${varStatus.index}].productInfo.id" />
 
                       </li>
                       <li>Name: ${cartLineInfo.productInfo.getProductName()}</li>
                       <li>Price: <span class="price">
                         <fmt:formatNumber value="${cartLineInfo.productInfo.getPrice()}" type="currency"/>
                        
                       </span></li>
                       <li>Quantity: <form:input
                               path="cartLines[${varStatus.index}].quantity" /></li>
                       <li>Subtotal:
                         <span class="subtotal">
                         <fmt:formatNumber value="${cartLineInfo.amount}" type="currency"/>
                         </span>
                       </li>
                       <li><a
                           href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.getId()}">
                               Delete </a></li>
                   </ul>
               </div>
           </c:forEach>
           <div style="clear: both"></div>
           <input class="button-update-sc" type="submit" value="Update Quantity" />
               
           <a class="addToCartBtn"
				href="${pageContext.request.contextPath}/home"> <span
				class="glyphicon glyphicon-shopping-cart"></span> Continue Buy</a>
				
			<a class="btn btn-danger"
				href="${pageContext.request.contextPath}/checkout"> <span
				class="glyphicon glyphicon-shopping-cart"></span> Process to checkout</a>
               
       </form:form>
 
 
   </c:if>

   <jsp:include page="footer.jsp" />

</body>
</html>