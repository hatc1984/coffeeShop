<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<ul class="nav nav-pills">
			<li class="active"><a href="/">Home</a></li>
			<sec:authorize access="hasRole('ADMIN')">
				<li><a href="/product/list">Product</a></li>
				<li><a href="/user/list">Person</a></li>
				<li><a href="/order/list">Order</a></li>
			</sec:authorize>
			<c:choose>
				<c:when test="${pageContext.request.userPrincipal.name == null}">
					<li style="float:right"><a href="/login">Login</a></li>
				</c:when>
				<c:otherwise>
					<li class="header"><a href="/logout">Logout</a></li>
					<sec:authorize access="hasRole('USER')">
						<li class="header user-icon"><a href="person/changeInformation?username=${pageContext.request.userPrincipal.name}"><img src="../resources/image/user.png"/></a></li>
						<li class="header count"><span>${sessionScope['cart'].size == null ? 0 : sessionScope['cart'].size}</span></li>
						<li class="header user-icon"><a href="/order"><img src="../resources/image/cart.png"/></a></li>
					</sec:authorize>
				</c:otherwise>
			</c:choose>
		</ul>
</body>
</html>