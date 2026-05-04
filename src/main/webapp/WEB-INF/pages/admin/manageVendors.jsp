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
  <title>Manage Vendors — EventFlow</title>
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
        <li><a href="/EventFlow/admin/volunteers">Volunteers</a></li>
        <li><a href="/EventFlow/admin/vendors" class="active">Vendors</a></li>
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
        <span class="breadcrumb-active">Manage Vendors</span>
      </div>
      <div class="topbar-spacer"></div>
      <div class="topbar-right">
        <a href="/EventFlow/logout" class="topbar-btn">Logout</a>
      </div>
    </div>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Manage Vendors</h1>
          <p>Review and approve vendor applications</p>
        </div>
      </div>

      <!-- Applications -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Vendor Applications</span>
          <span class="nav-badge">${applications.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Vendor</th>
              <th>Email</th>
              <th>Event</th>
              <th>Event Date</th>
              <th>Applied</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="a" items="${applications}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${a.full_name}</td>
                <td class="td-secondary">${a.email}</td>
                <td class="td-secondary">${a.event_title}</td>
                <td class="td-secondary">${a.event_date}</td>
                <td class="td-hint">${a.applied_at}</td>
                <td>
                  <c:choose>
                    <c:when test="${a.status == 'approved'}"><span class="badge badge-success">Approved</span></c:when>
                    <c:when test="${a.status == 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                    <c:otherwise><span class="badge badge-warning">Pending</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:if test="${a.status == 'pending'}">
                    <div style="display:flex;gap:4px">
                      <form method="post" action="/EventFlow/admin/vendors">
                        <input type="hidden" name="applicationId" value="${a.id}"/>
                        <input type="hidden" name="action" value="approve"/>
                        <button type="submit" class="btn-row">Approve</button>
                      </form>
                      <form method="post" action="/EventFlow/admin/vendors">
                        <input type="hidden" name="applicationId" value="${a.id}"/>
                        <input type="hidden" name="action" value="reject"/>
                        <button type="submit" class="btn-danger">Reject</button>
                      </form>
                    </div>
                  </c:if>
                  <c:if test="${a.status != 'pending'}"><span class="td-hint">—</span></c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty applications}">
              <tr><td colspan="8" style="text-align:center;color:var(--text-ghost);padding:24px">No applications found.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <!-- Vendors list -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Registered Vendors</span>
          <span class="nav-badge">${vendors.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Applications</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="v" items="${vendors}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${v.full_name}</td>
                <td class="td-secondary">${v.email}</td>
                <td class="td-secondary">${v.phone}</td>
                <td class="td-secondary">${v.application_count}</td>
                <td>
                  <c:choose>
                    <c:when test="${v.is_active == 1}"><span class="badge badge-success">Active</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">Inactive</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty vendors}">
              <tr><td colspan="6" style="text-align:center;color:var(--text-ghost);padding:24px">No vendors found.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
