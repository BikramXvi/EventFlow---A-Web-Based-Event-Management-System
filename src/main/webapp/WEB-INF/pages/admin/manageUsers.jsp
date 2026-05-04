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
  <title>Manage Users — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
</head>
<body>
<div class="dashboard-container">

  <!-- SIDEBAR -->
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
        <li><a href="/EventFlow/admin/users" class="active">Users</a></li>
        <li><a href="/EventFlow/admin/volunteers">Volunteers</a></li>
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

  <!-- MAIN -->
  <div class="main-content">
    <div class="topbar">
      <div class="breadcrumb">
        <span class="breadcrumb-seg">Admin</span>
        <span class="breadcrumb-sep">/</span>
        <span class="breadcrumb-active">Manage Users</span>
      </div>
      <div class="topbar-spacer"></div>
      <div class="topbar-right">
        <a href="/EventFlow/logout" class="topbar-btn">Logout</a>
      </div>
    </div>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Manage Users</h1>
          <p>View and manage all registered users</p>
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
          <span class="table-title">All Users</span>
          <span class="nav-badge">${users.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Role</th>
              <th>Status</th>
              <th>Locked</th>
              <th>Joined</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="u" items="${users}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${u.full_name}</td>
                <td class="td-secondary">${u.email}</td>
                <td class="td-secondary">${u.phone}</td>
                <td><span class="badge badge-info">${u.role}</span></td>
                <td>
                  <c:choose>
                    <c:when test="${u.is_active == 1}"><span class="badge badge-success">Active</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">Inactive</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${u.is_locked == 1}"><span class="badge badge-danger">Locked</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">—</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="td-hint">${u.created_at}</td>
                <td>
                  <div style="display:flex;gap:4px">
                    <form method="post" action="/EventFlow/admin/users">
                      <input type="hidden" name="id" value="${u.id}"/>
                      <input type="hidden" name="action" value="toggleActive"/>
                      <button type="submit" class="btn-row" data-tip="Toggle active">
                        <c:choose><c:when test="${u.is_active == 1}">Deactivate</c:when><c:otherwise>Activate</c:otherwise></c:choose>
                      </button>
                    </form>
                    <form method="post" action="/EventFlow/admin/users">
                      <input type="hidden" name="id" value="${u.id}"/>
                      <input type="hidden" name="action" value="toggleLocked"/>
                      <button type="submit" class="btn-row">
                        <c:choose><c:when test="${u.is_locked == 1}">Unlock</c:when><c:otherwise>Lock</c:otherwise></c:choose>
                      </button>
                    </form>
                    <form method="post" action="/EventFlow/admin/users" onsubmit="return confirm('Delete this user?')">
                      <input type="hidden" name="id" value="${u.id}"/>
                      <input type="hidden" name="action" value="delete"/>
                      <button type="submit" class="btn-danger">Delete</button>
                    </form>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty users}">
              <tr><td colspan="9" style="text-align:center;color:var(--text-ghost);padding:24px">No users found.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>
