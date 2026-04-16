package com.eventflow.model;

import com.eventflow.config.DBConfig;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

/**
 * Handles all user-related database operations.
 * Used by login, register and profile servlets.
 */
public class UserModel {

    /**
     * Registers a new user.
     * Returns "success" or an error message string.
     */
    public String registerUser(String fullName, String email,
                                String phone, String password, String role) {
        if (emailExists(email)) {
            return "Email already registered. Please use a different email.";
        }
        if (phoneExists(phone)) {
            return "Phone number already registered. Please use a different number.";
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String query = "INSERT INTO users (full_name, email, phone, password, role) "
                     + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, hashedPassword);
            stmt.setString(5, role);
            stmt.executeUpdate();
            return "success";

        } catch (SQLException e) {
            System.out.println("Register error: " + e.getMessage());
            return "Something went wrong. Please try again.";
        }
    }

    /**
     * Validates login credentials.
     * Returns user ResultSet if valid, null if not.
     */
    public ResultSet loginUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND is_active = 1";

        try {
            Connection conn = DBConfig.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                if (rs.getInt("is_locked") == 1) {
                    return null;
                }
                if (BCrypt.checkpw(password, rs.getString("password"))) {
                    return rs;
                }
            }
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Records each login attempt.
     * Locks account after 5 failed attempts in 15 minutes.
     */
    public void recordLoginAttempt(String email, boolean success) {
        String query = "INSERT INTO login_attempts (email, is_successful) VALUES (?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setInt(2, success ? 1 : 0);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Login attempt error: " + e.getMessage());
        }

        if (!success) {
            checkAndLockAccount(email);
        }
    }

    /**
     * Locks account if 5 failed attempts within 15 minutes.
     */
    private void checkAndLockAccount(String email) {
        String query = "SELECT COUNT(*) FROM login_attempts "
                     + "WHERE email = ? AND is_successful = 0 "
                     + "AND attempt_time > DATE_SUB(NOW(), INTERVAL 15 MINUTE)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) >= 5) {
                lockAccount(email);
            }

        } catch (SQLException e) {
            System.out.println("Lock check error: " + e.getMessage());
        }
    }

    /**
     * Sets is_locked = 1 for the given email.
     */
    private void lockAccount(String email) {
        String query = "UPDATE users SET is_locked = 1 WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lock account error: " + e.getMessage());
        }
    }

    /**
     * Checks if email already exists in the database.
     */
    private boolean emailExists(String email) {
        String query = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            return false;
        }
    }

    /**
     * Checks if phone number already exists in the database.
     */
    private boolean phoneExists(String phone) {
        String query = "SELECT id FROM users WHERE phone = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, phone);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            return false;
        }
    }
}