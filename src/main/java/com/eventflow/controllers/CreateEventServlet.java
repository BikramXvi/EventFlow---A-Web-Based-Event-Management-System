package com.eventflow.controllers;

import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles creating a new event.
 * GET  -> shows create event form
 * POST -> saves new event to database
 */
@WebServlet("/admin/createEvent")
public class CreateEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String location = request.getParameter("location").trim();
        String eventDate = request.getParameter("eventDate").trim();
        String startTime = request.getParameter("startTime").trim();
        String endTime = request.getParameter("endTime").trim();
        String capacityStr = request.getParameter("capacity").trim();

        // Validation
        if (title.isEmpty() || description.isEmpty() || location.isEmpty()
                || eventDate.isEmpty() || startTime.isEmpty()
                || endTime.isEmpty() || capacityStr.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp")
                   .forward(request, response);
            return;
        }

        int capacity = Integer.parseInt(capacityStr);
        HttpSession session = request.getSession();
        int createdBy = (int) session.getAttribute("userId");

        EventModel eventModel = new EventModel();
        boolean created = eventModel.createEvent(title, description, location,
                                                  eventDate, startTime, endTime,
                                                  capacity, createdBy);

        if (created) {
            response.sendRedirect(request.getContextPath()
                + "/admin/events?success=Event created successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to create event. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp")
                   .forward(request, response);
        }
    }
}