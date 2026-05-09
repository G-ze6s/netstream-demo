function validateLoginForm() {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    if (!username || !password) {
        alert("Please enter username and password.");
        return false;
    }

    return true;
}

function goToRegister() {
    window.location.href = "register.jsp";
}
