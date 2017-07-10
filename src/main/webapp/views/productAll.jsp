<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		<spring:message code="title.HomePage"></spring:message>
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
	<tiles:putAttribute name="body">
		<div id="productAll">
			<div>
				<div class="categories-title">
					<div>Categories</div>
				</div>
				<div class="categories-title-detail">
					<div>${category_title}</div>
				</div>
			</div>
			<div class="category col-sm-3">
				<ul>
					<li><a href="/productAll?type=bf">Breafast Coffee</a></li>
					<li><a href="/productAll?type=l">Lunch Coffee</a></li>
					<li><a href="/productAll?type=d">Dinner Coffee</a></li>
					<li><a href="/productAll?type=t">Tea</a></li>
				</ul>
			</div>
			<div id="coffee" class="col-sm-9">
				<div class="someStory">Famous brands often lose their
					reputation due to the bad servicing or shipping problems, but we
					work hard to make you feel comfortable while being a guest at our
					shop. We value every single client because giving you joy and
					happiness is why we are here.</div>
				<div class="content">
					<c:if test="${products.size() == 0}">
						<h1>No product at this category</h1>
					</c:if>
					<c:forEach items="${products}" var="product" varStatus="loop">
						<div class="item">
							<a href="detailProduct?id=${product.id}"><img
								src="${product.image.get(0).imageLink}"
								alt="${product.image.get(0).imageName}" /></a>
							<div class="caption">
								<div class="name">${product.productName}</div>
								<div class="description">${product.description}</div>
								<div class="price">$${product.price}</div>
								<sec:authorize access="hasRole('USER')">
									<a class="addToCartBtn" href="/buyProduct?code=${product.id}">
										<span class="glyphicon glyphicon-shopping-cart"></span> Add To
										Cart
									</a>
								</sec:authorize>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<c:url var="firstUrl" value="productAll?index=1" />
			<c:url var="lastUrl"
				value="productAll?index=${deploymentLog.totalPages}" />
			<c:url var="prevUrl" value="productAll?index=${currentIndex - 1}" />
			<c:url var="nextUrl" value="productAll?index=${currentIndex + 1}" />

			<c:if test="${products.size() > 0}">

				<ul class="pagination">
					<c:choose>
						<c:when test="${currentIndex == 1}">
							<li class="disabled"><a href="#">First</a></li>
							<li class="disabled"><a href="#">Prev</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${firstUrl}">First</a></li>
							<li><a href="${prevUrl}">Prev</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
						<c:url var="pageUrl" value="productAll?index=${i}" />
						<c:choose>
							<c:when test="${i == currentIndex}">
								<li class="active"><a href="${pageUrl}"><c:out
											value="${i}" /></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when
							test="${deploymentLog.totalPages == 0 || currentIndex == deploymentLog.totalPages}">
							<li class="disabled"><a href="#">Next</a></li>
							<li class="disabled"><a href="#">Last</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${nextUrl}">Next</a></li>
							<li><a href="${lastUrl}">Last</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</c:if>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer" value="/views/footer.jsp" />
</tiles:insertDefinition>



