package com.eventflow.controllers;

import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Handles viewing and deleting events.
 * GET  -> shows all events
 * POST -> handles delete action
 */
@WebServlet("/admin/events")
public class ManageEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventModel eventModel = new EventModel();
        List<String[]> events = eventModel.getAllEvents();
        request.setAttribute("events", events);

        request.getRequestDispatcher("/WEB-INF/pages/admin/manageEvents.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("delete")) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            EventModel eventModel = new EventModel();
            boolean deleted = eventModel.deleteEvent(eventId);

            if (deleted) {
                request.setAttribute("successMessage", "Event deleted successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to delete event.");
            }
        }

        // Reload the events list
        EventModel eventModel = new EventModel();
        request.setAttribute("events", eventModel.getAllEvents());
        request.getRequestDispatcher("/WEB-INF/pages/admin/manageEvents.jsp")
               .forward(request, response);
    }
}