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

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean created = false;
        if (username != null && !username.trim().isEmpty() &&
            password != null && !password.trim().isEmpty() &&
            email != null && !email.trim().isEmpty()) {

            UserDAO dao = new UserDAO();
            created = dao.register(username, email, password);

            if (created) {
                Map<String, String> user = dao.getUserDetails(email, password);
                if (user != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("userId", Integer.parseInt(user.get("id")));
                    session.setAttribute("username", user.get("name"));
                    resp.sendRedirect(req.getContextPath() + "/home.jsp");
                    return;
                }
            }
        }

        if (created) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            req.setAttribute("error", "Registration failed. Username may already exist or inputs are invalid.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
