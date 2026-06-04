{{flutter_js}}
{{flutter_build_config}}

(function () {
  function isAdminRoute() {
    var hash = window.location.hash || '';
    var path = window.location.pathname || '';
    return hash.indexOf('admin') >= 0 || path.indexOf('/admin') >= 0;
  }

  function applyLayout() {
    var admin = isAdminRoute();
    var shell = document.getElementById('landing-shell');
    var below = document.getElementById('landing-below');
    var host = document.getElementById('flutter-host');
    if (shell) shell.style.display = admin ? 'none' : '';
    if (below) below.style.display = admin ? 'none' : '';
    if (host) host.style.display = admin ? 'none' : '';
    if (admin) {
      document.body.style.margin = '0';
      document.body.style.background = '#F5F5F0';
    }
  }

  applyLayout();
  window.addEventListener('hashchange', applyLayout);

  var config = {};
  if (!isAdminRoute()) {
    var el = document.getElementById('flutter-host');
    if (el) config.hostElement = el;
  }

  _flutter.loader.load({
    config: config,
    serviceWorkerSettings: {
      serviceWorkerVersion: {{flutter_service_worker_version}},
    },
  });
})();
