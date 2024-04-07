<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%!Connection con;%>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vibenexa", "root", "");
%>
<%!Object yourAttribute;%>
<%!int id;%>
<%
id = Integer.parseInt(request.getParameter("id"));

HttpSession ses = request.getSession();
if (ses != null) {

	yourAttribute = ses.getAttribute("id");
	if (yourAttribute != null) {
		if (id == 0) {
	id = (Integer) yourAttribute;
		}
		//out.println(yourAttribute);
		//out.println(id);
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


<title>VibeNexa-Social Media</title>
</head>

<body>


	<div>
		<div class="home-container">
			<div class="home-container1">
				<div class="home-container2" id="anotherDiv">
					<div class="container-fluid">
						<a class="navbar-brand" href="#"><img id="mylogo"
							src="logo/logo.png" alt="RajeStyle"></a><strong>VibeNexa</strong>
					</div>
					<div class="container">
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

				<%!String name;%>
				<%!String fullname;%>
				<%!String about;%>
				<%!String path;%>
				<%!String base64Image;%>
				<%!int cnt;%>
				<%!int fri_cnt;%>

				<%
				int i = 1;
				Statement stmt;
				stmt = con.createStatement();

				ResultSet rs = stmt.executeQuery(
						"SELECT user_profile.name, user_profile.m_name, user_profile.surname, user_profile.about, user_profile.profile_pic, COUNT(post.post_id) AS post_count FROM user_profile INNER JOIN user ON user.user_id = user_profile.user_id LEFT JOIN post ON post.user_id = user.user_id WHERE user.user_id ="
						+ id);

				while (rs.next()) {
					name = rs.getString(1) + " " + rs.getString(3);
					fullname = rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3);
					about = rs.getString(4);
					cnt = rs.getInt("post_count");

					Blob blob = rs.getBlob("profile_pic");

					if (blob != null) {

						byte[] imageData = blob.getBytes(1, (int) blob.length());

						base64Image = Base64.getEncoder().encodeToString(imageData);

					}

				}

				Statement stmt1;
				stmt = con.createStatement();

				ResultSet rs1 = stmt.executeQuery(
						"SELECT COUNT(friend.friend_id) AS friend_count FROM user LEFT JOIN friend ON (friend.user_id = user.user_id OR friend.another_user_id = user.user_id) AND friend.status = 'accepted' WHERE user.user_id = "
						+ id);

				while (rs1.next()) {
					fri_cnt = rs1.getInt("friend_count");
				}
				%>












				<div class="home-container3" id="specificDiv">
					<div class="profile">
						<div class="profilepic" style="border-radius: 50%;">
							<%
							if (base64Image == null) {
							%>
							<img src=" logo/person-circle.svg" alt="">
							<%
							} else {
							%>
							<img src="data:image/jpeg;base64,<%=base64Image%>" alt="">
							<%
							}
							%>
						</div>
						<div class="profileimf">
							<h2><%=name%></h2>
							<span style="padding-top: 0;"><%=cnt%></span> Posts <span
								style="margin-left: 20px;"><%=fri_cnt%></span> Friends <br>
						</div>

					</div>
					<div class="personal">
						
						<div class="other" style="margin-left: 30%">
							<h6><%=fullname%></h6>
							<span><%=about%></span>
						</div>
					</div>
					<hr class="post-hr">





					<div style="display: flex; flex-wrap: wrap;">
						<div class="album">
							<div class="container">
								<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
									<%
									List<String> imageDataList = (List<String>) request.getAttribute("imageDataList");
									if (imageDataList != null) {
										for (String base64Image : imageDataList) {

											if (base64Image == "logo/noposts.png") {
									%>

									<div class="card"
										style="margin-top: 10px; overflow: hidden; overflow-x: hidden; width: 300px; height: 300px;">
										<%
											if(base64Image=="logo/noposts.png")
											{
												%>
												<img src="logo/noposts.png"
											width="100%" height="100%" class="card-img-top" alt="..."
											style="object-fit: cover;">
												<%
											}
										else{
											%>
											<img src="data:image/jpeg;base64,<%=base64Image%>"
											width="100%" height="100%" class="card-img-top" alt="..."
											style="object-fit: cover;">
											<%
										}
										%>
										
											
									</div>
									<%
									break;
									}

									if (!base64Image.isEmpty()) {
									%>

									<div class="card"
										style="margin-top: 10px; overflow: hidden; overflow-x: hidden; width: 300px; height: 300px;">
										<img src="data:image/jpeg;base64,<%=base64Image%>"
											width="100%" height="100%" class="card-img-top" alt="..."
											style="object-fit: cover;">
									</div>
									<%
									} else {
									%>
									<div class="card"
										style="margin-top: 10px; overflow: hidden; overflow-x: hidden; width: 300px; height: 300px;">
										<img src="logo/noposts.png"
											width="100%" height="100%" class="card-img-top" alt="..."
											style="object-fit: cover;">
									</div>
									<%
									}
									}
									} else {
									%>

									<%
									}
									%>

								</div>
							</div>
						</div>







					</div>
				</div>
			</div>
		</div>

	</div>






	



	<!-- Modal for request -->
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

						int j = 1;
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
								onclick="updateStatus(<%=id%>,<%=fri_id%>)"
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

    function updateStatus(myid,friid) {
        // Replace these with actual user and friend IDs
        var userId = myid;
        var friendId = friid;

        // Make an AJAX request to update the status
        $.ajax({
            type: "POST",
            url: "UpdateStatus", // Replace with your actual JSP file
            data: {
                action: "accept",
                userId: userId,
                friendId: friendId
            },
            success: function (response) {
                // Handle the response from the server if needed
                alert(response);
                location.reload();
            }
            },
            error: function (error) {
                // Handle errors if any
                alert("Error updating status:", error);
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
				<li><a class="nav-item" href="#">Something else here</a></li>
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

		ResultSet rs4 = stmt.executeQuery(str);
		while (rs4.next()) {
			count = rs4.getInt("user_count");
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
						Statement stmt2;

						stmt2 = con.createStatement();
						ResultSet rs3 = stmt2.executeQuery(
						"SELECT DISTINCT up.user_id, up.name, up.surname, up.profile_pic FROM friend f JOIN user u ON (f.another_user_id = u.user_id OR f.user_id = u.user_id) JOIN user_profile up ON u.user_id = up.user_id WHERE (f.user_id = "
								+ id + " OR f.another_user_id = " + id + ") AND f.status = 'accepted'");

						int k = 1;
						int fri_id = 0;
						while (rs3.next()) {
							fri_id = rs3.getInt(1);

							if (fri_id == id) {
						continue;
							}
							Blob blob = rs3.getBlob(4);

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
							<b><a href="Profile?id=<%=fri_id%>"><%=rs3.getString(2) + " " + rs3.getString(3)%></a></b>

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
	<script>
		$(document).ready(function() {
			$(buttonId).click(function() {
				$.ajax({
					type : "GET", // or "POST" depending on your servlet
					url : "http://localhost:8082/Vibe/Likes", // Replace with the actual URL of your servlet
					success : function(response) {
						// Handle the response from the servlet if needed
						console.log("Servlet executed successfully");
					},
					error : function() {
						// Handle errors if the servlet execution fails
						console.error("Failed to execute servlet");
					}
				});
			});
		});
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
						Statement stmt3;

						stmt3 = con.createStatement();
						ResultSet rs2 = stmt3.executeQuery(
						"SELECT DISTINCT up.user_id, up.name, up.surname, up.profile_pic FROM user_profile AS up LEFT JOIN friend AS f ON (up.user_id = f.user_id OR up.user_id = f.another_user_id) AND (f.user_id = "
								+ id + " OR f.another_user_id = " + id
								+ ") WHERE (f.user_id IS NULL AND f.another_user_id IS NULL) OR f.status = 'requested' AND up.user_id != "
								+ id + ";");

						int k = 1;
						int fri_id = 0;
						while (rs2.next()) {

							fri_id = rs2.getInt(1);

							if (fri_id == id) {
						continue;
							}
							Blob blob = rs2.getBlob(4);

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
								style="text-decoration: none;"><%=rs2.getString(2) + " " + rs2.getString(3)%></a></b>
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
                },
                error: function(xhr, status, error) {
                	alert("Error: " + error);

                    // Handle errors or provide feedback to the user
                    alert("Error adding friend. Please try again.");
                }
            });
        }
    </script>





</body>

</html>
<%
} else {
response.sendRedirect("login.html");
}
} else {
response.sendRedirect("login.html");
}
%>