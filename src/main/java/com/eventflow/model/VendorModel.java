package com.eventflow.model;

import com.eventflow.config.DBConfig;
import java.sql.*;
import java.util.*;

public class VendorModel {

    // ── Get all vendor applications (admin) ────────────────────
    public List<Map<String, Object>> getAllApplications() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT va.id, va.status, va.applied_at, " +
                     "u.full_name, u.email, u.phone, " +
                     "e.title AS event_title, e.event_date " +
                     "FROM vendor_applications va " +
                     "JOIN users u ON va.vendor_id = u.id " +
                     "JOIN events e ON va.event_id = e.id " +
                     "ORDER BY va.applied_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> a = new HashMap<>();
                a.put("id",          rs.getInt("id"));
                a.put("status",      rs.getString("status"));
                a.put("applied_at",  rs.getTimestamp("applied_at"));
                a.put("full_name",   rs.getString("full_name"));
                a.put("email",       rs.getString("email"));
                a.put("phone",       rs.getString("phone"));
                a.put("event_title", rs.getString("event_title"));
                a.put("event_date",  rs.getDate("event_date"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println("[VendorModel] getAllApplications: " + e.getMessage());
        }
        return list;
    }

    // ── Get all vendors list (admin) ───────────────────────────
	    public List<Map<String, Object>> getAllVendors() {
	        List<Map<String, Object>> list = new ArrayList<>();
	        String sql = "SELECT u.id, u.full_name, u.email, u.phone, u.is_active, " +
	                     "(SELECT COUNT(*) FROM vendor_applications WHERE vendor_id = u.id) AS application_count " +
	                     "FROM users u WHERE u.role = 'vendor' ORDER BY u.full_name ASC";
	        try (Connection conn = DBConfig.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Map<String, Object> v = new HashMap<>();
	                v.put("id",                rs.getInt("id"));
	                v.put("full_name",         rs.getString("full_name"));
	                v.put("email",             rs.getString("email"));
	                v.put("phone",             rs.getString("phone"));
	                v.put("is_active",         rs.getInt("is_active"));
	                v.put("application_count", rs.getInt("application_count"));
	                list.add(v);
	            }
	        } catch (SQLException e) {
	            System.err.println("[VendorModel] getAllVendors: " + e.getMessage());
	        }
	        return list;
	    }

    // ── Get my applications (vendor) ───────────────────────────
    public List<Map<String, Object>> getMyApplications(int vendorId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT va.id, va.status, va.applied_at, " +
                     "e.title, e.location, e.event_date, e.status AS event_status " +
                     "FROM vendor_applications va " +
                     "JOIN events e ON va.event_id = e.id " +
                     "WHERE va.vendor_id = ? ORDER BY va.applied_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vendorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> a = new HashMap<>();
                a.put("id",           rs.getInt("id"));
                a.put("status",       rs.getString("status"));
                a.put("applied_at",   rs.getTimestamp("applied_at"));
                a.put("title",        rs.getString("title"));
                a.put("location",     rs.getString("location"));
                a.put("event_date",   rs.getDate("event_date"));
                a.put("event_status", rs.getString("event_status"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println("[VendorModel] getMyApplications: " + e.getMessage());
        }
        return list;
    }

    public boolean apply(int eventId, int vendorId, String serviceDescription) {
        String sql = "INSERT INTO vendor_applications (event_id, vendor_id, service_description) VALUES (?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, vendorId);
            ps.setString(3, serviceDescription);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VendorModel] apply: " + e.getMessage());
            return false;
        }
    }

    // ── Update application status (admin) ─────────────────────
    public boolean updateStatus(int applicationId, String status) {
        String sql = "UPDATE vendor_applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("[VendorModel] updateStatus: " + e.getMessage());
            return false;
        }
    }
}