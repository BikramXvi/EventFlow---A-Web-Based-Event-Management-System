<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("volunteer")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Volunteer Dashboard — EventFlow</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("breadcrumbCurrent", "Dashboard"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarVolunteer.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Welcome, <%= session.getAttribute("userFullName") %></h1>
          <p>View your event assignments and tasks.</p>
        </div>
        <a href="${pageContext.request.contextPath}/volunteer/assignments" class="btn-secondary">View Assignments</a>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-label">My Assignments</div>
          <div class="stat-number"><%= request.getAttribute("totalAssignments") != null ? request.getAttribute("totalAssignments") : 0 %></div>
        </div>
      </div>

      <!-- Assignments Table -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">My Event Assignments</span>
          <a href="${pageContext.request.contextPath}/volunteer/assignments" class="btn-secondary">View all with tasks</a>
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
                List<String[]> assignments = (List<String[]>) request.getAttribute("assignments");
                if (assignments != null && !assignments.isEmpty()) {
                    for (String[] a : assignments) {
                        String badgeClass = "assigned".equals(a[3]) ? "badge-warning"
                                          : "completed".equals(a[3]) ? "badge-success"
                                          : "badge-danger";
            %>
            <tr>
              <td class="td-primary"><%= a[0] %></td>
              <td class="td-secondary"><%= a[1] %></td>
              <td class="td-secondary"><%= a[2] %></td>
              <td><span class="badge <%= badgeClass %>"><%= a[3] %></span></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
              <td colspan="4" style="text-align:center;color:var(--text-ghost);padding:24px">No assignments yet.</td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>

      <!-- Tasks Table -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">My Tasks</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>Task</th>
              <th>Notes</th>
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
              <td class="td-primary"><%= t[0] %></td>
              <td class="td-secondary"><%= t[1] != null ? t[1] : "—" %></td>
              <td class="td-secondary"><%= t[2] %></td>
              <td>
                <span class="badge <%= "0".equals(t[3]) ? "badge-warning" : "badge-success" %>">
                  <%= "0".equals(t[3]) ? "Pending" : "Completed" %>
                </span>
              </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
              <td colspan="4" style="text-align:center;color:var(--text-ghost);padding:24px">No tasks assigned yet.</td>
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
