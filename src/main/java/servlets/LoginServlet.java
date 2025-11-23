package servlets;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        UserDAO u = new UserDAO();
        Map<String, String> user = u.getUserDetails(email, pass);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", Integer.parseInt(user.get("id")));
            session.setAttribute("username", user.get("name"));
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            resp.sendRedirect("home.jsp");
        } else {
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}
