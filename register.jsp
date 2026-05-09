<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URI,java.net.http.HttpClient,java.net.http.HttpRequest,java.net.http.HttpResponse,java.time.Duration,java.util.regex.Matcher,java.util.regex.Pattern" %>
<%!
    private String extractJsonValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + Pattern.quote(key) + "\"\\s*:\\s*\"((?:\\\\.|[^\\\\\"])*)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1).replace("\\\"", "\"").replace("\\\\", "\\");
        }
        return null;
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
%>
<%
    String message = null;
    String messageType = "";
    String method = request.getMethod();

    if ("POST".equalsIgnoreCase(method)) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || password == null || confirmPassword == null ||
            username.trim().isEmpty() || password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            message = "All fields are required.";
            messageType = "error";
        } else if (!password.equals(confirmPassword)) {
            message = "Password and confirm password do not match.";
            messageType = "error";
        } else {
            try {
                String payload = "{"
                    + "\"username\":\"" + escapeJson(username.trim()) + "\","
                    + "\"password\":\"" + escapeJson(password) + "\","
                    + "\"confirmPassword\":\"" + escapeJson(confirmPassword) + "\""
                    + "}";

                HttpClient httpClient = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(5))
                    .build();

                HttpRequest httpRequest = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost/ott-backend/api/register_user.php"))
                    .timeout(Duration.ofSeconds(10))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(payload))
                    .build();

                HttpResponse<String> apiResponse = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());
                String body = apiResponse.body() == null ? "" : apiResponse.body();
                String apiMessage = extractJsonValue(body, "message");

                if (apiResponse.statusCode() >= 200 && apiResponse.statusCode() < 300) {
                    message = apiMessage != null ? apiMessage : "Registration successful. Please login.";
                    messageType = "success";
                } else {
                    message = apiMessage != null ? apiMessage : "Unable to register right now.";
                    messageType = "error";
                }
            } catch (Exception ex) {
                message = "Registration service is unavailable. Start XAMPP Apache and MySQL, then try again.";
                messageType = "error";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>OTT Platform - Register</title>
    <style>
        :root {
            --card: rgba(12, 19, 34, 0.74);
            --text: #ffffff;
            --accent: #14c38e;
            --accent-2: #4ed7f1;
            --line: rgba(255, 255, 255, 0.16);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: grid;
            place-items: center;
            background:
                radial-gradient(circle at top left, rgba(78, 215, 241, 0.16), transparent 30%),
                radial-gradient(circle at top right, rgba(20, 195, 142, 0.18), transparent 35%),
                linear-gradient(rgba(10, 10, 20, 0.68), rgba(10, 10, 20, 0.84)),
                url("login8.jpg") center / cover no-repeat fixed;
            color: var(--text);
            padding: 16px;
        }

        .card {
            width: 100%;
            max-width: 440px;
            background: var(--card);
            border: 1px solid var(--line);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 28px 50px rgba(0, 0, 0, 0.42);
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.8rem;
            letter-spacing: 1.1px;
            text-transform: uppercase;
            color: #d9fff6;
            margin-bottom: 14px;
        }

        .eyebrow .icon {
            width: 28px;
            height: 28px;
            border-radius: 9px;
            display: grid;
            place-items: center;
            background: linear-gradient(120deg, var(--accent), var(--accent-2));
            color: #0b1519;
            font-weight: 800;
            font-size: 0.78rem;
        }

        h1 {
            margin-bottom: 8px;
            font-size: 1.95rem;
            letter-spacing: 0.3px;
        }

        .subtext {
            color: #d5e8f7;
            margin-bottom: 18px;
            line-height: 1.45;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-size: 0.9rem;
            color: #dce4ff;
        }

        input {
            width: 100%;
            padding: 12px 13px;
            margin-bottom: 13px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.22);
            background: rgba(0, 0, 0, 0.18);
            color: #fff;
        }

        input:focus {
            outline: none;
            border-color: rgba(78, 215, 241, 0.52);
            box-shadow: 0 0 0 3px rgba(78, 215, 241, 0.12);
        }

        button {
            width: 100%;
            border: 0;
            border-radius: 10px;
            padding: 12px;
            background: linear-gradient(120deg, var(--accent), var(--accent-2));
            color: #08231d;
            font-weight: 700;
            cursor: pointer;
            letter-spacing: 0.3px;
        }

        .msg {
            margin-bottom: 12px;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .msg.error {
            background: rgba(255, 77, 77, 0.2);
            border: 1px solid rgba(255, 77, 77, 0.4);
            color: #ffd9d9;
        }

        .msg.success {
            background: rgba(26, 188, 156, 0.2);
            border: 1px solid rgba(26, 188, 156, 0.4);
            color: #d6fff6;
        }

        .links {
            text-align: center;
            margin-top: 14px;
        }

        a {
            color: #b9e6ff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="card">
    <div class="eyebrow"><span class="icon">RG</span><span>New Membership</span></div>
    <h1>Create Account</h1>
    <div class="subtext">Register once to access content browsing, subscriptions, chatbot help, and platform tools.</div>
    <% if (message != null) { %>
        <div class="msg <%= messageType %>"><%= message %></div>
    <% } %>

    <form method="post" action="register.jsp" onsubmit="return validateRegisterForm();">
        <label for="username">Username</label>
        <input id="username" name="username" type="text" placeholder="Choose username" />

        <label for="password">Password</label>
        <input id="password" name="password" type="password" placeholder="Create password" />

        <label for="confirmPassword">Confirm Password</label>
        <input id="confirmPassword" name="confirmPassword" type="password" placeholder="Re-enter password" />
        <button type="submit">Register</button>
    </form>

    <div class="links">
        Already have an account? <a href="login.jsp" onclick="goToLogin(); return false;">Login</a>
    </div>
</div>
<script src="register.js"></script>
</body>
</html>

