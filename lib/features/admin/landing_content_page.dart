import 'package:flutter/material.dart';
import '../../core/landing_scope.dart';
import '../../core/landing_store.dart';
import '../../core/theme.dart';

class LandingContentPage extends StatefulWidget {
  const LandingContentPage({super.key});

  @override
  State<LandingContentPage> createState() => _LandingContentPageState();
}

class _LandingContentPageState extends State<LandingContentPage> {
  late LandingContent _draft;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _draft = _clone(LandingScope.of(context).content);
      _initialized = true;
    }
  }

  LandingContent _clone(LandingContent c) {
    return LandingContent.fromJson(c.toJson());
  }

  void _markDirty(VoidCallback fn) {
    setState(fn);
  }

  void _save(BuildContext context) {
    final store = LandingScope.of(context);
    store.replaceContent(_draft);
    store.save();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ محتوى الموقع وتحديث الصفحة الرئيسية')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'تحرير صفحة الهبوط',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _markDirty(() => _draft = LandingContent.defaults());
                },
                child: const Text('استعادة الافتراضي'),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  foregroundColor: AppTheme.textDark,
                ),
                onPressed: () => _save(context),
                child: const Text('حفظ ونشر'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'التغييرات تُحفظ محلياً وتظهر فوراً على الموقع الرئيسي.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 24),
          _HeroCard(
            hero: _draft.hero,
            onChanged: (h) => _markDirty(() => _draft.hero = h),
          ),
          const SizedBox(height: 16),
          _StatsCard(
            stats: _draft.stats,
            onChanged: (s) => _markDirty(() => _draft.stats = s),
          ),
          const SizedBox(height: 16),
          _FeaturesCard(
            title: _draft.featuresTitle,
            features: _draft.features,
            onTitle: (t) => _markDirty(() => _draft.featuresTitle = t),
            onFeatures: (f) => _markDirty(() => _draft.features = f),
          ),
          const SizedBox(height: 16),
          _PricingCard(
            title: _draft.pricingTitle,
            subtitle: _draft.pricingSubtitle,
            packages: _draft.packages,
            onTitle: (t) => _markDirty(() => _draft.pricingTitle = t),
            onSubtitle: (t) => _markDirty(() => _draft.pricingSubtitle = t),
            onPackages: (p) => _markDirty(() => _draft.packages = p),
          ),
          const SizedBox(height: 16),
          _TestimonialsCard(
            title: _draft.testimonialsTitle,
            items: _draft.testimonials,
            onTitle: (t) => _markDirty(() => _draft.testimonialsTitle = t),
            onItems: (t) => _markDirty(() => _draft.testimonials = t),
          ),
          const SizedBox(height: 16),
          _SectionTextsCard(
            title: 'الحجز والدعوة للإجراء',
            fields: [
              _FieldDef('عنوان الحجز', _draft.bookingTitle,
                  (v) => _markDirty(() => _draft.bookingTitle = v)),
              _FieldDef('وصف الحجز', _draft.bookingSubtitle,
                  (v) => _markDirty(() => _draft.bookingSubtitle = v)),
              _FieldDef('عنوان CTA', _draft.ctaTitle,
                  (v) => _markDirty(() => _draft.ctaTitle = v)),
              _FieldDef('وصف CTA', _draft.ctaSubtitle,
                  (v) => _markDirty(() => _draft.ctaSubtitle = v)),
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldDef {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  _FieldDef(this.label, this.value, this.onChanged);
}

class _SectionTextsCard extends StatelessWidget {
  final String title;
  final List<_FieldDef> fields;
  const _SectionTextsCard({required this.title, required this.fields});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: title,
      child: Column(
        children: fields
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: TextEditingController(text: f.value)
                    ..selection = TextSelection.collapsed(offset: f.value.length),
                  decoration: InputDecoration(
                    labelText: f.label,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: f.onChanged,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final LandingHero hero;
  final ValueChanged<LandingHero> onChanged;
  const _HeroCard({required this.hero, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'قسم البطل (Hero)',
      child: Column(
        children: [
          _tf('العنوان الرئيسي', hero.title, (v) => onChanged(_copy(hero)..title = v)),
          _tf('الكلمة المميزة', hero.titleHighlight,
              (v) => onChanged(_copy(hero)..titleHighlight = v)),
          _tf('الوصف', hero.subtitle, (v) => onChanged(_copy(hero)..subtitle = v),
              maxLines: 3),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerRight,
            child: Text('شرائح الكاروسيل', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ...hero.slides.asMap().entries.map((e) {
            final i = e.key;
            final slide = e.value;
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  _tf('رابط الصورة ${i + 1}', slide.imageUrl,
                      (v) => onChanged(_copy(hero)..slides[i].imageUrl = v)),
                  _tf('وصف الصورة', slide.alt,
                      (v) => onChanged(_copy(hero)..slides[i].alt = v)),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () {
              final next = _copy(hero);
              next.slides.add(HeroSlide(imageUrl: '', alt: 'شريحة جديدة'));
              onChanged(next);
            },
            icon: const Icon(Icons.add),
            label: const Text('إضافة شريحة'),
          ),
        ],
      ),
    );
  }

  LandingHero _copy(LandingHero h) => LandingHero.fromJson(h.toJson());
}

class _StatsCard extends StatelessWidget {
  final List<LandingStat> stats;
  final ValueChanged<List<LandingStat>> onChanged;
  const _StatsCard({required this.stats, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'الإحصائيات',
      child: Column(
        children: stats.asMap().entries.map((e) {
          final i = e.key;
          final s = e.value;
          return Row(
            children: [
              Expanded(
                child: _tf('القيمة', s.value,
                    (v) => onChanged(_cloneStats(stats)..[i].value = v)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _tf('التسمية', s.label,
                    (v) => onChanged(_cloneStats(stats)..[i].label = v)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  List<LandingStat> _cloneStats(List<LandingStat> list) =>
      list.map((s) => LandingStat.fromJson(s.toJson())).toList();
}

class _FeaturesCard extends StatelessWidget {
  final String title;
  final List<LandingFeature> features;
  final ValueChanged<String> onTitle;
  final ValueChanged<List<LandingFeature>> onFeatures;
  const _FeaturesCard({
    required this.title,
    required this.features,
    required this.onTitle,
    required this.onFeatures,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'المميزات',
      child: Column(
        children: [
          _tf('عنوان القسم', title, onTitle),
          ...features.asMap().entries.map((e) {
            final i = e.key;
            final f = e.value;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ميزة ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  _tf('أيقونة Material', f.icon,
                      (v) => onFeatures(_clone(features)..[i].icon = v)),
                  _tf('العنوان', f.title,
                      (v) => onFeatures(_clone(features)..[i].title = v)),
                  _tf('الوصف', f.description,
                      (v) => onFeatures(_clone(features)..[i].description = v),
                      maxLines: 2),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  List<LandingFeature> _clone(List<LandingFeature> list) =>
      list.map((f) => LandingFeature.fromJson(f.toJson())).toList();
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<PricingPackage> packages;
  final ValueChanged<String> onTitle;
  final ValueChanged<String> onSubtitle;
  final ValueChanged<List<PricingPackage>> onPackages;
  const _PricingCard({
    required this.title,
    required this.subtitle,
    required this.packages,
    required this.onTitle,
    required this.onSubtitle,
    required this.onPackages,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'باقات الأسعار',
      child: Column(
        children: [
          _tf('عنوان القسم', title, onTitle),
          _tf('الوصف', subtitle, onSubtitle, maxLines: 2),
          ...packages.asMap().entries.map((e) {
            final i = e.key;
            final p = e.value;
            return Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.borderSubtle),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                  _tf('اسم الباقة', p.name,
                      (v) => onPackages(_clone(packages)..[i].name = v)),
                  _tf('السعر (ج.م)', '${p.price}',
                      (v) => onPackages(_clone(packages)
                        ..[i].price = int.tryParse(v.replaceAll(RegExp(r'\D'), '')) ?? p.price)),
                  _tf('المميزات (سطر لكل ميزة)', p.features.join('\n'),
                      (v) => onPackages(_clone(packages)
                        ..[i].features = v.split('\n').where((l) => l.trim().isNotEmpty).toList()),
                      maxLines: 5),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('باقة مميزة (تصميم أصفر)'),
                    value: p.featured,
                    activeColor: AppTheme.primaryGold,
                    onChanged: (v) => onPackages(_clone(packages)..[i].featured = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('ظاهرة في الموقع'),
                    value: p.visible,
                    activeColor: AppTheme.primaryGold,
                    onChanged: (v) => onPackages(_clone(packages)..[i].visible = v),
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () {
              final next = _clone(packages);
              next.add(PricingPackage(
                id: 'pkg-${next.length + 1}',
                name: 'باقة جديدة',
                price: 1500,
                features: ['ميزة 1'],
              ));
              onPackages(next);
            },
            icon: const Icon(Icons.add),
            label: const Text('إضافة باقة'),
          ),
        ],
      ),
    );
  }

  List<PricingPackage> _clone(List<PricingPackage> list) =>
      list.map((p) => PricingPackage.fromJson(p.toJson())).toList();
}

class _TestimonialsCard extends StatelessWidget {
  final String title;
  final List<LandingTestimonial> items;
  final ValueChanged<String> onTitle;
  final ValueChanged<List<LandingTestimonial>> onItems;
  const _TestimonialsCard({
    required this.title,
    required this.items,
    required this.onTitle,
    required this.onItems,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'آراء العملاء',
      child: Column(
        children: [
          _tf('عنوان القسم', title, onTitle),
          ...items.asMap().entries.map((e) {
            final i = e.key;
            final t = e.value;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  _tf('الاسم', t.name, (v) => onItems(_clone(items)..[i].name = v)),
                  _tf('المنطقة', t.area, (v) => onItems(_clone(items)..[i].area = v)),
                  _tf('الحرف', t.initial, (v) => onItems(_clone(items)..[i].initial = v)),
                  _tf('الرأي', t.quote, (v) => onItems(_clone(items)..[i].quote = v),
                      maxLines: 3),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  List<LandingTestimonial> _clone(List<LandingTestimonial> list) =>
      list.map((t) => LandingTestimonial.fromJson(t.toJson())).toList();
}

class _CardShell extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardShell({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

Widget _tf(
  String label,
  String value,
  ValueChanged<String> onChanged, {
  int maxLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: TextField(
      controller: TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      onChanged: onChanged,
    ),
  );
}
