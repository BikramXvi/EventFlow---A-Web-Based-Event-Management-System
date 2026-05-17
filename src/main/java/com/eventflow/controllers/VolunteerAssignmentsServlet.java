package com.eventflow.controllers;

import com.eventflow.model.VolunteerModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/volunteer/assignments")
public class VolunteerAssignmentsServlet extends HttpServlet {

    private final VolunteerModel volunteerModel = new VolunteerModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int volunteerId = Integer.parseInt(session.getAttribute("userId").toString());
        List<Map<String, Object>> assignments = volunteerModel.getMyAssignments(volunteerId);

        // Build tasks map keyed by assignment id
        Map<Integer, List<Map<String, Object>>> tasksByAssignment = new HashMap<>();
        for (Map<String, Object> a : assignments) {
            int aId = (Integer) a.get("id");
            tasksByAssignment.put(aId, volunteerModel.getTasksForAssignment(aId));
        }

        req.setAttribute("assignments",       assignments);
        req.setAttribute("tasksByAssignment", tasksByAssignment);
        req.getRequestDispatcher("/WEB-INF/pages/volunteer/assignments.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if ("toggleTask".equals(action)) {
            int taskId    = Integer.parseInt(req.getParameter("taskId"));
            int completed = Integer.parseInt(req.getParameter("completed"));
            volunteerModel.updateTaskCompletion(taskId, completed);
        }

        res.sendRedirect(req.getContextPath() + "/volunteer/assignments");
    }
}
