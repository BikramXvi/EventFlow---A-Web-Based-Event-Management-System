<%-- WEB-INF/pages/shared/_sidebarVendor.jsp --%>
<div class="sidebar">
  <div class="sidebar-header">
    <div class="sidebar-brand">
      <div class="sidebar-logo"><span></span><span></span><span></span><span></span></div>
      <h2>EventFlow</h2>
    </div>
    <p>Vendor Panel</p>
  </div>
  <nav class="sidebar-nav">
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/vendor/dashboard" ${activePage == 'dashboard' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="1" width="5" height="5" rx="1"/><rect x="8" y="1" width="5" height="5" rx="1"/><rect x="1" y="8" width="5" height="5" rx="1"/><rect x="8" y="8" width="5" height="5" rx="1"/></svg>
        Dashboard
      </a></li>
      <li><a href="${pageContext.request.contextPath}/vendor/apply" ${activePage == 'apply' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="2" y="1" width="10" height="12" rx="1"/><line x1="4" y1="5" x2="10" y2="5"/><line x1="4" y1="8" x2="8" y2="8"/></svg>
        Apply for Event
      </a></li>
      <li><a href="${pageContext.request.contextPath}/vendor/applications" ${activePage == 'applications' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="1" y="2" width="12" height="11" rx="1.2"/><polyline points="4,7 6,9 10,5"/></svg>
        My Applications
      </a></li>
      <li><a href="${pageContext.request.contextPath}/vendor/profile" ${activePage == 'profile' ? 'class="active"' : ''}>
        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.3"><circle cx="7" cy="4" r="2.5"/><path d="M2 12c0-2.5 2.2-4.5 5-4.5s5 2 5 4.5"/></svg>
        My Profile
      </a></li>
    </ul>
  </nav>
  <div class="sidebar-footer">
    <div class="sidebar-avatar">${sessionScope.userName != null ? sessionScope.userName.substring(0,2).toUpperCase() : 'VD'}</div>
    <div>
      <div class="sidebar-user-name">${sessionScope.userName}</div>
      <div class="sidebar-user-email">${sessionScope.userEmail}</div>
    </div>
  </div>
</div>
