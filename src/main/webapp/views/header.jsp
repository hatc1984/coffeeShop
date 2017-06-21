<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div id="header">
			<ul class="nav nav-pills">
				<li class="active"><a href="/"><spring:message code="header.home"/></a></li>
				<sec:authorize access="hasRole('ADMIN')">
					<li class="adminMenu"><a href="/product/list"><spring:message code="header.product"/></a></li>
					<li class="adminMenu"><a href="/user/list"><spring:message code="header.person"/></a></li>
					<li class="adminMenu"><a href="/order/list"><spring:message code="header.order"/></a></li>
				</sec:authorize>
					<li class="adminMenu i18n">
						<div class="flag"><a href="?lang=en"><img src="/resources/image/america.png" alt="america flag"/></a></div>
						<div class="flag"><a href="?lang=fr"><img src="/resources/image/france.png" alt="france flag"/></a></div>
					</li>
				<c:choose>
					<c:when test="${pageContext.request.userPrincipal.name == null}">
						<li style="float:right"><a href="/login"><spring:message code="header.login"/></a></li>
					</c:when>
					<c:otherwise>
						<li class="header"><a href="/logout"><spring:message code="header.logout"/></a></li>
						<sec:authorize access="hasRole('USER')">
							<li class="header user-icon"><a href="user?action=update&username=${pageContext.request.userPrincipal.name}"><img src="../resources/image/user.png"/></a></li>
							<li class="header count"><span>${sessionScope['myCart'].cartLines.size() == null ? 0 : sessionScope['myCart'].cartLines.size()}</span></li>
							<li class="header user-icon"><a href="/shoppingCart"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
						</sec:authorize>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
</body>
</html>