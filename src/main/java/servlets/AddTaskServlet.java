package servlets;

import dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddTaskServlet", urlPatterns = "/addTask")
public class AddTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        String title = req.getParameter("title");
        String desc = req.getParameter("description");
        String deadline = req.getParameter("deadline");
        String priority = req.getParameter("priority");
        new TaskDAO().addTask(userId, title, desc, deadline, priority);
        resp.sendRedirect("home.jsp");
    }
}
