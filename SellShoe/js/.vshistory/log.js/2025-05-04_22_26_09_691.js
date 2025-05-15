document.addEventListener('DOMContentLoaded', function () {
    // Form switching
    const loginForm = document.querySelector('.login-form');
    const signupForm = document.querySelector('.signup-form');
    const showSignupBtn = document.getElementById('show-signup');
    const showLoginBtn = document.getElementById('show-login');

    showSignupBtn.addEventListener('click', function (e) {
        e.preventDefault();
        loginForm.classList.remove('active');
        setTimeout(() => {
            signupForm.classList.add('active');
        }, 400);
    });

    showLoginBtn.addEventListener('click', function (e) {
        e.preventDefault();
        signupForm.classList.remove('active');
        setTimeout(() => {
            loginForm.classList.add('active');
        }, 400);
    });

    // Tab switching
    const tabs = document.querySelectorAll('.tab');
    const tabIndicator = document.querySelector('.tab-indicator');

    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            // Remove active class from all tabs
            tabs.forEach(t => t.classList.remove('active'));

            // Add active class to clicked tab
            this.classList.add('active');

            // Move the indicator
            if (this.dataset.tab === 'mobile') {
                tabIndicator.style.left = '150px';
            } else {
                tabIndicator.style.left = '0';
            }

            // Change input type based on selected tab
            const emailInput = document.getElementById('email');
            if (this.dataset.tab === 'mobile') {
                emailInput.type = 'tel';
                emailInput.placeholder = 'Mobile Number';
                document.querySelector('.login-form .input-group:first-child i').className = 'fa-solid fa-mobile-screen';
            } else {
                emailInput.type = 'email';
                emailInput.placeholder = 'Email';
                document.querySelector('.login-form .input-group:first-child i').className = 'fa-regular fa-envelope';
            }
        });
    });

    // Password visibility toggle
    const passwordFields = document.querySelectorAll('input[type="password"]');
    const passwordIcons = document.querySelectorAll('.input-group i.fa-eye-slash');

    passwordIcons.forEach((icon, index) => {
        icon.addEventListener('click', function () {
            const field = this.nextElementSibling;

            if (field.type === 'password') {
                field.type = 'text';
                this.className = 'fal fa-eye';
            } else {
                field.type = 'password';
                this.className = 'fal fa-eye-slash';
            }
        });
    });

    // Form validation
    const loginFormEl = document.getElementById('login-form');
    const signupFormEl = document.getElementById('signup-form');

    loginFormEl.addEventListener('submit', function (e) {
        e.preventDefault();

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        // Simple validation
        if (email && password) {
            // Here you would typically send the data to a server
            alert('Login successful! (This is just a demo)');
        } else {
            alert('Please fill in all fields');
        }
    });

    signupFormEl.addEventListener('submit', function (e) {
        e.preventDefault();

        const fullname = document.getElementById('fullname').value;
        const email = document.getElementById('signup-email').value;
        const password = document.getElementById('signup-password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        // Simple validation
        if (fullname && email && password) {
            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return;
            }

            // Here you would typically send the data to a server
            alert('Registration successful! (This is just a demo)');

            // Switch to login form
            signupForm.classList.remove('active');
            setTimeout(() => {
                loginForm.classList.add('active');
            }, 400);
        } else {
            alert('Please fill in all fields');
        }
    });
});