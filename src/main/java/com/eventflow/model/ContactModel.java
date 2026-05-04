package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;

public class ContactModel {

    public boolean saveMessage(String name, String email, String subject, String message) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, message);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[ContactModel] Error: " + e.getMessage());
            return false;
        }
    }
}