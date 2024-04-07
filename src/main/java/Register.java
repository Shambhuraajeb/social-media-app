
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Register
 */
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();

		int id=Integer.parseInt(request.getParameter("id"));

		String name=request.getParameter("name");
		String m_name=request.getParameter("m_name");
		String surname=request.getParameter("surname");
		
		String dob=request.getParameter("dob");
		
		String gender=request.getParameter("gender");
		String about=request.getParameter("about");

		try {

			Connection con;
			Statement stmt;

            Class.forName("com.mysql.cj.jdbc.Driver");

            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa","root","");


            stmt=con.createStatement();

            int i=stmt.executeUpdate("INSERT INTO `user_profile`(`user_id`, `name`, `m_name`, `surname`, `dob`, `gender`, `about`, `profile_pic`) "
            		+ "VALUES ("+id+",'"+name+"','"+m_name+"','"+surname+"',"+dob+",'"+gender+"','"+about+"',null)");
            
            
           
            response.sendRedirect("login.html");

		} catch (Exception e) {out.println("<b>"+e+"</b>");}
	}

}
