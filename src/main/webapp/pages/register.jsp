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

    String nameValue = request.getParameter("name");
    if (nameValue == null) {
        nameValue = "";
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
    <title>Register - Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page-wrap">
    <section class="shell auth-shell" aria-labelledby="register-title">
        <div class="auth-layout">
            <div class="auth-hero">
                <div class="auth-hero-inner">
                    <span class="kicker">CREATE ACCOUNT</span>
                    <h1 id="register-title">Start your Learning Log</h1>
                    <p class="subtitle">Create a profile to organize your topics and keep all your progress in one place.</p>
                    <div class="auth-meta">
                        <div class="auth-meta-item">Build a living archive of what you learn each week.</div>
                        <div class="auth-meta-item">Keep your best references, summaries, and reflections together.</div>
                    </div>
                </div>
            </div>

            <div class="content auth-content">
                <div class="stack">
                    <% if (hasError) { %>
                        <div id="register-error" class="alert" role="alert"><%= esc(errorMsg) %></div>
                    <% } %>

                    <form action="register" method="post" novalidate class="form-card">
                        <div class="stack">
                            <div>
                                <label for="name">Full name</label>
                                <input
                                        id="name"
                                        type="text"
                                        name="name"
                                        value="<%= esc(nameValue) %>"
                                        placeholder="Your full name"
                                        autocomplete="name"
                                        required>
                            </div>

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
                                        placeholder="Create a strong password"
                                        autocomplete="new-password"
                                        <%= hasError ? "aria-describedby=\"register-error\"" : "" %>
                                        required>
                            </div>

                            <button type="submit" class="btn btn-primary">Create account</button>
                        </div>
                    </form>

                    <p class="muted auth-footer auth-links">Already registered? <a href="login">Log in</a>.</p>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>