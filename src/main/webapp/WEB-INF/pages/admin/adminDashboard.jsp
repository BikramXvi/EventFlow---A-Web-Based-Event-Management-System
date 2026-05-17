<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard — EventFlow</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("breadcrumbCurrent", "Dashboard"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAdmin.jsp" %>

  <!-- Main Content -->
  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Welcome, <%= session.getAttribute("userFullName") != null ? session.getAttribute("userFullName") : session.getAttribute("userName") %></h1>
          <p>Here is what is happening with your events today.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/createEvent" class="btn-secondary">+ Create Event</a>
      </div>

      <!-- Stat Cards -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-label">Total Events</div>
          <div class="stat-number"><%= request.getAttribute("totalEvents") != null ? request.getAttribute("totalEvents") : 0 %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Upcoming Events</div>
          <div class="stat-number"><%= request.getAttribute("upcomingEvents") != null ? request.getAttribute("upcomingEvents") : 0 %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Registered Users</div>
          <div class="stat-number"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %></div>
        </div>
        <div class="stat-card">
          <div class="stat-label">Total Registrations</div>
          <div class="stat-number"><%= request.getAttribute("totalRegistrations") != null ? request.getAttribute("totalRegistrations") : 0 %></div>
        </div>
      </div>

      <!-- Recent Events Table -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Recent Events</span>
          <a href="${pageContext.request.contextPath}/admin/events" class="btn-secondary">View all</a>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Title</th>
              <th>Location</th>
              <th>Date</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
                List<String[]> recentEvents = (List<String[]>) request.getAttribute("recentEvents");
                if (recentEvents != null && !recentEvents.isEmpty()) {
                    int idx = 1;
                    for (String[] event : recentEvents) {
                        String badgeClass = event[4].equals("upcoming") ? "badge-info"
                                          : event[4].equals("ongoing")   ? "badge-success"
                                          : event[4].equals("completed") ? "badge-warning"
                                          : "badge-danger";
            %>
            <tr>
              <td class="td-hint"><%= idx++ %></td>
              <td class="td-primary"><%= event[1] %></td>
              <td class="td-secondary"><%= event[2] %></td>
              <td class="td-secondary"><%= event[3] %></td>
              <td><span class="badge <%= badgeClass %>"><%= event[4] %></span></td>
              <td>
<a href="${pageContext.request.contextPath}/admin/editEvent?id=<%= event[0] %>">
    Edit
</a>
        </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
              <td colspan="6" style="text-align:center;color:var(--text-ghost);padding:24px">No events yet. <a href="${pageContext.request.contextPath}/admin/createEvent" style="color:var(--text-mid)">Create one →</a></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>
</body>
</html>
