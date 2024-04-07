

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/vibenexa";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get user_id and post_id from the session or wherever they're available
        int userId = getUserIDFromSession(request);
        int postId = getPostIDFromSession(request);

        List<Comment> comments = fetchCommentsFromDatabase(userId, postId);
        writeResponse(response, comments);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = getUserIDFromSession(request);
        int postId = getPostIDFromSession(request);
        String commentText = request.getParameter("commentText");
        addCommentToDatabase(userId, postId, commentText);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private List<Comment> fetchCommentsFromDatabase(int userId, int postId) {
        List<Comment> comments = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT c.text, u.user_name, c.created_at FROM comments c " +
                             "JOIN user u ON c.user_id = u.user_id " +
                             "WHERE c.user_id = ? AND c.post_id = ? ORDER BY c.created_at DESC")) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, postId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    String text = resultSet.getString("text");
                    String userName = resultSet.getString("user_name");
                    Timestamp createdAt = resultSet.getTimestamp("created_at");
                    Comment comment = new Comment(userName, text, createdAt);
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        }

        return comments;
    }

    private void addCommentToDatabase(int userId, int postId, String commentText) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "INSERT INTO comments (user_id, post_id, text) VALUES (?, ?, ?)")) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, postId);
            preparedStatement.setString(3, commentText);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        }
    }

    private void writeResponse(HttpServletResponse response, List<Comment> comments) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            
            
        }
    }

    private int getUserIDFromSession(HttpServletRequest request) {
        // Implement logic to retrieve user_id from the session or other sources
        // For simplicity, a placeholder value is returned here
        return 1; // Replace with your actual logic
    }

    private int getPostIDFromSession(HttpServletRequest request) {
        // Implement logic to retrieve post_id from the session or other sources
        // For simplicity, a placeholder value is returned here
        return 1; // Replace with your actual logic
    }

    private static class Comment {
        private final String userName;
        private final String text;
        private final Timestamp createdAt;

        public Comment(String userName, String text, Timestamp createdAt) {
            this.userName = userName;
            this.text = text;
            this.createdAt = createdAt;
        }
    }
}

