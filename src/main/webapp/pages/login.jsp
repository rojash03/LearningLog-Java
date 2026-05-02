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
    String errorMsg = (String) request.getAttribute("error");
    if (errorMsg == null) {
        errorMsg = "";
    }

    String emailValue = request.getParameter("email");
    if (emailValue == null) {
        emailValue = "";
    }

    boolean hasError = !errorMsg.trim().isEmpty();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell auth-shell" aria-labelledby="login-title">
        <div class="auth-layout">
            <div class="auth-hero">
                <div class="auth-hero-inner">
                    <span class="kicker">WELCOME BACK</span>
                    <h1 id="login-title">Log in to your learning workspace</h1>
                    <p class="subtitle">Track your progress, review past topics, and keep your study momentum consistent.</p>
                    <div class="auth-meta">
                        <div class="auth-meta-item">Pick up right where you left off with saved topics and notes.</div>
                        <div class="auth-meta-item">See how your weekly learning streak is stacking up.</div>
                    </div>
                </div>
            </div>

            <div class="content auth-content">
                <div class="stack">
                    <% if (hasError) { %>
                        <div id="login-error" class="alert" role="alert"><%= esc(errorMsg) %></div>
                    <% } %>

                    <form action="login" method="post" novalidate class="form-card">
                        <div class="stack">
                            <div>
                                <label for="email">Email</label>
                                <input
                                        id="email"
                                        type="email"
                                        name="email"
                                        value="<%= esc(emailValue) %>"
                                        placeholder="name@example.com"
                                        autocomplete="email"
                                        required>
                            </div>

                            <div>
                                <label for="password">Password</label>
                                <input
                                        id="password"
                                        type="password"
                                        name="password"
                                        placeholder="Enter your password"
                                        autocomplete="current-password"
                                        <%= hasError ? "aria-describedby=\"login-error\"" : "" %>
                                        required>
                            </div>

                            <button type="submit" class="btn btn-primary">Log in</button>
                        </div>
                    </form>

                    <p class="muted auth-footer auth-links">No account yet? <a href="register">Create one here</a>.</p>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
