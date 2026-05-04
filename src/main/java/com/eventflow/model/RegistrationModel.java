package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.*;

public class RegistrationModel {

    // ── Register attendee for event ────────────────────────────
    public boolean register(int eventId, int userId) {
        String sql = "INSERT INTO event_registrations (event_id, user_id) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[RegistrationModel] register: " + e.getMessage());
            return false;
        }
    }

    // ── Cancel registration ────────────────────────────────────
    public boolean cancel(int registrationId, int userId) {
        String sql = "UPDATE event_registrations SET status = 'cancelled' WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, registrationId);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[RegistrationModel] cancel: " + e.getMessage());
            return false;
        }
    }

    // ── Check if already registered ───────────────────────────
    public boolean isRegistered(int eventId, int userId) {
        String sql = "SELECT id FROM event_registrations WHERE event_id = ? AND user_id = ? AND status = 'confirmed'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, userId);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            System.err.println("[RegistrationModel] isRegistered: " + e.getMessage());
            return false;
        }
    }

    // ── Get all registrations for a user ──────────────────────
    public List<Map<String, Object>> getMyRegistrations(int userId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT er.id, er.registration_date, er.status, " +
                     "e.title, e.location, e.event_date, e.start_time, e.status AS event_status " +
                     "FROM event_registrations er " +
                     "JOIN events e ON er.event_id = e.id " +
                     "WHERE er.user_id = ? ORDER BY er.registration_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> r = new HashMap<>();
                r.put("id",                rs.getInt("id"));
                r.put("registration_date", rs.getTimestamp("registration_date"));
                r.put("status",            rs.getString("status"));
                r.put("title",             rs.getString("title"));
                r.put("location",          rs.getString("location"));
                r.put("event_date",        rs.getDate("event_date"));
                r.put("start_time",        rs.getTime("start_time"));
                r.put("event_status",      rs.getString("event_status"));
                list.add(r);
            }
        } catch (SQLException e) {
            System.err.println("[RegistrationModel] getMyRegistrations: " + e.getMessage());
        }
        return list;
    }

    // ── Get all available events for attendee ──────────────────
    public List<Map<String, Object>> getAvailableEvents(int userId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT e.id, e.title, e.description, e.location, e.event_date, e.start_time, e.end_time, e.capacity, e.status, " +
                     "(SELECT COUNT(*) FROM event_registrations WHERE event_id = e.id AND status = 'confirmed') AS registered_count, " +
                     "(SELECT COUNT(*) FROM event_registrations WHERE event_id = e.id AND user_id = ? AND status = 'confirmed') AS is_registered " +
                     "FROM events e WHERE e.status != 'cancelled' ORDER BY e.event_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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
                e.put("registered_count", rs.getInt("registered_count"));
                e.put("is_registered",    rs.getInt("is_registered") > 0);
                list.add(e);
            }
        } catch (SQLException e) {
            System.err.println("[RegistrationModel] getAvailableEvents: " + e.getMessage());
        }
        return list;
    }
}