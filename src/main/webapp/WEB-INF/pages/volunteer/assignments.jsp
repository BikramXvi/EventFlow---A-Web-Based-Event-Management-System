<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("volunteer")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Assignments — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
  <style>
    /* Assignment card */
    .assignment-card {
      background: var(--bg-panel);
      border: 1px solid var(--border-subtle);
      border-radius: var(--r-lg);
      overflow: hidden;
    }
    .assignment-card-header {
      display: grid;
      grid-template-columns: 1fr auto;
      align-items: start;
      padding: 14px 16px;
      gap: 12px;
      cursor: pointer;
      transition: background 0.1s;
    }
    .assignment-card-header:hover { background: var(--bg-raised); }

    .ac-event-title {
      font-size: 13px;
      font-weight: 600;
      color: var(--text-78);
      margin-bottom: 4px;
      letter-spacing: -0.01em;
    }
    .ac-meta {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      font-size: 11px;
      color: var(--text-dim);
    }
    .ac-meta-item { display: flex; align-items: center; gap: 4px; }
    .ac-meta-item svg { width: 11px; height: 11px; color: var(--text-ghost); }

    .ac-badges { display: flex; gap: 6px; align-items: center; flex-shrink: 0; flex-wrap: wrap; justify-content: flex-end; }

    /* Task section */
    .task-section {
      display: none;
      border-top: 1px solid var(--border-faint);
      padding: 12px 16px;
      background: var(--bg-page);
    }
    .task-section.open { display: block; }

    .task-section-label {
      font-size: 9px;
      font-weight: 600;
      color: var(--text-ghost);
      text-transform: uppercase;
      letter-spacing: 0.08em;
      margin-bottom: 8px;
    }

    .task-rows { display: flex; flex-direction: column; gap: 4px; }

    .task-row {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 8px 10px;
      background: var(--bg-raised);
      border: 1px solid var(--border-faint);
      border-radius: var(--r-sm);
      font-size: 12px;
      transition: background 0.1s;
    }
    .task-row:hover { background: var(--bg-hover); }
    .task-row.done { opacity: 0.65; }

    .task-row label {
      display: flex;
      align-items: center;
      gap: 10px;
      cursor: pointer;
      flex: 1;
      font-size: 12px;
      color: var(--text-mid);
    }
    .task-row.done label { color: var(--text-dim); text-decoration: line-through; }

    .task-cb {
      width: 16px; height: 16px;
      border: 1px solid var(--border-strong);
      border-radius: 3px;
      background: var(--bg-input);
      flex-shrink: 0;
      cursor: pointer;
      accent-color: var(--success-text);
    }

    .task-notes { font-size: 10px; color: var(--text-ghost); margin-left: 26px; }

    .task-progress {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 10px;
    }
    .tp-bar { flex: 1; height: 3px; background: var(--bg-active); border-radius: 2px; overflow: hidden; }
    .tp-fill { height: 100%; background: var(--success-text); border-radius: 2px; transition: width 0.3s; }
    .tp-label { font-size: 10px; color: var(--text-dim); white-space: nowrap; }

    .no-tasks-msg {
      font-size: 11px;
      color: var(--text-ghost);
      padding: 8px 0;
    }

    .toggle-icon { transition: transform 0.15s; }
    .open .toggle-icon { transform: rotate(180deg); }

    .prog-summary {
      font-size: 10px;
      color: var(--text-dim);
      margin-top: 2px;
    }
    .prog-summary .done-count { color: var(--success-text); }
  </style>
</head>
<body>
<% request.setAttribute("activePage", "assignments"); %>
<% request.setAttribute("breadcrumbParent", "Volunteer"); %>
<% request.setAttribute("breadcrumbCurrent", "My Assignments"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarVolunteer.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>My Assignments</h1>
          <p>Events you've been assigned to — click an assignment to see your tasks</p>
        </div>
        <span class="nav-badge" style="font-size:11px;padding:4px 10px">${assignments.size()} assignments</span>
      </div>

      <c:choose>
        <c:when test="${empty assignments}">
          <div class="table-container" style="padding:40px;text-align:center;color:var(--text-ghost)">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="36" height="36" style="display:block;margin:0 auto 12px;color:var(--border-default)"><rect x="2" y="3.5" width="20" height="17" rx="2"/><line x1="7" y1="1.5" x2="7" y2="5.5"/><line x1="17" y1="1.5" x2="17" y2="5.5"/><line x1="2" y1="9" x2="22" y2="9"/></svg>
            <div style="font-size:13px;color:var(--text-dim)">No assignments yet</div>
            <div style="font-size:11px;margin-top:4px">An admin will assign you to events soon.</div>
          </div>
        </c:when>
        <c:otherwise>
          <div style="display:flex;flex-direction:column;gap:8px">
            <c:forEach var="a" items="${assignments}" varStatus="s">
              <c:set var="tasks"    value="${tasksByAssignment[a.id]}"/>
              <c:set var="taskCount" value="${tasks != null ? tasks.size() : 0}"/>

              <%-- Count completed --%>
              <c:set var="doneCount" value="0"/>
              <c:forEach var="t" items="${tasks}">
                <c:if test="${t.is_completed == 1}">
                  <c:set var="doneCount" value="${doneCount + 1}"/>
                </c:if>
              </c:forEach>
              <c:set var="pct" value="${taskCount > 0 ? (doneCount * 100) / taskCount : 0}"/>

              <div class="assignment-card" id="card-${a.id}">
                <!-- Header (clickable) -->
                <div class="assignment-card-header" onclick="toggleCard(${a.id})">
                  <div>
                    <div class="ac-event-title">${a.title}</div>
                    <div class="ac-meta">
                      <div class="ac-meta-item">
                        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><path d="M7 1.5C4.5 1.5 2.5 3.5 2.5 6c0 3.5 4.5 7 4.5 7s4.5-3.5 4.5-7c0-2.5-2-4.5-4.5-4.5z"/><circle cx="7" cy="6" r="1.5"/></svg>
                        ${a.location}
                      </div>
                      <div class="ac-meta-item">
                        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><rect x="1.5" y="2.5" width="11" height="10" rx="1.2"/><line x1="1.5" y1="5.5" x2="12.5" y2="5.5"/></svg>
                        <fmt:formatDate value="${a.event_date}" pattern="dd MMM yyyy"/>
                      </div>
                      <div class="ac-meta-item">
                        <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><circle cx="7" cy="7" r="5"/><path d="M7 4v3l2 1.5"/></svg>
                        <fmt:formatDate value="${a.start_time}" pattern="h:mm a"/>
                      </div>
                      <c:if test="${taskCount > 0}">
                        <div class="ac-meta-item prog-summary">
                          <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><polyline points="2,8 5,11 12,3"/></svg>
                          <span class="done-count">${doneCount}</span>/${taskCount} tasks done
                        </div>
                      </c:if>
                    </div>
                  </div>
                  <div class="ac-badges">
                    <c:choose>
                      <c:when test="${a.event_status == 'upcoming'}"><span class="badge badge-info">Upcoming</span></c:when>
                      <c:when test="${a.event_status == 'ongoing'}"><span class="badge badge-success">Ongoing</span></c:when>
                      <c:when test="${a.event_status == 'completed'}"><span class="badge badge-neutral">Completed</span></c:when>
                      <c:otherwise><span class="badge badge-danger">Cancelled</span></c:otherwise>
                    </c:choose>
                    <c:choose>
                      <c:when test="${a.assignment_status == 'assigned'}"><span class="badge badge-warning">Assigned</span></c:when>
                      <c:when test="${a.assignment_status == 'completed'}"><span class="badge badge-success">Done</span></c:when>
                      <c:otherwise><span class="badge badge-neutral">${a.assignment_status}</span></c:otherwise>
                    </c:choose>
                    <svg class="toggle-icon" id="icon-${a.id}" viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="12" height="12"><path d="M2 5l5 5 5-5"/></svg>
                  </div>
                </div>

                <!-- Task section (expandable) -->
                <div class="task-section" id="tasks-${a.id}">
                  <div class="task-section-label">Your Tasks</div>

                  <c:choose>
                    <c:when test="${not empty tasks}">
                      <div class="task-progress">
                        <div class="tp-bar"><div class="tp-fill" style="width:${pct}%"></div></div>
                        <span class="tp-label">${doneCount} of ${taskCount} completed</span>
                      </div>
                      <div class="task-rows">
                        <c:forEach var="t" items="${tasks}">
                          <div class="task-row ${t.is_completed == 1 ? 'done' : ''}">
                            <form method="post" action="/EventFlow/volunteer/assignments" style="display:contents">
                              <input type="hidden" name="action"    value="toggleTask"/>
                              <input type="hidden" name="taskId"    value="${t.id}"/>
                              <input type="hidden" name="completed" value="${t.is_completed == 1 ? 0 : 1}"/>
                              <label>
                                <input type="checkbox" class="task-cb"
                                  ${t.is_completed == 1 ? 'checked' : ''}
                                  onchange="this.form.submit()"
                                  title="Mark as ${t.is_completed == 1 ? 'incomplete' : 'complete'}"/>
                                ${t.task_title}
                              </label>
                            </form>
                          </div>
                          <c:if test="${not empty t.task_description}">
                            <div class="task-notes">${t.task_description}</div>
                          </c:if>
                        </c:forEach>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <div class="no-tasks-msg">No tasks assigned for this event yet. Check back later.</div>
                    </c:otherwise>
                  </c:choose>
                </div>

              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</div>

<script>
function toggleCard(id) {
  const section = document.getElementById('tasks-' + id);
  const icon    = document.getElementById('icon-' + id);
  const isOpen  = section.classList.toggle('open');
  if (isOpen) icon.style.transform = 'rotate(180deg)';
  else        icon.style.transform = '';
}
</script>
</body>
</html>
