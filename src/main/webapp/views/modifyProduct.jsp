<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Modify Product</title>
		<jsp:include page="layout.jsp"></jsp:include>
	</head>
	<body>
		<div id="modifyProduct">
			<h3>Add Or Update Product</h3>
			<c:choose>
				<c:when test='${product.id ==0}'><c:url var="productACtion" value="modify" /></c:when>
				<c:otherwise><c:url var="productACtion" value="product/modify" /></c:otherwise>
			</c:choose>
	
			<form:form modelAttribute="product" action="${productACtion}" method="post">
				<form:errors path="*" cssClass="error" element="div" />
				<div class="form-group">
					<c:if test="${product.id > 0}">
						<form:label path="id">
							<spring:message text="ID" />
						</form:label>
						<form:input path="id" readonly="true" size="8" disabled="true"
							id="productId" class="form-control" />
					</c:if>
					<form:hidden path="id"/>
				</div>
				
				<div class="form-group">
					<form:label path="productName">
						<spring:message text="Name"/>
					</form:label>
					<form:input path="productName" id="productName" class="form-control" cssErrorClass="form-control errorInput"/>
					<form:errors path="productName" cssClass="error"/>
				</div>
				
				<div class="form-group">
					<form:label path="description">
						<spring:message text="Description"/>
					</form:label>
					<form:input path="description" class="form-control" id="description" cssErrorClass="form-control errorInput"/>
					<form:errors path="description" cssClass="error"/>
				</div>
				
				<div class="form-group">
					<form:label path="price">
						<spring:message text="Price" />
					</form:label>
					<form:input path="price" id="price" class="form-control" cssErrorClass="form-control errorInput"/>
					<form:errors path="price" cssClass="error"/>
				</div>
				
				<div class="form-group">
					<form:label path="productType">
						<spring:message text="Type" /> 
					</form:label>
					<form:select path="productType" id="productType" class="form-control">
						<form:option value="BREAKFAST">Breakfast</form:option>
						<form:option value="LUNCH">Lunch</form:option>
						<form:option value="DINNER">Dinner</form:option>
					</form:select>
					<form:errors path="productType" cssClass="error"/>
				</div>			
				<c:choose>
					<c:when test="${product.id > 0}">
						<button type="submit" class="btn btn-success">Update</button>
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-success">Insert</button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${product.id > 0}">
						<a href="product/list" class="btn btn-info">Back</a>
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