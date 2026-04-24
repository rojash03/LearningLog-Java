package com.learninglog.learninglogproject.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession Session = httpRequest.getSession(false);

        boolean isLoggedIn = ( Session != null && Session.getAttribute("user") != null);

        String URI = httpRequest.getRequestURI();

        boolean isLoginPageORRegisterPage = URI.endsWith("login") || URI.endsWith("register");

        boolean isStaticFile = URI.contains("images") || URI.contains("css") || URI.contains("js");

        if (isLoggedIn && isLoginPageORRegisterPage) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }
        if(isLoggedIn || isLoginPageORRegisterPage || isStaticFile) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}