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
	
	<c:if test="${empty cartForm or empty cartForm.cartLines}">
       <h2>There is no items in Cart. So you can not Checkout</h2>
       <a href="${pageContext.request.contextPath}/home">Continues buying</a>
   </c:if>
 
 	<h3>Enter Shipping and Payment Information and Payment</h3>
 
 			<form:form role="form" action="${pageContext.request.contextPath}/shoppingCartConfirmation" method="POST"
				modelAttribute="checkoutForm">
				
				<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
						<div class="form-group">
							<form:label path="firstName">
								<spring:message text="First Name" />
							</form:label>
							<form:input path="firstName" type="text" name="firstName"
								id="firstName" class="form-control input-sm"
								placeholder="First Name"
								cssErrorClass="form-control input-sm errorInput" />
							<form:errors path="firstName" cssClass="errorSignUp" />
						</div>
					</div>
					<div class="col-xs-6 col-sm-6 col-md-6">
						<div class="form-group">
							<form:label path="lastName">
								<spring:message text="Last Name" />
							</form:label>
							<form:input path="lastName" type="text" name="lastName"
								id="lastName" class="form-control input-sm"
								placeholder="Last Name"
								cssErrorClass="form-control input-sm errorInput" />
							<form:errors path="lastName" cssClass="errorSignUp" />
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<form:label path="email">
						<spring:message text="Email" />
					</form:label>
					<form:input path="email" type="text" name="email" id="email"
						class="form-control input-sm" placeholder="Email Address"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="email" cssClass="errorSignUp" />
				</div>

				<div class="form-group">
					<form:label path="phone">
						<spring:message text="Phone" />
					</form:label>
					<form:input path="phone" type="text" name="phone" id="phone"
						class="form-control input-sm" placeholder="Phone Number"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="phone" cssClass="errorSignUp" />
				</div>

				<hr>

				<div class="form-group">
					<form:label path="address.city">
						<spring:message text="City" />
					</form:label>
					<form:input path="address.city" type="text" name="city" id="city"
						class="form-control input-sm" placeholder="City"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="address.city" cssClass="errorSignUp" />
				</div>

				<div class="form-group">
					<form:label path="address.state">
						<spring:message text="State" />
					</form:label>
					<form:input path="address.state" type="text" name="state"
						id="state" class="form-control input-sm" placeholder="State"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="address.state" cssClass="errorSignUp" />
				</div>

				<div class="form-group">
					<form:label path="address.country">
						<spring:message text="Country" />
					</form:label>
					<form:input path="address.country" type="text" name="country"
						id="country" class="form-control input-sm" placeholder="Country"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="address.country" cssClass="errorSignUp" />
				</div>

				<div class="form-group">
					<form:label path="address.zipcode">
						<spring:message text="ZipCode" />
					</form:label>
					<form:input path="address.zipcode" type="text" name="zipcode"
						id="zipcode" class="form-control input-sm" placeholder="Zipcode"
						cssErrorClass="form-control input-sm errorInput" />
					<form:errors path="address.zipcode" cssClass="errorSignUp" />
				</div>

				<div class="form-group">
				<label>Please input Payment Visa card </label>
					<input type ="text">
				</div>
				
				<button type="submit" class="btn btn-success">Check Out</button>
				
				<a href="user/list" class="btn btn-info">Back</a>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form:form>

   <jsp:include page="footer.jsp" />

</body>
</html>