<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
</head>
<body>
<h1>Add Task</h1>
<form action="addTask" method="post">
    Title: <input name="title"><br>
    Description: <input name="description"><br>
    Deadline: <input name="deadline" type="date"><br>
    Priority:
    <select name="priority">
        <option>High</option>
        <option>Medium</option>
        <option>Low</option>
    </select>
    <button type="submit">Add</button>
</form>
</body>
</html>
