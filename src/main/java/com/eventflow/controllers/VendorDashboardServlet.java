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
 * Loads data and forwards to vendor dashboard page.
 */
@WebServlet("/vendor/dashboard")
public class VendorDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBConfig.getConnection()) {

            // Get this vendor's applications
            PreparedStatement appStmt = conn.prepareStatement(
                "SELECT e.title, e.location, e.event_date, va.service_description, va.status " +
                "FROM vendor_applications va " +
                "JOIN events e ON va.event_id = e.id " +
                "WHERE va.vendor_id = ? ORDER BY va.applied_at DESC");
            appStmt.setInt(1, userId);
            ResultSet appRs = appStmt.executeQuery();
            List<String[]> applications = new ArrayList<>();
            while (appRs.next()) {
                String[] row = {
                    appRs.getString("title"),
                    appRs.getString("location"),
                    appRs.getString("event_date"),
                    appRs.getString("service_description"),
                    appRs.getString("status")
                };
                applications.add(row);
            }

            // Count by status
            int pending = 0, approved = 0, rejected = 0;
            for (String[] app : applications) {
                if (app[4].equals("pending")) pending++;
                else if (app[4].equals("approved")) approved++;
                else if (app[4].equals("rejected")) rejected++;
            }

            request.setAttribute("applications", applications);
            request.setAttribute("totalApplications", applications.size());
            request.setAttribute("pendingCount", pending);
            request.setAttribute("approvedCount", approved);
            request.setAttribute("rejectedCount", rejected);

        } catch (Exception e) {
            System.out.println("Vendor dashboard error: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/vendor/vendorDashboard.jsp")
               .forward(request, response);
    }
}