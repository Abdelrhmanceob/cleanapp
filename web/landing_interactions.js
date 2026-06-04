(function () {
  function scrollToSection(sectionId, offset) {
    var el = document.getElementById(sectionId);
    if (!el) return;
    var top =
      el.getBoundingClientRect().top +
      window.pageYOffset -
      (offset != null ? offset : 88);
    window.scrollTo({ top: top, behavior: 'smooth' });
  }

  window.scrollToSection = scrollToSection;

  window.goToBooking = function (packageId) {
    scrollToSection('booking', 88);
    if (packageId) {
      setTimeout(function () {
        var select = document.getElementById('service');
        if (select) {
          select.value = packageId;
          select.dispatchEvent(new Event('change', { bubbles: true }));
        }
        var name = document.getElementById('name');
        if (name) name.focus();
      }, 400);
    } else {
      setTimeout(function () {
        var name = document.getElementById('name');
        if (name) name.focus();
      }, 400);
    }
  };

  function closeMobileNav() {
    var panel = document.getElementById('mobile-nav');
    var backdrop = document.getElementById('mobile-nav-backdrop');
    if (panel) panel.classList.add('translate-x-full');
    if (backdrop) backdrop.classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
  }

  function openMobileNav() {
    var panel = document.getElementById('mobile-nav');
    var backdrop = document.getElementById('mobile-nav-backdrop');
    if (panel) panel.classList.remove('translate-x-full');
    if (backdrop) backdrop.classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
  }

  window.toggleMobileNav = function () {
    var panel = document.getElementById('mobile-nav');
    if (!panel) return;
    if (panel.classList.contains('translate-x-full')) openMobileNav();
    else closeMobileNav();
  };

  var navBound = false;
  var actionsBound = false;

  function setupNavAnchors() {
    if (navBound) return;
    navBound = true;
    document.querySelectorAll('[data-scroll]').forEach(function (link) {
      link.addEventListener('click', function (e) {
        var target = link.getAttribute('data-scroll');
        if (!target) return;
        e.preventDefault();
        closeMobileNav();
        scrollToSection(target.replace('#', ''), 88);
      });
    });
  }

  function setupDelegatedActions() {
    if (actionsBound) return;
    actionsBound = true;
    document.body.addEventListener('click', function (e) {
      var bookBtn = e.target.closest('[data-book-package]');
      if (bookBtn) {
        e.preventDefault();
        window.goToBooking(bookBtn.getAttribute('data-book-package') || '');
        return;
      }

      var exploreBtn = e.target.closest('[data-scroll-explore]');
      if (exploreBtn) {
        e.preventDefault();
        scrollToSection('features', 88);
        return;
      }

      var contactBtn = e.target.closest('[data-contact]');
      if (contactBtn) {
        e.preventDefault();
        window.location.href = 'tel:19000';
        return;
      }

      var adminBtn = e.target.closest('[data-go-admin]');
      if (adminBtn) {
        e.preventDefault();
        if (typeof window.goToAdmin === 'function') window.goToAdmin();
      }
    });
  }

  window.setupLandingInteractions = function () {
    setupNavAnchors();
    setupDelegatedActions();
  };

  document.addEventListener('DOMContentLoaded', function () {
    window.setupLandingInteractions();
  });
})();
