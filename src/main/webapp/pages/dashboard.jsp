<%@ page import="com.learninglog.learninglogproject.user.model.User" %>
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
    User user = (User) session.getAttribute("user");
    boolean loggedIn = user != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pookie Dashboard - Learning Log</title>
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
            width: 100%;
            max-width: 560px;
            background: rgba(255, 255, 255, 0.94);
            border: 1px solid #f9c4df;
            border-radius: 20px;
            box-shadow: 0 18px 42px rgba(147, 70, 166, 0.16);
            padding: 30px;
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
            margin: 0 0 10px 0;
            font-size: 28px;
        }

        .subtitle {
            margin: 0;
            color: #725284;
            font-size: 15px;
            line-height: 1.5;
        }

        .panel {
            margin-top: 20px;
            padding: 16px;
            border-radius: 12px;
            background: #fff1f8;
            border: 1px solid #f8bed8;
        }

        .panel strong {
            color: #6f2d92;
        }

        .metrics {
            margin-top: 16px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 12px;
        }

        .metric {
            background: #ffffff;
            border: 1px solid #efc7df;
            border-radius: 12px;
            padding: 12px;
        }

        .metric-title {
            margin: 0;
            color: #725284;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .metric-value {
            margin: 6px 0 0 0;
            color: #8b34b8;
            font-size: 22px;
            font-weight: 700;
        }

        .actions {
            margin-top: 18px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #d946ef, #a855f7);
            color: #ffffff;
        }

        .btn-secondary {
            background: #ffffff;
            color: #8b34b8;
            border: 1px solid #eab6d0;
        }

        .btn:hover {
            opacity: 0.92;
        }
    </style>
</head>
<body>
<main class="page">
    <section class="card" aria-labelledby="dashboard-title">
        <span class="badge">POOKIE DASHBOARD</span>

        <% if (loggedIn) { %>
            <h1 id="dashboard-title">Hey <%= esc(user.getName()) %>, your glow-up board is ready</h1>
            <p class="subtitle">This is your cozy place to track progress and stay consistent.</p>

            <div class="panel">
                <p class="subtitle"><strong>User ID:</strong> <%= user.getId() %></p>
            </div>

            <div class="metrics">
                <article class="metric">
                    <p class="metric-title">Mood</p>
                    <p class="metric-value">Focused</p>
                </article>
                <article class="metric">
                    <p class="metric-title">Momentum</p>
                    <p class="metric-value">Strong</p>
                </article>
                <article class="metric">
                    <p class="metric-title">Energy</p>
                    <p class="metric-value">Pookie</p>
                </article>
            </div>

            <div class="actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/topic">Add topic</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/topic?page=list">View topic list</a>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/dashboard">Refresh vibe</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/login">Switch account</a>
            </div>
        <% } else { %>
            <h1 id="dashboard-title">You are not logged in yet</h1>
            <p class="subtitle">Sign in to unlock your pookie dashboard and keep your learning streak alive.</p>
            <div class="actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Go to login</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/register">Create account</a>
            </div>
        <% } %>
    </section>
</main>
</body>
</html>
