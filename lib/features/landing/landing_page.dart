import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/landing_nav.dart';
import 'widgets/hero_section.dart';
import 'widgets/features_section.dart';
import 'widgets/how_it_works_section.dart';
import 'widgets/pricing_section.dart';
import 'widgets/service_journey_section.dart';
import 'widgets/testimonials_section.dart';
import '../../core/theme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 50;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 72),
                HeroSection(
                  onCta: () => context.go('/admin'),
                ),
                const FeaturesSection(),
                const HowItWorksSection(),
                const ServiceJourneySection(),
                const PricingSection(),
                const TestimonialsSection(),
                _Footer(),
              ],
            ),
          ),
          LandingNav(
            isScrolled: _isScrolled,
            onDashboard: () => context.go('/admin'),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE5E2E1),
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 48),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('N', style: TextStyle(color: Color(0xFF221B00), fontWeight: FontWeight.w800, fontSize: 22)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Nazavly', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: AppTheme.textDark)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'المعيار الذهبي للعناية المنزلية. نحن نوفر لك راحة البال والنظافة الفائقة بأفضل معايير الجودة العالمية.',
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 14, height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('روابط سريعة', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textDark)),
                    const SizedBox(height: 12),
                    ...[
                      'سياسة الخصوصية',
                      'شروط الخدمة',
                      'الوظائف',
                      'اتصل بنا',
                    ].map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(item, style: const TextStyle(color: AppTheme.textMuted, fontSize: 14)),
                    )),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('التطبيق', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textDark)),
                    const SizedBox(height: 12),
                    _AppStoreBadge(label: 'Google Play', icon: Icons.play_arrow),
                    const SizedBox(height: 8),
                    _AppStoreBadge(label: 'App Store', icon: Icons.apple),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Divider(color: AppTheme.borderSubtle),
          const SizedBox(height: 16),
          const Text(
            '© 2024 المعيار الذهبي للعناية المنزلية. جميع الحقوق محفوظة.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AppStoreBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _AppStoreBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.textDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('حمل من', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10)),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}