

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Account
 */
public class Account extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		boolean myBooleanValue = true;
		try {

			String email=request.getParameter("email");
			String pass=request.getParameter("pass");
			int id = 0;
			Connection con;
			Statement stmt;

            Class.forName("com.mysql.cj.jdbc.Driver");

            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa","root","");
            
            Statement stmt3=con.createStatement();
            
            ResultSet rs1=stmt3.executeQuery("select email from user where email='"+email+"'");
            if(rs1.next())
            {
            	response.sendRedirect("login.html?error=true");
            }


            Statement stmt1=con.createStatement();

            int j=stmt1.executeUpdate("INSERT INTO `user`(`email`, `password`) VALUES ('"+email+"','"+pass+"')");

            Statement stmt2=con.createStatement();

            ResultSet rs=stmt2.executeQuery("select user_id from user where email='"+email+"'and password='"+pass+"'");
            while(rs.next())
            {
            	id=rs.getInt(1);
            }

            
            HttpSession session = request.getSession();
            session.setAttribute("id", id);
            RequestDispatcher rd=request.getRequestDispatcher("register.jsp");
            rd.include(request, response);
		}catch (Exception e) {
							out.println("<b>"+e+"</b>");
		}
	}

}
