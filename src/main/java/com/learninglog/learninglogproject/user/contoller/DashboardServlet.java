package com.learninglog.learninglogproject.user.contoller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        // For now, just forward to a JSP page that will display the dashboard
        req.getRequestDispatcher("/pages/dashboard.jsp").forward(req, resp);

}
}
