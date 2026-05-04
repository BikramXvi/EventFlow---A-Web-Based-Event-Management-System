<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <title>My Assignments — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
</head>	
<body>
<div class="dashboard-container">

  <div class="sidebar">
    <div class="sidebar-header">
      <div class="sidebar-brand">
        <div class="sidebar-logo"><span></span><span></span><span></span><span></span></div>
        <h2>EventFlow</h2>
      </div>
      <p>Volunteer Panel</p>
    </div>
    <nav class="sidebar-nav">
      <ul class="sidebar-menu">
        <li><a href="/EventFlow/volunteer/dashboard">Dashboard</a></li>
        <li><a href="/EventFlow/volunteer/assignments" class="active">My Assignments</a></li>
        <li><a href="/EventFlow/volunteer/profile">My Profile</a></li>
        <li><a href="/EventFlow/logout">Logout</a></li>
      </ul>
    </nav>
    <div class="sidebar-footer">
      <div class="sidebar-avatar">${sessionScope.userName.substring(0,2).toUpperCase()}</div>
      <div>
        <div class="sidebar-user-name">${sessionScope.userName}</div>
        <div class="sidebar-user-email">${sessionScope.userEmail}</div>
      </div>
    </div>
  </div>

  <div class="main-content">
    <div class="topbar">
      <div class="breadcrumb">
        <span class="breadcrumb-seg">Volunteer</span>
        <span class="breadcrumb-sep">/</span>
        <span class="breadcrumb-active">My Assignments</span>
      </div>
      <div class="topbar-spacer"></div>
      <div class="topbar-right">
        <a href="/EventFlow/logout" class="topbar-btn">Logout</a>
      </div>
    </div>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>My Assignments</h1>
          <p>Events you have been assigned to volunteer at</p>
        </div>
      </div>

      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Assignments</span>
          <span class="nav-badge">${assignments.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Event</th>
              <th>Location</th>
              <th>Date</th>
              <th>Start Time</th>
              <th>Event Status</th>
              <th>Assignment</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="a" items="${assignments}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${a.title}</td>
                <td class="td-secondary">${a.location}</td>
                <td class="td-secondary">${a.event_date}</td>
                <td class="td-secondary">${a.start_time}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.event_status == 'upcoming'}"><span class="badge badge-info">Upcoming</span></c:when>
                    <c:when test="${a.event_status == 'ongoing'}"><span class="badge badge-success">Ongoing</span></c:when>
                    <c:when test="${a.event_status == 'completed'}"><span class="badge badge-neutral">Completed</span></c:when>
                    <c:otherwise><span class="badge badge-danger">Cancelled</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${a.assignment_status == 'assigned'}"><span class="badge badge-warning">Assigned</span></c:when>
                    <c:when test="${a.assignment_status == 'completed'}"><span class="badge badge-success">Completed</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">${a.assignment_status}</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty assignments}">
              <tr><td colspan="7" style="text-align:center;color:var(--text-ghost);padding:24px">No assignments yet.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
