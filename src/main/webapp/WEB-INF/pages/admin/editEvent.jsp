<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Event - EventFlow</title>
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

        <div class="page-header">
            <h1>Edit Event</h1>
            <p>Update the event details below.</p>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <%
            String[] event = (String[]) request.getAttribute("event");
        %>

        <div class="table-container">
            <form action="${pageContext.request.contextPath}/admin/editEvent" method="post">

                <input type="hidden" name="eventId" value="<%= event[0] %>">

                <div class="form-group">
                    <label>Event Title</label>
                    <input type="text" name="title" value="<%= event[1] %>" required>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4" required
                              style="width:100%; padding:10px 14px; border:1px solid #ddd;
                                     border-radius:8px; font-size:14px; resize:vertical;">
                        <%= event[2] %>
                    </textarea>
                </div>

                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="location" value="<%= event[3] %>" required>
                </div>

                <div class="form-group">
                    <label>Event Date</label>
                    <input type="date" name="eventDate" value="<%= event[4] %>" required>
                </div>

                <div class="form-group">
                    <label>Start Time</label>
                    <input type="time" name="startTime" value="<%= event[5] %>" required>
                </div>

                <div class="form-group">
                    <label>End Time</label>
                    <input type="time" name="endTime" value="<%= event[6] %>" required>
                </div>

                <div class="form-group">
                    <label>Capacity</label>
                    <input type="number" name="capacity" value="<%= event[7] %>" min="1" required>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="status" required>
                        <option value="upcoming" <%= event[8].equals("upcoming") ? "selected" : "" %>>Upcoming</option>
                        <option value="ongoing" <%= event[8].equals("ongoing") ? "selected" : "" %>>Ongoing</option>
                        <option value="completed" <%= event[8].equals("completed") ? "selected" : "" %>>Completed</option>
                        <option value="cancelled" <%= event[8].equals("cancelled") ? "selected" : "" %>>Cancelled</option>
                    </select>
                </div>

                <div style="display:flex; gap:12px; margin-top:10px;">
                    <button type="submit" class="btn-primary" style="width:auto; padding:10px 24px;">
                        Update Event
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/events"
                       class="btn-secondary" style="padding:10px 24px; text-decoration:none;">
                        Cancel
                    </a>
                </div>

            </form>
        </div>

    </div>
</div>

</body>
</html>