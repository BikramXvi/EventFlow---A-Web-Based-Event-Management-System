package com.eventflow.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Central database configuration class.
 * All models use getConnection() to get a MySQL connection.
 */
public class DBConfig {

    private static final String URL = 
        "jdbc:mysql://localhost:3306/event_management_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * Returns a live connection to the database.
     * Always close this after use.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL driver not found.");
        }
    }
}