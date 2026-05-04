package com.eventflow.controllers;

import com.eventflow.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {

    private final UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("users", userModel.getAllUsers());
        req.getRequestDispatcher("/WEB-INF/pages/admin/manageUsers.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int id = Integer.parseInt(req.getParameter("id"));

        switch (action) {
            case "toggleActive": userModel.toggleActive(id); break;
            case "toggleLocked": userModel.toggleLocked(id); break;
            case "delete":       userModel.deleteUser(id);   break;
        }

        res.sendRedirect(req.getContextPath() + "/admin/users");
    }
}