<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Topic - Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell" aria-labelledby="edit-topic-title">
        <header class="topbar">
            <h2 class="brand">Learning Log</h2>
            <nav class="nav-links" aria-label="Edit navigation">
                <a href="topic?page=list">Topic List</a>
                <a href="dashboard">Dashboard</a>
            </nav>
        </header>

        <div class="content">
            <span class="kicker">EDIT TOPIC</span>
            <h1 id="edit-topic-title">Update topic details</h1>
            <p class="subtitle">Make changes and save to keep your learning record up to date.</p>

            <div class="stack">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert" role="alert"><%= request.getAttribute("error") %></div>
                <% } %>

                <form method="post" action="edit-topic">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="id" value="${topic.id}" />

                    <label for="topicName">Topic name</label>
                    <input id="topicName" type="text" name="topicName" value="${topic.topic}" required />

                    <div class="actions">
                        <button type="submit">Update Topic</button>
                        <a class="btn btn-secondary" href="topic?page=list">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </section>
</main>
</body>
</html>
