<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>EventFlow — From planning to execution, all in one place</title>
  <meta name="description" content="EventFlow is the modern event management platform. Manage attendees, volunteers, and vendors — all in one place."/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Mono:wght@400;500&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
</head>
<body>

<!-- NAV -->
<nav class="nav" id="nav">
  <a class="nav-brand" href="/EventFlow/">
    <div class="nav-logo">
      <span></span><span></span><span></span><span></span>
    </div>
    <span class="nav-brand-name">EventFlow</span>
  </a>
  <div class="nav-links">
    <a href="#features">Features</a>
    <a href="#how">How it works</a>
    <a href="#pricing">Pricing</a>
    <a href="#faq">FAQ</a>
    <a href="#contact">Contact</a>
  </div>
  <div class="nav-ctas">
    <a href="/EventFlow/login" class="btn-ghost">Sign in</a>
    <a href="/EventFlow/register" class="btn-nav-cta">Get started free</a>
  </div>
  <button class="nav-hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- Mobile nav -->
<div class="mobile-nav" id="mobileNav">
  <a href="#features">Features</a>
  <a href="#how">How it works</a>
  <a href="#pricing">Pricing</a>
  <a href="#faq">FAQ</a>
  <a href="#contact">Contact</a>
  <div class="mobile-nav-ctas">
    <a href="/EventFlow/login" class="btn-ghost">Sign in</a>
    <a href="/EventFlow/register" class="btn-nav-cta">Get started free</a>
  </div>
</div>

<!-- HERO -->
<section class="hero">
  <div class="hero-dot-bg"></div>
  <div class="hero-glow"></div>
  <div class="hero-inner">
    <div class="hero-badge reveal">
      <span class="hero-badge-pulse"></span>
      Now in beta &mdash; free for early users
    </div>
    <h1 class="hero-h1 reveal reveal-delay-1">
      From planning<br/>
      <em>to execution,</em><br/>
      all in one place.
    </h1>
    <p class="hero-sub reveal reveal-delay-2">
      EventFlow is the event management platform built for Nepal's organizers.<br/>
      Attendees, volunteers, vendors &mdash; coordinated from a single dashboard.
    </p>
    <div class="hero-ctas reveal reveal-delay-3">
      <a href="/EventFlow/register" class="btn-cta-primary">
        Start for free
        <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5" width="14" height="14"><path d="M3 8h10M9 4l4 4-4 4"/></svg>
      </a>
      <a href="#features" class="btn-cta-ghost">See features</a>
    </div>
    <div class="hero-stats reveal reveal-delay-4">
      <div class="hero-stat">
        <div class="hero-stat-num">500<span>+</span></div>
        <div class="hero-stat-lbl">Events managed</div>
      </div>
      <div class="hero-stat">
        <div class="hero-stat-num">12k<span>+</span></div>
        <div class="hero-stat-lbl">Attendees tracked</div>
      </div>
      <div class="hero-stat">
        <div class="hero-stat-num">4</div>
        <div class="hero-stat-lbl">User roles</div>
      </div>
      <div class="hero-stat">
        <div class="hero-stat-num">100<span>%</span></div>
        <div class="hero-stat-lbl">Free to start</div>
      </div>
    </div>
  </div>

  <!-- Dashboard preview -->
  <div class="hero-preview reveal reveal-delay-4">
    <div class="preview-frame">
      <div class="preview-bar">
        <div class="preview-dots">
          <span class="pd pd-r"></span>
          <span class="pd pd-y"></span>
          <span class="pd pd-g"></span>
        </div>
        <div class="preview-url">app.eventflow.np/admin/dashboard</div>
      </div>
      <div class="preview-body">
        <div class="preview-sidebar">
          <div class="ps-logo">EF</div>
          <div class="ps-item active">Dashboard</div>
          <div class="ps-item">Events</div>
          <div class="ps-item">Attendees</div>
          <div class="ps-item">Volunteers</div>
          <div class="ps-item">Vendors</div>
        </div>
        <div class="preview-main">
          <div class="pm-header">
            <div class="pm-title">Dashboard</div>
            <div class="pm-btn">+ New event</div>
          </div>
          <div class="pm-stats">
            <div class="pm-stat"><div class="pm-stat-v">24</div><div class="pm-stat-l">Events</div></div>
            <div class="pm-stat"><div class="pm-stat-v">341</div><div class="pm-stat-l">Attendees</div></div>
            <div class="pm-stat"><div class="pm-stat-v">18</div><div class="pm-stat-l">Vendors</div></div>
            <div class="pm-stat"><div class="pm-stat-v">8</div><div class="pm-stat-l">Upcoming</div></div>
          </div>
          <div class="pm-table">
            <div class="pm-th"><span>Event</span><span>Date</span><span>Status</span><span>Reg.</span></div>
            <div class="pm-tr">
              <span class="pm-tr-name">Tech Summit 2026</span>
              <span class="pm-tr-meta">10 May</span>
              <span><span class="pm-badge pm-badge-blue">Upcoming</span></span>
              <span class="pm-tr-meta">48/200</span>
            </div>
            <div class="pm-tr">
              <span class="pm-tr-name">Design Workshop</span>
              <span class="pm-tr-meta">3 May</span>
              <span><span class="pm-badge pm-badge-green">Active</span></span>
              <span class="pm-tr-meta">32/50</span>
            </div>
            <div class="pm-tr" style="border-bottom:none">
              <span class="pm-tr-name">Music Fest KTM</span>
              <span class="pm-tr-meta">20 May</span>
              <span><span class="pm-badge pm-badge-gray">Draft</span></span>
              <span class="pm-tr-meta">&#8212;/500</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- LOGO BAR -->
<div class="logo-bar">
  <div class="logo-bar-label">Trusted by organizations across Nepal</div>
  <div class="logo-bar-items">
    <span>Tribhuvan University</span>
    <span class="lb-sep">&middot;</span>
    <span>Islington College</span>
    <span class="lb-sep">&middot;</span>
    <span>SoundWave Events</span>
    <span class="lb-sep">&middot;</span>
    <span>KTM Tech Community</span>
    <span class="lb-sep">&middot;</span>
    <span>Himalayan Ventures</span>
  </div>
</div>

<!-- FEATURES -->
<section class="section" id="features">
  <div class="section-head">
    <div class="section-eyebrow">Features</div>
    <h2 class="section-h2">Everything you need to run events</h2>
    <p class="section-sub">Built for organizers who want control without the complexity.</p>
  </div>
  <div class="feat-grid">
    <div class="feat-card feat-card-lg scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><rect x="2" y="3.5" width="20" height="17" rx="2"/><line x1="7" y1="1.5" x2="7" y2="5.5"/><line x1="17" y1="1.5" x2="17" y2="5.5"/><line x1="2" y1="9" x2="22" y2="9"/><rect x="6" y="13" width="4" height="4" rx="0.5"/></svg>
      </div>
      <h3 class="feat-title">Event management</h3>
      <p class="feat-desc">Create, schedule, and publish events with full control over capacity, venue, timing, and visibility. Edit or delete at any point.</p>
      <div class="feat-tag">Admin</div>
    </div>
    <div class="feat-card scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><circle cx="12" cy="7" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg>
      </div>
      <h3 class="feat-title">Attendee registration</h3>
      <p class="feat-desc">Let attendees browse, register, and manage their event history from a personal dashboard.</p>
      <div class="feat-tag">Attendee</div>
    </div>
    <div class="feat-card scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><circle cx="8" cy="7" r="3"/><circle cx="16" cy="7" r="3"/><path d="M2 20c0-3.5 2.7-6 6-6"/><path d="M22 20c0-3.5-2.7-6-6-6"/><path d="M8 14c1.5-.6 5.5-.6 8 0"/></svg>
      </div>
      <h3 class="feat-title">Volunteer coordination</h3>
      <p class="feat-desc">Assign tasks, manage availability, and track your volunteer team with role-based access control.</p>
      <div class="feat-tag">Volunteer</div>
    </div>
    <div class="feat-card scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><path d="M3 8.5L6 3h12l3 5.5"/><rect x="2" y="8.5" width="20" height="13" rx="1.5"/><line x1="12" y1="8.5" x2="12" y2="21.5"/></svg>
      </div>
      <h3 class="feat-title">Vendor management</h3>
      <p class="feat-desc">Vendors apply directly through the platform. Admins approve or reject applications in seconds.</p>
      <div class="feat-tag">Vendor</div>
    </div>
    <div class="feat-card feat-card-lg scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><rect x="3" y="11" width="8" height="10" rx="1"/><rect x="13" y="3" width="8" height="18" rx="1"/><rect x="3" y="3" width="8" height="5" rx="1"/></svg>
      </div>
      <h3 class="feat-title">Role-based dashboards</h3>
      <p class="feat-desc">Every user type gets their own tailored dashboard. Admin, Attendee, Volunteer, and Vendor — each sees only what they need. Clean, focused, no clutter.</p>
      <div class="feat-tag">All roles</div>
    </div>
    <div class="feat-card scroll-reveal">
      <div class="feat-icon-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.3" width="22" height="22"><rect x="5" y="11" width="14" height="10" rx="1.5"/><path d="M8 11V7a4 4 0 018 0v4"/><circle cx="12" cy="16" r="1"/></svg>
      </div>
      <h3 class="feat-title">Secure auth</h3>
      <p class="feat-desc">BCrypt hashing, session management, and account lockout after 5 failed attempts.</p>
      <div class="feat-tag">Security</div>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section class="section how-section" id="how">
  <div class="how-bg"></div>
  <div class="section-head">
    <div class="section-eyebrow">How it works</div>
    <h2 class="section-h2">Up and running in minutes</h2>
    <p class="section-sub">No setup. No spreadsheets. Just create an account and start.</p>
  </div>
  <div class="how-steps">
    <div class="how-step scroll-reveal">
      <div class="how-num">01</div>
      <h3 class="how-title">Create your account</h3>
      <p class="how-desc">Register and pick your role. Admin access is provisioned directly for organizers.</p>
    </div>
    <div class="how-step scroll-reveal">
      <div class="how-num">02</div>
      <h3 class="how-title">Create an event</h3>
      <p class="how-desc">Fill in the details — title, venue, date, capacity. Publish when you're ready.</p>
    </div>
    <div class="how-step scroll-reveal">
      <div class="how-num">03</div>
      <h3 class="how-title">Invite your team</h3>
      <p class="how-desc">Volunteers join, vendors apply, attendees register — all through their own dashboards.</p>
    </div>
    <div class="how-step scroll-reveal">
      <div class="how-num">04</div>
      <h3 class="how-title">Run your event</h3>
      <p class="how-desc">Track everything live from your admin dashboard. Zero spreadsheets.</p>
    </div>
  </div>
</section>

<!-- TESTIMONIALS -->
<section class="section" id="testimonials">
  <div class="section-head">
    <div class="section-eyebrow">Testimonials</div>
    <h2 class="section-h2">Trusted by organizers</h2>
    <p class="section-sub">From college fests to corporate summits.</p>
  </div>
  <div class="testi-grid">
    <div class="testi-card scroll-reveal">
      <div class="testi-quote">&ldquo;</div>
      <p class="testi-text">Used EventFlow for our college tech fest. Managing 400+ attendees and 12 vendors was genuinely smooth. The vendor approval flow saved us hours of back-and-forth.</p>
      <div class="testi-author">
        <div class="testi-av">SR</div>
        <div>
          <div class="testi-name">Suman Rai</div>
          <div class="testi-role">Student organizer, Tribhuvan University</div>
        </div>
      </div>
    </div>
    <div class="testi-card testi-card-featured scroll-reveal">
      <div class="testi-quote">&ldquo;</div>
      <p class="testi-text">The role-based dashboards are brilliant. Volunteers get exactly what they need — nothing more, nothing less. No confusion, no complaints on event day.</p>
      <div class="testi-author">
        <div class="testi-av">PM</div>
        <div>
          <div class="testi-name">Priya Maharjan</div>
          <div class="testi-role">Event coordinator, Kathmandu</div>
        </div>
      </div>
    </div>
    <div class="testi-card scroll-reveal">
      <div class="testi-quote">&ldquo;</div>
      <p class="testi-text">Ran a 3-day music festival with 800 attendees and zero spreadsheets. That's the goal. EventFlow delivered exactly that.</p>
      <div class="testi-author">
        <div class="testi-av">BT</div>
        <div>
          <div class="testi-name">Bikash Tamang</div>
          <div class="testi-role">Founder, SoundWave Events</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- PRICING -->
<section class="section pricing-section" id="pricing">
  <div class="pricing-bg"></div>
  <div class="section-head">
    <div class="section-eyebrow">Pricing</div>
    <h2 class="section-h2">Free forever. Seriously.</h2>
    <p class="section-sub">No credit card. No time limit. Contact us for larger organizations.</p>
  </div>
  <div class="pricing-grid">
    <div class="price-card scroll-reveal">
      <div class="price-top">
        <div class="price-name">Free</div>
        <div class="price-amt">NPR 0</div>
        <div class="price-period">forever, no card required</div>
      </div>
      <div class="price-divider"></div>
      <ul class="price-features">
        <li><span class="pf-check"></span>Unlimited events</li>
        <li><span class="pf-check"></span>Unlimited attendees</li>
        <li><span class="pf-check"></span>All 4 user roles</li>
        <li><span class="pf-check"></span>Volunteer &amp; vendor tools</li>
        <li><span class="pf-check"></span>Full dashboard access</li>
        <li><span class="pf-check"></span>Email support</li>
      </ul>
      <a href="/EventFlow/register" class="price-btn">Get started free</a>
    </div>
    <div class="price-card price-card-enterprise scroll-reveal">
      <div class="price-top">
        <div class="price-name">Enterprise</div>
        <div class="price-amt">Custom</div>
        <div class="price-period">for organizations &amp; institutions</div>
      </div>
      <div class="price-divider"></div>
      <ul class="price-features">
        <li><span class="pf-check"></span>Everything in Free</li>
        <li><span class="pf-check"></span>Custom integrations</li>
        <li><span class="pf-check"></span>Dedicated support line</li>
        <li><span class="pf-check"></span>SLA guarantee</li>
        <li><span class="pf-check"></span>Onboarding assistance</li>
        <li><span class="pf-check"></span>Multi-admin support</li>
      </ul>
      <a href="#contact" class="price-btn price-btn-enterprise">Contact us</a>
    </div>
  </div>
</section>

<!-- FAQ -->
<section class="section" id="faq">
  <div class="section-head">
    <div class="section-eyebrow">FAQ</div>
    <h2 class="section-h2">Common questions</h2>
    <p class="section-sub">Still have questions? Reach out directly.</p>
  </div>
  <div class="faq-list" id="faqList">
    <div class="faq-item">
      <button class="faq-q">Is EventFlow really free?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>Yes — completely free, no credit card, no expiry. Create an account and start managing events immediately. For organizations that need custom integrations or dedicated support, we offer an Enterprise plan.</p></div>
    </div>
    <div class="faq-item">
      <button class="faq-q">What roles does EventFlow support?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>Four roles: <strong>Admin</strong> (creates and manages events, approves vendors), <strong>Attendee</strong> (registers for events), <strong>Volunteer</strong> (views assignments), and <strong>Vendor</strong> (applies to events). Each role gets a focused dashboard.</p></div>
    </div>
    <div class="faq-item">
      <button class="faq-q">How is my account secured?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>All passwords are hashed using BCrypt. Sessions are managed server-side. Accounts lock after 5 consecutive failed login attempts within 15 minutes.</p></div>
    </div>
    <div class="faq-item">
      <button class="faq-q">Can I use this for a college event?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>That's exactly what EventFlow was built for. Whether it's a 50-person seminar or a 1,000-person tech fest — the free plan handles it all.</p></div>
    </div>
    <div class="faq-item">
      <button class="faq-q">How do I get admin access?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>Admin accounts are provisioned directly in the database for security. Contact us at createbikram@gmail.com or WhatsApp +977 9766562005 to get set up.</p></div>
    </div>
    <div class="faq-item">
      <button class="faq-q">What technology is EventFlow built on?<span class="faq-icon"><svg viewBox="0 0 14 14" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M2 5l5 5 5-5"/></svg></span></button>
      <div class="faq-a"><p>Java web application — Jakarta Servlets, JSP, MySQL, and Maven. Strict MVC architecture with JSP pages secured inside WEB-INF. Deployed on Apache Tomcat 10.x.</p></div>
    </div>
  </div>
</section>

<!-- CONTACT -->
<section class="section contact-section" id="contact">
  <div class="contact-glow"></div>
  <div class="section-head">
    <div class="section-eyebrow">Contact</div>
    <h2 class="section-h2">Get in touch</h2>
    <p class="section-sub">Questions, enterprise inquiries, or just want to say hi.</p>
  </div>
  <div class="contact-wrap">
    <div class="contact-info scroll-reveal">
      <div class="contact-item">
        <div class="contact-icon-wrap">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.3" width="18" height="18"><rect x="2" y="4" width="16" height="12" rx="2"/><path d="M2 6.5l8 5.5 8-5.5"/></svg>
        </div>
        <div>
          <div class="contact-lbl">Email</div>
          <a href="mailto:createbikram@gmail.com" class="contact-val">createbikram@gmail.com</a>
        </div>
      </div>
      <div class="contact-item">
        <div class="contact-icon-wrap">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.3" width="18" height="18"><path d="M3.5 4l3 3-2 2s1.5 4.5 7 7.5l2-2 3 3L14 20C6 16 0 8 3.5 4z"/></svg>
        </div>
        <div>
          <div class="contact-lbl">Phone &amp; WhatsApp</div>
          <a href="https://wa.me/9779766562005" class="contact-val">+977 9766562005</a>
        </div>
      </div>
      <div class="contact-item">
        <div class="contact-icon-wrap">
          <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.3" width="18" height="18"><circle cx="10" cy="8.5" r="3.5"/><path d="M3.5 18c0-4.5 3-7 6.5-7s6.5 2.5 6.5 7"/></svg>
        </div>
        <div>
          <div class="contact-lbl">Location</div>
          <div class="contact-val">Kathmandu, Nepal</div>
        </div>
      </div>
      <div class="contact-note">We usually respond within a few hours. For urgent matters, WhatsApp is fastest.</div>
    </div>
    <form class="contact-form scroll-reveal" action="/EventFlow/contact" method="POST">
      <c:if test="${not empty contactSuccess}">
        <div class="form-success">Message sent — we'll be in touch soon.</div>
      </c:if>
      <c:if test="${not empty contactError}">
        <div class="form-error">${contactError}</div>
      </c:if>
      <div class="cf-row">
        <div class="cf-group">
          <label class="cf-label" for="cf_name">Name</label>
          <input class="cf-input" type="text" id="cf_name" name="name" placeholder="Your name" required/>
        </div>
        <div class="cf-group">
          <label class="cf-label" for="cf_email">Email</label>
          <input class="cf-input" type="email" id="cf_email" name="email" placeholder="you@example.com" required/>
        </div>
      </div>
      <div class="cf-group">
        <label class="cf-label" for="cf_subject">Subject</label>
        <input class="cf-input" type="text" id="cf_subject" name="subject" placeholder="What's this about?"/>
      </div>
      <div class="cf-group">
        <label class="cf-label" for="cf_message">Message</label>
        <textarea class="cf-input cf-ta" id="cf_message" name="message" placeholder="Tell us more..." required></textarea>
      </div>
      <button type="submit" class="cf-submit">
        Send message
        <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5" width="13" height="13"><path d="M3 8h10M9 4l4 4-4 4"/></svg>
      </button>
    </form>
  </div>
</section>

<!-- CTA BAND -->
<section class="cta-band">
  <div class="cta-band-dot-bg"></div>
  <div class="cta-band-inner scroll-reveal">
    <div class="cta-band-eyebrow">Start today</div>
    <h2 class="cta-band-h2">Ready to run better events?</h2>
    <p class="cta-band-sub">Join organizers across Nepal already using EventFlow. Free forever, no card required.</p>
    <div class="cta-band-btns">
      <a href="/EventFlow/register" class="btn-cta-primary">
        Create free account
        <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5" width="14" height="14"><path d="M3 8h10M9 4l4 4-4 4"/></svg>
      </a>
      <a href="#contact" class="btn-cta-ghost">Talk to us</a>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer class="footer">
  <div class="footer-top">
    <div class="footer-brand-col">
      <div class="footer-brand">
        <div class="nav-logo"><span></span><span></span><span></span><span></span></div>
        <span class="footer-brand-name">EventFlow</span>
      </div>
      <p class="footer-brand-desc">From planning to execution, all in one place. Built in Nepal for Nepal's organizers.</p>
      <div class="footer-contact-mini">
        <a href="mailto:createbikram@gmail.com">createbikram@gmail.com</a>
        <a href="https://wa.me/9779766562005">+977 9766562005</a>
      </div>
    </div>
    <div class="footer-col">
      <div class="footer-col-title">Product</div>
      <div class="footer-links">
        <a href="#features">Features</a>
        <a href="#how">How it works</a>
        <a href="#pricing">Pricing</a>
        <a href="/EventFlow/register">Get started</a>
      </div>
    </div>
    <div class="footer-col">
      <div class="footer-col-title">Support</div>
      <div class="footer-links">
        <a href="#faq">FAQ</a>
        <a href="#contact">Contact</a>
        <a href="mailto:createbikram@gmail.com">Email us</a>
        <a href="https://wa.me/9779766562005">WhatsApp</a>
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
    <div class="footer-legal">
      <a href="#">Privacy</a>
      <a href="#">Terms</a>
    </div>
  </div>
</footer>

<script src="/EventFlow/js/landing.js"></script>
</body>
</html>
