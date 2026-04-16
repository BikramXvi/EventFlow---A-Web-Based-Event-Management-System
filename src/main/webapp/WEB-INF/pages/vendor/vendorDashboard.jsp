<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard - EventFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-container">

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>EventFlow</h2>
            <p>Vendor Panel</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/vendor/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/vendor/apply">Apply for Event</a></li>
            <li><a href="${pageContext.request.contextPath}/vendor/applications">My Applications</a></li>
            <li><a href="${pageContext.request.contextPath}/vendor/profile">My Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <div class="page-header">
            <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
            <p>Manage your event applications here.</p>
        </div>

        <!-- Stat Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalApplications") %></div>
                <div class="stat-label">Total Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("pendingCount") %></div>
                <div class="stat-label">Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("approvedCount") %></div>
                <div class="stat-label">Approved</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("rejectedCount") %></div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>

        <!-- Applications Table -->
        <div class="table-container">
            <h2>My Applications</h2>
            <table>
                <thead>
                    <tr>
                        <th>Event</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Service</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> applications = (List<String[]>) request.getAttribute("applications");
                        if (applications != null && !applications.isEmpty()) {
                            for (String[] app : applications) {
                    %>
                    <tr>
                        <td><%= app[0] %></td>
                        <td><%= app[1] %></td>
                        <td><%= app[2] %></td>
                        <td><%= app[3] %></td>
                        <td>
                            <span class="badge
                                <%= app[4].equals("approved") ? "badge-success" :
                                    app[4].equals("pending") ? "badge-warning" : "badge-danger" %>">
                                <%= app[4] %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center; color:#999;">No applications yet.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>