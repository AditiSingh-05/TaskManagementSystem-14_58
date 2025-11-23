<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.TaskDAO,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
Integer id = (Integer) session.getAttribute("userId");
if(id == null) { response.sendRedirect("login.jsp"); return; }
TaskDAO t = new TaskDAO();
List<Map<String,String>> list = t.getTasks(id);
%>
<h2>Your Tasks</h2>
<a href="home.jsp">Back</a>
<table border="1">
<tr>
    <th>Title</th><th>Description</th><th>Deadline</th><th>Priority</th><th>Status</th><th>Action</th>
</tr>
<% for(Map<String,String> m : list) { %>
<tr>
    <td><%= m.get("title") %></td>
    <td><%= m.get("description") %></td>
    <td><%= m.get("deadline") %></td>
    <td><%= m.get("priority") %></td>
    <td><%= m.get("status") %></td>
    <td>
        <a href="updateTask.jsp?id=<%=m.get("id")%>">Edit</a> |
        <a href="deleteTask?id=<%=m.get("id")%>">Delete</a>
    </td>
</tr>
<% } %>
</table>
</body>
</html>
