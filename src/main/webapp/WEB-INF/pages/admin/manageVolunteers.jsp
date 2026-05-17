<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
  <title>Manage Volunteers — EventFlow</title>
  <link rel="stylesheet" href="/EventFlow/css/style.css"/>
  <style>
    /* Task panel styles */
    .task-panel {
      display: none;
      padding: 12px 14px;
      background: var(--bg-page);
      border-top: 1px solid var(--border-faint);
    }
    .task-panel.open { display: block; }

    .task-list { list-style: none; display: flex; flex-direction: column; gap: 4px; margin-bottom: 10px; }
    .task-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 6px 10px;
      background: var(--bg-raised);
      border: 1px solid var(--border-faint);
      border-radius: var(--r-sm);
      font-size: 11px;
      color: var(--text-mid);
    }
    .task-item.done { color: var(--text-ghost); text-decoration: line-through; }
    .task-item .task-check {
      width: 14px; height: 14px;
      border-radius: 3px;
      border: 1px solid var(--border-strong);
      background: var(--bg-input);
      flex-shrink: 0;
      display: flex; align-items: center; justify-content: center;
    }
    .task-item.done .task-check {
      background: var(--success-bg);
      border-color: var(--success-border);
    }
    .task-item.done .task-check::after {
      content: '';
      width: 7px; height: 4px;
      border-left: 1.5px solid var(--success-text);
      border-bottom: 1.5px solid var(--success-text);
      transform: rotate(-45deg) translate(0.5px, -0.5px);
    }
    .task-meta { font-size: 10px; color: var(--text-dim); margin-left: 2px; }
    .task-del-btn {
      margin-left: auto;
      display: inline-flex;
      align-items: center;
      height: 20px;
      padding: 0 7px;
      border: 1px solid var(--danger-border);
      background: var(--danger-bg);
      color: var(--danger-text);
      border-radius: var(--r-xs);
      font-size: 10px;
      cursor: pointer;
    }
    .task-del-btn:hover { background: #2e1515; }

    .add-task-form {
      display: flex;
      gap: 6px;
      align-items: flex-end;
      flex-wrap: wrap;
      padding-top: 8px;
      border-top: 1px solid var(--border-faint);
    }
    .add-task-form .form-group { margin: 0; flex: 1; min-width: 160px; }
    .add-task-form .form-group input,
    .add-task-form .form-group select { height: 30px; font-size: 11px; }
    .add-task-btn {
      height: 30px;
      padding: 0 12px;
      background: var(--bg-raised);
      color: var(--text-78);
      border: 1px solid var(--border-strong);
      border-radius: var(--r-sm);
      font-size: 11px;
      font-weight: 500;
      cursor: pointer;
      white-space: nowrap;
    }
    .add-task-btn:hover { background: var(--bg-hover); }

    .task-toggle-btn {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      height: 22px;
      padding: 0 8px;
      border: 1px solid var(--border-subtle);
      background: transparent;
      color: var(--text-dim);
      border-radius: var(--r-xs);
      font-size: 10px;
      cursor: pointer;
      transition: all 0.1s;
    }
    .task-toggle-btn:hover { background: var(--bg-hover); color: var(--text-mid); }
    .task-toggle-btn svg { width: 10px; height: 10px; transition: transform 0.15s; }
    .task-toggle-btn.open svg { transform: rotate(180deg); }

    .prog-bar { height: 3px; background: var(--bg-raised); border-radius: 2px; overflow: hidden; width: 60px; }
    .prog-fill { height: 100%; background: var(--success-text); border-radius: 2px; }

    /* Predefined task categories */
    .task-presets {
      display: flex;
      flex-wrap: wrap;
      gap: 4px;
      margin-bottom: 8px;
      padding-bottom: 8px;
      border-bottom: 1px solid var(--border-faint);
    }
    .preset-btn {
      display: inline-flex;
      align-items: center;
      height: 22px;
      padding: 0 9px;
      border: 1px solid var(--border-subtle);
      background: transparent;
      color: var(--text-ghost);
      border-radius: 20px;
      font-size: 10px;
      cursor: pointer;
      transition: all 0.1s;
    }
    .preset-btn:hover { background: var(--bg-hover); color: var(--text-mid); border-color: var(--border-default); }
    .preset-lbl {
      font-size: 9px;
      color: var(--text-ghost);
      text-transform: uppercase;
      letter-spacing: 0.07em;
      margin-bottom: 5px;
    }
  </style>
</head>
<body>
<% request.setAttribute("activePage", "volunteers"); %>
<% request.setAttribute("breadcrumbParent", "Admin"); %>
<% request.setAttribute("breadcrumbCurrent", "Manage Volunteers"); %>
<div class="dashboard-container">

  <%@ include file="/WEB-INF/pages/shared/_sidebarAdmin.jsp" %>

  <div class="main-content">
    <%@ include file="/WEB-INF/pages/shared/_topbar.jsp" %>

    <div class="content-wrap">
      <div class="page-header">
        <div>
          <h1>Manage Volunteers</h1>
          <p>Assign volunteers to events and manage their tasks</p>
        </div>
        <span class="nav-badge" style="font-size:11px;padding:4px 10px">${assignments.size()} assignments</span>
      </div>

      <!-- ── Assign volunteer to event ── -->
      <div class="form-card">
        <div class="form-card-header">
          <h2>Assign volunteer to event</h2>
          <p>Select a volunteer and an event to create an assignment.</p>
        </div>
        <form method="post" action="/EventFlow/admin/volunteers">
          <input type="hidden" name="action" value="assign"/>
          <div class="form-row">
            <div class="form-group">
              <label>Volunteer</label>
              <select name="volunteerId" required>
                <option value="">Select volunteer</option>
                <c:forEach var="v" items="${volunteers}">
                  <option value="${v.id}">${v.full_name} (${v.email})</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label>Event</label>
              <select name="eventId" required>
                <option value="">Select event</option>
                <c:forEach var="e" items="${events}">
                  <option value="${e[0]}">${e[1]} — ${e[3]}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn-primary" style="width:auto">Assign Volunteer</button>
          </div>
        </form>
      </div>

      <!-- ── Current Assignments with Task Management ── -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">Current Assignments &amp; Tasks</span>
          <span class="nav-badge">${assignments.size()} total</span>
        </div>

        <c:choose>
          <c:when test="${empty assignments}">
            <div style="text-align:center;padding:32px;color:var(--text-ghost);font-size:12px">
              No assignments yet. Assign a volunteer above.
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="a" items="${assignments}" varStatus="s">
              <c:set var="tasks" value="${tasksByAssignment[a.id]}"/>
              <c:set var="pct"   value="${a.task_count > 0 ? (a.completed_count * 100) / a.task_count : 0}"/>

              <!-- Assignment row -->
              <div style="border-bottom: 1px solid var(--border-faint);">
                <div style="display:grid;grid-template-columns:1fr 1fr 120px 140px 100px;align-items:center;padding:10px 14px;gap:10px;">

                  <!-- Volunteer -->
                  <div>
                    <div style="font-size:12px;font-weight:500;color:var(--text-78)">${a.volunteer_name}</div>
                    <div style="font-size:10px;color:var(--text-dim)">${a.volunteer_email}</div>
                  </div>

                  <!-- Event -->
                  <div>
                    <div style="font-size:12px;color:var(--text-mid)">${a.event_title}</div>
                    <div style="font-size:10px;color:var(--text-dim)">
                      <fmt:formatDate value="${a.event_date}" pattern="dd MMM yyyy"/>
                      &middot; ${a.location}
                    </div>
                  </div>

                  <!-- Task progress -->
                  <div>
                    <c:choose>
                      <c:when test="${a.task_count == 0}">
                        <span style="font-size:10px;color:var(--text-ghost)">No tasks yet</span>
                      </c:when>
                      <c:otherwise>
                        <div style="font-size:10px;color:var(--text-dim);margin-bottom:4px">${a.completed_count}/${a.task_count} done</div>
                        <div class="prog-bar"><div class="prog-fill" style="width:${pct}%"></div></div>
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <!-- Task toggle button -->
                  <div>
                    <button type="button" class="task-toggle-btn" id="toggle-${a.id}" onclick="toggleTasks(${a.id})">
                      <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M2 5l5 5 5-5"/></svg>
                      Manage Tasks
                    </button>
                  </div>

                  <!-- Remove assignment -->
                  <div style="text-align:right">
                    <form method="post" action="/EventFlow/admin/volunteers" style="display:inline" onsubmit="return confirm('Remove this assignment and all its tasks?')">
                      <input type="hidden" name="action"       value="remove"/>
                      <input type="hidden" name="assignmentId" value="${a.id}"/>
                      <button type="submit" class="btn-danger">Remove</button>
                    </form>
                  </div>
                </div>

                <!-- Task panel (collapsible) -->
                <div class="task-panel" id="tasks-${a.id}">

                  <!-- Predefined task categories -->
                  <div class="preset-lbl">Quick add task:</div>
                  <div class="task-presets">
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Crowd Management')">Crowd Management</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Stage Setup & Management')">Stage Setup</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Hosting & MC')">Hosting / MC</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Registration Desk')">Registration Desk</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Security')">Security</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Logistics & Transport')">Logistics</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Technical Support (AV/IT)')">Technical Support</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Catering & Food Service')">Catering</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Photography & Documentation')">Photography</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Guest Relations')">Guest Relations</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'Cleanup & Breakdown')">Cleanup</button>
                    <button type="button" class="preset-btn" onclick="setTaskTitle(${a.id}, 'First Aid Support')">First Aid</button>
                  </div>

                  <!-- Existing tasks -->
                  <c:choose>
                    <c:when test="${not empty tasks}">
                      <ul class="task-list">
                        <c:forEach var="t" items="${tasks}">
                          <li class="task-item ${t.is_completed == 1 ? 'done' : ''}">
                            <div class="task-check"></div>
                            <span>${t.task_title}</span>
                            <c:if test="${not empty t.task_description}">
                              <span class="task-meta">— ${t.task_description}</span>
                            </c:if>
                            <form method="post" action="/EventFlow/admin/volunteers" style="margin-left:auto">
                              <input type="hidden" name="action" value="removeTask"/>
                              <input type="hidden" name="taskId" value="${t.id}"/>
                              <button type="submit" class="task-del-btn">Remove</button>
                            </form>
                          </li>
                        </c:forEach>
                      </ul>
                    </c:when>
                    <c:otherwise>
                      <div style="font-size:11px;color:var(--text-ghost);margin-bottom:10px">No tasks assigned yet. Add tasks using the quick buttons or custom form below.</div>
                    </c:otherwise>
                  </c:choose>

                  <!-- Add task form -->
                  <form method="post" action="/EventFlow/admin/volunteers" class="add-task-form">
                    <input type="hidden" name="action"       value="addTask"/>
                    <input type="hidden" name="assignmentId" value="${a.id}"/>
                    <div class="form-group">
                      <label>Task Title</label>
                      <input type="text" name="taskTitle" id="taskTitle-${a.id}" placeholder="e.g. Crowd Management" required/>
                    </div>
                    <div class="form-group">
                      <label>Notes (optional)</label>
                      <input type="text" name="taskDescription" placeholder="Any extra details..."/>
                    </div>
                    <button type="submit" class="add-task-btn">+ Add Task</button>
                  </form>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- ── All Volunteers List ── -->
      <div class="table-container">
        <div class="table-header">
          <span class="table-title">All Volunteers</span>
          <span class="nav-badge">${volunteers.size()} total</span>
        </div>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Assignments</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="v" items="${volunteers}" varStatus="s">
              <tr>
                <td class="td-hint">${s.count}</td>
                <td class="td-primary">${v.full_name}</td>
                <td class="td-secondary">${v.email}</td>
                <td class="td-secondary">${v.phone}</td>
                <td class="td-secondary">${v.assignment_count}</td>
                <td>
                  <c:choose>
                    <c:when test="${v.is_active == 1}"><span class="badge badge-success">Active</span></c:when>
                    <c:otherwise><span class="badge badge-neutral">Inactive</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty volunteers}">
              <tr><td colspan="6" style="text-align:center;color:var(--text-ghost);padding:24px">No volunteers found.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>

<script>
function toggleTasks(assignmentId) {
  const panel  = document.getElementById('tasks-' + assignmentId);
  const toggle = document.getElementById('toggle-' + assignmentId);
  const isOpen = panel.classList.toggle('open');
  toggle.classList.toggle('open', isOpen);
}

function setTaskTitle(assignmentId, title) {
  const input = document.getElementById('taskTitle-' + assignmentId);
  if (input) input.value = title;
  // Also open the panel
  const panel  = document.getElementById('tasks-' + assignmentId);
  const toggle = document.getElementById('toggle-' + assignmentId);
  if (!panel.classList.contains('open')) {
    panel.classList.add('open');
    toggle.classList.add('open');
  }
}
</script>
</body>
</html>
