<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.TaskDAO, java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Map<String, String>> tasks = new TaskDAO().getTasks(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="logout-corner">
        <a href="logout" class="btn">🚪 Logout</a>
    </div>

    <div class="container">
        <div class="welcome-header">
            <h1>📋 All Tasks</h1>
            <h2>Manage your tasks efficiently</h2>
        </div>

        <div class="nav">
            <a href="home.jsp" class="back-link">← Back to Home</a>
            <a href="addTask.jsp" class="btn">➕ Add New Task</a>
        </div>

        <% if (tasks.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-state-icon">📝</div>
                <p>No tasks found!</p>
                <p style="font-size: 14px; color: #666;">Start by adding a new task</p>
            </div>
        <% } else { %>
            <div class="tasks-header">
                <h3>Task List</h3>
                <span class="tasks-count"><%= tasks.size() %> Task<%= tasks.size() != 1 ? "s" : "" %></span>
            </div>

            <table>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Deadline</th>
                    <th>Priority</th>
                    <th>Status</th>
                    <th style="text-align: center;">Actions</th>
                </tr>
                <% for (Map<String, String> task : tasks) {
                    String priority = task.get("priority");
                    String status = task.get("status");
                    String priorityClass = "";
                    if ("High".equals(priority)) priorityClass = "priority-high";
                    else if ("Medium".equals(priority)) priorityClass = "priority-medium";
                    else if ("Low".equals(priority)) priorityClass = "priority-low";

                    String statusClass = "Completed".equals(status) ? "status-completed" : "status-pending";
                %>
                <tr>
                    <td><strong><%= task.get("title") %></strong></td>
                    <td><%= task.get("description") != null && !task.get("description").isEmpty() ? task.get("description") : "-" %></td>
                    <td>📅 <%= task.get("deadline") %></td>
                    <td class="<%= priorityClass %>">⚡ <%= priority %></td>
                    <td class="<%= statusClass %>"><%= status %></td>
                    <td class="action-links" style="text-align: center;">
                        <a href="updateTask.jsp?id=<%= task.get("id") %>" title="Edit Task">✏️</a>
                        <a href="deleteTask?id=<%= task.get("id") %>" onclick="return confirm('Are you sure you want to delete this task?')" title="Delete Task">🗑️</a>
                    </td>
                </tr>
                <% } %>
            </table>
        <% } %>
    </div>
</body>
</html>
