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
        String sql = "SELECT id, task_title, task_description, is_completed FROM volunteer_tasks WHERE assignment_id = ? ORDER BY created_at ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> t = new HashMap<>();
                t.put("id",               rs.getInt("id"));
                t.put("task_title",       rs.getString("task_title"));
                t.put("task_description", rs.getString("task_description"));
                t.put("is_completed",     rs.getInt("is_completed"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getTasksForAssignment: " + e.getMessage());
        }
        return list;
    }

    // ── Get ALL tasks grouped by assignment_id (admin, one query) ─
    public Map<Integer, List<Map<String, Object>>> getAllTasksByAssignment() {
        Map<Integer, List<Map<String, Object>>> result = new LinkedHashMap<>();
        String sql = "SELECT id, assignment_id, task_title, task_description, is_completed " +
                     "FROM volunteer_tasks ORDER BY assignment_id, created_at ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int aId = rs.getInt("assignment_id");
                Map<String, Object> t = new HashMap<>();
                t.put("id",               rs.getInt("id"));
                t.put("task_title",       rs.getString("task_title"));
                t.put("task_description", rs.getString("task_description"));
                t.put("is_completed",     rs.getInt("is_completed"));
                result.computeIfAbsent(aId, k -> new ArrayList<>()).add(t);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getAllTasksByAssignment: " + e.getMessage());
        }
        return result;
    }

    // ── Get all assignments with volunteer + event info (admin) ─
    public List<Map<String, Object>> getAllAssignments() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT va.id, va.status, va.assigned_at, " +
                     "u.id AS volunteer_id, u.full_name AS volunteer_name, u.email AS volunteer_email, " +
                     "e.id AS event_id, e.title AS event_title, e.event_date, e.location, " +
                     "(SELECT COUNT(*) FROM volunteer_tasks vt WHERE vt.assignment_id = va.id) AS task_count, " +
                     "(SELECT COUNT(*) FROM volunteer_tasks vt WHERE vt.assignment_id = va.id AND vt.is_completed = 1) AS completed_count " +
                     "FROM volunteer_assignments va " +
                     "JOIN users u ON va.volunteer_id = u.id " +
                     "JOIN events e ON va.event_id = e.id " +
                     "ORDER BY e.event_date DESC, u.full_name ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> a = new HashMap<>();
                a.put("id",              rs.getInt("id"));
                a.put("status",          rs.getString("status"));
                a.put("volunteer_id",    rs.getInt("volunteer_id"));
                a.put("volunteer_name",  rs.getString("volunteer_name"));
                a.put("volunteer_email", rs.getString("volunteer_email"));
                a.put("event_id",        rs.getInt("event_id"));
                a.put("event_title",     rs.getString("event_title"));
                a.put("event_date",      rs.getDate("event_date"));
                a.put("location",        rs.getString("location"));
                a.put("task_count",      rs.getInt("task_count"));
                a.put("completed_count", rs.getInt("completed_count"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] getAllAssignments: " + e.getMessage());
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
        try (Connection conn = DBConfig.getConnection()) {
            // Delete tasks first
            PreparedStatement taskPs = conn.prepareStatement(
                "DELETE FROM volunteer_tasks WHERE assignment_id = ?");
            taskPs.setInt(1, assignmentId);
            taskPs.executeUpdate();
            // Delete assignment
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM volunteer_assignments WHERE id = ?");
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] removeAssignment: " + e.getMessage());
            return false;
        }
    }

    // ── Add task to assignment ─────────────────────────────────
    public boolean addTask(int assignmentId, String taskTitle, String taskDescription) {
        String sql = "INSERT INTO volunteer_tasks (assignment_id, task_title, task_description) VALUES (?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ps.setString(2, taskTitle.trim());
            ps.setString(3, taskDescription != null ? taskDescription.trim() : "");
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] addTask: " + e.getMessage());
            return false;
        }
    }

    // ── Remove a task ──────────────────────────────────────────
    public boolean removeTask(int taskId) {
        String sql = "DELETE FROM volunteer_tasks WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] removeTask: " + e.getMessage());
            return false;
        }
    }

    // ── Update task completion ─────────────────────────────────
    public boolean updateTaskCompletion(int taskId, int completed) {
        String sql = "UPDATE volunteer_tasks SET is_completed = ? WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, completed);
            ps.setInt(2, taskId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VolunteerModel] updateTaskCompletion: " + e.getMessage());
            return false;
        }
    }
}