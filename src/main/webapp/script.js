document.addEventListener('DOMContentLoaded', function() {
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

	colorToggle.addEventListener('click', function() {
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

		nav.style.backgroundColor = body.classList.contains('dark-theme') ? 'gray' : '#FAF9DE';
		nav.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';

		modals.forEach(modal => {
			modal.style.backgroundColor = body.classList.contains('dark-theme') ? 'transparent' : 'transparent';
			modal.style.color = body.classList.contains('dark-theme') ? 'white' : 'black';
		});
	}
});

