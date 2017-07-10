<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><tiles:insertAttribute name="title" /></title>
		<link rel="stylesheet" href="<c:url value="../resources/css/bootstrap.css" />">
		<link rel="stylesheet" href="<c:url value="../resources/css/main.css" />">
		<script src="<c:url value="../resources/js/jquery.js" />"></script>
		<script src="<c:url value="../resources/js/bootstrap.js" />"></script>
		<link rel="stylesheet"
				href="<c:url value="../resources/css/slideshow.css" />">
		<link rel="stylesheet"
				href="<c:url value="../resources/css/style.css" />">
		<link rel="stylesheet"
				href="<c:url value="../resources/css/star-rating.css" />">
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Lato">
		<link rel="icon" href="../resources/image/icon.png" />
		<link rel="stylesheet" href="../resources/font-awesome/css/font-awesome.min.css">
		<script src="<c:url value="../resources/js/jquery.elevatezoom.js" />"></script>
		<script type="text/javascript" src="<c:url value="../resources/js/home.js"/>"></script>
		<script type="text/javascript" src="<c:url value="../resources/js/product.js"/>"></script>
		<script type="text/javascript" src="<c:url value="../resources/js/star-rating.js"/>"></script>
	</head>
	<body>
		<tiles:insertAttribute name="header" />
        <tiles:insertAttribute name="body" />
        <tiles:insertAttribute name="footer" />
	</body>
</html>