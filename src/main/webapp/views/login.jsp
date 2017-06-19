<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
	<link href="../resources/css/style_2.css" th:href="@{/css/style.css}" rel="stylesheet" />
	<meta charset="UTF-8" />
	<title>Login Page</title>
</head>
<body class="main-content">
    <div >
    <div class="login">
<%--         <p th:if="${param.error}" class="error">Invalid email or password</p> --%>
<%--         <p th:if="${param.logout}" class="success">You have been logged out</p> --%>
        <h3>Login to continue</h3>
        <form th:action="@{/login}" method="POST">
        	<input type="hidden" name="${ _csrf.parameterName}" value = "${_csrf.token}" /><br />
            <input type="text" name="user" placeholder="Your username" /><br />
            <input type="password" name="password" placeholder="Your password" /><br />
            <button type="submit">Login</button> <br />
        </form>
        <form>
        	<p>Do you wanna create new account?</p>
        	<a href="/signup">SignUp</a>
        </form>
        </div>>
    </div>
</body>
</html>