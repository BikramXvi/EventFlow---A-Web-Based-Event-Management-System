<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
  <title>Create Event — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
  <style>
    .upload-area {
      border: 1px dashed var(--border-default);
      border-radius: var(--r-md);
      padding: 24px;
      text-align: center;
      cursor: pointer;
      transition: border-color 0.12s, background 0.12s;
      background: var(--bg-input);
      position: relative;
    }

    .upload-area:hover { border-color: var(--border-strong); background: var(--bg-hover); }
    .upload-area.has-image { border-color: var(--success-border); border-style: solid; }

    .upload-area input[type=file] {
      position: absolute;
      inset: 0;
      opacity: 0;
      cursor: pointer;
      width: 100%;
      height: 100%;
    }

    .upload-preview {
      width: 100%;
      height: 160px;
      object-fit: cover;
      border-radius: var(--r-md);
      display: none;
    }

    .upload-placeholder svg { width: 28px; height: 28px; color: var(--text-ghost); margin-bottom: 8px; }
    .upload-placeholder p   { font-size: 12px; color: var(--text-dim); }
    .upload-placeholder span { font-size: 10px; color: var(--text-ghost); }
  </style>
</head>
<body>
<% request.setAttribute("activePage", "events"); %>
<% request.setAttribute("breadcrumbParent", "Admin / Events"); %>
<% request.setAttribute("breadcrumbCurrent", "Create Event"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAdmin.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Create event</h1>
          <p>Fill in the details to publish a new event</p>
        </div>
      </div>

      <c:if test="${not empty errorMsg}">
        <div class="alert alert-error">${errorMsg}</div>
      </c:if>

      <div class="form-card" style="max-width:700px">
        <div class="form-card-header">
          <h2>Event details</h2>
          <p>All fields except image are required</p>
        </div>

        <form method="post" action="/EventFlow/admin/createEvent" enctype="multipart/form-data">

          <div class="form-group">
            <label>Event title</label>
            <input type="text" name="title" placeholder="e.g. Tech Summit Kathmandu 2026" required
                   value="${not empty param.title ? param.title : ''}"/>
          </div>

          <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="4" placeholder="Describe what this event is about..." required>${not empty param.description ? param.description : ''}</textarea>
          </div>

          <div class="form-group">
            <label>Event image (optional)</label>
            <div class="upload-area" id="uploadArea">
              <input type="file" name="eventImage" id="imageInput" accept="image/jpeg,image/png,image/gif"
                     onchange="previewImage(this)"/>
              <img id="uploadPreview" class="upload-preview" alt="preview"/>
              <div class="upload-placeholder" id="uploadPlaceholder">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="M21 15l-5-5L5 21"/></svg>
                <p>Click to upload event image</p>
                <span>JPG, PNG or GIF · max 5MB</span>
              </div>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Venue / Location</label>
              <input type="text" name="location" placeholder="e.g. Bhrikuti Mandap, KTM" required
                     value="${not empty param.location ? param.location : ''}"/>
            </div>
            <div class="form-group">
              <label>Capacity</label>
              <input type="number" name="capacity" placeholder="e.g. 200" min="1" required
                     value="${not empty param.capacity ? param.capacity : ''}"/>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Event date</label>
              <input type="date" name="eventDate" required
                     value="${not empty param.eventDate ? param.eventDate : ''}"/>
            </div>
            <div class="form-group">
              <label>Status</label>
              <select name="status">
                <option value="upcoming">Upcoming</option>
                <option value="ongoing">Ongoing</option>
                <option value="draft">Draft</option>
              </select>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Start time</label>
              <input type="time" name="startTime" required
                     value="${not empty param.startTime ? param.startTime : ''}"/>
            </div>
            <div class="form-group">
              <label>End time</label>
              <input type="time" name="endTime" required
                     value="${not empty param.endTime ? param.endTime : ''}"/>
            </div>
          </div>

          <div class="form-actions">
            <a href="/EventFlow/admin/events" class="btn-secondary">Cancel</a>
            <button type="submit" class="btn-primary" style="width:auto">Create event</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
function previewImage(input) {
  var preview = document.getElementById('uploadPreview');
  var placeholder = document.getElementById('uploadPlaceholder');
  var area = document.getElementById('uploadArea');
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      preview.src = e.target.result;
      preview.style.display = 'block';
      placeholder.style.display = 'none';
      area.classList.add('has-image');
    };
    reader.readAsDataURL(input.files[0]);
  }
}
</script>
</body>
</html>
