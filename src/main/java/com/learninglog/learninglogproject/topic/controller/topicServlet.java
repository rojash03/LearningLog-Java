package com.learninglog.learninglogproject.topic.controller;


import com.learninglog.learninglogproject.topic.model.dao.topicDao;
import com.learninglog.learninglogproject.topic.model.topic;
import com.learninglog.learninglogproject.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/topic")
public class topicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String page = req.getParameter("page");

        if ("list".equals(page)) {
            try{
                List<topic> topicList = topicDao.fetchTopic();
                req.setAttribute("topics", topicList);
            } catch (SQLException e) {
                req.setAttribute("error", "Unable to fetch topic list");

            }

            req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (!"add".equals(action)) {
            req.setAttribute("error", "Invalid topic action.");
            req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
            return;
        }

        String topicName = req.getParameter("topicName");
        if (topicName != null) {
            topicName = topicName.trim();
        }
        req.setAttribute("topicNameValue", topicName);

        if (topicName == null || topicName.isEmpty()) {
            req.setAttribute("error", "Topic name is required.");
            req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        int userId = user.getId();
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());

        try {
            boolean result = topicDao.insertTopic(topicName, userId, createdAt);
            if (result) {
                resp.sendRedirect("dashboard");
            } else {
                req.setAttribute("error", "Unable to add topic.");
                req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error while adding topic: " + e.getMessage());
            req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Unexpected error while adding topic: " + e.getMessage());
            req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
        }
    }
}
