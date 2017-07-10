<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Login Page
	</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="main-content">
	<div id="login">
		<div class="container">
			<h3>Login to continue</h3>
			<form action="<c:url value='login' />" method="post">
				<div class="form-group">
					<label for="username">Username:</label> <input type="text"
						class="form-control" id="username" placeholder="Enter email"
						name="username" value="${cookie.username.value}" required>
				</div>
				<div class="form-group">
					<label for="password">Password:</label> <input type="password"
						class="form-control" id="password" placeholder="Enter password"
						name="password" required>
				</div>

				<input name="submit" type="submit" value="Sign In"
					class="btn btn-success" />
				<c:if test="${not empty error}">
					<div class="error message">${error}</div>
				</c:if>
				<div class="checkbox">
					<label><input type="checkbox" name="rememberMeChk"
						<c:if test="${not empty cookie.username.value}">checked</c:if> />Keep
						me signed in</label>
				</div>
				<div class="divider-break">
					<p>New to shop?</p>
					<a href="signup" class="btn btn-primary">Sign Up</a>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>
</div>
	</tiles:putAttribute>
</tiles:insertDefinition>

