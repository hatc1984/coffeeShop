<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Order Management
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="orders">
			<div>
				<h3>Order Management</h3>
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th>Customer Name</th>
							<th>Customer Email</th>
							<th>Date Order</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${orders}">
							<tr>
								<td>${order.id}</td>
								<td>${order.person.firstName}${order.person.lastName}</td>
								<td>${order.person.email}</td>
								<td>${order.orderDate}</td>
								<td><a href="detail?orderId=${order.id}">Detail</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>

