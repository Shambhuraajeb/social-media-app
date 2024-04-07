import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Replace these with actual user and friend IDs
        String userId = request.getParameter("userId");
        String friendId = request.getParameter("friendId");

        // JDBC URL, username, and password of MySQL server
        String jdbcUrl = "jdbc:mysql://localhost:3306/vibenexa";
        String dbUser = "root";
        String dbPassword = "";

        // JDBC variables for opening, closing, and managing connection
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to update status to "accepted"
            String updateQuery = "UPDATE friend\r\n"
                    + "SET status = 'accepted'\r\n"
                    + "WHERE\r\n"
                    + "  (user_id = ? AND another_user_id = ?)\r\n"
                    + "  OR\r\n"
                    + "  (user_id = ? AND another_user_id = ?);\r\n"
                    + "";

            // Create a PreparedStatement object to execute the query
            preparedStatement = connection.prepareStatement(updateQuery);
            preparedStatement.setString(1, userId);
            preparedStatement.setString(2, friendId);
            preparedStatement.setString(3, friendId);
            preparedStatement.setString(4, userId);

            // Execute the update query
            int rowsAffected = preparedStatement.executeUpdate();

            // Send a response back to the client
            PrintWriter out = response.getWriter();
            if (rowsAffected > 0) {
                out.println("success");
            } else {
                out.println("failure");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
            response.getWriter().println("error");
        } finally {
            // Close resources in a finally block to ensure they're closed even if an exception occurs
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
