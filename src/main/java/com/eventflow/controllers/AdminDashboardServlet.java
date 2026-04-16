package com.eventflow.controllers;

import com.eventflow.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Loads data and forwards to admin dashboard page.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConfig.getConnection()) {

            // Get total users count
            PreparedStatement userStmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM users WHERE role != 'admin'");
            ResultSet userRs = userStmt.executeQuery();
            int totalUsers = 0;
            if (userRs.next()) totalUsers = userRs.getInt(1);

            // Get total events count
            PreparedStatement eventStmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM events");
            ResultSet eventRs = eventStmt.executeQuery();
            int totalEvents = 0;
            if (eventRs.next()) totalEvents = eventRs.getInt(1);

            // Get upcoming events count
            PreparedStatement upcomingStmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM events WHERE status = 'upcoming'");
            ResultSet upcomingRs = upcomingStmt.executeQuery();
            int upcomingEvents = 0;
            if (upcomingRs.next()) upcomingEvents = upcomingRs.getInt(1);

            // Get total registrations count
            PreparedStatement regStmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM event_registrations WHERE status = 'confirmed'");
            ResultSet regRs = regStmt.executeQuery();
            int totalRegistrations = 0;
            if (regRs.next()) totalRegistrations = regRs.getInt(1);

            // Get recent events list
            PreparedStatement recentStmt = conn.prepareStatement(
                "SELECT id, title, location, event_date, status FROM events " +
                "ORDER BY created_at DESC LIMIT 5");
            ResultSet recentRs = recentStmt.executeQuery();
            List<String[]> recentEvents = new ArrayList<>();
            while (recentRs.next()) {
                String[] row = {
                    recentRs.getString("id"),
                    recentRs.getString("title"),
                    recentRs.getString("location"),
                    recentRs.getString("event_date"),
                    recentRs.getString("status")
                };
                recentEvents.add(row);
            }

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalEvents", totalEvents);
            request.setAttribute("upcomingEvents", upcomingEvents);
            request.setAttribute("totalRegistrations", totalRegistrations);
            request.setAttribute("recentEvents", recentEvents);

        } catch (Exception e) {
            System.out.println("Admin dashboard error: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/adminDashboard.jsp")
               .forward(request, response);
    }
}