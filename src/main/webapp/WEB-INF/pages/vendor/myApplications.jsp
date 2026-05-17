<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("vendor")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Applications — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
</head>
<body>
<% request.setAttribute("activePage", "applications"); %>
<% request.setAttribute("breadcrumbParent", "Vendor"); %>
<% request.setAttribute("breadcrumbCurrent", "My Applications"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarVendor.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>My Applications</h1>
          <p>Track the status of your vendor applications</p>
        </div>
      </div>

      <div class="table-container">
        <div class="table-header">
          <span class="table-title">All applications</span>
          <span class="nav-badge">${applications.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Event</th>
              <th>Location</th>
              <th>Event Date</th>
              <th>Event Status</th>
              <th>Applied On</th>
              <th>My Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="a" items="${applications}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${a.title}</td>
                <td class="td-secondary">${a.location}</td>
                <td class="td-secondary">${a.event_date}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.event_status == 'upcoming'}"><span class="badge badge-info">Upcoming</span></c:when>
                    <c:when test="${a.event_status == 'ongoing'}"> <span class="badge badge-success">Ongoing</span></c:when>
                    <c:when test="${a.event_status == 'completed'}"><span class="badge badge-neutral">Completed</span></c:when>
                    <c:otherwise>                                  <span class="badge badge-danger">Cancelled</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="td-hint">${a.applied_at}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.status == 'approved'}"><span class="badge badge-success">Approved</span></c:when>
                    <c:when test="${a.status == 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                    <c:otherwise>                           <span class="badge badge-warning">Pending</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty applications}">
              <tr>
                <td colspan="7" style="text-align:center;color:var(--text-ghost);padding:32px">
                  No applications yet.
                  <a href="/EventFlow/vendor/apply" style="color:var(--text-mid);margin-left:6px">Apply for an event →</a>
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
