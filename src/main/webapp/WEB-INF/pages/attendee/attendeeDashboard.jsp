<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendee Dashboard - EventFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-container">

    <div class="sidebar">
        <div class="sidebar-header">
            <h2>EventFlow</h2>
            <p>Attendee Panel</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/attendee/dashboard" class="active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/attendee/events">Browse Events</a></li>
            <li><a href="${pageContext.request.contextPath}/attendee/myregistrations">My Registrations</a></li>
            <li><a href="${pageContext.request.contextPath}/attendee/profile">My Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <div class="main-content">

        <div class="page-header">
            <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
            <p>Browse and register for upcoming events.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalRegistrations") %></div>
                <div class="stat-label">My Registrations</div>
            </div>
        </div>

        <!-- Upcoming Events -->
        <div class="table-container" style="margin-bottom: 24px;">
            <h2>Upcoming Events</h2>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Capacity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> upcomingEvents = (List<String[]>) request.getAttribute("upcomingEvents");
                        if (upcomingEvents != null && !upcomingEvents.isEmpty()) {
                            for (String[] event : upcomingEvents) {
                    %>
                    <tr>
                        <td><%= event[1] %></td>
                        <td><%= event[2] %></td>
                        <td><%= event[3] %></td>
                        <td><%= event[4] %></td>
                        <td><%= event[5] %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align:center; color:#999;">No upcoming events.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- My Registrations -->
        <div class="table-container">
            <h2>My Registrations</h2>
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
                        List<String[]> myRegistrations = (List<String[]>) request.getAttribute("myRegistrations");
                        if (myRegistrations != null && !myRegistrations.isEmpty()) {
                            for (String[] reg : myRegistrations) {
                    %>
                    <tr>
                        <td><%= reg[0] %></td>
                        <td><%= reg[1] %></td>
                        <td><%= reg[2] %></td>
                        <td>
                            <span class="badge <%= reg[3].equals("confirmed") ? "badge-success" : "badge-danger" %>">
                                <%= reg[3] %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" style="text-align:center; color:#999;">You have not registered for any events yet.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>