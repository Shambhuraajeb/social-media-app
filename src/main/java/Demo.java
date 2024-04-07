import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class Demo extends HttpServlet {


    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //int imageId = Integer.parseInt(request.getParameter("id")); // Assuming you pass image ID as a parameter

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa","root","");

            // Assuming you have a table named 'images' with a BLOB column 'image_data'
            String sql = "SELECT profile_pic FROM user_profile WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, 1);


            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                // Retrieve image data from the result set
                byte[] imageData = resultSet.getBytes("image_data");

                // Set the content type based on the image format
                response.setContentType("image/jpeg"); // Adjust as per your image format

                // Get the output stream from the response
                try (OutputStream outputStream = response.getOutputStream()) {
                    // Write the image data to the output stream
                    outputStream.write(imageData);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

            // Close resources
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
