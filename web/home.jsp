<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
<%
Integer id = (Integer) session.getAttribute("userId");
if(id == null) response.sendRedirect("login.jsp");
%>
<h2>Welcome to Task Manager</h2>
<a href="addTask.jsp">Add Task</a> |
<a href="viewTasks.jsp">View Tasks</a> |
<a href="logout">Logout</a>
</body>
</html>
