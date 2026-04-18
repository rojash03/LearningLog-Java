<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>My Topics - Learning Log</title>
</head>
<body>
<h2>My Added Topics</h2>
<p>
    <a href="topic">Add New Topic</a> |
    <a href="dashboard">Back to Dashboard</a>
</p>
<c:if test="${not empty error}">
    <p style="color: #b00020;">${error}</p>
</c:if>

<table border="1">
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>UserId</th>
        <th>CreatedDate</th>
        <th>Action</th>
    </tr>
    <tbody>
    <c:if test="${empty topics}">
        <tr>
            <td colspan="5">No topics added yet.</td>
        </tr>
    </c:if>
    <c:forEach var="t" items="${topics}">
        <tr>
             <td>${t.id}</td>
            <td>${t.topic}</td>
            <td>${t.userid}</td>
            <td>${t.created_at}</td>
            <td>
                <a href="topic?page=edit&id=${t.id}">Edit</a> |
                <a href="topic?page=delete&id=${t.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>