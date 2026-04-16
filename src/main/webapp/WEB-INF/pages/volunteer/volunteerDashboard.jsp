<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Volunteer Dashboard - EventFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-container">

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>EventFlow</h2>
            <p>Volunteer Panel</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/volunteer/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/volunteer/assignments">My Assignments</a></li>
            <li><a href="${pageContext.request.contextPath}/volunteer/profile">My Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <div class="page-header">
            <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
            <p>View your event assignments and tasks.</p>
        </div>

        <!-- Stat Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalAssignments") %></div>
                <div class="stat-label">My Assignments</div>
            </div>
        </div>

        <!-- Assignments Table -->
        <div class="table-container" style="margin-bottom: 24px;">
            <h2>My Event Assignments</h2>
            <table>
                <thead>
                    <tr>
                        <th>Event</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> assignments = (List<String[]>) request.getAttribute("assignments");
                        if (assignments != null && !assignments.isEmpty()) {
                            for (String[] a : assignments) {
                    %>
                    <tr>
                        <td><%= a[0] %></td>
                        <td><%= a[1] %></td>
                        <td><%= a[2] %></td>
                        <td>
                            <span class="badge <%= a[3].equals("assigned") ? "badge-info" : 
                                a[3].equals("completed") ? "badge-success" : "badge-danger" %>">
                                <%= a[3] %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" style="text-align:center; color:#999;">No assignments yet.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Tasks Table -->
        <div class="table-container">
            <h2>My Tasks</h2>
            <table>
                <thead>
                    <tr>
                        <th>Task</th>
                        <th>Description</th>
                        <th>Event</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> tasks = (List<String[]>) request.getAttribute("tasks");
                        if (tasks != null && !tasks.isEmpty()) {
                            for (String[] t : tasks) {
                    %>
                    <tr>
                        <td><%= t[0] %></td>
                        <td><%= t[1] %></td>
                        <td><%= t[2] %></td>
                        <td>
                            <span class="badge <%= t[3].equals("0") ? "badge-warning" : "badge-success" %>">
                                <%= t[3].equals("0") ? "Pending" : "Completed" %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" style="text-align:center; color:#999;">No tasks assigned yet.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>