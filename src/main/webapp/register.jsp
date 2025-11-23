<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-header">
            <h1>📝 Task Management System</h1>
            <h2>Create your account</h2>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="register" method="post">
            <label>Full Name</label>
            <input name="name" type="text" placeholder="Enter your full name" required>

            <label>Email Address</label>
            <input name="email" type="email" placeholder="Enter your email" required>

            <label>Password</label>
            <input name="password" type="password" placeholder="Create a password" required>

            <div style="text-align: center; margin-top: 10px;">
                <button type="submit">Register</button>
            </div>
        </form>

        <div class="nav">
            <p>Already have an account? <a href="login.jsp"><strong>Login here</strong></a></p>
        </div>
    </div>
</body>
</html>
