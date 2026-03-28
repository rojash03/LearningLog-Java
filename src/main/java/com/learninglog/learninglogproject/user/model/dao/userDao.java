package com.learninglog.learninglogproject.user.model.dao;

import com.learninglog.learninglogproject.user.model.User;
import com.learninglog.learninglogproject.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class userDao {
    public boolean insertUser(User user) throws SQLException {
        String Query = "INSERT INTO user(name, email, password) values (?,?,?)";

        try (
                Connection conn = DbConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(Query);

        ) {
            st.setString(1, user.getName());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPassword());

            int insertedRows = st.executeUpdate();

            if (insertedRows > 0) {
                return true;
            }  else {
                return false;
            }
        }
    }
    public User LoginUser(String email, String Password)
            throws SQLException{
        String sqlQuery = "SELECT * FROM user WHERE email = ? AND password = ?";
    }
}
