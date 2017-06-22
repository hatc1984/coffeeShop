<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Checkout Page</title>
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
  
   <div class="container">
       <h3>Thank you for Order</h3>
   </div>
   
   <jsp:include page="footer.jsp" />
</body>
</html>
