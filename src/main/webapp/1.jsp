<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send and Receive Data in JSP</title>
</head>
<body>

    <% 
        // Check if the form has been submitted
        if (request.getMethod().equalsIgnoreCase("post")) {
            // Retrieve data from the form
            String dataReceived = request.getParameter("myInput");
    %>

    <h2>Data Received:</h2>
    <p><%= dataReceived %></p>

    <%
        } else {
            // Display the form
    %>
    
    <form action="" method="post">
        <label for="myInput">Enter Data:</label>
        <input type="text" id="myInput" name="myInput">
        <button type="submit">Submit</button>
    </form>

    <%
        }
    %>

</body>
</html>
