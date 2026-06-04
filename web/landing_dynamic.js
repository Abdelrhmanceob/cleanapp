(function () {
  var STORAGE_KEY = 'dr_cleaner_landing';

  var HERO_SLIDES_HQ = [
    { imageUrl: '/hero/hero-1.png', alt: 'خدمة تنظيف احترافية' },
    { imageUrl: '/hero/hero-2.png', alt: 'تنظيف المنازل والفيلات' },
    { imageUrl: '/hero/hero-3.png', alt: 'فريق عمل مصري محترف' },
    { imageUrl: '/hero/hero-4.png', alt: 'معايير جودة عالمية' },
  ];

  function isLowQualityHeroUrl(url) {
    return (
      !url ||
      url.indexOf('aida-public') >= 0 ||
      url.indexOf('googleusercontent.com') >= 0
    );
  }

  function isLegacyHeroUrl(url) {
    return (
      isLowQualityHeroUrl(url) ||
      url.indexOf('images.unsplash.com') >= 0 ||
      url.indexOf('images.pexels.com') >= 0 ||
      url.indexOf('assets/hero/') >= 0
    );
  }

  function isLocalHeroAsset(url) {
    return url && (url.indexOf('/hero/') >= 0 || url.indexOf('hero/hero-') >= 0);
  }

  function optimizeHeroUrl(url, width) {
    if (!url || isLowQualityHeroUrl(url)) return null;
    var w = width || 2400;
    if (url.indexOf('images.unsplash.com') >= 0) {
      var base = url.split('?')[0];
      return base + '?auto=format&fit=crop&w=' + w + '&q=90';
    }
    if (url.indexOf('images.pexels.com') >= 0) {
      if (url.indexOf('w=') >= 0) {
        return url.replace(/w=\d+/, 'w=' + w);
      }
      return url + (url.indexOf('?') >= 0 ? '&' : '?') + 'w=' + w;
    }
    return url;
  }

  function resolveHeroSlide(slide, index) {
    if (isLegacyHeroUrl(slide.imageUrl)) {
      return HERO_SLIDES_HQ[index % HERO_SLIDES_HQ.length];
    }
    return {
      imageUrl: optimizeHeroUrl(slide.imageUrl, 2400) || slide.imageUrl,
      alt: slide.alt || HERO_SLIDES_HQ[index % HERO_SLIDES_HQ.length].alt,
    };
  }

  function buildHeroImgHtml(slide, index) {
    var resolved = resolveHeroSlide(slide, index);
    var src = resolved.imageUrl;
    var attrs =
      index === 0 ? ' fetchpriority="high" loading="eager"' : ' loading="lazy"';
    if (isLocalHeroAsset(src)) {
      return (
        '<img alt="' +
        esc(resolved.alt) +
        '" class="w-full h-full object-cover hero-slide-img" src="' +
        esc(src) +
        '" sizes="100vw" decoding="async"' +
        attrs +
        '/>'
      );
    }
    var base = src.split('?')[0];
    var src1280 = base + '?auto=format&fit=crop&w=1280&q=88';
    var src1920 = base + '?auto=format&fit=crop&w=1920&q=90';
    return (
      '<img alt="' +
      esc(resolved.alt) +
      '" class="w-full h-full object-cover hero-slide-img" src="' +
      esc(src) +
      '" srcset="' +
      esc(src1280) +
      ' 1280w, ' +
      esc(src1920) +
      ' 1920w, ' +
      esc(src) +
      ' 2400w" sizes="100vw" decoding="async"' +
      attrs +
      '/>'
    );
  }

  function esc(s) {
    return String(s)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  function setText(id, text) {
    var el = document.getElementById(id);
    if (el && text != null) el.textContent = text;
  }

  function applyHero(hero) {
    if (!hero) return;
    setText('hero-title-line1', hero.title);
    var highlight = document.getElementById('hero-title-highlight');
    if (highlight) highlight.textContent = hero.titleHighlight || '';
    setText('hero-subtitle', hero.subtitle);

    var track = document.getElementById('hero-carousel');
    if (!track || !hero.slides || !hero.slides.length) return;

    track.innerHTML = hero.slides
      .map(function (slide, index) {
        return (
          '<div class="min-w-full h-full relative">' +
          buildHeroImgHtml(slide, index) +
          '</div>'
        );
      })
      .join('');

    var dotsWrap = document.getElementById('hero-dots');
    if (dotsWrap) {
      dotsWrap.innerHTML = hero.slides
        .map(function (_, i) {
          var active = i === 0 ? 'bg-primary-container' : 'bg-white/50';
          return (
            '<button type="button" class="w-3 h-3 rounded-full ' +
            active +
            ' carousel-dot flex items-center justify-center text-[10px] text-on-primary-fixed" onclick="slideHero(' +
            i +
            ')"></button>'
          );
        })
        .join('');
    }

    window.__heroSlideCount = hero.slides.length;
    if (typeof window.slideHero === 'function') window.slideHero(0);
  }

  function applyStats(stats) {
    var bar = document.getElementById('stats-bar');
    if (!bar || !stats || !stats.length) return;
    bar.innerHTML = stats
      .map(function (stat, i) {
        var divider =
          i < stats.length - 1
            ? '<div class="w-px h-16 bg-surface-variant"></div>'
            : '';
        return (
          '<div><h3 class="text-headline-lg font-headline-xl text-primary">' +
          esc(stat.value) +
          '</h3><p class="text-label-md font-label-md text-on-surface-variant">' +
          esc(stat.label) +
          '</p></div>' +
          divider
        );
      })
      .join('');
  }

  function applyFeatures(title, features) {
    setText('features-title', title);
    var grid = document.getElementById('features-grid');
    if (!grid || !features) return;
    grid.innerHTML = features
      .map(function (f) {
        return (
          '<div class="bg-white p-lg rounded-2xl shadow-sm hover:shadow-md transition-all border border-surface-variant text-center">' +
          '<div class="w-16 h-16 bg-primary-container/10 rounded-full flex items-center justify-center mx-auto mb-md">' +
          '<span class="material-symbols-outlined text-primary text-4xl" data-weight="fill">' +
          esc(f.icon || 'bolt') +
          '</span></div>' +
          '<h4 class="text-headline-md font-headline-md mb-sm">' +
          esc(f.title) +
          '</h4>' +
          '<p class="text-body-md text-on-surface-variant">' +
          esc(f.description) +
          '</p></div>'
        );
      })
      .join('');
  }

  function applyPricing(title, subtitle, packages) {
    setText('pricing-title', title);
    setText('pricing-subtitle', subtitle);
    var grid = document.getElementById('pricing-grid');
    if (!grid || !packages) return;

    var visible = packages.filter(function (p) {
      return p.visible !== false;
    });
    var cols =
      visible.length <= 2
        ? 'md:grid-cols-2 max-w-4xl'
        : 'md:grid-cols-3 max-w-6xl';
    grid.className =
      'grid grid-cols-1 ' + cols + ' gap-lg mx-auto';

    grid.innerHTML = visible
      .map(function (pkg, i) {
        var featured = !!pkg.featured;
        var delay = 0.1 + i * 0.2;
        var featuresHtml = (pkg.features || [])
          .map(function (line) {
            return (
              '<li class="flex items-center gap-sm flex-row-reverse">' +
              '<span class="material-symbols-outlined ' +
              (featured ? 'text-on-primary-fixed' : 'text-primary') +
              '" style="font-variation-settings: \'FILL\' 1;">check_circle</span>' +
              esc(line) +
              '</li>'
            );
          })
          .join('');

        if (featured) {
          return (
            '<div class="animate-fade-up bg-primary-container p-lg rounded-2xl flex flex-col items-center text-center shadow-xl md:scale-110 max-md:scale-100 relative z-10 overflow-hidden group pricing-card-hover" style="animation-delay: ' +
            delay +
            's;">' +
            '<span class="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-on-surface text-surface text-label-md px-md py-xs rounded-full font-bold whitespace-nowrap">الأكثر طلباً</span>' +
            '<h3 class="text-headline-md font-bold mb-sm text-on-primary-fixed mt-sm">' +
            esc(pkg.name) +
            '</h3>' +
            '<div class="flex items-baseline gap-xs mb-md text-on-primary-fixed">' +
            '<span class="text-headline-xl font-bold">' +
            esc(String(pkg.price)) +
            '</span>' +
            '<span class="text-label-md font-label-md">ج.م</span></div>' +
            '<ul class="space-y-sm text-right w-full mb-xl text-on-primary-fixed">' +
            featuresHtml +
            '</ul>' +
            '<button type="button" data-book-package="' +
            esc(pkg.id) +
            '" class="w-full py-md rounded-xl bg-on-primary-fixed text-primary-container font-bold hover:opacity-90 transition-all mt-auto">اطلب الآن</button></div>'
          );
        }

        return (
          '<div class="animate-fade-up bg-white p-lg rounded-2xl border border-surface-variant flex flex-col items-center text-center pricing-card-hover" style="animation-delay: ' +
          delay +
          's;">' +
          '<h3 class="text-headline-md font-bold mb-sm">' +
          esc(pkg.name) +
          '</h3>' +
          '<div class="flex items-baseline gap-xs mb-md">' +
          '<span class="text-headline-xl font-bold text-primary">' +
          esc(String(pkg.price)) +
          '</span>' +
          '<span class="text-label-md font-label-md text-on-surface-variant">ج.م</span></div>' +
          '<ul class="space-y-sm text-right w-full mb-xl">' +
          featuresHtml +
          '</ul>' +
          '<button type="button" data-book-package="' +
          esc(pkg.id) +
          '" class="w-full py-md rounded-xl border-2 border-primary-container text-primary font-bold hover:bg-primary-container/10 transition-all mt-auto">اطلب الآن</button></div>'
        );
      })
      .join('');
  }

  function applyTestimonials(title, items) {
    setText('testimonials-title', title);
    var grid = document.getElementById('testimonials-grid');
    if (!grid || !items) return;
    grid.innerHTML = items
      .map(function (t) {
        return (
          '<div class="bg-surface-container-lowest p-lg rounded-2xl border border-surface-variant relative">' +
          '<div class="flex flex-row-reverse gap-xs mb-md">' +
          Array(5)
            .fill(
              '<span class="material-symbols-outlined text-primary-container" style="font-variation-settings: \'FILL\' 1;">star</span>'
            )
            .join('') +
          '</div>' +
          '<p class="text-body-md text-on-surface mb-lg italic leading-relaxed">"' +
          esc(t.quote) +
          '"</p>' +
          '<div class="flex items-center gap-md flex-row-reverse">' +
          '<div class="w-12 h-12 rounded-full bg-surface-variant flex items-center justify-center font-bold text-primary">' +
          esc(t.initial || t.name.charAt(0)) +
          '</div>' +
          '<div class="text-right"><h5 class="font-bold">' +
          esc(t.name) +
          '</h5><p class="text-label-sm text-on-surface-variant">' +
          esc(t.area) +
          '</p></div></div></div>'
        );
      })
      .join('');
  }

  function applyBooking(title, subtitle, packages) {
    setText('booking-title', title);
    setText('booking-subtitle', subtitle);
    var select = document.getElementById('service');
    if (!select) return;
    var visible = (packages || []).filter(function (p) {
      return p.visible !== false;
    });
    select.innerHTML =
      '<option value="">اختر الباقة المناسبة</option>' +
      visible
        .map(function (p) {
          return (
            '<option value="' +
            esc(p.id) +
            '">' +
            esc(p.name) +
            '</option>'
          );
        })
        .join('');
  }

  function applyCta(title, subtitle) {
    setText('cta-title', title);
    setText('cta-subtitle', subtitle);
  }

  window.applyLandingContent = function (jsonOrObj) {
    try {
      var data =
        typeof jsonOrObj === 'string' ? JSON.parse(jsonOrObj) : jsonOrObj;
      if (!data) return;
      applyHero(data.hero);
      applyStats(data.stats);
      applyFeatures(data.featuresTitle, data.features);
      applyPricing(data.pricingTitle, data.pricingSubtitle, data.packages);
      applyTestimonials(data.testimonialsTitle, data.testimonials);
      applyCta(data.ctaTitle, data.ctaSubtitle);
      applyBooking(data.bookingTitle, data.bookingSubtitle, data.packages);
      if (typeof window.setupLandingInteractions === 'function') {
        window.setupLandingInteractions();
      }
    } catch (e) {
      console.warn('applyLandingContent failed', e);
    }
  };

  window.loadLandingFromStorage = function () {
    try {
      var raw = localStorage.getItem(STORAGE_KEY);
      if (raw) window.applyLandingContent(raw);
    } catch (e) {
      console.warn(e);
    }
  };

  document.addEventListener('DOMContentLoaded', function () {
    window.loadLandingFromStorage();
  });

  window.addEventListener('storage', function (e) {
    if (e.key === STORAGE_KEY) window.loadLandingFromStorage();
  });
})();
