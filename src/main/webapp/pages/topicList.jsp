<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/topic">Add Topic</a>
            </nav>
        </header>

        <div class="content">
            <span class="kicker">TOPICS</span>
            <h1 id="topic-list-title">My added topics</h1>
            <p class="subtitle">Review your recorded topics and quickly jump into edits when needed.</p>

            <div class="topic-hero" aria-label="Topic list summary">
                <article class="topic-card">
                    <p class="tile-label">Topics recorded</p>
                    <p class="tile-value"><c:out value="${not empty topics ? topics.size() : 0}" /></p>
                    <p class="topic-card-note">A quick view of everything you have added so far.</p>
                </article>
                <article class="topic-card topic-card-highlight">
                    <p class="tile-label">Fast actions</p>
                    <p class="tile-value">Edit, remove, or add</p>
                    <p class="topic-card-note">Keep your learning log organized from one screen.</p>
                </article>
            </div>

            <div class="actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/topic">Add New Topic</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>
            </div>

            <div class="stack">
                <c:if test="${not empty error}">
                    <div class="alert" role="alert"><c:out value="${error}" /></div>
                </c:if>

                <c:choose>
                    <c:when test="${empty topics}">
                        <div class="topic-empty panel">
                            <p class="tile-label">No topics yet</p>
                            <h2>Start building your learning list</h2>
                            <p class="subtitle">Add your first topic to begin tracking what you are working on.</p>
                            <div class="actions">
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/topic">Add First Topic</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-wrap topic-table-wrap">
                            <table class="topic-table">
                                <caption class="sr-only">List of topics you have added</caption>
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
                                <c:forEach var="t" items="${topics}">
                                    <tr>
                                        <td><c:out value="${t.id}" /></td>
                                        <td><c:out value="${t.topic}" /></td>
                                        <td><c:out value="${t.userid}" /></td>
                                        <td><fmt:formatDate value="${t.created_at}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <div class="row-actions">
                                                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/topic?page=edit&id=${t.id}">Edit</a>
                                                <a class="btn btn-danger" href="${pageContext.request.contextPath}/topic?page=delete&id=${t.id}" onclick="return confirm('Delete this topic?');">Delete</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
</main>
</body>
</html>