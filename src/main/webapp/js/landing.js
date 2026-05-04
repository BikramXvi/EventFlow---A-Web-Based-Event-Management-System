// Nav scroll effect
(function() {
  var nav = document.getElementById('nav');
  if (!nav) return;
  window.addEventListener('scroll', function() {
    nav.style.borderBottomColor = window.scrollY > 40 ? '#1c1c1c' : '#181818';
  });
})();

// Mobile hamburger
(function() {
  var btn = document.getElementById('hamburger');
  var mobileNav = document.getElementById('mobileNav');
  if (!btn || !mobileNav) return;
  btn.addEventListener('click', function() {
    mobileNav.classList.toggle('open');
  });
})();

function closeMobile() {
  var m = document.getElementById('mobileNav');
  if (m) m.classList.remove('open');
}

// Scroll reveal
(function() {
  var els = document.querySelectorAll('.reveal, .scroll-reveal');
  if (!els.length) return;
  var observer = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
  els.forEach(function(el) { observer.observe(el); });
})();

// FAQ accordion
(function() {
  var items = document.querySelectorAll('.faq-item');
  items.forEach(function(item) {
    var btn = item.querySelector('.faq-q');
    if (!btn) return;
    btn.addEventListener('click', function() {
      var isOpen = item.classList.contains('open');
      items.forEach(function(i) { i.classList.remove('open'); });
      if (!isOpen) item.classList.add('open');
    });
  });
  if (items[0]) items[0].classList.add('open');
})();

// Smooth scroll
(function() {
  document.querySelectorAll('a[href^="#"]').forEach(function(a) {
    a.addEventListener('click', function(e) {
      var id = a.getAttribute('href').slice(1);
      var target = document.getElementById(id);
      if (!target) return;
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      closeMobile();
    });
  });
})();

// Contact form loading state
(function() {
  var form = document.querySelector('.contact-form');
  if (!form) return;
  form.addEventListener('submit', function() {
    var btn = form.querySelector('.cf-submit');
    if (btn) {
      btn.textContent = 'Sending...';
      btn.style.opacity = '0.6';
      btn.disabled = true;
    }
  });
})();