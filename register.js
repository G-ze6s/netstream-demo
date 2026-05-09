function validateRegisterForm() {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();
    const confirmPassword = document.getElementById("confirmPassword").value.trim();

    if (!username || !password || !confirmPassword) {
        alert("Please fill all fields.");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Password and confirm password must match.");
        return false;
    }

    return true;
}

function goToLogin() {
    window.location.href = "login.jsp";
}
