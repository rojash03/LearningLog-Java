package com.learninglog.learninglogproject.topic.controller;

import com.learninglog.learninglogproject.topic.model.dao.TopicDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit-topic")
public class TopicEditServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("topic-name");
        try{
            TopicDao dao = new TopicDao();
            boolean result = dao.updateTopic(id, name,123);
            if(result){
                res.sendRedirect("/topic?page=list");
                return;

            }else{
                req.setAttribute("error", "Failed to update topic. Please try again.");
                req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, res);
                return;

            }
        }catch (Exception e){
            req.setAttribute("error", "An error occurred while updating the topic: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/editTopic.jsp").forward(req, res);
        return;
    }



}