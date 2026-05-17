<%-- WEB-INF/pages/shared/_sidebarVolunteer.jsp --%>
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
      <li><a href="${pageContext.request.contextPath}/volunteer/dashboard" ${activePage == 'dashboard' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="1" width="5" height="5" rx="1"/><rect x="8" y="1" width="5" height="5" rx="1"/><rect x="1" y="8" width="5" height="5" rx="1"/><rect x="8" y="8" width="5" height="5" rx="1"/></svg>
        Dashboard
      </a></li>
      <li><a href="${pageContext.request.contextPath}/volunteer/assignments" ${activePage == 'assignments' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="2" width="12" height="11" rx="1.2"/><line x1="4" y1="9" x2="10" y2="9"/><line x1="4" y1="6" x2="8" y2="6"/></svg>
        My Assignments
      </a></li>
      <li><a href="${pageContext.request.contextPath}/volunteer/profile" ${activePage == 'profile' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><circle cx="7" cy="4" r="2.5"/><path d="M2 12c0-2.5 2.2-4.5 5-4.5s5 2 5 4.5"/></svg>
        My Profile
      </a></li>
    </ul>
  </nav>
  <div class="sidebar-footer">
    <div class="sidebar-avatar">${sessionScope.userName != null ? sessionScope.userName.substring(0,2).toUpperCase() : 'VO'}</div>
    <div>
      <div class="sidebar-user-name">${sessionScope.userName}</div>
      <div class="sidebar-user-email">${sessionScope.userEmail}</div>
    </div>
  </div>
</div>
