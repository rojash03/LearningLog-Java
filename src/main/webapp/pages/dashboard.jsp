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
    <title>Dashboard - Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell" aria-labelledby="dashboard-title">
        <header class="topbar">
            <h2 class="brand">Learning Log</h2>
            <nav class="nav-links" aria-label="Dashboard navigation">
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/topic">Add Topic</a>
                <a href="${pageContext.request.contextPath}/topic?page=list">Topic List</a>
                <a href="${pageContext.request.contextPath}/login">Switch Account</a>
            </nav>
        </header>

        <div class="content">
            <span class="kicker">DASHBOARD</span>

        <% if (loggedIn) { %>
            <h1 id="dashboard-title">Welcome, <%= esc(user.getName()) %></h1>
            <p class="subtitle">Use this space to track what you are learning and jump quickly to your next topic update.</p>

            <div class="stack">
                <div class="panel">
                    <p class="subtitle"><strong>Signed in as:</strong> <%= esc(user.getEmail()) %></p>
                </div>

                <div class="grid">
                    <article class="tile">
                        <p class="tile-label">User ID</p>
                        <p class="tile-value"><%= user.getId() %></p>
                    </article>
                    <article class="tile">
                        <p class="tile-label">Status</p>
                        <p class="tile-value">Active</p>
                    </article>
                    <article class="tile">
                        <p class="tile-label">Next Step</p>
                        <p class="tile-value">Add a topic</p>
                    </article>
                </div>

                <div class="actions">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/topic">Add Topic</a>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/topic?page=list">View Topic List</a>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Refresh</a>
                </div>
            </div>
        <% } else { %>
            <h1 id="dashboard-title">You are not logged in yet</h1>
            <p class="subtitle">Sign in to access your topic workspace.</p>
            <div class="actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Go to Login</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/register">Create Account</a>
            </div>
        <% } %>
        </div>
   </section>
</main>
</body>
</html>
