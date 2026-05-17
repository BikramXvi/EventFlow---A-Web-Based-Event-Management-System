<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("attendee")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Attendee Dashboard — EventFlow</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("breadcrumbCurrent", "Dashboard"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAttendee.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
          <p>Browse and register for upcoming events.</p>
        </div>
        <a href="${pageContext.request.contextPath}/attendee/events" class="btn-secondary">Browse Events</a>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-label">My Registrations</div>
          <div class="stat-number"><%= request.getAttribute("totalRegistrations") != null ? request.getAttribute("totalRegistrations") : 0 %></div>
        </div>
      </div>

      <!-- Upcoming Events -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Upcoming Events</span>
          <a href="${pageContext.request.contextPath}/attendee/events" class="btn-secondary">Browse all</a>
        </div>
        <table>
          <thead>
            <tr>
              <th>Title</th>
              <th>Location</th>
              <th>Date</th>
              <th>Time</th>
              <th>Capacity</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <%
                List<String[]> upcomingEvents = (List<String[]>) request.getAttribute("upcomingEvents");
                if (upcomingEvents != null && !upcomingEvents.isEmpty()) {
                    for (String[] event : upcomingEvents) {
            %>
            <tr>
              <td class="td-primary"><%= event[1] %></td>
              <td class="td-secondary"><%= event[2] %></td>
              <td class="td-secondary"><%= event[3] %></td>
              <td class="td-secondary"><%= event[4] %></td>
              <td class="td-hint"><%= event[5] %></td>
              <td><a href="${pageContext.request.contextPath}/attendee/events" class="btn-row">Register</a></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
              <td colspan="6" style="text-align:center;color:var(--text-ghost);padding:24px">No upcoming events.</td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- My Registrations -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">My Registrations</span>
          <a href="${pageContext.request.contextPath}/attendee/myregistrations" class="btn-secondary">View all</a>
        </div>
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
              <td class="td-primary"><%= reg[0] %></td>
              <td class="td-secondary"><%= reg[1] %></td>
              <td class="td-secondary"><%= reg[2] %></td>
              <td><span class="badge <%= "confirmed".equals(reg[3]) ? "badge-success" : "badge-danger" %>"><%= reg[3] %></span></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
              <td colspan="4" style="text-align:center;color:var(--text-ghost);padding:24px">You have not registered for any events yet.</td>
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
