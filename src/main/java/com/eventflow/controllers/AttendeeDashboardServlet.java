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
 * Loads data and forwards to attendee dashboard page.
 */
@WebServlet("/attendee/dashboard")
public class AttendeeDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBConfig.getConnection()) {

            // Get all upcoming events
            PreparedStatement eventsStmt = conn.prepareStatement(
                "SELECT id, title, location, event_date, start_time, capacity " +
                "FROM events WHERE status = 'upcoming' ORDER BY event_date ASC");
            ResultSet eventsRs = eventsStmt.executeQuery();
            List<String[]> upcomingEvents = new ArrayList<>();
            while (eventsRs.next()) {
                String[] row = {
                    eventsRs.getString("id"),
                    eventsRs.getString("title"),
                    eventsRs.getString("location"),
                    eventsRs.getString("event_date"),
                    eventsRs.getString("start_time"),
                    eventsRs.getString("capacity")
                };
                upcomingEvents.add(row);
            }

            // Get this attendee's registrations
            PreparedStatement myRegStmt = conn.prepareStatement(
                "SELECT e.title, e.location, e.event_date, er.status " +
                "FROM event_registrations er " +
                "JOIN events e ON er.event_id = e.id " +
                "WHERE er.user_id = ? ORDER BY e.event_date ASC");
            myRegStmt.setInt(1, userId);
            ResultSet myRegRs = myRegStmt.executeQuery();
            List<String[]> myRegistrations = new ArrayList<>();
            while (myRegRs.next()) {
                String[] row = {
                    myRegRs.getString("title"),
                    myRegRs.getString("location"),
                    myRegRs.getString("event_date"),
                    myRegRs.getString("status")
                };
                myRegistrations.add(row);
            }

            request.setAttribute("upcomingEvents", upcomingEvents);
            request.setAttribute("myRegistrations", myRegistrations);
            request.setAttribute("totalRegistrations", myRegistrations.size());

        } catch (Exception e) {
            System.out.println("Attendee dashboard error: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/attendee/attendeeDashboard.jsp")
               .forward(request, response);
    }
}