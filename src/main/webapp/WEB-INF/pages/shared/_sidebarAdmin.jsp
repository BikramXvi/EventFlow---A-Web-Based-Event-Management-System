<%-- WEB-INF/pages/shared/_sidebarAdmin.jsp --%>
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
      <li><a href="${pageContext.request.contextPath}/admin/dashboard" ${activePage == 'dashboard' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="1" width="5" height="5" rx="1"/><rect x="8" y="1" width="5" height="5" rx="1"/><rect x="1" y="8" width="5" height="5" rx="1"/><rect x="8" y="8" width="5" height="5" rx="1"/></svg>
        Dashboard
      </a></li>
      <li><a href="${pageContext.request.contextPath}/admin/events" ${activePage == 'events' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="2" width="12" height="11" rx="1.2"/><line x1="4" y1="1" x2="4" y2="3.5"/><line x1="10" y1="1" x2="10" y2="3.5"/><line x1="1" y1="5.5" x2="13" y2="5.5"/></svg>
        Manage Events
      </a></li>
      <li><a href="${pageContext.request.contextPath}/admin/users" ${activePage == 'users' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><circle cx="7" cy="4" r="2.5"/><path d="M2 12c0-2.5 2.2-4.5 5-4.5s5 2 5 4.5"/></svg>
        Manage Users
      </a></li>
      <li><a href="${pageContext.request.contextPath}/admin/volunteers" ${activePage == 'volunteers' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><circle cx="5" cy="4" r="2"/><circle cx="9" cy="4" r="2"/><path d="M1 12c0-2 1.8-3.5 4-3.5"/><path d="M13 12c0-2-1.8-3.5-4-3.5"/><path d="M5 8.5c1-.4 3-.4 4 0"/></svg>
        Manage Volunteers
      </a></li>
      <li><a href="${pageContext.request.contextPath}/admin/vendors" ${activePage == 'vendors' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><path d="M1.5 5L3 1.5h8L12.5 5"/><rect x="1" y="5" width="12" height="8" rx="1"/><line x1="7" y1="5" x2="7" y2="13"/></svg>
        Manage Vendors
      </a></li>
    </ul>
  </nav>
  <div class="sidebar-footer">
    <div class="sidebar-avatar">${sessionScope.userName != null ? sessionScope.userName.substring(0,2).toUpperCase() : 'AD'}</div>
    <div>
      <div class="sidebar-user-name">${sessionScope.userName}</div>
      <div class="sidebar-user-email">${sessionScope.userEmail}</div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" style="margin-left:auto;color:var(--text-ghost);" title="Logout">
      <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3" width="13" height="13"><path d="M5 2H2.5A1 1 0 001.5 3v8a1 1 0 001 1H5"/><path d="M9.5 10L12.5 7l-3-3"/><line x1="12.5" y1="7" x2="5" y2="7"/></svg>
    </a>
  </div>
</div>
