package com.eventflow.controllers;

import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles editing an existing event.
 * GET  -> loads event data into edit form
 * POST -> saves updated event to database
 */
@WebServlet("/admin/editEvent")
public class EditEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("id"));
        EventModel eventModel = new EventModel();
        String[] event = eventModel.getEventById(eventId);

        if (event == null) {
            response.sendRedirect(request.getContextPath() + "/admin/events");
            return;
        }

        request.setAttribute("event", event);
        request.getRequestDispatcher("/WEB-INF/pages/admin/editEvent.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String location = request.getParameter("location").trim();
        String eventDate = request.getParameter("eventDate").trim();
        String startTime = request.getParameter("startTime").trim();
        String endTime = request.getParameter("endTime").trim();
        int capacity = Integer.parseInt(request.getParameter("capacity").trim());
        String status = request.getParameter("status").trim();

        if (title.isEmpty() || description.isEmpty() || location.isEmpty()
                || eventDate.isEmpty() || startTime.isEmpty() || endTime.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.setAttribute("event", new String[]{
                String.valueOf(eventId), title, description, location,
                eventDate, startTime, endTime,
                String.valueOf(capacity), status
            });
            request.getRequestDispatcher("/WEB-INF/pages/admin/editEvent.jsp")
                   .forward(request, response);
            return;
        }

        EventModel eventModel = new EventModel();
        boolean updated = eventModel.updateEvent(eventId, title, description,
                                                  location, eventDate, startTime,
                                                  endTime, capacity, status);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/admin/events");
        } else {
            request.setAttribute("errorMessage", "Failed to update event.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/editEvent.jsp")
                   .forward(request, response);
        }
    }
}