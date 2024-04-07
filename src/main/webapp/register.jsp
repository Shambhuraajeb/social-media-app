<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="jakarta.servlet.*" %>
	
<%!int id; %>
<% 
HttpSession ses = request.getSession(false);
id = (ses != null) ? (Integer) ses.getAttribute("id") : null;
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account with VibeNexa</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background: linear-gradient(135deg, #3498db, #9b59b6);
            overflow: hidden;
        }

        .container {
            perspective: 1000px;
        }

        .card {
            width: 400px;
            height: 400px;
            transform-style: preserve-3d;
            transition: transform 0.5s;
        }

        .card.flipped {
            transform: rotateY(180deg);
        }

        .card .side {
            position: absolute;
            width: 90%;
            height: 100%;
            backface-visibility: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            background: linear-gradient(135deg, #3498db, #9b59b6);
        }

        .card .side.back {
            transform: rotateY(180deg);
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #fff;
            color: #3e1f6f;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #f48197;
            color: #fff;
        }

        input, select, textarea {
            margin-bottom: 15px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Only one form tag wrapping the entire content -->
    <form id="registrationForm" method="post" action="http://localhost:8082/Vibe/Register?id=<%=id %>">
        <div class="container">
            <div class="card" id="card">
                <div class="side">
                    <h2>Personal Information</h2>
                    <input type="hidden" name="id" value="<%=id %>">
                    <!-- Form 1 -->
                    <label for="fname">First Name:</label>
                    <input type="text" id="fname" name="name" required>

                    <label for="mname">Middle Name:</label>
                    <input type="text" id="mname" name="m_name" required>

                    <label for="lname">Last Name:</label>
                    <input type="text" id="lname" name="surname" required>

                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" required>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                    <div class="btn-container">
                        <!-- Added submit button for Form 1 -->
                        <button type="button" class="btn" onclick="flipCard()">Next</button>
                    </div>
                </div>

                <div class="side back">
                    <h2>About You</h2>
                    <!-- Form 2 -->
                    <label for="about">Tell us about yourself:</label>
                    <textarea id="about" name="about" rows="4" required></textarea>
                    <div class="btn-container">
                        <!-- Added submit button for Form 2 -->
                        <button type="button" class="btn" onclick="flipCard()">Back</button>
                        <button type="submit" class="btn" onclick="submitForm()" style="margin-left: 10px">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function flipCard() {
            const card = document.getElementById('card');
            card.classList.toggle('flipped');
        }

        function submitForm() {
            // Handle form submission here
            // You can use JavaScript to gather form data and send it to the server
            
            alert('Form submitted!');
        }
    </script>
</body>
</html>
