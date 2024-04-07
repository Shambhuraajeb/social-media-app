<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%!Connection con;%>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa", "root", "");
%>

<%!int id;%>
<%
HttpSession ses = request.getSession(false);
id = (ses != null) ? (Integer) ses.getAttribute("id") : null;

if (id != 0) {
	session.setAttribute("id", id);
%>
<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="post.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>


<script src="script.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>
<style>
.like-button {
	background-color: transparent;
	border: none;
	cursor: pointer;
	outline: none;
}

.image-button {
	width: 30px;
	height: 29px;
	background: transparent;
	background-image: url("logo/suit-heart.svg");
	/* Initial background image */
	background-size: cover; /* Adjust as needed */
	color: #fff;
	border: none;
	cursor: pointer;
}
</style>



<title>VibeNexa -Social Media</title>
</head>

<body>
	<!-- Login session check -->





	<div>
		<div class="home-container">
			<div class="home-container1">
				<div class="home-container2" id="anotherDiv">
					<div class="container-fluid">
						<a class="navbar-brand" href="#"><img id="mylogo"
							src="logo/logo.png" alt="RajeStyle"></a><strong>VibeNexa</strong>
					</div>
					<div class="container" id="nav">
						<ul>
							<li><a class="nav-item" href="home.html"><img
									class="logo" src="logo/house-heart-fill.svg" alt="Home"><b>Home</b></a>
							</li>
							<li><a class="nav-item" data-bs-toggle="modal"
								data-bs-target="#search"><img class="logo"
									src="logo/search-heart-fill.svg" alt="Search"><b>Search</b></a>
							</li>


							<li><a class="nav-item" data-bs-toggle="modal"
								data-bs-target="#friendlist"><img class="logo"
									src="logo/friend.png" alt="Friends"><b>Friends</b></a></li>


							<li><a class="nav-item" data-bs-toggle="modal"
								data-bs-target="#request"><img class="logo"
									src="logo/chat-heart-fill.svg" alt="Chat"><b>Requests</b></a></li>


							<li><a class="nav-item" data-bs-toggle="modal"
								data-bs-target="#exampleModal"><img class="logo"
									src="logo/plus-circle-fill.svg" alt="Create"><b>Create</b></a>
							</li>
							<li><a class="nav-item" data-bs-toggle="offcanvas"
								href="#offcanvasExample" role="button"
								aria-controls="offcanvasExample"><img class="logo"
									src="logo/gear-fill.svg" alt="Settings"><b>Settings</b></a></li>
							<li><a class="nav-item" href="Profile?id=<%=id%>"><img
									class="logo" src="logo/person-circle.svg" alt="Profile"><b>Profile</b></a>
							</li>
						</ul>
					</div>
				</div>

				<%
				//Statement stmt=con.createStatement();
				//ResultSet rs2=stmt.executeQuery("");
				%>
				<div class="home-container3" id="specificDiv">







					<%@ page import="java.util.*"%>
					<%
					List<ArrayList<Object>> post = (List<ArrayList<Object>>) request.getAttribute("post");

					ArrayList<Object> profile = new ArrayList<>();
					ArrayList<Object> names = new ArrayList<>();
					ArrayList<Object> img = new ArrayList<>();
					ArrayList<Object> caps = new ArrayList<>();
					ArrayList<Object> postid = new ArrayList<>();
					ArrayList<Object> userid = new ArrayList<>();

					for (int i = 0; i < post.size(); i++) {
						if (i == 0) {
							profile = post.get(i);
						}
						if (i == 1) {
							names = post.get(i);
						}
						if (i == 2) {
							img = post.get(i);
						}
						if (i == 3) {
							caps = post.get(i);
						}
						if (i == 4) {
							postid = post.get(i);
						}
						if (i == 5) {
							userid = post.get(i);
						}
					}

					for (int i = 0; i < profile.size(); i++) {

						if (profile.isEmpty() || names.isEmpty() || img.isEmpty() || caps.isEmpty() || postid.isEmpty()
						|| userid.isEmpty()) {
							out.println("<b>Add friend to configure posts</b>");
						} else {
							String buttonId = "myButton" + i;
							Object p = postid.get(i);
							Object u = postid.get(i);
							int post_id = 0;
							int user_id = 0;

							if (p instanceof Integer) {
						post_id = (Integer) p;
							}

							if (u instanceof Integer) {
						user_id = (Integer) u;
							}
					%>



					<div class="post">
						<div class="card" style="width: 27rem; margin-top: 10px;">
							<div class="card-header">
								<img src="data:image/jpeg;base64,<%=profile.get(i)%>" alt=""
									style="width: 50px; height: 50px; border-radius: 50%;"><b><%=names.get(i)%></b>
							</div>
							<img src="data:image/jpeg;base64,<%=img.get(i)%>"
								class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title">
									<span style="display: flex;">
										<button type="button" id="<%=buttonId%>" class="image-button"
											data-post-id="<%=post_id%>" data-user-id="<%=id%>">
										</button>
										<button
											style="margin-left: 15px; background-color: none; background-image: url('logo/chat-heart-fill.svg');"
											type="button" class="image-button" data-toggle="modal"
											data-target="#commentModal" data-post-id="<%=post_id%>"></button> 

									</span>
								</h5>
								<p class="card-text"><%=caps.get(i)%></p>
							</div>
						</div>
					</div>
					<script>
$(document).ready(function () {
    $(".image-button").click(function () {
        var button = $(this);
        var postId = button.data("post-id");
        var userId = button.data("user-id");

        // Perform an AJAX request to update the like status
        $.ajax({
            type: "POST",
            url: "Likes.jsp",
            data: {
                postId: postId,
                userId: userId
            },
            dataType: "text",
            success: function (response) {
                console.log('AJAX Success:', response);

                // Trim any leading/trailing whitespaces
                var imageUrl = response.trim();
                console.log('New Image URL:', imageUrl);

                // Update the background image of the button
                button.css('background-image', 'url(' + imageUrl + ')');

                console.log("Background image toggled successfully");
            },
            error: function (xhr, status, error) {
                console.error("Failed to toggle background image");
                console.error("Status:", status);
                console.error("Error:", error);
            }
        });
    });
});
</script>






					<%
					}
					}
					%>


				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div class="modal fade" id="commentModal" tabindex="-1" role="dialog"
		aria-labelledby="commentModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="commentModalLabel">Comment Section</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Comments will be displayed here -->
					<ul id="commentList" class="list-group">
						<!-- Comments dynamically loaded using JavaScript -->
					</ul>
				</div>
				<div class="modal-footer">
					<!-- Form to submit new comment -->
					<form id="commentForm">
						<div class="form-group">
							<textarea class="form-control" id="commentText"
								placeholder="Write your comment"></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Post
							Comment</button>
					</form>
				</div>
			</div>
		</div>
	</div>
<script>
$(document).ready(function () {
    // Event handler for the comment button click
    $('.comment-button').on('click', function () {
        // Get the post ID from the data attribute
        var postId = $(this).data('post-id');

        // Set the post ID in a variable accessible to other functions
        window.currentPostId = postId;

        // Load comments for the selected post
        loadComments();
        
        // Show the comment modal
        $('#commentModal').modal('show');
    });

    // Submit new comment
    $('#commentForm').submit(function (event) {
        event.preventDefault();
        var commentText = $('#commentText').val();
        postComment(commentText);
    });
});

function loadComments() {
    // Make an AJAX request to retrieve comments for the current post
    $.ajax({
        type: 'GET',
        url: 'CommentServlet', // Replace with your actual servlet URL
        data: { postId: window.currentPostId }, // Send the current post ID to the server
        dataType: 'json',
        success: function (comments) {
            displayComments(comments);
        },
        error: function (error) {
            console.error('Error fetching comments:', error.responseText);
        }
    });
}

function postComment(commentText) {
    // Make an AJAX request to post a new comment for the current post
    $.ajax({
        type: 'POST',
        url: 'CommentServlet', // Replace with your actual servlet URL
        data: { action: 'add', postId: window.currentPostId, commentText: commentText },
        success: function () {
            // Reload comments after posting a new comment
            loadComments();
            // Clear the comment input field
            $('#commentText').val('');
        },
        error: function (error) {
            console.error('Error posting comment:', error.responseText);
        }
    });
}

function displayComments(comments) {
    var commentList = $('#commentList');
    commentList.empty();

    // Append each comment to the list
    comments.forEach(function (comment) {
        commentList.append('<li class="list-group-item">' + comment.text + ' by ' + comment.userName + '</li>');
    });
}

</script>
























	<!-- Modal for accept request -->
	<div class="modal fade" id="request" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Friend Request</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<%
					try {
						Statement stmt2;

						stmt2 = con.createStatement();
						ResultSet rs2 = stmt2.executeQuery(
						"select * FROM friend JOIN user_profile up ON friend.user_id=up.user_id WHERE another_user_id=" + id
								+ " and status='requested'");

						int i = 1;
						int fri_id = 0;
						while (rs2.next()) {
							fri_id = rs2.getInt(2);

							if (fri_id == id) {
						continue;
							}
							Blob blob = rs2.getBlob(13);

							if (blob != null) {
						byte[] imageData = blob.getBytes(1, (int) blob.length());
						image = Base64.getEncoder().encodeToString(imageData);

							} else {
						image = "logo/person-circle.svg";
							}
					%>
					<div class="row">
						<div class="col1">
							<%
							if (image == "logo/person-circle.svg") {
							%>
							<img src="logo/person-circle.svg" alt=""
								style="border-radius: 50%">
							<%
							} else {
							%>
							<img src="data:image/jpeg;base64,<%=image%>" alt=""
								style="border-radius: 50%">
							<%
							}
							%>

						</div>
						<div class="col">
							<b><a href="Profile?id=<%=fri_id%>"
								style="text-decoration: none;"><%=rs2.getString(7) + " " + rs2.getString(9)%></a></b>
							<button class="btn btn-primary"
								onclick="updateStatus('<%=id%>', '<%=fri_id%>')"
								style="position: relative; margin-right: 10px; padding: 5px; float: right">Accept</button>

						</div>
					</div>
					<%
					}
					} catch (Exception e) {
					}
					%>

				</div>
			</div>
		</div>
	</div>
	<script>
	function updateStatus(myid, friid) {
	    var userId = myid;
	    var friendId = friid;

	    // Log that the AJAX request is being sent
	    console.log("AJAX Request Sent");

	    // Make an AJAX request to update the status
	    $.ajax({
	        type: "POST",
	        url: "UpdateStatus",
	        data: {
	            action: "accept",
	            userId: userId,
	            friendId: friendId
	        },
	        success: function(response) {
	            // Handle the response from the server
	            console.log("Response:", response);

	            // Check if the response is "success" before reloading the page
	            if (response.trim() === "success") {
	                console.log("Reloading the page...");
	                // Display an alert message
	                alert("Request accepted!");
	                // Reload the page
	                location.reload();
	            } else {
	                console.log("Status is not 'success'.");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX Error:", status, error);
	        }
	    });
	}

</script>














	<!--Settings offcanvas-->
	<div class="offcanvas offcanvas-start" tabindex="-1"
		id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasExampleLabel">Settings</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="container">
			<ul>
				<li><a class="nav-item" id="colorToggle">Theme</a></li>
				<li><a class="nav-item" href="#">Another action</a></li>
				<li><a class="nav-item" href="#"><i style="color: red">Logout</i></a></li>
			</ul>
		</div>
	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function () {
        const body = document.body;
        const colorToggle = document.getElementById('colorToggle');
        const specificDiv = document.getElementById('specificDiv');
        const anotherDiv = document.getElementById('anotherDiv');
        const modals = document.querySelectorAll('.modal');
        const nav = document.getElementById('nav');

        // Load theme preference from localStorage
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            body.classList.add(savedTheme);
        }

        // Apply theme based on the saved preference
        applyTheme();

        colorToggle.addEventListener('click', function () {
            // Toggle the dark-theme class on the body
            body.classList.toggle('dark-theme');

            // Save the theme preference to localStorage
            const currentTheme = body.classList.contains('dark-theme') ? 'dark-theme' : '';
            localStorage.setItem('theme', currentTheme);

            // Apply the theme
            applyTheme();
        });

        function applyTheme() {
            // Set the background color and text color of specificDiv and anotherDiv
            specificDiv.style.backgroundColor = body.classList.contains('dark-theme') ? 'lightgray' : 'transparent';
            specificDiv.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';

            anotherDiv.style.backgroundColor = body.classList.contains('dark-theme') ? 'gray' : '#FAF9DE';
            anotherDiv.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';
            
            var nav = document.getElementById('nav');
            nav.style.backgroundColor = body.classList.contains('dark-theme') ? 'gray' : '#FAF9DE';
            nav.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';

            
            modals.forEach(modal => {
                modal.style.backgroundColor = body.classList.contains('dark-theme') ? 'transparent' : 'transparent';
                modal.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';
            });
        }
    });
</script>















	<!--Modal for new post-->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Create new Post</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form method="post" action="http://localhost:8082/Vibe/Post"
					enctype="multipart/form-data">
					<div class="modal-body">
						<input type="file" name="image" id="inputimage" accept="image/*"
							onchange="displayImage()" /> <img id="image"
							alt="Selected Image"
							style="display: none; width: 25rem; height: 25rem;" /><br>
						<br>
						<textarea rows="4" cols="40" name="caps" id="description"
							placeholder="How do you feel today?"></textarea>
						<input type="text" name="location" id="textinput"
							placeholder="Where are you?"> <input type="hidden"
							id="hiddenDate" name="date" /> <input type="hidden" name="id"
							value="<%=id%>">

						<script>
						function displayImage() {
							const input = document.getElementById('inputimage');
							const image = document.getElementById('image');
							const file = input.files[0];

							if (file) {
								const reader = new FileReader();

								reader.onload = function(e) {
									image.src = e.target.result;
									image.style.display = 'block';
								};

								reader.readAsDataURL(file);
							} else {
								image.src = '';
								image.style.display = 'none';
							}
						}

							
							function setCurrentDate() {
								var hiddenDateInput = document
										.getElementById('hiddenDate');
								var currentDate = new Date().toISOString()
										.split('T')[0];
								hiddenDateInput.value = currentDate;
							}
							window.onload = setCurrentDate;
						</script>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Post</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript"></script>

















	<!--Modal for friends list-->
	<div class="modal fade" id="friendlist" tabindex="-1"
		aria-labelledby="friendlistLabel" aria-hidden="true">

		<%!int count;%>
		<%!Statement stmt;%>
		<%
		stmt = con.createStatement();
		String str = "SELECT friend.*, COUNT(user.user_id) AS user_count FROM friend INNER JOIN user ON friend.user_id =user.user_id INNER JOIN user AS another_user ON friend.another_user_id = another_user.user_id WHERE (user.user_id = "
				+ id + " OR another_user.user_id = " + id + ") AND friend.status='accepted'";

		ResultSet rs = stmt.executeQuery(str);
		while (rs.next()) {
			count = rs.getInt("user_count");
		}
		%>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="friendlistLabel">
						Friends (<%=count%>)
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>


				<div class="modal-body">
					<%!String image;%>
					<%
					try {
						Statement stmt1;

						stmt1 = con.createStatement();
						ResultSet rs1 = stmt1.executeQuery(
						"SELECT DISTINCT up.user_id, up.name, up.surname, up.profile_pic FROM friend f JOIN user u ON (f.another_user_id = u.user_id OR f.user_id = u.user_id) JOIN user_profile up ON u.user_id = up.user_id WHERE (f.user_id = "
								+ id + " OR f.another_user_id = " + id + ") AND f.status = 'accepted'");

						int i = 1;
						int fri_id = 0;
						while (rs1.next()) {
							fri_id = rs1.getInt(1);

							if (fri_id == id) {
						continue;
							}
							Blob blob = rs1.getBlob(4);

							if (blob != null) {
						byte[] imageData = blob.getBytes(1, (int) blob.length());
						image = Base64.getEncoder().encodeToString(imageData);

							} else {
						image = "logo/person-circle.svg";
							}
					%>
					<div class="row">
						<div class="col1">
							<%
							if (image == "logo/person-circle.svg") {
							%>
							<img src="logo/person-circle.svg" alt=""
								style="border-radius: 50%">
							<%
							} else {
							%>
							<img src="data:image/jpeg;base64,<%=image%>" alt=""
								style="border-radius: 50%">
							<%
							}
							%>

						</div>
						<div class="col">
							<b><a href="Profile?id=<%=fri_id%>"><%=rs1.getString(2) + " " + rs1.getString(3)%></a></b>

						</div>
					</div>
					<%
					}
					} catch (Exception e) {
					}
					%>

				</div>


			</div>
		</div>
	</div>








	<!-- javascript code from here-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script>
		
		function toggleBackgroundImage(buttonId, postId, userId) {
	        var button = document.getElementById(buttonId);
	        var post = document.getElementById(postId);
	        var user = document.getElementById(userId);
	        
	        window.location.href = '<%=request.getRequestURI()%>?post='+ encodeURIComponent(post) + '&user='+ encodeURIComponent(user);

			var currentImage = button.style.backgroundImage;

			if (currentImage.includes('logo/suit-heart.svg')) {
				button.style.backgroundImage = 'url("logo/red-heart-icon.svg")';

				// Perform an AJAX request to the server
				var xhr = new XMLHttpRequest();
				var post_id = document.getElementById(postId);
				var user_id = document.getElementById(userId);

				xhr.open("POST", "Likes.jsp", true);
				xhr.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");

				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						// Handle the response from the server if needed
						console.log(xhr.responseText);
					}
				};

				xhr.send("post=" + encodeURIComponent(post_id) + "&user="
						+ encodeURIComponent(user_id));
			} else {
				button.style.backgroundImage = 'url("logo/suit-heart.svg")';
			}
		}
	</script>



















	<!--Modal for search-->
	<div class="modal fade" id="search" tabindex="-1"
		aria-labelledby="friendlistLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="friendlistLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>


				<div class="modal-body">
					<%!String img1;%>
					<%!int user_id;%>
					<%!int friend_id;%>

					<%
					try {
						Statement stmt1;

						stmt1 = con.createStatement();
						ResultSet rs1 = stmt1.executeQuery(
						"SELECT DISTINCT up.user_id, up.name, up.surname, up.profile_pic FROM user_profile AS up LEFT JOIN friend AS f ON (up.user_id = f.user_id OR up.user_id = f.another_user_id) AND (f.user_id = "
								+ id + " OR f.another_user_id = " + id
								+ ") WHERE (f.user_id IS NULL AND f.another_user_id IS NULL) OR f.status = 'requested' AND up.user_id != "
								+ id + ";");

						int i = 1;
						int fri_id = 0;
						while (rs1.next()) {

							fri_id = rs1.getInt(1);

							if (fri_id == id) {
						continue;
							}
							Blob blob = rs1.getBlob(4);

							if (blob != null) {
						byte[] imageData = blob.getBytes(1, (int) blob.length());
						img1 = Base64.getEncoder().encodeToString(imageData);

							} else {
						img1 = "logo/person-circle.svg";
							}
					%>
					<div class="row">
						<div class="col1">
							<%
							if (img1 == "logo/person-circle.svg") {
							%>
							<img src="logo/person-circle.svg" alt=""
								style="border-radius: 50%">
							<%
							} else {
							%>
							<img src="data:image/jpeg;base64,<%=img1%>" alt=""
								style="border-radius: 50%">
							<%
							}
							%>

						</div>
						<div class="col">
							<%
							user_id = id;
							friend_id = fri_id;
							%>

							<%
							// Database connection
							Connection con = null;
							try {
								Class.forName("com.mysql.cj.jdbc.Driver");

								con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa", "root", "");

								// Check if the users are already friends
								PreparedStatement checkStmt = con.prepareStatement(
								"SELECT * FROM friend WHERE (user_id = ? AND another_user_id = ?) OR (user_id = ? AND another_user_id = ?) AND status=?");
								checkStmt.setInt(1, user_id);
								checkStmt.setInt(2, friend_id);
								checkStmt.setInt(3, user_id);
								checkStmt.setInt(4, friend_id);
								checkStmt.setString(5, "accepted");
								ResultSet resultSet = checkStmt.executeQuery();

								boolean areFriends = resultSet.next();
							%>
							<b><a href="Profile?id=<%=fri_id%>"
								style="text-decoration: none;"><%=rs1.getString(2) + " " + rs1.getString(3)%></a></b>
							<%
							if (!areFriends) {
							%>
							<button onclick="addFriend(<%=user_id%>,<%=friend_id%>)"
								class="btn btn-primary" id="acceptButton"
								style="position: relative; margin-right: 10px; padding: 5px; float: right;">Add
								Friend</button>

							<%
							} else if (areFriends) {
							%><button style="background-color: transparent; border: none;">Request
								Sent</button>
							<%
							}
							} catch (Exception e) {
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


						</div>
					</div>
					<%
					}
					} catch (Exception e) {
					}
					%>

				</div>


			</div>
		</div>
	</div>
	<script>
	function addFriend(userId, friendId) {
	    // Perform an AJAX request to update friend status in the database
	    $.ajax({
	        type: "POST",
	        url: "Friend.jsp",
	        data: {
	            userId: userId,
	            friendId: friendId,
	            action: "add"
	        },
	        success: function(response) {
	            // Handle the response from the server if needed
	            alert(response);

	            // Update UI or provide feedback to the user
	            alert(response);

	            // Reload the page
	            location.reload();
	        },
	        error: function(xhr, status, error) {
	            alert("Error: " + error);

	            // Handle errors or provide feedback to the user
	            alert("Error adding friend. Please try again.");
	        }
	    });
	}

    </script>




















	<!-- Comment Section -->

	<!-- Comment Modal -->




























</body>

</html>
<%
} else {
// Redirect to the login page if not logged in
response.sendRedirect("login.html");
}
con.close();
%>
