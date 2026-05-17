package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.*;
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
            int capacity, String status, int createdBy, String imagePath) {
String query = "INSERT INTO events (title, description, image_path, location, event_date, " +
    "start_time, end_time, capacity, status, created_by) " +
    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

try (Connection conn = DBConfig.getConnection();
PreparedStatement stmt = conn.prepareStatement(query)) {

stmt.setString(1, title);
stmt.setString(2, description);
stmt.setString(3, imagePath);   // null is fine — stored as NULL
stmt.setString(4, location);
stmt.setString(5, eventDate);
stmt.setString(6, startTime);
stmt.setString(7, endTime);
stmt.setInt(8, capacity);
stmt.setString(9, status);
stmt.setInt(10, createdBy);

return stmt.executeUpdate() > 0;

} catch (SQLException e) {
System.out.println("Create event error: " + e.getMessage());
return false;
}
}

    /**
     * Updates an existing event by ID.
     */
    public boolean updateEvent(int id,
            String title,
            String description,
            String location,
            String eventDate,
            String startTime,
            String endTime,
            int capacity,
            String status,
            String imagePath) {
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
    
    // ── Public events list (with optional filter + search) ────
    public List<Map<String, Object>> getPublicEvents(String filter, String search) {
        List<Map<String, Object>> list = new ArrayList<>();
 
        StringBuilder sql = new StringBuilder(
            "SELECT e.id, e.title, e.description, e.location, e.event_date, " +
            "e.start_time, e.end_time, e.capacity, e.status, e.image_path, " +
            "u.full_name AS organizer, " +
            "(SELECT COUNT(*) FROM event_registrations WHERE event_id = e.id AND status = 'confirmed') AS registered_count " +
            "FROM events e JOIN users u ON e.created_by = u.id " +
            "WHERE e.status != 'cancelled' "
        );
 
        List<Object> params = new ArrayList<>();
 
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (e.title LIKE ? OR e.description LIKE ? OR e.location LIKE ?) ");
            String like = "%" + search.trim() + "%";
            params.add(like); params.add(like); params.add(like);
        }
 
        if (filter != null) {
            switch (filter) {
                case "upcoming":  sql.append("AND e.status = 'upcoming' ");  break;
                case "ongoing":   sql.append("AND e.status = 'ongoing' ");   break;
                case "free":      sql.append("AND e.status != 'completed' "); break;
                case "this_week":
                    sql.append("AND e.event_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) ");
                    break;
            }
        }
 
        sql.append("ORDER BY e.event_date ASC");
 
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
 
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
 
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> e = new HashMap<>();
                e.put("id",               rs.getInt("id"));
                e.put("title",            rs.getString("title"));
                e.put("description",      rs.getString("description"));
                e.put("location",         rs.getString("location"));
                e.put("event_date",       rs.getDate("event_date"));
                e.put("start_time",       rs.getTime("start_time"));
                e.put("end_time",         rs.getTime("end_time"));
                e.put("capacity",         rs.getInt("capacity"));
                e.put("status",           rs.getString("status"));
                e.put("image_path",       rs.getString("image_path"));
                e.put("organizer",        rs.getString("organizer"));
                e.put("registered_count", rs.getInt("registered_count"));
                list.add(e);
            }
        } catch (SQLException e) {
            System.err.println("[EventModel] getPublicEvents: " + e.getMessage());
        }
        return list;
    }
 
    // ── Featured event — most upcoming with most registrations ─
    public Map<String, Object> getFeaturedEvent() {
        String sql =
            "SELECT e.id, e.title, e.description, e.location, e.event_date, " +
            "e.start_time, e.end_time, e.capacity, e.status, e.image_path, " +
            "u.full_name AS organizer, " +
            "(SELECT COUNT(*) FROM event_registrations WHERE event_id = e.id AND status = 'confirmed') AS registered_count " +
            "FROM events e JOIN users u ON e.created_by = u.id " +
            "WHERE e.status IN ('upcoming', 'ongoing') " +
            "ORDER BY registered_count DESC, e.event_date ASC " +
            "LIMIT 1";
 
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
 
            if (rs.next()) {
                Map<String, Object> e = new HashMap<>();
                e.put("id",               rs.getInt("id"));
                e.put("title",            rs.getString("title"));
                e.put("description",      rs.getString("description"));
                e.put("location",         rs.getString("location"));
                e.put("event_date",       rs.getDate("event_date"));
                e.put("start_time",       rs.getTime("start_time"));
                e.put("end_time",         rs.getTime("end_time"));
                e.put("capacity",         rs.getInt("capacity"));
                e.put("status",           rs.getString("status"));
                e.put("image_path",       rs.getString("image_path"));
                e.put("organizer",        rs.getString("organizer"));
                e.put("registered_count", rs.getInt("registered_count"));
                return e;
            }
        } catch (SQLException e) {
            System.err.println("[EventModel] getFeaturedEvent: " + e.getMessage());
        }
        return null;
    }
 
    // ── Update image_path for an event (called after upload) ──
    public boolean updateImagePath(int eventId, String imagePath) {
        String sql = "UPDATE events SET image_path = ? WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, eventId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[EventModel] updateImagePath: " + e.getMessage());
            return false;
        }
    }
}