import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = [
    {
      'icon': Icons.bolt,
      'title': 'خدمة سريعة',
      'desc': 'حجز فوري في أقل من 60 ثانية لتلبية احتياجاتك الطارئة.',
    },
    {
      'icon': Icons.verified_user,
      'title': 'عمال موثوقين',
      'desc': 'جميع مزودي الخدمة لدينا خضعوا لفحص أمني وتدريب احترافي مكثف.',
    },
    {
      'icon': Icons.payments,
      'title': 'أسعار شفافة',
      'desc': 'لا توجد تكاليف خفية. السعر الذي تراه هو السعر الذي تدفعه دائماً.',
    },
    {
      'icon': Icons.support_agent,
      'title': 'دعم فني 24/7',
      'desc': 'فريق خدمة العملاء متاح دائماً للإجابة على استفساراتك وضمان رضاك.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppTheme.surfaceWhite,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Column(
        children: [
          // Section label
          Text(
            'لماذا تختارنا',
            style: TextStyle(
              color: AppTheme.primaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 12),
          Text(
            'المعيار الذهبي في كل تفصيلة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 600.ms),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxis = constraints.maxWidth > 900 ? 4 : (constraints.maxWidth > 600 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: crossAxis >= 4 ? 0.85 : 1.2,
                ),
                itemCount: _features.length,
                itemBuilder: (context, i) => _FeatureCard(
                  icon: _features[i]['icon'] as IconData,
                  title: _features[i]['title'] as String,
                  desc: _features[i]['desc'] as String,
                ).animate().fadeIn(delay: (i * 80).ms).slideY(begin: 0.2),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _FeatureCard({required this.icon, required this.title, required this.desc});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppTheme.primaryGold.withOpacity(0.5) : AppTheme.borderSubtle,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: AppTheme.primaryGold.withOpacity(0.12), blurRadius: 24, spreadRadius: 0)]
              : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, spreadRadius: 0)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: AppTheme.primaryDark, size: 24),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.desc,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}