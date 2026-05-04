<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Profile — EventFlow</title>
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
      <p>${sessionScope.userRole} Panel</p>
    </div>
    <nav class="sidebar-nav">
      <ul class="sidebar-menu">
        <li><a href="/EventFlow/${sessionScope.userRole}/dashboard">Dashboard</a></li>
        <c:if test="${sessionScope.userRole == 'attendee'}">
          <li><a href="/EventFlow/attendee/events">Browse Events</a></li>
          <li><a href="/EventFlow/attendee/myregistrations">My Registrations</a></li>
        </c:if>
        <c:if test="${sessionScope.userRole == 'volunteer'}">
          <li><a href="/EventFlow/volunteer/assignments">My Assignments</a></li>
        </c:if>
        <li><a href="/EventFlow/${sessionScope.userRole}/profile" class="active">My Profile</a></li>
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
        <span class="breadcrumb-seg">${sessionScope.userRole}</span>
        <span class="breadcrumb-sep">/</span>
        <span class="breadcrumb-active">My Profile</span>
      </div>
      <div class="topbar-spacer"></div>
      <div class="topbar-right">
        <a href="/EventFlow/logout" class="topbar-btn">Logout</a>
      </div>
    </div>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>My Profile</h1>
          <p>Update your personal information</p>
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

      <div class="form-card">
        <div class="form-card-header">
          <h2>Personal information</h2>
          <p>Update your name and phone number</p>
        </div>
        <form method="post" action="/EventFlow/${sessionScope.userRole}/profile">
          <div class="form-row">
            <div class="form-group">
              <label>Full name</label>
              <input type="text" name="full_name" value="${user.full_name}" required/>
            </div>
            <div class="form-group">
              <label>Phone</label>
              <input type="text" name="phone" value="${user.phone}" required/>
            </div>
          </div>
          <div class="form-group">
            <label>Email</label>
            <input type="email" value="${user.email}" disabled style="opacity:0.5"/>
          </div>
          <div class="form-group">
            <label>Role</label>
            <input type="text" value="${user.role}" disabled style="opacity:0.5;text-transform:capitalize"/>
          </div>
          <div class="form-group">
            <label>Member since</label>
            <input type="text" value="${user.created_at}" disabled style="opacity:0.5"/>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn-primary" style="width:auto">Save changes</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
