<%--
  Register Page JSP
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%!
    private String esc(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>
<%
    String errorMsg = (String) request.getAttribute("error");
    if (errorMsg == null) {
        errorMsg = "";
    }

    String nameValue = request.getParameter("name");
    if (nameValue == null) {
        nameValue = "";
    }

    String emailValue = request.getParameter("email");
    if (emailValue == null) {
        emailValue = "";
    }

    boolean hasError = !errorMsg.trim().isEmpty();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pookie Register - Learning Log</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #ffe4ec 0%, #ffd7f3 45%, #e4dcff 100%);
            color: #31234a;
        }

        .page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 28px;
        }

        .card {
            position: relative;
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.93);
            border: 1px solid #f9c4df;
            border-radius: 20px;
            box-shadow: 0 18px 42px rgba(147, 70, 166, 0.16);
            padding: 30px;
            backdrop-filter: blur(2px);
        }

        .badge {
            display: inline-block;
            margin-bottom: 12px;
            padding: 6px 12px;
            border-radius: 999px;
            background: #fce7f3;
            border: 1px solid #f5b7dc;
            color: #9d2d73;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        h1 {
            margin: 0 0 6px 0;
            font-size: 26px;
        }

        .subtitle {
            margin: 0 0 20px 0;
            color: #725284;
            font-size: 14px;
            line-height: 1.5;
        }

        .alert {
            margin: 0 0 16px 0;
            padding: 11px 12px;
            border: 1px solid #f7b8cb;
            background: #fff1f5;
            color: #9b1c43;
            border-radius: 10px;
            font-size: 14px;
        }

        .field {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: 600;
            color: #56386d;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 10px 12px;
            border: 1px solid #eab6d0;
            border-radius: 10px;
            font-size: 14px;
            color: #31234a;
            background: #ffffff;
        }

        input:focus {
            outline: none;
            border-color: #b455d8;
            box-shadow: 0 0 0 3px rgba(180, 85, 216, 0.22);
        }

        button {
            width: 100%;
            padding: 11px 14px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #d946ef, #a855f7);
            color: #ffffff;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.12s ease, box-shadow 0.12s ease;
        }

        button:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(168, 85, 247, 0.35);
        }

        button:focus-visible {
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.9), 0 0 0 6px rgba(168, 85, 247, 0.4);
        }

        .footer {
            margin-top: 16px;
            text-align: center;
            font-size: 14px;
            color: #725284;
        }

        .footer a {
            color: #8b34b8;
            text-decoration: none;
            font-weight: 600;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (prefers-reduced-motion: reduce) {
            button {
                transition: none;
            }
        }
    </style>
</head>
<body>
<main class="page">
    <section class="card" aria-labelledby="register-title">
        <span class="badge">POOKIE MODE</span>
        <h1 id="register-title">Join the pookie club</h1>
        <p class="subtitle">Create your account and start collecting learning wins.</p>

        <% if (hasError) { %>
            <div id="register-error" class="alert" role="alert"><%= esc(errorMsg) %></div>
        <% } %>

        <form action="register" method="post" novalidate>
            <div class="field">
                <label for="name">Full Name</label>
                <input
                        id="name"
                        type="text"
                        name="name"
                        value="<%= esc(nameValue) %>"
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required>
            </div>

            <div class="field">
                <label for="email">Email</label>
                <input
                        id="email"
                        type="email"
                        name="email"
                        value="<%= esc(emailValue) %>"
                        placeholder="Enter your email"
                        autocomplete="email"
                        required>
            </div>

            <div class="field">
                <label for="password">Password</label>
                <input
                        id="password"
                        type="password"
                        name="password"
                        placeholder="Create a password"
                        autocomplete="new-password"
                        <%= hasError ? "aria-describedby=\"register-error\"" : "" %>
                        required>
            </div>

            <button type="submit">Register</button>
        </form>

        <p class="footer">Already have an account? <a href="login">Log in</a></p>
    </section>
</main>
</body>
</html>