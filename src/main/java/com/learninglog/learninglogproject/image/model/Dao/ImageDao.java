package com.learninglog.learninglogproject.image.model.Dao;

public class ImageDao {
    public  static boolean insertImageDetails(
            String name, String imagePath
    ) {
        String query = "INSERT INTO images(name, path)" + "VALUES (?,?)";
        return true;
    }
}
