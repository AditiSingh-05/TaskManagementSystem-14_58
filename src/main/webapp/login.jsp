<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Task Manager</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="welcome-header">
            <h1>🔐 Task Management System</h1>
            <h2>Sign in to your account</h2>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <label>Email Address</label>
            <input name="email" type="email" placeholder="Enter your email" required>

            <label>Password</label>
            <input name="password" type="password" placeholder="Enter your password" required>

            <div style="text-align: center; margin-top: 10px;">
                <button type="submit">Login</button>
            </div>
        </form>

        <div class="nav">
            <p>Don't have an account? <a href="register.jsp"><strong>Register here</strong></a></p>
        </div>
    </div>
</body>
</html>
