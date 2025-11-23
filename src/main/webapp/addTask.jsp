<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-header">
            <h1>➕ Add New Task</h1>
            <h2>Fill in the details below</h2>
        </div>

        <form action="addTask" method="post">
            <label>Task Title</label>
            <input name="title" type="text" placeholder="Enter task title" required>

            <label>Description</label>
            <input name="description" type="text" placeholder="Enter task description (optional)">

            <label>Deadline</label>
            <input name="deadline" type="date" required>

            <label>Priority Level</label>
            <select name="priority">
                <option value="High">🔴 High</option>
                <option value="Medium" selected>🟡 Medium</option>
                <option value="Low">🟢 Low</option>
            </select>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit">Create Task</button>
            </div>
        </form>

        <div class="nav">
            <a href="home.jsp" class="back-link">← Back to Home</a>
        </div>
    </div>
</body>
</html>
