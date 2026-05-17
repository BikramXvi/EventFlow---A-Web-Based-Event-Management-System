<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("vendor")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Apply for Event — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
  <style>
    /* ── Modal overlay ── */
    .modal-overlay {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.72);
      z-index: 500;
      align-items: center;
      justify-content: center;
    }

    .modal-overlay.open {
      display: flex;
    }

    .modal {
      background: var(--bg-panel);
      border: 1px solid var(--border-subtle);
      border-radius: var(--r-xl);
      padding: 28px;
      width: 100%;
      max-width: 480px;
      position: relative;
    }

    .modal-header {
      margin-bottom: 20px;
      padding-bottom: 14px;
      border-bottom: 1px solid var(--border-subtle);
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      gap: 12px;
    }

    .modal-title {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-78);
      letter-spacing: -0.01em;
    }

    .modal-subtitle {
      font-size: 11px;
      color: var(--text-dim);
      margin-top: 3px;
    }

    .modal-close {
      width: 24px;
      height: 24px;
      border-radius: var(--r-xs);
      border: 1px solid var(--border-subtle);
      background: transparent;
      color: var(--text-dim);
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      font-size: 14px;
      line-height: 1;
      transition: background 0.1s;
    }

    .modal-close:hover {
      background: var(--bg-hover);
      color: var(--text-mid);
    }

    .modal-event-info {
      background: var(--bg-raised);
      border: 1px solid var(--border-subtle);
      border-radius: var(--r-md);
      padding: 10px 12px;
      margin-bottom: 16px;
    }

    .modal-event-name {
      font-size: 13px;
      font-weight: 500;
      color: var(--text-78);
      margin-bottom: 3px;
    }

    .modal-event-meta {
      font-size: 11px;
      color: var(--text-dim);
    }

    .char-count {
      font-size: 10px;
      color: var(--text-ghost);
      text-align: right;
      margin-top: 4px;
    }

    .char-count.warn { color: var(--warning-text); }
  </style>
</head>
<body>
<% request.setAttribute("activePage", "apply"); %>
<% request.setAttribute("breadcrumbParent", "Vendor"); %>
<% request.setAttribute("breadcrumbCurrent", "Apply for Event"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarVendor.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Apply for Event</h1>
          <p>Browse available events and submit your vendor application</p>
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

      <!-- Already applied -->
      <c:if test="${not empty applications}">
        <div class="table-container">
          <div class="table-header">
            <span class="table-title">Already applied</span>
            <span class="nav-badge">${applications.size()}</span>
          </div>
          <table>
            <thead>
              <tr>
                <th>Event</th>
                <th>Date</th>
                <th>Status</th>
                <th>Applied on</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="a" items="${applications}">
                <tr>
                  <td class="td-primary">${a.title}</td>
                  <td class="td-secondary">${a.event_date}</td>
                  <td>
                    <c:choose>
                      <c:when test="${a.status == 'approved'}"><span class="badge badge-success">Approved</span></c:when>
                      <c:when test="${a.status == 'rejected'}"><span class="badge badge-danger">Rejected</span></c:when>
                      <c:otherwise><span class="badge badge-warning">Pending</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td class="td-hint">${a.applied_at}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <!-- Events table -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Available events</span>
          <span class="nav-badge">${events.size()}</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Event</th>
              <th>Location</th>
              <th>Date</th>
              <th>Time</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="e" items="${events}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${e[1]}</td>
                <td class="td-secondary">${e[2]}</td>
                <td class="td-secondary">${e[3]}</td>
                <td class="td-secondary">${e[4]} — ${e[5]}</td>
                <td>
                  <c:choose>
                    <c:when test="${e[7] == 'upcoming'}"><span class="badge badge-info">Upcoming</span></c:when>
                    <c:when test="${e[7] == 'ongoing'}"> <span class="badge badge-success">Ongoing</span></c:when>
                    <c:when test="${e[7] == 'draft'}">   <span class="badge badge-neutral">Draft</span></c:when>
                    <c:otherwise>                        <span class="badge badge-neutral">${e[7]}</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${e[7] == 'upcoming' || e[7] == 'ongoing'}">
                      <button class="btn-row"
                              onclick="openApplyModal('${e[0]}', '${e[1]}', '${e[3]}', '${e[2]}')">
                        Apply
                      </button>
                    </c:when>
                    <c:otherwise>
                      <span class="td-hint">—</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty events}">
              <tr>
                <td colspan="7" style="text-align:center;color:var(--text-ghost);padding:24px">
                  No events available.
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- ── Apply Modal ── -->
<div class="modal-overlay" id="applyModal">
  <div class="modal">
    <div class="modal-header">
      <div>
        <div class="modal-title">Submit vendor application</div>
        <div class="modal-subtitle">Describe the service you will provide at this event</div>
      </div>
      <button class="modal-close" onclick="closeModal()">&#x2715;</button>
    </div>

    <!-- Event info preview -->
    <div class="modal-event-info">
      <div class="modal-event-name" id="modal-event-name">—</div>
      <div class="modal-event-meta" id="modal-event-meta">—</div>
    </div>

    <form method="post" action="/EventFlow/vendor/apply" id="applyForm">
      <input type="hidden" name="eventId" id="modal-event-id"/>

      <div class="form-group">
        <label>Service description</label>
        <textarea name="serviceDescription" id="serviceDesc"
                  placeholder="e.g. Providing catering and refreshments for 200 attendees. Menu includes momo, samosa, tea and snacks."
                  rows="5" required maxlength="500"
                  oninput="updateCount(this)"></textarea>
        <div class="char-count" id="charCount">0 / 500</div>
      </div>

      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary" style="width:auto">Submit application</button>
      </div>
    </form>
  </div>
</div>

<script>
function openApplyModal(eventId, eventName, eventDate, eventLocation) {
  document.getElementById('modal-event-id').value   = eventId;
  document.getElementById('modal-event-name').textContent = eventName;
  document.getElementById('modal-event-meta').textContent = eventDate + ' · ' + eventLocation;
  document.getElementById('serviceDesc').value = '';
  document.getElementById('charCount').textContent = '0 / 500';
  document.getElementById('charCount').classList.remove('warn');
  document.getElementById('applyModal').classList.add('open');
}

function closeModal() {
  document.getElementById('applyModal').classList.remove('open');
}

function updateCount(ta) {
  var len  = ta.value.length;
  var el   = document.getElementById('charCount');
  el.textContent = len + ' / 500';
  el.classList.toggle('warn', len > 450);
}

document.getElementById('applyModal').addEventListener('click', function(e) {
  if (e.target === this) closeModal();
});

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') closeModal();
});
</script>
</body>
</html>
