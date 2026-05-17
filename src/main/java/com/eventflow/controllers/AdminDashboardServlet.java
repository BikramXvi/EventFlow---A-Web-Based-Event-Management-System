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

	        int totalUsers = 0;
	        int totalEvents = 0;
	        int upcomingEvents = 0;
	        int totalRegistrations = 0;

	        // USERS
	        try (PreparedStatement stmt = conn.prepareStatement(
	                "SELECT COUNT(*) FROM users WHERE role != 'admin'");
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) totalUsers = rs.getInt(1);
	        }

	        // EVENTS
	        try (PreparedStatement stmt = conn.prepareStatement(
	                "SELECT COUNT(*) FROM events");
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) totalEvents = rs.getInt(1);
	        }

	        // UPCOMING EVENTS
	        try (PreparedStatement stmt = conn.prepareStatement(
	                "SELECT COUNT(*) FROM events WHERE status = 'upcoming'");
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) upcomingEvents = rs.getInt(1);
	        }

	        // REGISTRATIONS
	        try (PreparedStatement stmt = conn.prepareStatement(
	                "SELECT COUNT(*) FROM event_registrations WHERE status = 'confirmed'");
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) totalRegistrations = rs.getInt(1);
	        }

	        // RECENT EVENTS
	        List<String[]> recentEvents = new ArrayList<>();

	        try (PreparedStatement stmt = conn.prepareStatement(
	                "SELECT id, title, location, event_date, status FROM events " +
	                "ORDER BY created_at DESC LIMIT 5");
	             ResultSet rs = stmt.executeQuery()) {

	            while (rs.next()) {
	                recentEvents.add(new String[]{
	                        rs.getString("id"),
	                        rs.getString("title"),
	                        rs.getString("location"),
	                        rs.getString("event_date"),
	                        rs.getString("status")
	                });
	            }
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