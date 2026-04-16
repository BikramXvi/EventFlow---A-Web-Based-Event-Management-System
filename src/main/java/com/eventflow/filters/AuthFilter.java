package com.eventflow.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Intercepts every request.
 * Blocks unauthenticated users and enforces role-based access.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String path = request.getRequestURI();
        String contextPath = request.getContextPath();

        boolean isPublicPage = path.equals(contextPath + "/login")
                || path.equals(contextPath + "/register")
                || path.equals(contextPath + "/about")
                || path.equals(contextPath + "/contact")
                || path.startsWith(contextPath + "/css/")
                || path.startsWith(contextPath + "/js/")
                || path.startsWith(contextPath + "/images/")
                || path.equals(contextPath + "/")
                || path.equals(contextPath + "/index.jsp");

        boolean isLoggedIn = (session != null 
                && session.getAttribute("userId") != null);

        if (isPublicPage) {
            chain.doFilter(req, res);
            return;
        }

        if (!isLoggedIn) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (path.startsWith(contextPath + "/admin/") && !role.equals("admin")) {
            response.sendRedirect(contextPath + "/login");
            return;
        }
        if (path.startsWith(contextPath + "/attendee/") && !role.equals("attendee")) {
            response.sendRedirect(contextPath + "/login");
            return;
        }
        if (path.startsWith(contextPath + "/volunteer/") && !role.equals("volunteer")) {
            response.sendRedirect(contextPath + "/login");
            return;
        }
        if (path.startsWith(contextPath + "/vendor/") && !role.equals("vendor")) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}