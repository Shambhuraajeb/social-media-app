import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Likes")
public class Likes extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession ses = request.getSession(false);
            int userId = (ses != null) ? (Integer) ses.getAttribute("id") : -1;
            int postId = Integer.parseInt(request.getParameter("postId"));

            Connection con;
            PreparedStatement pstmt;

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa", "root", "");

            // Assuming you have a 'likes' table with columns 'user_id', 'post_id', and 'datetime'
            pstmt = con.prepareStatement(
                    "INSERT INTO `likes`(`user_id`, `post_id`, `datetime`) VALUES (?, ?, NOW())");

            pstmt.setInt(1, userId);
            pstmt.setInt(2, postId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Successfully inserted the like
                String imageUrl = "logo/red-heart-icon-fill.svg"; // Replace with the actual image URL
                response.getWriter().write(imageUrl);
            } else {
                // Failed to insert the like
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to insert like");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Exception occurred: " + e.getMessage());
        }
    }
}
