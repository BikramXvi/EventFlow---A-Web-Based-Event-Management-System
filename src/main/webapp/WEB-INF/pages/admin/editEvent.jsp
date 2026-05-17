<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    if (session.getAttribute("userRole") == null ||
        !session.getAttribute("userRole").equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String[] event = (String[]) request.getAttribute("event");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Edit Event — EventFlow</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>

<style>
.upload-area {
  border: 1px dashed var(--border-default);
  border-radius: var(--r-md);
  padding: 24px;
  text-align: center;
  cursor: pointer;
  background: var(--bg-input);
  position: relative;
}

.upload-area:hover {
  background: var(--bg-hover);
}

.upload-preview {
  width: 100%;
  height: 160px;
  object-fit: cover;
  border-radius: var(--r-md);
  margin-top: 10px;
}
</style>
</head>

<body>
<% request.setAttribute("activePage", "events"); %>
<% request.setAttribute("breadcrumbParent", "Admin / Events"); %>
<% request.setAttribute("breadcrumbCurrent", "Edit Event"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAdmin.jsp" %>

  <!-- MAIN -->
  <div class="main-content">

    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
    <div class="page-header">
      <h1>Edit Event</h1>
      <p>Update event details</p>
    </div>

    <c:if test="${not empty errorMsg}">
      <div class="alert alert-error">${errorMsg}</div>
    </c:if>

    <div class="form-card" style="max-width:700px">

      <form method="post"
            action="${pageContext.request.contextPath}/admin/editEvent"
            enctype="multipart/form-data">

        <!-- ID -->
        <input type="hidden" name="id" value="<%= event[0] %>"/>

        <!-- TITLE -->
        <div class="form-group">
          <label>Event title</label>
          <input type="text" name="title" required value="<%= event[1] %>">
        </div>

        <!-- DESCRIPTION -->
        <div class="form-group">
          <label>Description</label>
          <textarea name="description" rows="4"><%= event[2] %></textarea>
        </div>

        <!-- LOCATION -->
        <div class="form-group">
          <label>Location</label>
          <input type="text" name="location" required value="<%= event[3] %>">
        </div>

        <div class="form-row">

          <!-- DATE -->
          <div class="form-group">
            <label>Event Date</label>
            <input type="date" name="eventDate" required value="<%= event[4] %>">
          </div>

          <!-- STATUS -->
          <div class="form-group">
            <label>Status</label>
            <select name="status">
              <option value="upcoming" <%= "upcoming".equals(event[8]) ? "selected" : "" %>>Upcoming</option>
              <option value="ongoing" <%= "ongoing".equals(event[8]) ? "selected" : "" %>>Ongoing</option>
              <option value="draft" <%= "draft".equals(event[8]) ? "selected" : "" %>>Draft</option>
            </select>
          </div>
        </div>

        <div class="form-row">

          <!-- START TIME -->
          <div class="form-group">
            <label>Start Time</label>
            <input type="time" name="startTime" required value="<%= event[5] %>">
          </div>

          <!-- END TIME -->
          <div class="form-group">
            <label>End Time</label>
            <input type="time" name="endTime" required value="<%= event[6] %>">
          </div>
        </div>

        <!-- CAPACITY -->
        <div class="form-group">
          <label>Capacity</label>
          <input type="number" name="capacity" required value="<%= event[7] %>">
        </div>

        <!-- IMAGE -->
        <div class="form-group">
          <label>Change Image (optional)</label>
          <input type="file" name="eventImage" accept="image/*">

          <!-- NOTE: you don't currently return image_path in getEventById -->
          <p style="font-size:12px;color:gray;margin-top:5px;">
            Upload only if you want to replace existing image
          </p>
        </div>

        <!-- ACTIONS -->
        <div class="form-actions">
          <a href="${pageContext.request.contextPath}/admin/events" class="btn-secondary">Cancel</a>
          <button type="submit" class="btn-primary">Update Event</button>
        </div>

      </form>

    </div>
    </div><!-- content-wrap -->
  </div><!-- main-content -->
</div><!-- dashboard-container -->

</body>
</html>