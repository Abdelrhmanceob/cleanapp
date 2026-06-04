import 'dart:convert';

import 'package:flutter/material.dart';

import 'hero_images.dart';
import 'landing_bridge.dart';
import 'landing_init.dart' as landing_io;

class HeroSlide {
  String imageUrl;
  String alt;

  HeroSlide({required this.imageUrl, required this.alt});

  Map<String, dynamic> toJson() => {'imageUrl': imageUrl, 'alt': alt};

  factory HeroSlide.fromJson(Map<String, dynamic> j) => HeroSlide(
        imageUrl: j['imageUrl'] as String? ?? '',
        alt: j['alt'] as String? ?? '',
      );
}

class LandingHero {
  String title;
  String titleHighlight;
  String subtitle;
  List<HeroSlide> slides;

  LandingHero({
    required this.title,
    required this.titleHighlight,
    required this.subtitle,
    required this.slides,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'titleHighlight': titleHighlight,
        'subtitle': subtitle,
        'slides': slides.map((s) => s.toJson()).toList(),
      };

  factory LandingHero.fromJson(Map<String, dynamic> j) => LandingHero(
        title: j['title'] as String? ?? '',
        titleHighlight: j['titleHighlight'] as String? ?? '',
        subtitle: j['subtitle'] as String? ?? '',
        slides: (j['slides'] as List<dynamic>? ?? [])
            .map((e) => HeroSlide.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class LandingStat {
  String value;
  String label;

  LandingStat({required this.value, required this.label});

  Map<String, dynamic> toJson() => {'value': value, 'label': label};

  factory LandingStat.fromJson(Map<String, dynamic> j) => LandingStat(
        value: j['value'] as String? ?? '',
        label: j['label'] as String? ?? '',
      );
}

class LandingFeature {
  String icon;
  String title;
  String description;

  LandingFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'title': title,
        'description': description,
      };

  factory LandingFeature.fromJson(Map<String, dynamic> j) => LandingFeature(
        icon: j['icon'] as String? ?? 'bolt',
        title: j['title'] as String? ?? '',
        description: j['description'] as String? ?? '',
      );
}

class PricingPackage {
  String id;
  String name;
  int price;
  List<String> features;
  bool featured;
  bool visible;

  PricingPackage({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    this.featured = false,
    this.visible = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'features': features,
        'featured': featured,
        'visible': visible,
      };

  factory PricingPackage.fromJson(Map<String, dynamic> j) => PricingPackage(
        id: j['id'] as String? ?? '',
        name: j['name'] as String? ?? '',
        price: (j['price'] as num?)?.toInt() ?? 0,
        features: (j['features'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        featured: j['featured'] as bool? ?? false,
        visible: j['visible'] as bool? ?? true,
      );
}

class LandingTestimonial {
  String name;
  String area;
  String quote;
  String initial;

  LandingTestimonial({
    required this.name,
    required this.area,
    required this.quote,
    required this.initial,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'area': area,
        'quote': quote,
        'initial': initial,
      };

  factory LandingTestimonial.fromJson(Map<String, dynamic> j) =>
      LandingTestimonial(
        name: j['name'] as String? ?? '',
        area: j['area'] as String? ?? '',
        quote: j['quote'] as String? ?? '',
        initial: j['initial'] as String? ?? '',
      );
}

class LandingContent {
  LandingHero hero;
  List<LandingStat> stats;
  String featuresTitle;
  List<LandingFeature> features;
  String pricingTitle;
  String pricingSubtitle;
  List<PricingPackage> packages;
  String testimonialsTitle;
  List<LandingTestimonial> testimonials;
  String ctaTitle;
  String ctaSubtitle;
  String bookingTitle;
  String bookingSubtitle;

  LandingContent({
    required this.hero,
    required this.stats,
    required this.featuresTitle,
    required this.features,
    required this.pricingTitle,
    required this.pricingSubtitle,
    required this.packages,
    required this.testimonialsTitle,
    required this.testimonials,
    required this.ctaTitle,
    required this.ctaSubtitle,
    required this.bookingTitle,
    required this.bookingSubtitle,
  });

  Map<String, dynamic> toJson() => {
        'hero': hero.toJson(),
        'stats': stats.map((s) => s.toJson()).toList(),
        'featuresTitle': featuresTitle,
        'features': features.map((f) => f.toJson()).toList(),
        'pricingTitle': pricingTitle,
        'pricingSubtitle': pricingSubtitle,
        'packages': packages.map((p) => p.toJson()).toList(),
        'testimonialsTitle': testimonialsTitle,
        'testimonials': testimonials.map((t) => t.toJson()).toList(),
        'ctaTitle': ctaTitle,
        'ctaSubtitle': ctaSubtitle,
        'bookingTitle': bookingTitle,
        'bookingSubtitle': bookingSubtitle,
      };

  factory LandingContent.fromJson(Map<String, dynamic> j) => LandingContent(
        hero: LandingHero.fromJson(
            j['hero'] as Map<String, dynamic>? ?? <String, dynamic>{}),
        stats: (j['stats'] as List<dynamic>? ?? [])
            .map((e) => LandingStat.fromJson(e as Map<String, dynamic>))
            .toList(),
        featuresTitle: j['featuresTitle'] as String? ?? '',
        features: (j['features'] as List<dynamic>? ?? [])
            .map((e) => LandingFeature.fromJson(e as Map<String, dynamic>))
            .toList(),
        pricingTitle: j['pricingTitle'] as String? ?? '',
        pricingSubtitle: j['pricingSubtitle'] as String? ?? '',
        packages: (j['packages'] as List<dynamic>? ?? [])
            .map((e) => PricingPackage.fromJson(e as Map<String, dynamic>))
            .toList(),
        testimonialsTitle: j['testimonialsTitle'] as String? ?? '',
        testimonials: (j['testimonials'] as List<dynamic>? ?? [])
            .map((e) =>
                LandingTestimonial.fromJson(e as Map<String, dynamic>))
            .toList(),
        ctaTitle: j['ctaTitle'] as String? ?? '',
        ctaSubtitle: j['ctaSubtitle'] as String? ?? '',
        bookingTitle: j['bookingTitle'] as String? ?? '',
        bookingSubtitle: j['bookingSubtitle'] as String? ?? '',
      );

  static LandingContent defaults() => LandingContent(
        hero: LandingHero(
          title: 'تنظيف احترافي',
          titleHighlight: 'على الطلب',
          subtitle:
              'فريق مصري محترف مدرب على أعلى معايير الجودة العالمية. احجز خدمتك الآن بضغطة زر عبر تطبيقنا المتطور واستمتع بنظافة تفوق الخيال.',
          slides: HeroImages.defaultSlides
              .map(
                (s) => HeroSlide(imageUrl: s.imageUrl, alt: s.alt),
              )
              .toList(),
        ),
        stats: [
          LandingStat(value: '+5000', label: 'عميل سعيد'),
          LandingStat(value: '+120', label: 'عامل محترف'),
        ],
        featuresTitle: 'المعيار الذهبي في كل تفصيلة',
        features: [
          LandingFeature(
            icon: 'bolt',
            title: 'خدمة سريعة',
            description:
                'نصلك في أسرع وقت ممكن مع الالتزام التام بالمواعيد المحددة.',
          ),
          LandingFeature(
            icon: 'verified_user',
            title: 'عمال موثوقين',
            description:
                'جميع أفراد فريقنا يخضعون لفحوصات أمنية وتدريب مكثف لضمان أمانك.',
          ),
          LandingFeature(
            icon: 'payments',
            title: 'أسعار شفافة',
            description: 'لا توجد رسوم خفية. أسعارنا واضحة ومحددة مسبقاً حسب الخدمة.',
          ),
          LandingFeature(
            icon: 'support_agent',
            title: 'دعم 24/7',
            description:
                'فريق خدمة العملاء متاح دائماً للرد على استفساراتكم وحل مشكلاتكم.',
          ),
        ],
        pricingTitle: 'خطط الأسعار المناسبة لك',
        pricingSubtitle:
            'باقات مرنة صممت لتناسب جميع احتياجاتك السكنية والتجارية',
        packages: [
          PricingPackage(
            id: 'basic',
            name: 'الباقة الأساسية',
            price: 1200,
            features: [
              'تنظيف الغرف الرئيسية',
              'مسح الأرضيات',
              'تنظيف المطبخ السطحي',
            ],
          ),
          PricingPackage(
            id: 'villa',
            name: 'باقة الفيلات',
            price: 2400,
            featured: true,
            features: [
              'تنظيف عميق لجميع الغرف',
              'تلميع المقتنيات الثمينة',
              'تعقيم الحمامات والمطابخ',
              'تعطير المكان بروائح فاخرة',
            ],
          ),
          PricingPackage(
            id: 'royal',
            name: 'الباقة الملكية',
            price: 4500,
            features: [
              'تنظيف شامل (الواجهات والحدائق)',
              'غسيل السجاد والستائر بالبخار',
              'فريق مخصص من 4 أفراد',
            ],
          ),
        ],
        testimonialsTitle: 'آراء عملاء دكتور كلينر',
        testimonials: [
          LandingTestimonial(
            name: 'أحمد صالح',
            area: 'الشيخ زايد',
            quote:
                'تجربة رائعة بكل المقاييس. الفريق كان محترف جداً ومنظم، والنتيجة كانت مذهلة فعلاً. البيت رجع كأنه جديد.',
            initial: 'أ',
          ),
          LandingTestimonial(
            name: 'سارة خالد',
            area: 'التجمع الخامس',
            quote:
                'أهم حاجة عجبتني هي الأمانة والدقة في المواعيد. والأسعار فعلاً منطقية جداً مقابل الخدمة اللي استلمتها.',
            initial: 'س',
          ),
          LandingTestimonial(
            name: 'محمد علي',
            area: 'مدينة نصر',
            quote:
                'تطبيق سهل الاستخدام جداً وخدمة العملاء بتتابع معاك خطوة بخطوة. أنصح بيهم أي حد بيدور على راحة البال.',
            initial: 'م',
          ),
        ],
        ctaTitle: 'جاهز لتجربة مستوى جديد من النظافة؟',
        ctaSubtitle:
            'انضم لأكثر من 5000 عميل سعيد في مصر واستمتع بمنزل مشرق وصحي دائماً.',
        bookingTitle: 'احجز خدمتك الآن',
        bookingSubtitle: 'سجل بياناتك وسنتواصل معك لتأكيد الموعد',
      );
}

class LandingStore extends ChangeNotifier {
  LandingContent _content = LandingContent.defaults();

  LandingContent get content => _content;

  List<PricingPackage> get visiblePackages =>
      _content.packages.where((p) => p.visible).toList();

  void load() {
    final raw = readLandingFromStorage();
    if (raw == null || raw.isEmpty) return;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      _content = LandingContent.fromJson(map);
      _upgradeHeroImagesIfNeeded();
      _upgradePackagesIfNeeded();
      notifyListeners();
    } catch (_) {
      /* keep defaults */
    }
  }

  void _upgradeHeroImagesIfNeeded() {
    final needsUpgrade = _content.hero.slides
        .any((s) => HeroImages.shouldUpgradeHeroUrl(s.imageUrl));
    if (!needsUpgrade) return;
    _content.hero.slides = HeroImages.defaultSlides
        .map((s) => HeroSlide(imageUrl: s.imageUrl, alt: s.alt))
        .toList();
    landing_io.persistLanding(jsonEncode(_content.toJson()));
  }

  void _upgradePackagesIfNeeded() {
    final hasVilla =
        _content.packages.any((p) => p.id == 'villa' && p.visible);
    if (hasVilla && _content.packages.length >= 3) return;
    _content.packages = LandingContent.defaults().packages;
    landing_io.persistLanding(jsonEncode(_content.toJson()));
  }

  void replaceContent(LandingContent next) {
    _content = next;
    notifyListeners();
  }

  void syncToWeb() {
    landing_io.syncLandingToDom(jsonEncode(_content.toJson()));
  }

  void save() {
    final json = jsonEncode(_content.toJson());
    landing_io.persistLanding(json);
    landing_io.syncLandingToDom(json);
    notifyListeners();
  }

  void resetToDefaults() {
    _content = LandingContent.defaults();
    save();
  }

  static int priceForServiceLabel(String service, LandingContent? content) {
    if (content != null) {
      for (final p in content.packages) {
        if (service.contains(p.name)) return p.price;
      }
    }
    final s = service.toLowerCase();
    if (s.contains('ملك') || s.contains('royal')) return 4500;
    if (s.contains('فيل') || s.contains('villa') || s.contains('مميز')) {
      return 2400;
    }
    return 1200;
  }
}
