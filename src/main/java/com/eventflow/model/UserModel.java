package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.*;

public class UserModel {

    // ── Get all users (admin) ──────────────────────────────────
    public List<Map<String, Object>> getAllUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT id, full_name, email, phone, role, is_active, is_locked, created_at FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id",         rs.getInt("id"));
                u.put("full_name",  rs.getString("full_name"));
                u.put("email",      rs.getString("email"));
                u.put("phone",      rs.getString("phone"));
                u.put("role",       rs.getString("role"));
                u.put("is_active",  rs.getInt("is_active"));
                u.put("is_locked",  rs.getInt("is_locked"));
                u.put("created_at", rs.getTimestamp("created_at"));
                users.add(u);
            }
        } catch (SQLException e) {
            System.err.println("[UserModel] getAllUsers: " + e.getMessage());
        }
        return users;
    }

    // ── Get users by role ──────────────────────────────────────
    public List<Map<String, Object>> getUsersByRole(String role) {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT id, full_name, email, phone, is_active, is_locked, created_at FROM users WHERE role = ? ORDER BY created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id",         rs.getInt("id"));
                u.put("full_name",  rs.getString("full_name"));
                u.put("email",      rs.getString("email"));
                u.put("phone",      rs.getString("phone"));
                u.put("is_active",  rs.getInt("is_active"));
                u.put("is_locked",  rs.getInt("is_locked"));
                u.put("created_at", rs.getTimestamp("created_at"));
                users.add(u);
            }
        } catch (SQLException e) {
            System.err.println("[UserModel] getUsersByRole: " + e.getMessage());
        }
        return users;
    }

    // ── Get single user by ID ──────────────────────────────────
    public Map<String, Object> getUserById(int id) {
        String sql = "SELECT id, full_name, email, phone, role, is_active, is_locked, created_at FROM users WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id",         rs.getInt("id"));
                u.put("full_name",  rs.getString("full_name"));
                u.put("email",      rs.getString("email"));
                u.put("phone",      rs.getString("phone"));
                u.put("role",       rs.getString("role"));
                u.put("is_active",  rs.getInt("is_active"));
                u.put("is_locked",  rs.getInt("is_locked"));
                u.put("created_at", rs.getTimestamp("created_at"));
                return u;
            }
        } catch (SQLException e) {
            System.err.println("[UserModel] getUserById: " + e.getMessage());
        }
        return null;
    }

    // ── Toggle active status ───────────────────────────────────
    public boolean toggleActive(int id) {
        String sql = "UPDATE users SET is_active = 1 - is_active WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[UserModel] toggleActive: " + e.getMessage());
            return false;
        }
    }

    // ── Toggle locked status ───────────────────────────────────
    public boolean toggleLocked(int id) {
        String sql = "UPDATE users SET is_locked = 1 - is_locked WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[UserModel] toggleLocked: " + e.getMessage());
            return false;
        }
    }

    // ── Delete user ────────────────────────────────────────────
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[UserModel] deleteUser: " + e.getMessage());
            return false;
        }
    }

    // ── Update profile ─────────────────────────────────────────
    public boolean updateProfile(int id, String fullName, String phone) {
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[UserModel] updateProfile: " + e.getMessage());
            return false;
        }
    }

    // ── Get user by email (used by LoginServlet) ───────────────
    public Map<String, Object> getUserByEmail(String email) {
        String sql = "SELECT id, full_name, email, password, role, is_active, is_locked FROM users WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id",        rs.getInt("id"));
                u.put("full_name", rs.getString("full_name"));
                u.put("email",     rs.getString("email"));
                u.put("password",  rs.getString("password"));
                u.put("role",      rs.getString("role"));
                u.put("is_active", rs.getInt("is_active"));
                u.put("is_locked", rs.getInt("is_locked"));
                return u;
            }
        } catch (SQLException e) {
            System.err.println("[UserModel] getUserByEmail: " + e.getMessage());
        }
        return null;
    }

    // ── Register new user ──────────────────────────────────────
    public boolean registerUser(String fullName, String email, String phone, String hashedPassword, String role) {
        String sql = "INSERT INTO users (full_name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, hashedPassword);
            ps.setString(5, role);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[UserModel] registerUser: " + e.getMessage());
            return false;
        }
    }

    // ── Check email exists ─────────────────────────────────────
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            System.err.println("[UserModel] emailExists: " + e.getMessage());
            return false;
        }
    }

    // ── Record login attempt ───────────────────────────────────
    public void recordLoginAttempt(String email, boolean success) {
        String sql = "INSERT INTO login_attempts (email, is_successful) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setBoolean(2, success);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[UserModel] recordLoginAttempt: " + e.getMessage());
        }
    }

    // ── Check if account is locked due to failed attempts ──────
    public boolean isLockedByAttempts(String email) {
        String sql = "SELECT COUNT(*) FROM login_attempts " +
                     "WHERE email = ? AND is_successful = 0 " +
                     "AND attempt_time >= NOW() - INTERVAL 15 MINUTE";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) >= 5;
            }
        } catch (SQLException e) {
            System.err.println("[UserModel] isLockedByAttempts: " + e.getMessage());
        }
        return false;
    }

    // ── Lock user account ──────────────────────────────────────
    public void lockUser(String email) {
        String sql = "UPDATE users SET is_locked = 1 WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[UserModel] lockUser: " + e.getMessage());
        }
    }
}