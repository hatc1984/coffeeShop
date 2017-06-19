<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8" />
<title>Login Page</title>
<link href="../static/css/style.css" th:href="@{/css/style.css}" rel="stylesheet" />
</head>
<body>
    <div class="main-content">
        <p th:if="${param.error}" class="error">Invalid email or password</p>
        <p th:if="${param.logout}" class="success">You have been logged out</p>
        <h3>Login to continue</h3>
        <form th:action="@{/login}" method="POST">
            <input type="text" name="user" placeholder="Your username" /><br />
            <input type="password" name="password" placeholder="Your password" /><br />
            <button type="submit">Login</button> <br />
        </form>
    </div>
</body>
</html>