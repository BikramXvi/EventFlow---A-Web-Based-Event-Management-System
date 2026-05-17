<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Events — EventFlow</title>
  <meta name="description" content="Browse upcoming events in Nepal. Find concerts, tech talks, workshops and more."/>
  <link rel="stylesheet" href="/EventFlow/css/landing.css"/>
  <style>
    .events-page { background: #0d0d0d; min-height: 100vh; }

    /* ── Hero event ── */
    .hero-event {
      display: grid;
      grid-template-columns: 380px 1fr;
      border: 1px solid #272727;
      border-radius: 12px;
      overflow: hidden;
      background: #141414;
      margin: 0 48px 32px;
    }

    .hero-event-img {
      position: relative;
      min-height: 320px;
      display: flex;
      align-items: flex-end;
      padding: 20px;
      overflow: hidden;
    }

    .hero-event-img img {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: center;
    }

    .hero-event-img .img-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(to top, rgba(13,13,13,0.85) 0%, rgba(13,13,13,0.2) 100%);
    }

    .hero-event-img .gradient-fallback {
      position: absolute;
      inset: 0;
    }

    .hero-date-badge {
      position: relative;
      z-index: 2;
      background: rgba(13,13,13,0.88);
      border: 1px solid #333;
      border-radius: 8px;
      padding: 10px 14px;
      text-align: center;
      backdrop-filter: blur(8px);
    }

    .hero-date-badge-month {
      font-size: 10px;
      font-weight: 700;
      color: #4caf74;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      line-height: 1;
      margin-bottom: 4px;
    }

    .hero-date-badge-day {
      font-size: 28px;
      font-weight: 700;
      color: #f5f5f5;
      line-height: 1;
      letter-spacing: -0.04em;
    }

    .hero-event-body {
      padding: 28px;
      display: flex;
      flex-direction: column;
      gap: 14px;
    }

    .hero-event-title {
      font-size: 22px;
      font-weight: 700;
      color: #f5f5f5;
      letter-spacing: -0.02em;
      line-height: 1.2;
    }

    .hero-event-desc {
      font-size: 13px;
      color: #606060;
      line-height: 1.7;
      font-weight: 300;
    }

    .event-meta-list {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .event-meta-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: #8a8a8a;
    }

    .event-meta-item svg {
      width: 14px;
      height: 14px;
      color: #404040;
      flex-shrink: 0;
    }

    .hero-event-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding-top: 14px;
      border-top: 1px solid #1e1e1e;
      margin-top: auto;
    }

    .capacity-bar-wrap {
      flex: 1;
      margin-right: 20px;
    }

    .capacity-label {
      font-size: 11px;
      color: #606060;
      margin-bottom: 6px;
      display: flex;
      justify-content: space-between;
    }

    .capacity-bar {
      height: 3px;
      background: #1e1e1e;
      border-radius: 2px;
      overflow: hidden;
    }

    .capacity-fill {
      height: 100%;
      background: #4caf74;
      border-radius: 2px;
      transition: width 0.3s;
    }

    .hero-reg-btn {
      height: 36px;
      padding: 0 20px;
      border-radius: 7px;
      border: 1px solid #444;
      background: #1c1c1c;
      font-size: 13px;
      font-weight: 600;
      color: #c0c0c0;
      cursor: pointer;
      font-family: inherit;
      transition: all 0.15s;
      white-space: nowrap;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .hero-reg-btn:hover {
      background: #242424;
      color: #f5f5f5;
      border-color: #555;
    }

    /* ── Badges ── */
    .badge {
      display: inline-flex;
      align-items: center;
      padding: 2px 8px;
      border-radius: 20px;
      font-size: 10px;
      font-weight: 600;
      border: 1px solid;
    }

    .badge-upcoming { background: #0d1d30; color: #5b9bd6; border-color: #1a3a5c; }
    .badge-ongoing  { background: #0e2018; color: #4caf74; border-color: #1a3d27; }
    .badge-draft    { background: #1c1c1c; color: #606060; border-color: #333; }
    .badge-full     { background: #221a08; color: #c49a3a; border-color: #3d2e0d; }

    /* ── Filter bar ── */
    .filter-bar {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 16px 48px;
      border-bottom: 1px solid #1e1e1e;
      background: #0d0d0d;
      flex-wrap: wrap;
    }

    .search-box {
      display: flex;
      align-items: center;
      gap: 7px;
      background: #111;
      border: 1px solid #272727;
      border-radius: 6px;
      padding: 0 10px;
      height: 30px;
      flex: 0 0 240px;
    }

    .search-box svg {
      width: 12px;
      height: 12px;
      color: #404040;
      flex-shrink: 0;
    }

    .search-box input {
      border: none;
      background: transparent;
      outline: none;
      font-size: 12px;
      color: #c0c0c0;
      width: 100%;
      font-family: inherit;
    }

    .search-box input::placeholder { color: #2e2e2e; }

    .filter-chip {
      height: 28px;
      padding: 0 12px;
      border-radius: 20px;
      border: 1px solid #272727;
      background: transparent;
      font-size: 11px;
      font-weight: 500;
      color: #404040;
      cursor: pointer;
      font-family: inherit;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      transition: all 0.1s;
    }

    .filter-chip:hover { background: #1c1c1c; color: #606060; }
    .filter-chip.active { background: #1c1c1c; border-color: #444; color: #8a8a8a; }

    /* ── Events list ── */
    .events-list {
      padding: 24px 48px 48px;
      display: flex;
      flex-direction: column;
      gap: 1px;
      background: #272727;
      border: 1px solid #272727;
      border-radius: 10px;
      overflow: hidden;
      margin: 0 48px 48px;
    }

    .event-row {
      display: grid;
      grid-template-columns: 80px 1fr auto;
      gap: 0;
      background: #141414;
      transition: background 0.1s;
    }

    .event-row:hover { background: #1c1c1c; }

    /* Date column */
    .er-date {
      padding: 20px 16px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      border-right: 1px solid #1e1e1e;
    }

    .er-date-day {
      font-size: 22px;
      font-weight: 700;
      color: #dedede;
      line-height: 1;
      letter-spacing: -0.03em;
    }

    .er-date-month {
      font-size: 9px;
      font-weight: 600;
      color: #404040;
      text-transform: uppercase;
      letter-spacing: 0.07em;
      margin-top: 3px;
    }

    /* Event info column */
    .er-body {
      padding: 16px 20px;
      display: flex;
      gap: 16px;
    }

    .er-thumb {
      width: 72px;
      height: 72px;
      border-radius: 6px;
      overflow: hidden;
      flex-shrink: 0;
      position: relative;
    }

    .er-thumb img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .er-thumb .thumb-fallback {
      width: 100%;
      height: 100%;
    }

    .er-info { flex: 1; min-width: 0; }

    .er-title {
      font-size: 14px;
      font-weight: 600;
      color: #c0c0c0;
      margin-bottom: 4px;
      letter-spacing: -0.01em;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .er-desc {
      font-size: 12px;
      color: #606060;
      line-height: 1.55;
      margin-bottom: 8px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .er-meta {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
    }

    .er-meta-item {
      display: flex;
      align-items: center;
      gap: 5px;
      font-size: 11px;
      color: #8a8a8a;
    }

    .er-meta-item svg {
      width: 12px;
      height: 12px;
      color: #404040;
    }

    /* Action column */
    .er-action {
      padding: 16px 20px;
      display: flex;
      flex-direction: column;
      align-items: flex-end;
      justify-content: space-between;
      gap: 10px;
      border-left: 1px solid #1e1e1e;
      min-width: 160px;
    }

    .er-capacity {
      font-size: 10px;
      color: #606060;
      text-align: right;
    }

    .er-cap-bar {
      width: 100%;
      height: 2px;
      background: #1e1e1e;
      border-radius: 1px;
      overflow: hidden;
      margin-top: 4px;
    }

    .er-cap-fill {
      height: 100%;
      background: #4caf74;
      border-radius: 1px;
    }

    .er-btn {
      height: 28px;
      padding: 0 14px;
      border-radius: 5px;
      border: 1px solid #333;
      background: transparent;
      font-size: 11px;
      font-weight: 500;
      color: #8a8a8a;
      cursor: pointer;
      font-family: inherit;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      transition: all 0.1s;
      white-space: nowrap;
    }

    .er-btn:hover { background: #1c1c1c; color: #c0c0c0; border-color: #444; }
    .er-btn.full  { color: #c49a3a; border-color: #3d2e0d; background: #221a08; cursor: default; }
    .er-btn.login { color: #5b9bd6; border-color: #1a3a5c; background: #0d1d30; }

    /* ── Section labels ── */
    .section-eyebrow {
      font-size: 10px;
      font-weight: 600;
      color: #404040;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      margin-bottom: 14px;
      font-family: monospace;
    }

    /* ── Page header ── */
    .pub-hero {
      padding: 48px 48px 32px;
      border-bottom: 1px solid #1e1e1e;
    }

    .pub-hero-eyebrow {
      font-size: 10px;
      font-weight: 600;
      color: #404040;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      margin-bottom: 10px;
      font-family: monospace;
    }

    .pub-hero-h1 {
      font-size: 32px;
      font-weight: 700;
      color: #f5f5f5;
      letter-spacing: -0.03em;
      line-height: 1.1;
      margin-bottom: 8px;
    }

    .pub-hero-h1 em { font-style: italic; color: #c0c0c0; }

    .pub-hero-sub {
      font-size: 14px;
      color: #606060;
      line-height: 1.7;
      margin-bottom: 20px;
      max-width: 480px;
      font-weight: 300;
    }

    .pub-stats {
      display: inline-flex;
      border: 1px solid #1e1e1e;
      border-radius: 8px;
      overflow: hidden;
    }

    .pub-stat {
      padding: 10px 20px;
      text-align: center;
      border-right: 1px solid #1e1e1e;
    }

    .pub-stat:last-child { border-right: none; }

    .pub-stat-v {
      font-size: 18px;
      font-weight: 700;
      color: #dedede;
      letter-spacing: -0.03em;
      line-height: 1;
    }

    .pub-stat-l {
      font-size: 9px;
      color: #404040;
      text-transform: uppercase;
      letter-spacing: 0.07em;
      margin-top: 3px;
    }

    /* ── Gradient palette for events without images ── */
    .gp-0 { background: #1a2a1a; }
    .gp-1 { background: #1a1a2e; }
    .gp-2 { background: #2a1a1a; }
    .gp-3 { background: #1a2a2a; }
    .gp-4 { background: #2a1a2a; }
    .gp-5 { background: #2a2a1a; }
    .gp-6 { background: #1e1a2a; }
    .gp-7 { background: #2a1e1a; }

    /* ── Empty state ── */
    .empty-state {
      text-align: center;
      padding: 64px 24px;
      color: #404040;
      font-size: 14px;
    }

    .empty-state svg {
      width: 40px;
      height: 40px;
      color: #272727;
      margin-bottom: 14px;
    }

    /* ── Responsive ── */
    @media (max-width: 860px) {
      .hero-event { grid-template-columns: 1fr; margin: 0 24px 24px; }
      .hero-event-img { min-height: 180px; }
      .filter-bar { padding: 12px 24px; }
      .events-list { margin: 0 24px 24px; }
      .pub-hero { padding: 32px 24px 24px; }
      .event-row { grid-template-columns: 60px 1fr; }
      .er-action { display: none; }
    }
  </style>
</head>
<body>
<div class="events-page">

  <!-- NAV -->
  <nav class="nav">
    <a class="nav-brand" href="/EventFlow/">
      <div class="nav-logo"><span></span><span></span><span></span><span></span></div>
      <span class="nav-brand-name">EventFlow</span>
    </a>
    <div class="nav-links">
      <a href="/EventFlow/events" style="color:#c0c0c0;font-weight:500">Events</a>
      <a href="/EventFlow/#contact">Contact</a>
    </div>
    <div class="nav-ctas">
      <a href="/EventFlow/login"    class="btn-ghost">Sign in</a>
      <a href="/EventFlow/register" class="btn-nav-cta">Register free</a>
    </div>
  </nav>

  <!-- PAGE HERO -->
  <div class="pub-hero">
    <div class="pub-hero-eyebrow">Events in Nepal</div>
    <h1 class="pub-hero-h1">Discover what's<br/><em>happening near you</em></h1>
    <p class="pub-hero-sub">Browse concerts, tech talks, workshops, and festivals. No account needed to explore.</p>
    <div class="pub-stats">
      <div class="pub-stat">
        <div class="pub-stat-v">${events.size() + (featured != null ? 1 : 0)}</div>
        <div class="pub-stat-l">Events</div>
      </div>
      <div class="pub-stat">
        <div class="pub-stat-v">KTM</div>
        <div class="pub-stat-l">City</div>
      </div>
      <div class="pub-stat">
        <div class="pub-stat-v">Free</div>
        <div class="pub-stat-l">To explore</div>
      </div>
    </div>
  </div>

  <!-- FILTER BAR -->
  <form class="filter-bar" method="get" action="/EventFlow/events">
    <div class="search-box">
      <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="6" cy="6" r="4"/><line x1="9.5" y1="9.5" x2="13" y2="13"/></svg>
      <input type="text" name="search" value="${search}" placeholder="Search events, venues..."/>
    </div>
    <a href="/EventFlow/events" class="filter-chip ${filter == 'all' || filter == '' ? 'active' : ''}">All</a>
    <a href="/EventFlow/events?filter=this_week" class="filter-chip ${filter == 'this_week' ? 'active' : ''}">This week</a>
    <a href="/EventFlow/events?filter=upcoming"  class="filter-chip ${filter == 'upcoming'  ? 'active' : ''}">Upcoming</a>
    <a href="/EventFlow/events?filter=ongoing"   class="filter-chip ${filter == 'ongoing'   ? 'active' : ''}">Happening now</a>
    <button type="submit" class="filter-chip" style="cursor:pointer">Search</button>
  </form>

  <!-- FEATURED EVENT (hero card) -->
  <c:if test="${featured != null}">
    <div style="padding: 28px 48px 0">
      <div class="section-eyebrow">Featured event</div>
    </div>
    <div class="hero-event">
      <div class="hero-event-img">
        <c:choose>
          <c:when test="${not empty featured.image_path}">
            <img src="/EventFlow/uploads/events/${featured.image_path}" alt="${featured.title}"/>
            <div class="img-overlay"></div>
          </c:when>
          <c:otherwise>
            <div class="gradient-fallback gp-0"></div>
          </c:otherwise>
        </c:choose>
        <div class="hero-date-badge">
          <div class="hero-date-badge-month">
            <fmt:formatDate value="${featured.event_date}" pattern="MMM"/>
          </div>
          <div class="hero-date-badge-day">
            <fmt:formatDate value="${featured.event_date}" pattern="dd"/>
          </div>
        </div>
      </div>
      <div class="hero-event-body">
        <div style="display:flex;gap:7px;flex-wrap:wrap">
          <c:choose>
            <c:when test="${featured.status == 'ongoing'}">  <span class="badge badge-ongoing">Happening now</span></c:when>
            <c:otherwise>                                    <span class="badge badge-upcoming">Upcoming</span></c:otherwise>
          </c:choose>
        </div>
        <div class="hero-event-title">${featured.title}</div>
        <div class="hero-event-desc">${featured.description}</div>
        <div class="event-meta-list">
          <div class="event-meta-item">
            <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><path d="M7 1.5C4.5 1.5 2.5 3.5 2.5 6c0 3.5 4.5 7 4.5 7s4.5-3.5 4.5-7c0-2.5-2-4.5-4.5-4.5z"/><circle cx="7" cy="6" r="1.5"/></svg>
            ${featured.location}
          </div>
          <div class="event-meta-item">
            <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><circle cx="7" cy="7" r="5"/><path d="M7 4v3l2 1.5"/></svg>
            <fmt:formatDate value="${featured.start_time}" pattern="h:mm a"/> —
            <fmt:formatDate value="${featured.end_time}"   pattern="h:mm a"/>
          </div>
          <div class="event-meta-item">
            <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><circle cx="7" cy="4.5" r="2.2"/><path d="M2 12c0-2.5 2.2-4 5-4s5 1.5 5 4"/></svg>
            ${featured.registered_count} registered · ${featured.capacity - featured.registered_count} spots left
          </div>
          <div class="event-meta-item">
            <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><rect x="1.5" y="2.5" width="11" height="10" rx="1.2"/><line x1="1.5" y1="5.5" x2="12.5" y2="5.5"/></svg>
            Organised by ${featured.organizer}
          </div>
        </div>
        <div class="hero-event-footer">
          <div class="capacity-bar-wrap">
            <div class="capacity-label">
              <span>${featured.registered_count} / ${featured.capacity} registered</span>
              <span>${(featured.registered_count * 100) / featured.capacity}% full</span>
            </div>
            <div class="capacity-bar">
              <div class="capacity-fill" style="width:${(featured.registered_count * 100) / featured.capacity}%"></div>
            </div>
          </div>
          <c:choose>
            <c:when test="${sessionScope.userRole == 'attendee'}">
              <a href="/EventFlow/attendee/events" class="hero-reg-btn">Register now →</a>
            </c:when>
            <c:otherwise>
              <a href="/EventFlow/register" class="hero-reg-btn">Sign up to register →</a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </c:if>

  <!-- EVENTS LIST -->
  <div style="padding: 0 48px 16px">
    <div class="section-eyebrow">
      <c:choose>
        <c:when test="${not empty search}">Results for "${search}"</c:when>
        <c:otherwise>All upcoming events</c:otherwise>
      </c:choose>
    </div>
  </div>

  <c:choose>
    <c:when test="${empty events}">
      <div class="empty-state" style="margin: 0 48px 48px; border: 1px solid #1e1e1e; border-radius: 10px; background: #141414">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3"><rect x="2" y="3.5" width="20" height="17" rx="2"/><line x1="7" y1="1.5" x2="7" y2="5.5"/><line x1="17" y1="1.5" x2="17" y2="5.5"/><line x1="2" y1="9" x2="22" y2="9"/></svg>
        <div style="color:#8a8a8a;margin-bottom:8px">No events found</div>
        <div>Try a different filter or <a href="/EventFlow/events" style="color:#5b9bd6">view all events</a></div>
      </div>
    </c:when>
    <c:otherwise>
      <div class="events-list">
        <c:forEach var="ev" items="${events}" varStatus="s">
          <c:set var="pct" value="${ev.capacity > 0 ? (ev.registered_count * 100) / ev.capacity : 0}"/>
          <c:set var="isFull" value="${ev.registered_count >= ev.capacity}"/>
          <div class="event-row">
            <!-- Date -->
            <div class="er-date">
              <div class="er-date-day"><fmt:formatDate value="${ev.event_date}" pattern="dd"/></div>
              <div class="er-date-month"><fmt:formatDate value="${ev.event_date}" pattern="MMM"/></div>
            </div>
            <!-- Info -->
            <div class="er-body">
              <div class="er-thumb">
                <c:choose>
                  <c:when test="${not empty ev.image_path}">
                    <img src="/EventFlow/uploads/events/${ev.image_path}" alt="${ev.title}"/>
                  </c:when>
                  <c:otherwise>
                    <div class="thumb-fallback gp-${s.index % 8}"></div>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="er-info">
                <div class="er-title">${ev.title}</div>
                <div class="er-desc">${ev.description}</div>
                <div class="er-meta">
                  <div class="er-meta-item">
                    <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><path d="M7 1.5C4.5 1.5 2.5 3.5 2.5 6c0 3.5 4.5 7 4.5 7s4.5-3.5 4.5-7c0-2.5-2-4.5-4.5-4.5z"/><circle cx="7" cy="6" r="1.5"/></svg>
                    ${ev.location}
                  </div>
                  <div class="er-meta-item">
                    <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><circle cx="7" cy="7" r="5"/><path d="M7 4v3l2 1.5"/></svg>
                    <fmt:formatDate value="${ev.start_time}" pattern="h:mm a"/> — <fmt:formatDate value="${ev.end_time}" pattern="h:mm a"/>
                  </div>
                  <div class="er-meta-item">
                    <svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.4"><circle cx="7" cy="4.5" r="2.2"/><path d="M2 12c0-2.5 2.2-4 5-4s5 1.5 5 4"/></svg>
                    ${ev.registered_count} / ${ev.capacity} attending
                  </div>
                  <div style="margin-left:auto">
                    <c:choose>
                      <c:when test="${ev.status == 'ongoing'}">  <span class="badge badge-ongoing">Now</span></c:when>
                      <c:when test="${ev.status == 'upcoming'}"> <span class="badge badge-upcoming">Upcoming</span></c:when>
                      <c:otherwise>                              <span class="badge badge-draft">${ev.status}</span></c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </div>
            <!-- Action -->
            <div class="er-action">
              <div class="er-capacity">
                ${ev.registered_count} / ${ev.capacity}
                <div class="er-cap-bar">
                  <div class="er-cap-fill" style="width:${pct}%"></div>
                </div>
              </div>
              <c:choose>
                <c:when test="${isFull}">
                  <span class="er-btn full">Full</span>
                </c:when>
                <c:when test="${sessionScope.userRole == 'attendee'}">
                  <a href="/EventFlow/attendee/events" class="er-btn">Register →</a>
                </c:when>
                <c:otherwise>
                  <a href="/EventFlow/register" class="er-btn login">Sign up to register</a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <!-- CTA if not logged in -->
  <c:if test="${empty sessionScope.userId}">
    <div style="margin:0 48px 48px;padding:32px;border:1px solid #272727;border-radius:10px;background:#141414;text-align:center">
      <div style="font-size:14px;font-weight:600;color:#c0c0c0;margin-bottom:6px">Want to register for events?</div>
      <div style="font-size:12px;color:#606060;margin-bottom:18px;font-weight:300">Create a free account to register for events, track your registrations, and get updates.</div>
      <div style="display:flex;gap:10px;justify-content:center">
        <a href="/EventFlow/register" class="hero-reg-btn">Create free account →</a>
        <a href="/EventFlow/login" style="height:36px;padding:0 20px;border-radius:7px;border:1px solid #272727;background:transparent;font-size:13px;font-weight:500;color:#606060;display:inline-flex;align-items:center;text-decoration:none">Sign in</a>
      </div>
    </div>
  </c:if>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer-top">
      <div class="footer-brand-col">
        <div class="footer-brand">
          <div class="nav-logo"><span></span><span></span><span></span><span></span></div>
          <span class="footer-brand-name">EventFlow</span>
        </div>
        <p class="footer-brand-desc">From planning to execution, all in one place.</p>
      </div>
      <div class="footer-col">
        <div class="footer-col-title">Explore</div>
        <div class="footer-links">
          <a href="/EventFlow/events">Browse events</a>
          <a href="/EventFlow/">Home</a>
          <a href="/EventFlow/#contact">Contact</a>
        </div>
      </div>
      <div class="footer-col">
        <div class="footer-col-title">Account</div>
        <div class="footer-links">
          <a href="/EventFlow/login">Sign in</a>
          <a href="/EventFlow/register">Register</a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="footer-copy">&copy; 2026 EventFlow. Built in Nepal.</div>
    </div>
  </footer>

</div>
</body>
</html>
