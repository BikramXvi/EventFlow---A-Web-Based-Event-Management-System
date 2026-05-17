<%-- WEB-INF/pages/shared/_topbar.jsp --%>
<%
  String _tbParent  = (String) request.getAttribute("breadcrumbParent");
  String _tbCurrent = (String) request.getAttribute("breadcrumbCurrent");
%>
<div class="topbar">
  <div class="breadcrumb">
    <% if (_tbParent != null && !_tbParent.isEmpty()) { %>
      <span class="breadcrumb-seg"><%= _tbParent %></span>
      <span class="breadcrumb-sep">/</span>
    <% } %>
    <span class="breadcrumb-active"><%= _tbCurrent != null ? _tbCurrent : "" %></span>
  </div>
  <div class="topbar-spacer"></div>
  <div class="topbar-right">
    <a href="${pageContext.request.contextPath}/logout" class="topbar-btn">Logout</a>
  </div>
</div>
