<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		<spring:message code="title.HomePage"></spring:message>
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div style="height: 90px; display: inline-block;">
			<div class="logo">
				<img alt="logo" src="../resources/image/logo.png">
			</div>
		</div>

		<div class="container">
			<h3>Thank you for Order</h3>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer" value="/views/footer.jsp" />
</tiles:insertDefinition>





