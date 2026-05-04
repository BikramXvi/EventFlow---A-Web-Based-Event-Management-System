package com.eventflow.controllers;

import com.eventflow.model.VolunteerModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles volunteer assignment page
 */
@WebServlet("/volunteer/assignments")
public class VolunteerAssignmentsServlet extends HttpServlet {

    private VolunteerModel volunteerModel = new VolunteerModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get existing session
        HttpSession session = req.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            // Redirect to login page
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Safely get userId
        int volunteerId = Integer.parseInt(session.getAttribute("userId").toString());

        // Fetch assignments
        req.setAttribute("assignments",
                volunteerModel.getMyAssignments(volunteerId));

        // Forward to JSP
        req.getRequestDispatcher("/WEB-INF/pages/volunteer/assignments.jsp")
           .forward(req, res);
    }
}