<%@ page import="java.sql.*, java.io.PrintWriter, java.util.HashMap, java.util.Map" %>

<%
int postId = Integer.parseInt(request.getParameter("postId"));
int userId = Integer.parseInt(request.getParameter("userId"));
String imageUrl = "logo/suit-heart.svg";

String jdbcUrl = "jdbc:mysql://localhost:3306/vibenexa";
String dbUser = "root";
String dbPassword = "";

try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
    // Check if the user has already liked the post
    String checkQuery = "SELECT COUNT(*) FROM likes WHERE user_id = ? AND post_id = ?";
    
    try (PreparedStatement checkStatement = connection.prepareStatement(checkQuery)) {
        checkStatement.setInt(1, userId);
        checkStatement.setInt(2, postId);

        ResultSet resultSet = checkStatement.executeQuery();

        if (resultSet.next() && resultSet.getInt(1) > 0) {
            // User has already liked the post, update like status
            String updateQuery = "UPDATE likes SET datetime = NOW() WHERE user_id = ? AND post_id = ?";
            
            try (PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) {
                updateStatement.setInt(1, userId);
                updateStatement.setInt(2, postId);

                int rowsAffected = updateStatement.executeUpdate();

                if (rowsAffected > 0) {
                    imageUrl = "logo/suit-heart.svg";
                } else {
                    imageUrl = "update failed";
                }
            }
        } else {
            // User has not liked the post, proceed with insertion
            String insertQuery = "INSERT INTO likes(user_id, post_id, datetime) VALUES (?, ?, NOW())";

            try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                insertStatement.setInt(1, userId);
                insertStatement.setInt(2, postId);

                int rowsAffected = insertStatement.executeUpdate();

                if (rowsAffected > 0) {
                    imageUrl = "logo/red-heart-icon.svg";
                } else {
                    imageUrl = "logo/red-heart-icon.svg";
                }
            }
        }
    }

} catch (SQLException e) {
    out.println(e);
    e.printStackTrace(); // Handle the exception appropriately
} finally {
    // Close resources in the reverse order of their creation (if needed)
}

response.setContentType("text/plain");
try (PrintWriter out1 = response.getWriter()) {
    out1.print(imageUrl);
    out1.flush();
}
%>
