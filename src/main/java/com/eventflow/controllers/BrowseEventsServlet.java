package com.eventflow.controllers;

import com.eventflow.model.RegistrationModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/attendee/events")
public class BrowseEventsServlet extends HttpServlet {

    private final RegistrationModel registrationModel = new RegistrationModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");
        req.setAttribute("events", registrationModel.getAvailableEvents(userId));
        req.getRequestDispatcher("/WEB-INF/pages/attendee/browseEvents.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId  = (int) session.getAttribute("userId");
        int eventId = Integer.parseInt(req.getParameter("eventId"));

        boolean success = registrationModel.register(eventId, userId);
        req.getSession().setAttribute(success ? "successMsg" : "errorMsg",
            success ? "Successfully registered for event!" : "Could not register. You may already be registered.");

        res.sendRedirect(req.getContextPath() + "/attendee/events");
    }
}