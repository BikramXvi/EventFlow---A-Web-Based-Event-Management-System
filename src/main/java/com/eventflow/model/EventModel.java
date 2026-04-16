package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles all event-related database operations.
 * Used by admin event management servlets.
 */
public class EventModel {

    /**
     * Returns all events from the database.
     */
    public List<String[]> getAllEvents() {
        List<String[]> events = new ArrayList<>();
        String query = "SELECT e.id, e.title, e.location, e.event_date, "
                     + "e.start_time, e.end_time, e.capacity, e.status, "
                     + "u.full_name as created_by "
                     + "FROM events e "
                     + "JOIN users u ON e.created_by = u.id "
                     + "ORDER BY e.event_date ASC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String[] row = {
                    rs.getString("id"),
                    rs.getString("title"),
                    rs.getString("location"),
                    rs.getString("event_date"),
                    rs.getString("start_time"),
                    rs.getString("end_time"),
                    rs.getString("capacity"),
                    rs.getString("status"),
                    rs.getString("created_by")
                };
                events.add(row);
            }

        } catch (SQLException e) {
            System.out.println("Get all events error: " + e.getMessage());
        }
        return events;
    }

    /**
     * Returns a single event by its ID.
     */
    public String[] getEventById(int id) {
        String query = "SELECT * FROM events WHERE id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new String[] {
                    rs.getString("id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("location"),
                    rs.getString("event_date"),
                    rs.getString("start_time"),
                    rs.getString("end_time"),
                    rs.getString("capacity"),
                    rs.getString("status")
                };
            }

        } catch (SQLException e) {
            System.out.println("Get event by id error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Creates a new event in the database.
     */
    public boolean createEvent(String title, String description, String location,
                                String eventDate, String startTime, String endTime,
                                int capacity, int createdBy) {
        String query = "INSERT INTO events (title, description, location, event_date, "
                     + "start_time, end_time, capacity, created_by) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, eventDate);
            stmt.setString(5, startTime);
            stmt.setString(6, endTime);
            stmt.setInt(7, capacity);
            stmt.setInt(8, createdBy);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Create event error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing event by ID.
     */
    public boolean updateEvent(int id, String title, String description,
                                String location, String eventDate, String startTime,
                                String endTime, int capacity, String status) {
        String query = "UPDATE events SET title=?, description=?, location=?, "
                     + "event_date=?, start_time=?, end_time=?, capacity=?, status=? "
                     + "WHERE id=?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, eventDate);
            stmt.setString(5, startTime);
            stmt.setString(6, endTime);
            stmt.setInt(7, capacity);
            stmt.setString(8, status);
            stmt.setInt(9, id);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Update event error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes an event by ID.
     * Also deletes related registrations, assignments and applications first.
     */
    public boolean deleteEvent(int id) {
        try (Connection conn = DBConfig.getConnection()) {

            // Delete related tasks first
            PreparedStatement taskStmt = conn.prepareStatement(
                "DELETE vt FROM volunteer_tasks vt " +
                "JOIN volunteer_assignments va ON vt.assignment_id = va.id " +
                "WHERE va.event_id = ?");
            taskStmt.setInt(1, id);
            taskStmt.executeUpdate();

            // Delete volunteer assignments
            PreparedStatement assignStmt = conn.prepareStatement(
                "DELETE FROM volunteer_assignments WHERE event_id = ?");
            assignStmt.setInt(1, id);
            assignStmt.executeUpdate();

            // Delete registrations
            PreparedStatement regStmt = conn.prepareStatement(
                "DELETE FROM event_registrations WHERE event_id = ?");
            regStmt.setInt(1, id);
            regStmt.executeUpdate();

            // Delete vendor applications
            PreparedStatement vendorStmt = conn.prepareStatement(
                "DELETE FROM vendor_applications WHERE event_id = ?");
            vendorStmt.setInt(1, id);
            vendorStmt.executeUpdate();

            // Finally delete the event
            PreparedStatement eventStmt = conn.prepareStatement(
                "DELETE FROM events WHERE id = ?");
            eventStmt.setInt(1, id);
            return eventStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Delete event error: " + e.getMessage());
            return false;
        }
    }
}