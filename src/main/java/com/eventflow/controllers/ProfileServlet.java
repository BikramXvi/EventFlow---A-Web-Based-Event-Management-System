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

@WebServlet({"/attendee/profile", "/volunteer/profile", "/vendor/profile"})
public class ProfileServlet extends HttpServlet {

    private final UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");
        String role = (String) session.getAttribute("userRole");

        req.setAttribute("user", userModel.getUserById(userId));
        req.getRequestDispatcher("/WEB-INF/pages/" + role + "/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId    = (int) session.getAttribute("userId");
        String role   = (String) session.getAttribute("userRole");
        String name   = req.getParameter("full_name").trim();
        String phone  = req.getParameter("phone").trim();

        boolean success = userModel.updateProfile(userId, name, phone);

        if (success) {
            session.setAttribute("userName", name);
            req.getSession().setAttribute("successMsg", "Profile updated successfully.");
        } else {
            req.getSession().setAttribute("errorMsg", "Could not update profile.");
        }

        res.sendRedirect(req.getContextPath() + "/" + role + "/profile");
    }
}