package com.learninglog.learninglogproject.topic.model.dao;

import com.learninglog.learninglogproject.topic.model.topic;
import com.learninglog.learninglogproject.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class topicDao {
    private static final String CREATE_TOPIC_TABLE_SQL =
            "CREATE TABLE IF NOT EXISTS topic ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "topic VARCHAR(255) NOT NULL, "
                    + "userid INT NOT NULL, "
                    + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "
                    + "INDEX idx_topic_userid (userid)"
                    + ")";

    public static boolean insertTopic(String topic, int userid, Timestamp created_at) throws SQLException {
        String query = "INSERT INTO topic(topic, userid, created_at) values (?,?,?)";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setString(1, topic);
                st.setInt(2, userid);
                st.setTimestamp(3, created_at);
                int insertedRows = st.executeUpdate();
                return insertedRows > 0;
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting topic. Check table/column names and DB constraints. Cause: " + e.getMessage(), e);
        }

    }

    public static List<topic> fetchTopic() throws SQLException {
        String query = "SELECT * FROM topic";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query);
                 ResultSet rs = st.executeQuery()) {
                List<topic> list = new ArrayList<>();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String topicName = rs.getString("topic");
                    int userId = rs.getInt("userid");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    topic obj = new topic(id, topicName, userId, createdAt);
                    list.add(obj);
                }
                return list;
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching topics. Cause: " + e.getMessage(), e);
        }
    }

    private static void ensureTopicTableExists(Connection conn) throws SQLException {
        try (Statement st = conn.createStatement()) {
            st.execute(CREATE_TOPIC_TABLE_SQL);
        }
    }
}
