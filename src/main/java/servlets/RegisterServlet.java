package servlets;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        }

        if (created) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            req.setAttribute("error", "Registration failed. Username may already exist or inputs are invalid.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
