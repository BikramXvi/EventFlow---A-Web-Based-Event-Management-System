package com.eventflow.controllers;

import com.eventflow.model.VolunteerModel;
import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/volunteers")
public class ManageVolunteersServlet extends HttpServlet {

    private final VolunteerModel volunteerModel = new VolunteerModel();
    private final EventModel eventModel = new EventModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("volunteers",   volunteerModel.getAllVolunteers());
        req.setAttribute("events",       eventModel.getAllEvents());
        req.setAttribute("assignments",  volunteerModel.getAllAssignments());
        req.setAttribute("tasksByAssignment", volunteerModel.getAllTasksByAssignment());
        req.getRequestDispatcher("/WEB-INF/pages/admin/manageVolunteers.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("assign".equals(action)) {
            int eventId     = Integer.parseInt(req.getParameter("eventId"));
            int volunteerId = Integer.parseInt(req.getParameter("volunteerId"));
            volunteerModel.assignVolunteer(eventId, volunteerId);

        } else if ("remove".equals(action)) {
            int assignmentId = Integer.parseInt(req.getParameter("assignmentId"));
            volunteerModel.removeAssignment(assignmentId);

        } else if ("addTask".equals(action)) {
            int    assignmentId  = Integer.parseInt(req.getParameter("assignmentId"));
            String taskTitle     = req.getParameter("taskTitle");
            String taskDesc      = req.getParameter("taskDescription");
            if (taskTitle != null && !taskTitle.trim().isEmpty()) {
                volunteerModel.addTask(assignmentId, taskTitle, taskDesc);
            }

        } else if ("removeTask".equals(action)) {
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            volunteerModel.removeTask(taskId);
        }

        res.sendRedirect(req.getContextPath() + "/admin/volunteers");
    }
}
