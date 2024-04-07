import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class Profile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html");
		PrintWriter out=response.getWriter();


		int myid;
		
		HttpSession ses = request.getSession(false);
		myid = (ses != null) ? (Integer) ses.getAttribute("id") : null;
		
		
    	int id =Integer.parseInt(request.getParameter("id"));
    	out.println(myid);

    	

        String url = "jdbc:mysql://localhost:3306/vibenexa";
        String user = "root";
        String password = "";

        String sql = "SELECT imageurl FROM photopost INNER JOIN post ON post.post_id=photopost.post_id INNER JOIN user ON user.user_id=post.user_id where user.user_id="+id;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
        }

        List<String> imageDataList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(url, user, password);
             Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
            	        ResultSet.CONCUR_READ_ONLY);
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Blob blob = resultSet.getBlob("imageurl");

                if (blob != null) {
                    // Convert BLOB data to byte array
                    byte[] imageData = blob.getBytes(1, (int) blob.length());

                    // Convert byte array to base64-encoded string
                    String base64Image = Base64.getEncoder().encodeToString(imageData);

                    // Add the base64-encoded image data to the list
                    imageDataList.add(base64Image);
                } else {
                    // Handle the case where the BLOB is null (no image found)
                    imageDataList.add("");
                }
            }
            if (!resultSet.first()) {
				imageDataList.add("logo/posts.png");
			}
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println(e);
        }

       
        if(myid==id)
        {
        	request.setAttribute("imageDataList", imageDataList);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
        else {
        	request.setAttribute("imageDataList", imageDataList);
            request.getRequestDispatcher("profile1.jsp").forward(request, response);
		}

        
    }
}
