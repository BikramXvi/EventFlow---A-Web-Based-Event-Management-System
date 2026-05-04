<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <title>Manage Volunteers — EventFlow</title>
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
      <p>Admin Panel</p>
    </div>
    <nav class="sidebar-nav">
      <ul class="sidebar-menu">
        <li><a href="/EventFlow/admin/dashboard">Dashboard</a></li>
        <li><a href="/EventFlow/admin/events">Events</a></li>
        <li><a href="/EventFlow/admin/users">Users</a></li>
        <li><a href="/EventFlow/admin/volunteers" class="active">Volunteers</a></li>
        <li><a href="/EventFlow/admin/vendors">Vendors</a></li>
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
        <span class="breadcrumb-seg">Admin</span>
        <span class="breadcrumb-sep">/</span>
        <span class="breadcrumb-active">Manage Volunteers</span>
      </div>
      <div class="topbar-spacer"></div>
      <div class="topbar-right">
        <a href="/EventFlow/logout" class="topbar-btn">Logout</a>
      </div>
    </div>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Manage Volunteers</h1>
          <p>Assign volunteers to events and track their work</p>
        </div>
      </div>

      <!-- Assign form -->
      <div class="form-card">
        <div class="form-card-header">
          <h2>Assign volunteer to event</h2>
        </div>
        <form method="post" action="/EventFlow/admin/volunteers">
          <input type="hidden" name="action" value="assign"/>
          <div class="form-row">
            <div class="form-group">
              <label>Volunteer</label>
              <select name="volunteerId" required>
                <option value="">Select volunteer</option>
                <c:forEach var="v" items="${volunteers}">
                  <option value="${v.id}">${v.full_name} (${v.email})</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label>Event</label>
              <select name="eventId" required>
                <option value="">Select event</option>
                <c:forEach var="e" items="${events}">
				  <option value="${e[0]}">${e[1]} — ${e[3]}</option>
				</c:forEach>
              </select>
            </div>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn-primary" style="width:auto">Assign</button>
          </div>
        </form>
      </div>

      <!-- Volunteers table -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">All Volunteers</span>
          <span class="nav-badge">${volunteers.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Assignments</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="v" items="${volunteers}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${v.full_name}</td>
                <td class="td-secondary">${v.email}</td>
                <td class="td-secondary">${v.phone}</td>
                <td class="td-secondary">${v.assignment_count}</td>
                <td>
                  <c:choose>
                    <c:when test="${v.is_active == 1}"><span class="badge badge-success">Active</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">Inactive</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty volunteers}">
              <tr><td colspan="6" style="text-align:center;color:var(--text-ghost);padding:24px">No volunteers found.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
