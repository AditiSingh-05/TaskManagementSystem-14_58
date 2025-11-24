<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.TaskDAO, java.util.*" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    List<Map<String, String>> allTasks = new TaskDAO().getTasks(userId);

    List<Map<String, String>> incompleteTasks = new ArrayList<>();
    List<Map<String, String>> completedTasks = new ArrayList<>();

    for (Map<String, String> task : allTasks) {
        if ("Completed".equals(task.get("status"))) {
            completedTasks.add(task);
        } else {
            incompleteTasks.add(task);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .task-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin: 0;
        }
        .completed-task {
            opacity: 0.7;
        }
        .completed-task td {
            text-decoration: line-through;
        }
        .section-divider {
            margin: 30px 0 20px 0;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
        }
        .incomplete-section {
            background: linear-gradient(135deg, #ff4444 0%, #cc0000 100%);
        }
        .checkbox-cell {
            text-align: center;
            width: 50px;
        }
    </style>
</head>
<body>
    <div class="logout-corner">
        <a href="logout" class="btn">🚪 Logout</a>
    </div>

    <div class="container">
        <div class="welcome-header">
            <h1>Task Management System</h1>
            <h2>Welcome back<%= username != null ? ", " + username : "" %>! 👋</h2>
        </div>

        <a href="addTask.jsp" class="btn-create-task">
            ➕ Create New Task
        </a>

        <% if (allTasks.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-state-icon">📝</div>
                <p>No tasks yet! Start organizing your work.</p>
                <p style="font-size: 14px; color: #666;">Click the button above to create your first task</p>
            </div>
        <% } else { %>
            <div class="tasks-header">
                <h3>📋 Your Tasks</h3>
                <span class="tasks-count"><%= allTasks.size() %> Task<%= allTasks.size() != 1 ? "s" : "" %> (<%= incompleteTasks.size() %> Incomplete, <%= completedTasks.size() %> Completed)</span>
            </div>

            <% if (!incompleteTasks.isEmpty()) { %>
                <div class="section-divider incomplete-section">
                    ⏳ Incomplete Tasks (<%= incompleteTasks.size() %>)
                </div>

                <table>
                    <tr>
                        <th style="width: 50px;">Done</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Deadline</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                    <% for (Map<String, String> task : incompleteTasks) {
                        String priority = task.get("priority");
                        String status = task.get("status");
                        String priorityClass = "";
                        if ("High".equals(priority)) priorityClass = "priority-high";
                        else if ("Medium".equals(priority)) priorityClass = "priority-medium";
                        else if ("Low".equals(priority)) priorityClass = "priority-low";

                        String statusClass = "status-pending";
                    %>
                    <tr>
                        <td class="checkbox-cell">
                            <input type="checkbox" class="task-checkbox"
                                   onclick="window.location.href='toggleTask?id=<%= task.get("id") %>'"
                                   title="Mark as complete">
                        </td>
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

            <% if (!completedTasks.isEmpty()) { %>
                <div class="section-divider">
                    ✅ Completed Tasks (<%= completedTasks.size() %>)
                </div>

                <table>
                    <tr>
                        <th style="width: 50px;">Done</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Deadline</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                    <% for (Map<String, String> task : completedTasks) {
                        String priority = task.get("priority");
                        String status = task.get("status");
                        String priorityClass = "";
                        if ("High".equals(priority)) priorityClass = "priority-high";
                        else if ("Medium".equals(priority)) priorityClass = "priority-medium";
                        else if ("Low".equals(priority)) priorityClass = "priority-low";

                        String statusClass = "status-completed";
                    %>
                    <tr class="completed-task">
                        <td class="checkbox-cell">
                            <input type="checkbox" class="task-checkbox" checked
                                   onclick="window.location.href='toggleTask?id=<%= task.get("id") %>'"
                                   title="Mark as incomplete">
                        </td>
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
        <% } %>
    </div>
</body>
</html>
