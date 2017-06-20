<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Sign Up Page</title>
		<jsp:include page="layout.jsp"></jsp:include>
	</head>
	<body>
		<div id="signUp">
			<div class="container">
		        <div class="row centered-form">
			        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
			        	<div class="panel panel-default">
			        		<div class="panel-heading">
						    		<h3 class="panel-title">Please sign up for Coffe Shop <small>It's free!</small></h3>
						 			</div>
						 			<div class="panel-body">
						    		<form:form role="form" action="signup" method="POST" modelAttribute="user">
						    			<c:if test="${not empty error}">
						    				 <div class="errorSignUp">${error}</div>
						    			</c:if>
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						               				<form:input path="firstName" type="text" name="firstName" 
						               					id="firstName" class="form-control input-sm" placeholder="First Name" cssErrorClass="form-control input-sm errorInput"/>
						    						<form:errors path="firstName" cssClass="errorSignUp"/>
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<form:input path="lastName" type="text" name="lastName" 
						    							id="lastName" class="form-control input-sm" placeholder="Last Name" cssErrorClass="form-control input-sm errorInput"/>
						    						<form:errors path="lastName" cssClass="errorSignUp"/>
						    					</div>
						    				</div>
						    			</div>
			
						    			<div class="form-group">
						    				<form:input path="email" type="text" name="email" 
						    					id="email" class="form-control input-sm" placeholder="Email Address" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="email" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<div class="row">
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<form:input path="password" 
						    							type="password" name="password" id="password" class="form-control input-sm" placeholder="Password" cssErrorClass="form-control input-sm errorInput"/>
						    						<form:errors path="password" cssClass="errorSignUp"/>
						    					</div>
						    				</div>
						    				<div class="col-xs-6 col-sm-6 col-md-6">
						    					<div class="form-group">
						    						<form:input path="passwordConfirm" type="password" name="passwordConfirm" 
						    							id="passwordConfirm" class="form-control input-sm" placeholder="Confirm Password" cssErrorClass="form-control input-sm errorInput"/>
						    						<form:errors path="passwordConfirm" cssClass="errorSignUp"/>
						    					</div>
						    				</div>
						    			</div>
						    			
						    			<div class="form-group">
						    				<form:input path="phone" type="text" name="phone" 
						    					id="phone" class="form-control input-sm" placeholder="Phone Number" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="phone" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<hr>
						    			
						    			<div class="form-group">
						    				<form:input path="address.city" type="text" name="city" 
						    					id="city" class="form-control input-sm" placeholder="City" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="address.city" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<div class="form-group">
						    				<form:input path="address.state" type="text" name="state" 
						    					id="state" class="form-control input-sm" placeholder="State" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="address.state" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<div class="form-group">
						    				<form:input path="address.country" type="text" name="country" 
						    					id="country" class="form-control input-sm" placeholder="Country" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="address.country" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<div class="form-group">
						    				<form:input path="address.zipcode" type="text" name="zipcode" 
						    					id="zipcode" class="form-control input-sm" placeholder="Zipcode" cssErrorClass="form-control input-sm errorInput"/>
						    				<form:errors path="address.zipcode" cssClass="errorSignUp"/>
						    			</div>
						    			
						    			<input type="submit" value="Register" class="btn btn-info btn-block">
						    		</form:form>
						    	</div>
				    		</div>
		    		</div>
		    	</div>
		    </div>
	    </div>
	</body>
</html>