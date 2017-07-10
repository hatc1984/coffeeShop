<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Checkout Page
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="checkoutPage">
			<c:if test="${empty cartForm or empty cartForm.cartLines}">
				<h2>There is no items in Cart. So you can not Checkout</h2>
				<a href="${pageContext.request.contextPath}/home">Continues
					buying</a>
			</c:if>

			<h3>Enter Shipping and Payment Information</h3>

			<form:form role="form"
				action="${pageContext.request.contextPath}/shoppingCartConfirmation"
				method="POST" modelAttribute="checkoutForm">

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
					<a id="checkoutAddressBtn" class="checkoutAddressBtn"><span><i
							class="fa fa-pencil-square-o" aria-hidden="true"></i>Add new
							shipping address</span></a>
				</div>

				<div id="checkoutAddress" style="display: none">
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
				</div>

				<div class="form-group">
					<label>Visa card </label> <input type="text" class="form-control">
				</div>

				<div class="group-card">
					<ul class="cart-list">
						<li><img alt="visa" src="resources/image/visa.png"></li>
						<li><img alt="mastercard"
							src="resources/image/mastercard.png"></li>
						<li><img alt="paycard" src="resources/image/paycard.png"></li>
						<li><img alt="express" src="resources/image/express.png"></li>
						<li><img alt="paypal" src="resources/image/paypal.png"></li>
					</ul>
				</div>

				<a href="/shoppingCart" class="btn btn-info">Back</a>
				<button type="submit" class="btn btn-success">Check Out</button>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form:form>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer" value="/views/footer.jsp" />
</tiles:insertDefinition>



