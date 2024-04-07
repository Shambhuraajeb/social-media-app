<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String userId = request.getParameter("userId");
    String friendId = request.getParameter("friendId");
    String action = request.getParameter("action");

    // Database connection
    Connection con = null;
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");

        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa","root","");

        if ("add".equals(action)) {
            // Check if the users are not already friends
            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM friend WHERE (user_id = ? AND another_user_id = ?) OR (user_id = ? AND another_user_id = ?)");
            checkStmt.setString(1, userId);
			checkStmt.setString(2, friendId);
			checkStmt.setString(3, userId);
			checkStmt.setString(4, friendId);
            ResultSet resultSet = checkStmt.executeQuery();

            if (!resultSet.next()) {
                // Add the friendship to the database
                PreparedStatement addStmt = con.prepareStatement("INSERT INTO friend (user_id, another_user_id, status) VALUES (?, ?, ?)");
                addStmt.setString(1, userId);
                addStmt.setString(2, friendId);
                addStmt.setString(3, "requested");
                addStmt.executeUpdate();
                out.println("Friend added successfully.");
            } else{
                out.println("Users are already friends.");
            }
        } else {
            out.println("Invalid action.");
        }
    } catch (Exception e) {
    	out.println(e);
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
