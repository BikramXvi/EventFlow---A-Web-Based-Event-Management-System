<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - EventFlow</title>
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
            <h1>Create New Event</h1>
            <p>Fill in the details below to create a new event.</p>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <div class="table-container">
            <form action="${pageContext.request.contextPath}/admin/createEvent" method="post">

                <div class="form-group">
                    <label>Event Title</label>
                    <input type="text" name="title" placeholder="Enter event title" required>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4"
                              placeholder="Enter event description" required
                              style="width:100%; padding:10px 14px; border:1px solid #ddd;
                                     border-radius:8px; font-size:14px; resize:vertical;">
                    </textarea>
                </div>

                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="location" placeholder="Enter event location" required>
                </div>

                <div class="form-group">
                    <label>Event Date</label>
                    <input type="date" name="eventDate" required>
                </div>

                <div class="form-group">
                    <label>Start Time</label>
                    <input type="time" name="startTime" required>
                </div>

                <div class="form-group">
                    <label>End Time</label>
                    <input type="time" name="endTime" required>
                </div>

                <div class="form-group">
                    <label>Capacity</label>
                    <input type="number" name="capacity" placeholder="Max attendees" min="1" required>
                </div>

                <div style="display:flex; gap:12px; margin-top:10px;">
                    <button type="submit" class="btn-primary" style="width:auto; padding:10px 24px;">
                        Create Event
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