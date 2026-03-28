package com.learninglog.learninglogproject.user.contoller;


import com.learninglog.learninglogproject.user.model.User;
import com.learninglog.learninglogproject.user.model.dao.userDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req,  HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/pages/register.jsp");
        rd.forward (req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req,  HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Please enter all the fields");
            req.getRequestDispatcher("pages/register.jsp").forward(req,resp);
        }

        User userObj = new User();
        userObj.setName(name);
        userObj.setEmail(email);
//        userObj.setPassword(password);
String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
userObj.setPassword(hashedPassword);
        userDao dao = new userDao();
        try {
            boolean result = dao.insertUser(userObj);
            if (result == true) {
                resp.sendRedirect("login");
            }else  {
                req.setAttribute("error", "Unable to register user");
                req.getRequestDispatcher("pages/register.jsp").forward(req,resp);
            }
        }
        catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("pages/register.jsp").forward(req,resp);

        }
    }

}


