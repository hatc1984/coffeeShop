<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Modify User</title>
		<jsp:include page="layout.jsp"></jsp:include>
	</head>
	<body>
		<div id="modifyUser">
			<div id="modifyUser">
			<c:choose>
				<c:when test="${user.id == 0}">
					<h3><spring:message text="Add User" /></h3>
				</c:when>
				<c:otherwise>
					<h3><spring:message text="Update User" /></h3>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test='${user.id ==0}'><c:url var="userACtion" value="modify" /></c:when>
				<c:otherwise><c:url var="userACtion" value="user/modify" /></c:otherwise>
			</c:choose>

	   		<form:form role="form" action="signup" method="POST" modelAttribute="user">
				<div class="form-group">
					<c:if test="${user.id > 0}">
						<form:label path="id">
							<spring:message text="Id" />
						</form:label>
						<form:input path="id" readonly="true" size="8" disabled="true"
							id="userId" class="form-control" />
					</c:if>
					<form:hidden path="id"/>
				</div>
	   			<c:if test="${not empty error}">
	   				 <div class="errorSignUp">${error}</div>
	   			</c:if>
	   			
	   			<div class="row">
	   				<div class="col-xs-6 col-sm-6 col-md-6">
	   					<div class="form-group">
	   						<form:label path="firstName">
								<spring:message text="First Name" />
							</form:label>
	              			<form:input path="firstName" type="text" name="firstName" 
	              					id="firstName" class="form-control input-sm" placeholder="First Name" cssErrorClass="form-control input-sm errorInput"/>
	   						<form:errors path="firstName" cssClass="errorSignUp"/>
	   					</div>
	   				</div>
	   				<div class="col-xs-6 col-sm-6 col-md-6">
	   					<div class="form-group">
	   						<form:label path="lastName">
								<spring:message text="Last Name" />
							</form:label>
	   						<form:input path="lastName" type="text" name="lastName" 
	   							id="lastName" class="form-control input-sm" placeholder="Last Name" cssErrorClass="form-control input-sm errorInput"/>
	   						<form:errors path="lastName" cssClass="errorSignUp"/>
	   					</div>
	   				</div>
	   			</div>
	
	   			<div class="form-group">
	   				<form:label path="email">
							<spring:message text="Email" />
					</form:label>
	   				<form:input path="email" type="text" name="email" 
	   					id="email" class="form-control input-sm" placeholder="Email Address" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="email" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<div class="row">
	   				<div class="col-xs-6 col-sm-6 col-md-6">
	   					<div class="form-group">
	   					<form:label path="password">
							<spring:message text="Password" />
						</form:label>
	   						<form:input path="password" 
	   							type="password" name="password" id="password" class="form-control input-sm" placeholder="Password" cssErrorClass="form-control input-sm errorInput"/>
	   						<form:errors path="password" cssClass="errorSignUp"/>
	   					</div>
	   				</div>
	   				<div class="col-xs-6 col-sm-6 col-md-6">
	   					<div class="form-group">
	   						<form:label path="passwordConfirm">
								<spring:message text="Password Confirm" />
							</form:label>
	   						<form:input path="passwordConfirm" type="password" name="passwordConfirm" 
	   							id="passwordConfirm" class="form-control input-sm" placeholder="Confirm Password" cssErrorClass="form-control input-sm errorInput"/>
	   						<form:errors path="passwordConfirm" cssClass="errorSignUp"/>
	   					</div>
	   				</div>
	   			</div>
	   			
	   			<div class="form-group">
	   				<form:label path="phone">
							<spring:message text="Phone" />
					</form:label>
	   				<form:input path="phone" type="text" name="phone" 
	   					id="phone" class="form-control input-sm" placeholder="Phone Number" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="phone" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<hr>
	   			
	   			<div class="form-group">
					<form:label path="address.city">
						<spring:message text="City" />
					</form:label>
					<form:input path="address.city" type="text" name="city" 
	   					id="city" class="form-control input-sm" placeholder="City" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="address.city" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<div class="form-group">
					<form:label path="address.state">
						<spring:message text="State" />
					</form:label>
					<form:input path="address.state" type="text" name="state" 
	   					id="state" class="form-control input-sm" placeholder="State" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="address.state" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<div class="form-group">
					<form:label path="address.country">
						<spring:message text="Country" />
					</form:label>
					<form:input path="address.country" type="text" name="country" 
	   					id="country" class="form-control input-sm" placeholder="Country" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="address.country" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<div class="form-group">
					<form:label path="address.zipcode">
						<spring:message text="ZipCode" />
					</form:label>
					<form:input path="address.zipcode" type="text" name="zipcode" 
	   					id="zipcode" class="form-control input-sm" placeholder="Zipcode" cssErrorClass="form-control input-sm errorInput"/>
	   				<form:errors path="address.zipcode" cssClass="errorSignUp"/>
	   			</div>
	   			
	   			<input type="submit" value="Register" class="btn btn-info btn-block">
				<c:choose>
					<c:when test="${user.id > 0}">
						<button type="submit" class="btn btn-success">Update</button>
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-success">Add</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${user.id > 0}">
						<a href="user/list" class="btn btn-info">Back</a>
					</c:when>
					<c:otherwise>
						<a href="list" class="btn btn-info">Back</a>
					</c:otherwise>
				</c:choose>
				
				<input type="hidden" name="${_csrf.parameterName}"
	 									value="${_csrf.token}"/>
	   		</form:form>
		</div>
	</body>
</html>