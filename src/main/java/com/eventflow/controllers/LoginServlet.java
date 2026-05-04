package com.eventflow.controllers;

import com.eventflow.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

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

        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
            return;
        }

        UserModel userModel = new UserModel();

        if (userModel.isLockedByAttempts(email)) {
            request.setAttribute("errorMessage", "Too many failed attempts. Try again in 15 minutes.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
            return;
        }

        Map<String, Object> user = userModel.getUserByEmail(email);

        if (user != null) {
            String storedHash = (String) user.get("password");
            boolean passwordMatch = org.mindrot.jbcrypt.BCrypt.checkpw(password, storedHash);

            if (passwordMatch) {
                if ((int) user.get("is_locked") == 1) {
                    request.setAttribute("errorMessage", "Your account has been locked. Contact support.");
                    request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                           .forward(request, response);
                    return;
                }

                if ((int) user.get("is_active") == 0) {
                    request.setAttribute("errorMessage", "Your account is inactive. Contact support.");
                    request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                           .forward(request, response);
                    return;
                }

                userModel.recordLoginAttempt(email, true);

                HttpSession session = request.getSession();
                session.setAttribute("userId",    user.get("id"));
                session.setAttribute("userName",  user.get("full_name"));
                session.setAttribute("userEmail", user.get("email"));
                session.setAttribute("userRole",  user.get("role"));
                session.setMaxInactiveInterval(30 * 60);

                String role = (String) user.get("role");
                switch (role) {
                    case "admin":     response.sendRedirect(request.getContextPath() + "/admin/dashboard");     break;
                    case "attendee":  response.sendRedirect(request.getContextPath() + "/attendee/dashboard");  break;
                    case "volunteer": response.sendRedirect(request.getContextPath() + "/volunteer/dashboard"); break;
                    default:          response.sendRedirect(request.getContextPath() + "/vendor/dashboard");    break;
                }

            } else {
                userModel.recordLoginAttempt(email, false);
                if (userModel.isLockedByAttempts(email)) {
                    userModel.lockUser(email);
                    request.setAttribute("errorMessage", "Too many failed attempts. Your account has been locked.");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password.");
                }
                request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                       .forward(request, response);
            }

        } else {
            userModel.recordLoginAttempt(email, false);
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/pages/shared/login.jsp")
                   .forward(request, response);
        }
    }
}