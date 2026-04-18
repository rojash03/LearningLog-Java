<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/13/2026
  Time: 3:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Topic</title>
</head>
<body>
<h2>Edit Topic</h2>
<p><a href="topic?page=list">Back to Topic List</a></p>

<% if (request.getAttribute("error") != null) { %>
    <p style="color: #b00020;"><%= request.getAttribute("error") %></p>
<% } %>

<form method="post" action="edit-topic">
    <input type="hidden" name="action" value="edit" />
    <input type="hidden" name="id" value="${topic.id}" />

    <label for="topicName">Topic Name</label>
    <input id="topicName" type="text" name="topicName" value="${topic.topic}" required />

    <button type="submit">Update Topic</button>
</form>
</body>
</html>
