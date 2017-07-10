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
	<tiles:putAttribute name="header" value="/views/header.jsp">
		
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div style="height: 90px; display: inline-block;">
			<div class="logo">
				<img alt="logo" src="../resources/image/logo.png">
				<ul>
					<li class="social-icon"><a
						href="https://www.facebook.com/profile.php?id=100001675162908"><i
							class="fa fa-facebook" aria-hidden="true"></i></a></li>
					<li class="social-icon"><a href="https://twitter.com"><i
							class="fa fa-twitter" aria-hidden="true"></i></a></li>
					<li class="social-icon"><a href="#"><i
							class="fa fa-google-plus" aria-hidden="true"></i></a></li>
					<li class="social-icon"><a href="#"><i
							class="fa fa-instagram" aria-hidden="true"></i></a></li>
					<li class="social-icon"><a href="#"><i
							class="fa fa-pinterest" aria-hidden="true"></i></a></li>
				</ul>
			</div>
		</div>
		<div class="pull-right">
			<div id="search" class="search">
				<div class="search-block">
					<form method="GET" action="filter">
						<input type="text" name="info" value="" placeholder="Search">
						<button type="submit" class="button-search">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</form>
				</div>
			</div>
		</div>
		<div id="home">
			<div class="carousel fade-carousel slide" data-ride="carousel"
				data-interval="10000" id="bs-carousel">
				<!-- Overlay -->
				<div class="overlay"></div>

				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#bs-carousel" data-slide-to="0" class="active"></li>
					<li data-target="#bs-carousel" data-slide-to="1"></li>
					<li data-target="#bs-carousel" data-slide-to="2"></li>
				</ol>
				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item slides active">
						<div class="slide-1"></div>
						<div class="hero">
							<hgroup>
								<h1>VietNamese Coffee</h1>
								<h3>Get start your purchase</h3>
							</hgroup>
							<button class="btn btn-hero btn-lg" role="button"
								onclick="location.href='/productAll';">See all product</button>
						</div>
					</div>
					<div class="item slides">
						<div class="slide-2"></div>
						<div class="hero">
							<hgroup>
								<h1>The Best Coffee In The World</h1>
								<h3>Get start your purchase</h3>
							</hgroup>
							<button class="btn btn-hero btn-lg" role="button"
								onclick="location.href='/productAll';">See all product</button>
						</div>
					</div>
					<div class="item slides">
						<div class="slide-3"></div>
						<div class="hero">
							<hgroup>
								<h1>Start a new day with a cup of coffee</h1>
								<h3>Get start your purchase</h3>
							</hgroup>
							<button class="btn btn-hero btn-lg" role="button"
								onclick="location.href='/productAll';">See all product</button>
						</div>
					</div>
				</div>
			</div>
			<div id="coffee">
				<div class="module_header">
					<h3>Coffee</h3>
				</div>
				<div class="content">
					<c:if test="${coffee.size() == 0}">
						<h1>No product at this category</h1>
					</c:if>
					<c:forEach items="${coffee}" var="product" varStatus="loop">
						<div class="item">
							<a href="detailProduct?id=${product.id}"><img
								src="${product.image != null ? product.image.get(0).imageLink : null}"
								alt="${product.image.get(0).imageName}" /></a>
							<div class="caption">
								<div class="name">${product.productName}</div>
								<div class="description">${product.description}</div>
								<div class="price">$${product.price}</div>
								<div class="available">
									<strong>Availability: </strong>
									<c:choose>
										<c:when test="${product.quantity > 0}">
											<label>In Stock</label>
										</c:when>
										<c:otherwise>
											<label>Out Of Stock</label>
										</c:otherwise>
									</c:choose>
								</div>
								<br>
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
			<div id="tea">
				<h3>Tea</h3>
				<div class="content">
					<c:if test="${tea.size() == 0}">
						<h1>No product at this category</h1>
					</c:if>
					<c:forEach items="${tea}" var="product" varStatus="loop">
						<div class="item">
							<a href="detailProduct?id=${product.id}"><img
								src="${product.image.get(0).imageLink}"
								alt="${product.image.get(0).imageName}" /></a>
							<div class="caption">
								<div class="name">${product.productName}</div>
								<div class="description">${product.description}</div>
								<div class="price">$${product.price}</div>
								<div class="available">
									<strong>Availability: </strong>
									<c:choose>
										<c:when test="${product.quantity > 0}">
											<label>In Stock</label>
										</c:when>
										<c:otherwise>
											<label>Out Of Stock</label>
										</c:otherwise>
									</c:choose>
								</div>
								<br>
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
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="footer" value="/views/footer.jsp" />
		
</tiles:insertDefinition>



