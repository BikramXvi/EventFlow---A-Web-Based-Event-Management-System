package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.*;

public class VolunteerModel {

    // ── Get all volunteers (admin) ─────────────────────────────
    public List<Map<String, Object>> getAllVolunteers() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT u.id, u.full_name, u.email, u.phone, u.is_active, " +
                     "(SELECT COUNT(*) FROM volunteer_assignments WHERE volunteer_id = u.id) AS assignment_count " +
                     "FROM users u WHERE u.role = 'volunteer' ORDER BY u.full_name ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> v = new HashMap<>();
                v.put("id",               rs.getInt("id"));
                v.put("full_name",        rs.getString("full_name"));
                v.put("email",            rs.getString("email"));
                v.put("phone",            rs.getString("phone"));
                v.put("is_active",        rs.getInt("is_active"));
                v.put("assignment_count", rs.getInt("assignment_count"));
                list.add(v);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getAllVolunteers: " + e.getMessage());
        }
        return list;
    }

    // ── Get my assignments (volunteer) ─────────────────────────
    public List<Map<String, Object>> getMyAssignments(int volunteerId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT va.id, va.status AS assignment_status, " +
                     "e.title, e.location, e.event_date, e.start_time, e.status AS event_status " +
                     "FROM volunteer_assignments va " +
                     "JOIN events e ON va.event_id = e.id " +
                     "WHERE va.volunteer_id = ? ORDER BY e.event_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, volunteerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> a = new HashMap<>();
                a.put("id",                rs.getInt("id"));
                a.put("assignment_status", rs.getString("assignment_status"));
                a.put("title",             rs.getString("title"));
                a.put("location",          rs.getString("location"));
                a.put("event_date",        rs.getDate("event_date"));
                a.put("start_time",        rs.getTime("start_time"));
                a.put("event_status",      rs.getString("event_status"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getMyAssignments: " + e.getMessage());
        }
        return list;
    }

    // ── Get tasks for an assignment ────────────────────────────
    public List<Map<String, Object>> getTasksForAssignment(int assignmentId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT id, task_title, is_completed FROM volunteer_tasks WHERE assignment_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> t = new HashMap<>();
                t.put("id",           rs.getInt("id"));
                t.put("task_title",   rs.getString("task_title"));
                t.put("is_completed", rs.getInt("is_completed"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getTasksForAssignment: " + e.getMessage());
        }
        return list;
    }

    // ── Assign volunteer to event (admin) ──────────────────────
    public boolean assignVolunteer(int eventId, int volunteerId) {
        String sql = "INSERT INTO volunteer_assignments (event_id, volunteer_id) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, volunteerId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] assignVolunteer: " + e.getMessage());
            return false;
        }
    }

    // ── Remove assignment (admin) ──────────────────────────────
    public boolean removeAssignment(int assignmentId) {
        String sql = "DELETE FROM volunteer_assignments WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] removeAssignment: " + e.getMessage());
            return false;
        }
    }
}