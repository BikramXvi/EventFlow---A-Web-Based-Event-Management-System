package com.eventflow.controllers;

import com.eventflow.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Loads data and forwards to volunteer dashboard page.
 */
@WebServlet("/volunteer/dashboard")
public class VolunteerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBConfig.getConnection()) {

            // Get assigned events for this volunteer
            PreparedStatement assignStmt = conn.prepareStatement(
                "SELECT e.title, e.location, e.event_date, va.status " +
                "FROM volunteer_assignments va " +
                "JOIN events e ON va.event_id = e.id " +
                "WHERE va.volunteer_id = ? ORDER BY e.event_date ASC");
            assignStmt.setInt(1, userId);
            ResultSet assignRs = assignStmt.executeQuery();
            List<String[]> assignments = new ArrayList<>();
            while (assignRs.next()) {
                String[] row = {
                    assignRs.getString("title"),
                    assignRs.getString("location"),
                    assignRs.getString("event_date"),
                    assignRs.getString("status")
                };
                assignments.add(row);
            }

            // Get tasks for this volunteer
            PreparedStatement taskStmt = conn.prepareStatement(
                "SELECT vt.task_title, vt.task_description, e.title, vt.is_completed " +
                "FROM volunteer_tasks vt " +
                "JOIN volunteer_assignments va ON vt.assignment_id = va.id " +
                "JOIN events e ON va.event_id = e.id " +
                "WHERE va.volunteer_id = ? ORDER BY vt.is_completed ASC");
            taskStmt.setInt(1, userId);
            ResultSet taskRs = taskStmt.executeQuery();
            List<String[]> tasks = new ArrayList<>();
            while (taskRs.next()) {
                String[] row = {
                    taskRs.getString("task_title"),
                    taskRs.getString("task_description"),
                    taskRs.getString("title"),
                    taskRs.getString("is_completed")
                };
                tasks.add(row);
            }

            request.setAttribute("assignments", assignments);
            request.setAttribute("tasks", tasks);
            request.setAttribute("totalAssignments", assignments.size());

        } catch (Exception e) {
            System.out.println("Volunteer dashboard error: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/volunteer/volunteerDashboard.jsp")
               .forward(request, response);
    }
}