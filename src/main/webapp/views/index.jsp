<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" 
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity4">
<head>
<meta charset="UTF-8" />
<title>Index Page</title>
<link href="../static/css/style.css" th:href="@{/css/style.css}" rel="stylesheet" />
</head>
<body>
    Logged user: <span sec:authentication="name"></span> <br/> 
    Roles: <span sec:authentication="principal.authorities"></span>
    <form action="#" th:action="@{/logout}" method="POST">
        <button type="submit">Logout</button>
    </form>
</body>
</html>