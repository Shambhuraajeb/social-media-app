<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Theme</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            transition: background-color 0.3s, color 0.3s;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Additional style when in dark theme */
        body.dark-theme {
            background-color: black;
            color: white;
        }

        .dark-theme div {
            background-color: black;
            color: white;
        }

        .dark-theme div bold {
            color: white;
        }

        /* Style for the anchor tag (toggle button) */
        #colorToggle {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            border: 2px solid #3498db;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>My Webpage</h1>
    <p>This is some content on the page.</p>

    <!-- Anchor tag to toggle the theme -->
    <a href="#" id="colorToggle">Toggle Theme</a>

    <!-- Additional div elements in the container -->
    <div id="specificDiv">Div 1 with <bold>bold text</bold></div>
    <div id="anotherDiv">Div 2 with <bold>bold text</bold></div>
</div>

<!-- Script to handle the theme toggle -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const body = document.body;
        const colorToggle = document.getElementById('colorToggle');
        const specificDiv = document.getElementById('specificDiv');
        const anotherDiv = document.getElementById('anotherDiv');

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
            specificDiv.style.backgroundColor = body.classList.contains('dark-theme') ? 'black' : 'transparent';
            specificDiv.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';

            anotherDiv.style.backgroundColor = body.classList.contains('dark-theme') ? 'black' : 'transparent';
            anotherDiv.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';
        }
    });
</script>

</body>
</html>
