<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
  <title>My Registrations — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
</head>
<body>
<% request.setAttribute("activePage", "myregistrations"); %>
<% request.setAttribute("breadcrumbParent", "Attendee"); %>
<% request.setAttribute("breadcrumbCurrent", "My Registrations"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAttendee.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>My Registrations</h1>
          <p>Events you have registered for</p>
        </div>
      </div>

      <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
        <c:remove var="successMsg" scope="session"/>
      </c:if>
      <c:if test="${not empty errorMsg}">
        <div class="alert alert-error">${errorMsg}</div>
        <c:remove var="errorMsg" scope="session"/>
      </c:if>

      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Registered Events</span>
          <span class="nav-badge">${registrations.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Event</th>
              <th>Location</th>
              <th>Date</th>
              <th>Registered On</th>
              <th>Event Status</th>
              <th>My Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="r" items="${registrations}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${r.title}</td>
                <td class="td-secondary">${r.location}</td>
                <td class="td-secondary">${r.event_date}</td>
                <td class="td-hint">${r.registration_date}</td>
                <td>
                  <c:choose>
                    <c:when test="${r.event_status == 'upcoming'}"><span class="badge badge-info">Upcoming</span></c:when>
                    <c:when test="${r.event_status == 'ongoing'}"><span class="badge badge-success">Ongoing</span></c:when>
                    <c:when test="${r.event_status == 'completed'}"><span class="badge badge-neutral">Completed</span></c:when>
                    <c:otherwise><span class="badge badge-danger">Cancelled</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${r.status == 'confirmed'}"><span class="badge badge-success">Confirmed</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">Cancelled</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:if test="${r.status == 'confirmed' && r.event_status == 'upcoming'}">
                    <form method="post" action="/EventFlow/attendee/myregistrations"
                          onsubmit="return confirm('Cancel this registration?')">
                      <input type="hidden" name="registrationId" value="${r.id}"/>
                      <button type="submit" class="btn-danger">Cancel</button>
                    </form>
                  </c:if>
                  <c:if test="${r.status != 'confirmed' || r.event_status != 'upcoming'}">
                    <span class="td-hint">—</span>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty registrations}">
              <tr><td colspan="8" style="text-align:center;color:var(--text-ghost);padding:24px">No registrations yet. <a href="/EventFlow/attendee/events" style="color:var(--text-mid)">Browse events</a></td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
