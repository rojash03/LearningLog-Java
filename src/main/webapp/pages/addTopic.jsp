<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/3/2026
  Time: 3:16 PM
  To change this template use File | Settings | File Templates.
--%>
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
            max-width: 480px;
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
            margin: 0 0 8px 0;
            font-size: 26px;
        }

        .subtitle {
            margin: 0 0 18px 0;
            color: #725284;
            font-size: 14px;
        }

        .meta {
            margin: 0 0 16px 0;
            color: #6f2d92;
            font-size: 13px;
            background: #fff1f8;
            border: 1px solid #f8bed8;
            border-radius: 10px;
            padding: 10px 12px;
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

        .actions {
            margin-top: 16px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        button, .link {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        button {
            background: linear-gradient(135deg, #d946ef, #a855f7);
            color: #ffffff;
        }

        .link {
            background: #ffffff;
            color: #8b34b8;
            border: 1px solid #eab6d0;
        }
    </style>
</head>
<body>
<main class="page">
    <section class="card">
        <span class="badge">TOPIC LAB</span>
        <h1>Add a new topic</h1>
        <p class="subtitle">Capture what you are learning so your dashboard stays fresh.</p>
        <p class="meta"><strong>Signed in user:</strong> <%= userId %></p>

        <% if (hasError) { %>
            <div class="alert" role="alert"><%= esc(errorMsg) %></div>
        <% } %>

        <form method="post" action="topic">
            <input type="hidden" value="add" name="action">
            <label for="topicName">Topic Name</label>
            <input
                    id="topicName"
                    type="text"
                    name="topicName"
                    value="<%= esc(topicNameValue) %>"
                    placeholder="e.g. Java collections"
                    required>

            <div class="actions">
                <button type="submit">Add Topic</button>
                <a class="link" href="dashboard">Back to Dashboard</a>
            </div>
        </form>
    </section>
</main>
</body>
</html>