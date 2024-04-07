

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
 * Servlet implementation class Login
 */

public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		response.setContentType("text/html");
		PrintWriter out=response.getWriter();

		String email=request.getParameter("email");
		String pass=request.getParameter("pw");

		//out.println("<html>"+email+" "+pass+"<br>");

		try {
			Connection con;
			Statement stmt,stmt1;

            Class.forName("com.mysql.cj.jdbc.Driver");

            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa","root","");
            
            stmt1=con.createStatement();
            
            ResultSet rs1=stmt1.executeQuery("SELECT u.user_id FROM user u LEFT JOIN user_profile up ON u.user_id = up.user_id WHERE up.user_id IS NULL and u.email='"+email+"' and password='"+pass+"'");

            if(rs1.next())
            {
            	int id=rs1.getInt("user_id");
            	HttpSession session = request.getSession();
                session.setAttribute("id", id);
            	response.sendRedirect("register.jsp");
            }
            else
            {
            	out.println("");
            }
            

            stmt=con.createStatement();

            ResultSet rs=stmt.executeQuery("select * from user where email='" + email + "' and password='" + pass + "'");
            String str="NO";
            int id=0;
            if(rs.next())
            {
            	id=rs.getInt(1);
            	str="loginSuccessful";
            }
            else
            {
            	response.sendRedirect("login.html?error=true");
            }
            if (str=="loginSuccessful") {


            	request.setAttribute("id", id);
                HttpSession session = request.getSession();
                session.setAttribute("id", id);
                RequestDispatcher rd=request.getRequestDispatcher("AccessDB");
                rd.include(request, response);



            } else {
                // Redirect back to the login page with an error message
                response.sendRedirect("login.html?error=true");
            }

		}catch(Exception e) { out.println("<p>"+e+"<p></html>");}

	}

}
