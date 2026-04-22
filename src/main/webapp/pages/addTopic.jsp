<%@ page import="com.learninglog.learninglogproject.user.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    String topicNameValue = (String) request.getAttribute("topicNameValue");
    if (topicNameValue == null) {
        topicNameValue = "";
    }

    User userObj = (User) session.getAttribute("user");
    int userId = 0;
    if (userObj != null) {
        userId = userObj.getId();
    }

    boolean hasError = !errorMsg.trim().isEmpty();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Topic - Learning Log</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell" aria-labelledby="add-topic-title">
        <header class="topbar">
            <h2 class="brand">Learning Log</h2>
            <nav class="nav-links" aria-label="Topic navigation">
                <a href="dashboard">Dashboard</a>
                <a href="topic?page=list">Topic List</a>
            </nav>
        </header>

        <div class="content">
        <span class="kicker">ADD TOPIC</span>
        <h1>Add a new topic</h1>
        <p class="subtitle">Capture key concepts from class, labs, or tutorials so you can review them later.</p>
        <div class="panel"><strong>Signed in user ID:</strong> <%= userId %></div>

        <div class="stack">
            <% if (hasError) { %>
                <div class="alert" role="alert"><%= esc(errorMsg) %></div>
            <% } %>

            <form method="post" action="topic">
                <input type="hidden" value="add" name="action">
                <label for="topicName">Topic name</label>
                <input
                        id="topicName"
                        type="text"
                        name="topicName"
                        value="<%= esc(topicNameValue) %>"
                        placeholder="e.g. Java collections"
                        required>

                <div class="actions">
                    <button type="submit">Save Topic</button>
                    <a class="btn btn-secondary" href="topic?page=list">View Topics</a>
                    <a class="btn btn-secondary" href="dashboard">Back to Dashboard</a>
                </div>
            </form>
        </div>
        </div>
    </section>
</main>
</body>
</html>