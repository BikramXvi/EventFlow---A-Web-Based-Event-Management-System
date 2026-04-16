<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - EventFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-container">

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>EventFlow</h2>
            <p>Admin Panel</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/events">Manage Events</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/volunteers">Manage Volunteers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/vendors">Manage Vendors</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <div class="page-header">
            <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
            <p>Here is what is happening with your events today.</p>
        </div>

        <!-- Stat Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalEvents") %></div>
                <div class="stat-label">Total Events</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("upcomingEvents") %></div>
                <div class="stat-label">Upcoming Events</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalUsers") %></div>
                <div class="stat-label">Registered Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalRegistrations") %></div>
                <div class="stat-label">Total Registrations</div>
            </div>
        </div>

        <!-- Recent Events Table -->
        <div class="table-container">
            <h2>Recent Events</h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> recentEvents = (List<String[]>) request.getAttribute("recentEvents");
                        if (recentEvents != null && !recentEvents.isEmpty()) {
                            for (String[] event : recentEvents) {
                    %>
                    <tr>
                        <td><%= event[0] %></td>
                        <td><%= event[1] %></td>
                        <td><%= event[2] %></td>
                        <td><%= event[3] %></td>
                        <td>
                            <span class="badge 
                                <%= event[4].equals("upcoming") ? "badge-info" : 
                                    event[4].equals("ongoing") ? "badge-success" :
                                    event[4].equals("completed") ? "badge-warning" : "badge-danger" %>">
                                <%= event[4] %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center; color:#999;">No events found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>