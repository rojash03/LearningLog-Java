package com.learninglog.learninglogproject.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

public class ImageUtils {
    public static String writeImage(Part imagePart) throws IOException {
        String uploadDirectory = "C:\\Users\\Dell\\OneDrive - London Metropolitan University\\Second Year\\Advance Programming\\learninglog\\src\\main\\webapp\\images\\";

        File imagespath = new File(uploadDirectory);
        if (!imagespath.exists()) {
            imagespath.mkdirs();
        }
        String fileName = imagePart.getSubmittedFileName();
        imagePart.write(uploadDirectory +File.separator + fileName);

        return "images/" + fileName;
    }
}
