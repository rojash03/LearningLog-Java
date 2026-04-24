package com.learninglog.learninglogproject.image.controller;

import com.learninglog.learninglogproject.HelloServlet;
import com.learninglog.learninglogproject.image.model.Dao.ImageDao;
import com.learninglog.learninglogproject.utils.ImageUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet("/image")
@MultipartConfig
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/imageUpload.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        Part image = req.getPart("image");
        try{
        String filepath= ImageUtils.writeImage(image);
        boolean result = ImageDao.insertImageDetails(name, filepath);

        if (result){
            req.setAttribute("message", "Image uploaded successfully!");

        } else {
            req.setAttribute("message", "Image upload failed!");
        }

        }catch (Exception e){
            req.setAttribute("error", "An error occurred while uploading the image: " + e.getMessage());
        }
    }
}
