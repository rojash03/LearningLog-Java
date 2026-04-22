<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Topics - Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell" aria-labelledby="topic-list-title">
        <header class="topbar">
            <h2 class="brand">Learning Log</h2>
            <nav class="nav-links" aria-label="Topic list navigation">
                <a href="dashboard">Dashboard</a>
                <a href="topic">Add Topic</a>
            </nav>
        </header>

        <div class="content">
            <span class="kicker">TOPICS</span>
            <h1 id="topic-list-title">My added topics</h1>
            <p class="subtitle">Review your recorded topics and quickly jump into edits when needed.</p>

            <div class="actions">
                <a class="btn btn-primary" href="topic">Add New Topic</a>
                <a class="btn btn-secondary" href="dashboard">Back to Dashboard</a>
            </div>

            <div class="stack">
                <c:if test="${not empty error}">
                    <div class="alert" role="alert">${error}</div>
                </c:if>

                <div class="table-wrap">
                    <table>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Topic</th>
                            <th>User ID</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty topics}">
                            <tr>
                                <td colspan="5" class="empty">No topics added yet.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="t" items="${topics}">
                            <tr>
                                <td>${t.id}</td>
                                <td>${t.topic}</td>
                                <td>${t.userid}</td>
                                <td>${t.created_at}</td>
                                <td>
                                    <div class="actions">
                                        <a class="btn btn-secondary" href="topic?page=edit&id=${t.id}">Edit</a>
                                        <a class="btn btn-danger" href="topic?page=delete&id=${t.id}">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>