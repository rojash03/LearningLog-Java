<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/24/2026
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../components/header.jsp" />
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Add New Image</h2>
<p style="color: red; font-weight: bold " >${error} </p>
<p style="color: blue; font-weight: bold">${success}</p>

<form method="post" action="image" enctype="multipart/form-data">
    Name: <input type="text" name="name">
    <input type="file" name="image">
    <button>Add image</button>
</form>
</body>
</html>
