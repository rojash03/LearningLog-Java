package com.learninglog.learninglogproject.topic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.learninglog.learninglogproject.topic.model.Topic;
import com.learninglog.learninglogproject.utils.DbConnection;

public class TopicDao {
    private static final String CREATE_TOPIC_TABLE_SQL = "CREATE TABLE IF NOT EXISTS topic ("
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
            throw new SQLException(
                    "Error inserting topic. Check table/column names and DB constraints. Cause: " + e.getMessage(), e);
        }

    }

    public static List<Topic> fetchTopic() throws SQLException {
        String query = "SELECT * FROM topic";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query);
                    ResultSet rs = st.executeQuery()) {
                List<Topic> list = new ArrayList<>();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String topicName = rs.getString("topic");
                    int userId = rs.getInt("userid");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    Topic obj = new Topic(id, topicName, userId, createdAt);
                    list.add(obj);
                }
                return list;
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching topics. Cause: " + e.getMessage(), e);
        }
    }

    public static List<Topic> fetchTopicsByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM topic WHERE userid = ? ORDER BY created_at DESC";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setInt(1, userId);
                try (ResultSet rs = st.executeQuery()) {
                    List<Topic> list = new ArrayList<>();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String topicName = rs.getString("topic");
                        Timestamp createdAt = rs.getTimestamp("created_at");
                        Topic obj = new Topic(id, topicName, userId, createdAt);
                        list.add(obj);
                    }
                    return list;
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching topics by user ID. Cause: " + e.getMessage(), e);
        }
    }

    public static Topic fetchTopicById(int id) throws SQLException {
        String query = "SELECT * FROM topic WHERE id = ?";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setInt(1, id);
                try (ResultSet rs = st.executeQuery()) {
                    if (rs.next()) {
                        String topicName = rs.getString("topic");
                        int userId = rs.getInt("userid");
                        Timestamp createdAt = rs.getTimestamp("created_at");
                        return new Topic(id, topicName, userId, createdAt);
                    } else {
                        return null; // No topic found with the given ID
                    }
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching topic by ID. Cause: " + e.getMessage(), e);
        }
    }

    public static Topic fetchTopicByIdAndUserId(int id, int userId) throws SQLException {
        String query = "SELECT * FROM topic WHERE id = ? AND userid = ?";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setInt(1, id);
                st.setInt(2, userId);
                try (ResultSet rs = st.executeQuery()) {
                    if (rs.next()) {
                        String topicName = rs.getString("topic");
                        Timestamp createdAt = rs.getTimestamp("created_at");
                        return new Topic(id, topicName, userId, createdAt);
                    }
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error fetching topic by ID and user. Cause: " + e.getMessage(), e);
        }
    }

    public static boolean updateTopic(int id, String topicName, int userId) throws SQLException {
        String query = "UPDATE topic SET topic = ? WHERE id = ? AND userid = ?";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setString(1, topicName);
                st.setInt(2, id);
                st.setInt(3, userId);
                int updatedRows = st.executeUpdate();

                if (updatedRows > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error updating topic. Cause: " + e.getMessage(), e);
        }
    }

    public static boolean deleteTopic(int id, int userId) throws SQLException {
        String query = "DELETE FROM topic WHERE id = ? AND userid = ?";

        try (Connection conn = DbConnection.getConnection()) {
            ensureTopicTableExists(conn);

            try (PreparedStatement st = conn.prepareStatement(query)) {
                st.setInt(1, id);
                st.setInt(2, userId);
                int deletedRows = st.executeUpdate();
                return deletedRows > 0;
            }
        } catch (SQLException e) {
            throw new SQLException("Error deleting topic. Cause: " + e.getMessage(), e);
        }
    }

    private static void ensureTopicTableExists(Connection conn) throws SQLException {
        try (Statement st = conn.createStatement()) {
            st.execute(CREATE_TOPIC_TABLE_SQL);
        }
    }
}
