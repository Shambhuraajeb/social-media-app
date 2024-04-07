
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AccessDB
 */
@SuppressWarnings("unused")
public class AccessDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AccessDB() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		int myid=0;

		response.setContentType("text/html;charset=UTF-8");

		int id1 = (int) request.getAttribute("id");
		String idParameter = request.getParameter("id");

		try {

			if (idParameter != null) {
				try {

					int id = Integer.parseInt(idParameter);
					myid = id;
				} catch (NumberFormatException e) {
					out.println("<p>Invalid ID format. Please provide a valid integer.</p>");
				}
			} else {

				myid = id1;
			}
		} catch (Exception e) {
		}

		try {

			Connection con;
			Statement stmt, stmt1;

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa?maxAllowedPacket=67108864", "root", "");

			stmt = con.createStatement();
			stmt1 = con.createStatement();
			int i = 1;
			String relPath, relPath1;

			int post_id;
			List<ArrayList<Object>> post = new ArrayList<>();
			// ResultSet rs=stmt.executeQuery("SELECT * FROM profile inner join user on
			// profile.user_id=user.user_id WHERE user.user_id="+myid);

			ResultSet rs1 = stmt1.executeQuery(
					"SELECT post.post_id, photopost.imageurl, photopost.caption, user_profile.name, user_profile.surname, user_profile.profile_pic, user.user_id FROM photopost JOIN post ON photopost.post_id = post.post_id JOIN user ON post.user_id = user.user_id JOIN user_profile ON user.user_id = user_profile.user_id JOIN friend ON user.user_id = friend.user_id OR user.user_id = friend.another_user_id WHERE ( (friend.user_id = "+myid+" AND friend.another_user_id = post.user_id) OR (friend.user_id = post.user_id AND friend.another_user_id = "+myid+") ) AND friend.status = 'accepted' LIMIT 100 OFFSET 0");
			ArrayList<Object> img = new ArrayList<>();
			ArrayList<Object> profile = new ArrayList<>();
			ArrayList<Object> names = new ArrayList<>();
			ArrayList<Object> caps = new ArrayList<>();
			ArrayList<Object> postid = new ArrayList<>();
			ArrayList<Object> userid = new ArrayList<>();
			while (rs1.next()) {

				postid.add(rs1.getInt("post_id"));
				userid.add(rs1.getInt("user_id"));
				Blob blob = rs1.getBlob(6);

				if (blob != null) {
					byte[] imageData = blob.getBytes(1, (int) blob.length());
					String base64Image = Base64.getEncoder().encodeToString(imageData);
					profile.add(base64Image);

				}

				String nm = rs1.getString(4);
				String sname = rs1.getString(5);
				String name = nm + " " + sname;
				names.add(name);

				Blob blob1 = rs1.getBlob(2);

				if (blob != null) {
					byte[] imageData = blob1.getBytes(1, (int) blob1.length());
					String base64Image = Base64.getEncoder().encodeToString(imageData);
					img.add(base64Image);

				}

				String cap = rs1.getString(3);
				caps.add(cap);

				i++;

			}

			post.add(profile);
			post.add(names);
			post.add(img);
			post.add(caps);
			post.add(postid);
			post.add(userid);

			request.setAttribute("post", post);
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}
