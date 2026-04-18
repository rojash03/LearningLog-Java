package com.learninglog.learninglogproject.topic.controller;


import com.learninglog.learninglogproject.topic.model.dao.TopicDao;
import com.learninglog.learninglogproject.topic.model.Topic;
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
public class TopicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String page = req.getParameter("page");
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        if ("edit".equals(page)) {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Invalid topic id for editing.");
                req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
                return;
            }

            try {
                int id = Integer.parseInt(idParam);
                Topic obj = TopicDao.fetchTopicById(id);
                if (obj == null) {
                    req.setAttribute("error", "Topic not found for editing.");
                    req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
                    return;
                }

                req.setAttribute("topic", obj);
                req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, resp);
                return;
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Topic id must be a number.");
                req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
                return;
            } catch (SQLException e) {
                req.setAttribute("error", "Unable to fetch topic for editing: " + e.getMessage());
                req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
                return;
            }
        }

        if ("list".equals(page)) {
            try {
                List<Topic> topicList = TopicDao.fetchTopic();
                req.setAttribute("topics", topicList);
            } catch (SQLException e) {
                req.setAttribute("error", "Unable to fetch topic list: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/topicList.jsp").forward(req, resp);
            return;
        }
        req.getRequestDispatcher("/pages/addTopic.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (!"add".equals(action) && !"edit".equals(action)) {
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

        if ("edit".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                req.setAttribute("error", "Topic id is required for editing.");
                req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, resp);
                return;
            }

            try {
                int id = Integer.parseInt(idParam);
                boolean updated = TopicDao.updateTopic(id, topicName, user.getId());
                if (updated) {
                    resp.sendRedirect("topic?page=list");
                } else {
                    req.setAttribute("error", "Unable to update topic.");
                    Topic existingTopic = TopicDao.fetchTopicById(id);
                    if (existingTopic != null) {
                        req.setAttribute("topic", existingTopic);
                    }
                    req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, resp);
                }
                return;
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Topic id must be a number.");
                req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, resp);
                return;
            } catch (SQLException e) {
                req.setAttribute("error", "Database error while updating topic: " + e.getMessage());
                req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, resp);
                return;
            }
        }

        int userId = user.getId();
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());

        try {
            boolean result = TopicDao.insertTopic(topicName, userId, createdAt);
            if (result) {
                resp.sendRedirect("topic?page=list");
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
