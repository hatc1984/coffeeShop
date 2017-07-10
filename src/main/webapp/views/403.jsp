<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Access Denied Page
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div id="error">
			<div class="container"></div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>

