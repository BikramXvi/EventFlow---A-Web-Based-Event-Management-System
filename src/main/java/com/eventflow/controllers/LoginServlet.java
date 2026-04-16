package com.eventflow.controllers;

import com.eventflow.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;

/**
 * Handles user login.
 * GET  -> shows login page
 * POST -> processes login form
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
            return;
        }

        UserModel userModel = new UserModel();
        ResultSet user = userModel.loginUser(email, password);

        if (user != null) {
            try {
                userModel.recordLoginAttempt(email, true);

                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getInt("id"));
                session.setAttribute("userFullName", user.getString("full_name"));
                session.setAttribute("userEmail", user.getString("email"));
                session.setAttribute("userRole", user.getString("role"));
                session.setMaxInactiveInterval(30 * 60);

                String role = user.getString("role");

                if (role.equals("admin")) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else if (role.equals("attendee")) {
                    response.sendRedirect(request.getContextPath() + "/attendee/dashboard");
                } else if (role.equals("volunteer")) {
                    response.sendRedirect(request.getContextPath() + "/volunteer/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/vendor/dashboard");
                }

            } catch (Exception e) {
                request.setAttribute("errorMessage", "Something went wrong. Please try again.");
                request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                       .forward(request, response);
            }
        } else {
            userModel.recordLoginAttempt(email, false);
            request.setAttribute("errorMessage", 
                "Invalid credentials or your account has been locked.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
        }
    }
}