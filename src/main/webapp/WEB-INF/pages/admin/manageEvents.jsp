<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Events - EventFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-container">

    <div class="sidebar">
        <div class="sidebar-header">
            <h2>EventFlow</h2>
            <p>Admin Panel</p>
        </div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/events" class="active">Manage Events</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/volunteers">Manage Volunteers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/vendors">Manage Vendors</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>

    <div class="main-content">

        <div class="page-header" style="display:flex; justify-content:space-between; align-items:center;">
            <div>
                <h1>Manage Events</h1>
                <p>Create, edit and delete events.</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/createEvent" class="btn-primary"
               style="width:auto; padding: 10px 20px; text-decoration:none;">
                + Create New Event
            </a>
        </div>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("success") %></div>
        <% } %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Capacity</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> events = (List<String[]>) request.getAttribute("events");
                        if (events != null && !events.isEmpty()) {
                            for (String[] event : events) {
                    %>
                    <tr>
                        <td><%= event[0] %></td>
                        <td><%= event[1] %></td>
                        <td><%= event[2] %></td>
                        <td><%= event[3] %></td>
                        <td><%= event[6] %></td>
                        <td>
                            <span class="badge
                                <%= event[7].equals("upcoming") ? "badge-info" :
                                    event[7].equals("ongoing") ? "badge-success" :
                                    event[7].equals("completed") ? "badge-warning" : "badge-danger" %>">
                                <%= event[7] %>
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/editEvent?id=<%= event[0] %>"
                               class="btn-secondary" style="text-decoration:none; margin-right:6px;">
                                Edit
                            </a>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/admin/events"
                                  style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this event?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="eventId" value="<%= event[0] %>">
                                <button type="submit" class="btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align:center; color:#999;">No events found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>