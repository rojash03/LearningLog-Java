package com.learninglog.learninglogproject.topic.model.dao;

import com.learninglog.learninglogproject.utils.DbConnection;


import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class topicDao {
    public static boolean insertTopic(String topic, int userid, Timestamp created_at) throws SQLException {
        String Query = "INSERT INTO topic(topic, userid, created_at) values (?,?,?)";

        try{
            Connection conn = DbConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(Query);
            st.setString(1, topic);
            st.setInt(2, userid);
            st.setTimestamp(3, created_at);
            int insertedRows = st.executeUpdate();
            if (insertedRows > 0) {
                return true;
            }
            else {
                return false;
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting topic: " + e.getMessage());
        }

    }
}
