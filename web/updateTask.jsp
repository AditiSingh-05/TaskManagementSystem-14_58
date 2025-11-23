<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.TaskDAO,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Task</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h1>Update Task</h1>
<%
int taskId = Integer.parseInt(request.getParameter("id"));
Integer userId = (Integer) session.getAttribute("userId");
TaskDAO t = new TaskDAO();
List<Map<String,String>> tasks = t.getTasks(userId);
Map<String,String> task = null;
for(Map<String,String> x : tasks) {
    if(x.get("id").equals(String.valueOf(taskId))) { task = x; break; }
}
if(task == null) {
    out.println("Task not found");
} else {
%>
<form action="updateTask" method="post">
    <input type="hidden" name="id" value="<%=task.get("id")%>">
    <label>Title: <input name="title" value="<%=task.get("title")%>"></label><br>
    <label>Description: <input name="description" value="<%=task.get("description")%>"></label><br>
    <label>Deadline: <input name="deadline" type="date" value="<%=task.get("deadline")%>"></label><br>
    <label>Priority: <input name="priority" value="<%=task.get("priority")%>"></label><br>
    <label>Status:
        <select name="status">
            <option value="Pending" <%= "Pending".equals(task.get("status"))?"selected":"" %>>Pending</option>
            <option value="Completed" <%= "Completed".equals(task.get("status"))?"selected":"" %>>Completed</option>
        </select>
    </label><br>
    <button type="submit">Update</button>
</form>
<% } %>
</body>
</html>
