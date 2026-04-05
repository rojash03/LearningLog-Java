package com.learninglog.learninglogproject.topic.controller;


import com.learninglog.learninglogproject.topic.model.dao.topicDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/topic")
public class topicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equals("add")) {
            // Handle adding a new topic
            String topicName = req.getParameter("topicName");
            int userId = Integer.parseInt(req.getParameter("userId"));
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            try {
                topicDao dao = new topicDao();
                boolean result = topicDao.insertTopic(topicName, userId, createdAt);
                if (result) {
                    resp.sendRedirect("dashboard");
                } else {
                    req.setAttribute("error", "Unable to add topic");
                    req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
                }


            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
            }
        }
    }
}
