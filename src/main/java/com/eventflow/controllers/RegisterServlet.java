package com.eventflow.controllers;

import com.eventflow.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles user registration.
 * GET  -> shows register page
 * POST -> processes registration form
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();
        String role = request.getParameter("role").trim();

        if (fullName.isEmpty() || email.isEmpty() || phone.isEmpty()
                || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
                   .forward(request, response);
            return;
        }

        if (!fullName.matches("[a-zA-Z ]+")) {
            request.setAttribute("errorMessage", 
                "Full name should only contain letters.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
                   .forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
                   .forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", 
                "Password must be at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
                   .forward(request, response);
            return;
        }

        UserModel userModel = new UserModel();
        String result = userModel.registerUser(fullName, email, phone, password, role);

        if (result.equals("success")) {
            request.setAttribute("successMessage", 
                "Registration successful! You can now log in.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("errorMessage", result);
            request.getRequestDispatcher("/WEB-INF/pages/shared/register.jsp")
                   .forward(request, response);
        }
    }
}