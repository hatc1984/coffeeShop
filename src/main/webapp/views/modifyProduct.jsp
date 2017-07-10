<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Modify Product
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div id="modifyProduct">
			<div>
				<c:choose>
					<c:when test="${product.id == 0}">
						<h3>
							<spring:message text="Add Product" />
						</h3>
					</c:when>
					<c:otherwise>
						<h3>
							<spring:message text="Update Product" />
						</h3>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test='${product.id ==0}'>
						<c:url var="productACtion" value="modify" />
					</c:when>
					<c:otherwise>
						<c:url var="productACtion" value="product/modify" />
					</c:otherwise>
				</c:choose>

				<form:form modelAttribute="product" action="${productACtion}"
					method="post" enctype="multipart/form-data">
					<div class="form-group">
						<c:if test="${product.id > 0}">
							<form:label path="id">
								<spring:message text="Id" />
							</form:label>
							<form:input path="id" readonly="true" size="8" disabled="true"
								id="productId" class="form-control" />
						</c:if>
						<form:hidden path="id" />
					</div>

					<div class="form-group">
						<form:label path="productName">
							<spring:message text="Name" />
						</form:label>
						<form:input path="productName" id="productName"
							class="form-control" cssErrorClass="form-control errorInput" />
						<form:errors path="productName" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="description">
							<spring:message text="Description" />
						</form:label>

						<form:textarea rows="5" cols="10" class="form-control"
							path="description" id="description"
							cssErrorClass="form-control errorInput"></form:textarea>
						<form:errors path="description" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="price">
							<spring:message text="Price" />
						</form:label>
						<form:input path="price" id="price" class="form-control"
							cssErrorClass="form-control errorInput" />
						<form:errors path="price" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="quantity">
							<spring:message text="Quantity" />
						</form:label>
						<form:input path="quantity" id="quantity" class="form-control"
							cssErrorClass="form-control errorInput" />
						<form:errors path="quantity" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="productType">
							<spring:message text="Type" />
						</form:label>
						<form:select path="productType" id="productType"
							class="form-control">
							<form:option value="BREAKFAST">Breakfast Coffee</form:option>
							<form:option value="LUNCH">Lunch Coffee</form:option>
							<form:option value="DINNER">Dinner Coffee</form:option>
							<form:option value="TEA">Tea</form:option>
						</form:select>
						<form:errors path="productType" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="manufacturer">
							<spring:message text="Manufacturer" />
						</form:label>
						<form:select path="manufacturer" id="manufacturer"
							class="form-control">
							<form:option value="VIETNAM">Viet Nam</form:option>
							<form:option value="USA">America</form:option>
							<form:option value="COMLOMBIA">Columbia</form:option>
							<form:option value="INDONESIA">Indonesia</form:option>
						</form:select>
						<form:errors path="manufacturer" cssClass="error" />
					</div>

					<div class="form-group">
						<form:label path="created">
							<spring:message text="Created Day" />
						</form:label>
						<form:input path="created" id="created" class="form-control"
							type="date" cssErrorClass="form-control errorInput" />
						<form:errors path="created" cssClass="error" />
					</div>

					<c:if test="${product.id == 0}">
						<div class="form-group">
							<form:label path="productImage">
								<spring:message text="Product Image" />
							</form:label>
							<form:input path="productImage" id="productImage"
								class="form:input-large" type="file" multiple="true" />
							<div class="upload">
								<span class="glyphicon glyphicon-picture"></span>Choose Product
								Image..
							</div>
							<c:if test="${not empty imageError}">
								<div class="error">${imageError}</div>
							</c:if>
						</div>
					</c:if>

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
						value="${_csrf.token}" />
				</form:form>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


