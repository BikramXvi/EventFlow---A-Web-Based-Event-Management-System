package com.eventflow.controllers;

import com.eventflow.model.RegistrationModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/attendee/myregistrations")
public class MyRegistrationsServlet extends HttpServlet {

    private final RegistrationModel registrationModel = new RegistrationModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");
        req.setAttribute("registrations", registrationModel.getMyRegistrations(userId));
        req.getRequestDispatcher("/WEB-INF/pages/attendee/myRegistrations.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session    = req.getSession(false);
        int userId             = (int) session.getAttribute("userId");
        int registrationId     = Integer.parseInt(req.getParameter("registrationId"));

        boolean success = registrationModel.cancel(registrationId, userId);
        req.getSession().setAttribute(success ? "successMsg" : "errorMsg",
            success ? "Registration cancelled." : "Could not cancel registration.");

        res.sendRedirect(req.getContextPath() + "/attendee/myregistrations");
    }
}