import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
//other imports...

@WebServlet("/ImageUploadServlet")
@MultipartConfig

public class Post extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		Part filePart = request.getPart("image");
		InputStream inputStream = filePart.getInputStream();
		int id = Integer.parseInt(request.getParameter("id"));
		String date = request.getParameter("date");
		String cap= request.getParameter("caps");
		String loc = request.getParameter("location");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa", "root", "");

			Statement stmt = conn.createStatement();
			int i = stmt.executeUpdate("INSERT INTO `post`( `user_id`, `location`, `datetime`) VALUES (" + id + ",'"
					+ loc + "','" + date + "')", Statement.RETURN_GENERATED_KEYS);

			
			
			
			if (i > 0) {
                // Retrieve the generated keys
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int generatedId = generatedKeys.getInt(1);
                        int pid=generatedId;
                        
                        PreparedStatement p=conn.prepareStatement("INSERT INTO `photopost`(`post_id`, `imageurl`, `caption`) VALUES (?, ?, ?)");
                        p.setInt(1, pid);
                        p.setBlob(2, inputStream);
                        p.setString(3, cap);
                        int j=p.executeUpdate();
                        
                        if(j>0)
                        {
                        	out.println("<html><body><script type='text/javascript'>window.alert('Image uploaded successfully')</script></body></html>");
                        	response.sendRedirect("AccessDB?id="+id);                        }
                        else {
                        	out.println("<html><body><script type='text/javascript'>window.alert('Something went wrong')</script></body></html>");
                        	response.sendRedirect("login.html?error=true");
						}
                        
                    } else {
                        throw new SQLException("Failed to retrieve the generated ID.");
                    }
                }
            } else {
                throw new SQLException("Failed to insert the record.");
            }
			
		} catch (Exception e) {
			out.println(e);
		}

	}
}
