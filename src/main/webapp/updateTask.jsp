<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.TaskDAO, java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int taskId = Integer.parseInt(request.getParameter("id"));
    Map<String, String> task = null;
    for (Map<String, String> t : new TaskDAO().getTasks(userId)) {
        if (t.get("id").equals(String.valueOf(taskId))) {
            task = t;
            break;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Task - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-header">
            <h1>✏️ Update Task</h1>
            <h2>Modify task details</h2>
        </div>

        <% if (task != null) { %>
        <form action="updateTask" method="post">
            <input type="hidden" name="id" value="<%= task.get("id") %>">

            <label>Task Title</label>
            <input name="title" type="text" value="<%= task.get("title") %>" placeholder="Enter task title" required>

            <label>Description</label>
            <input name="description" type="text" value="<%= task.get("description") %>" placeholder="Enter task description">

            <label>Deadline</label>
            <input name="deadline" type="date" value="<%= task.get("deadline") %>" required>

            <label>Priority Level</label>
            <input name="priority" type="text" value="<%= task.get("priority") %>" placeholder="High, Medium, or Low" required>

            <label>Status</label>
            <select name="status">
                <option value="Pending" <%= "Pending".equals(task.get("status")) ? "selected" : "" %>>⏳ Pending</option>
                <option value="Completed" <%= "Completed".equals(task.get("status")) ? "selected" : "" %>>✅ Completed</option>
            </select>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit">Update Task</button>
            </div>
        </form>
        <% } else { %>
            <div class="error">❌ Task not found.</div>
        <% } %>

        <div class="nav">
            <a href="home.jsp" class="back-link">← Back to Home</a>
        </div>
    </div>
</body>
</html>
