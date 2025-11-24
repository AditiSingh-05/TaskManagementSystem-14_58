package servlets;

import dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ToggleTaskServlet", urlPatterns = "/toggleTask")
public class ToggleTaskServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                TaskDAO dao = new TaskDAO();
                dao.toggleTaskStatus(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/home.jsp");
    }
}

