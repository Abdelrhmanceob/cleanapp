import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppTheme.surfaceWhite,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Column(
        children: [
          const _SectionLabel(label: 'PRICING'),
          const SizedBox(height: 16),
          Text(
            'خطط الأسعار المرنة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 12),
          const Text(
            'اختر الباقة التي تناسب حجم منزلك واحتياجاتك',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 16),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 64),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _PricingCard(
                name: 'الأساسي',
                price: '1200',
                period: 'ج.م / زيارة',
                features: ['تنظيف غرفتين', 'تنظيف مطبخ وحمام', 'دعم أساسي'],
                isPopular: false,
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
              _PricingCard(
                name: 'المميز',
                price: '2400',
                period: 'ج.م / زيارة',
                features: ['منزل كامل (4 غرف)', 'تنظيف عميق للمطبخ', 'تلميع الأسطح الزجاجية', 'تعقيم شامل'],
                isPopular: true,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
              _PricingCard(
                name: 'الملكي',
                price: '4500',
                period: 'ج.م / زيارة',
                features: ['فيلا كاملة', 'تلميع رخام وثريات', 'غسيل سجاد وكنب'],
                isPopular: false,
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
            ],
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;

  const _PricingCard({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.isPopular,
  });

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 300,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: widget.isPopular ? AppTheme.primaryGold : AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isPopular
                ? AppTheme.primaryGold
                : (_hovered ? AppTheme.primaryGold.withOpacity(0.5) : AppTheme.borderSubtle),
            width: widget.isPopular ? 2 : 1,
          ),
          boxShadow: widget.isPopular
              ? [BoxShadow(color: AppTheme.primaryGold.withOpacity(0.3), blurRadius: 40, spreadRadius: 0)]
              : [BoxShadow(color: Colors.black.withOpacity(_hovered ? 0.08 : 0.04), blurRadius: 20)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppTheme.textDark,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  'الأكثر طلباً',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1),
                ),
              ),
            Text(
              widget.name,
              style: TextStyle(
                color: widget.isPopular ? AppTheme.textDark.withOpacity(0.8) : AppTheme.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.price,
                  style: TextStyle(
                    color: widget.isPopular ? AppTheme.textDark : AppTheme.textDark,
                    fontSize: widget.isPopular ? 48 : 36,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 6),
                  child: Text(
                    widget.period,
                    style: TextStyle(
                      color: widget.isPopular ? AppTheme.textDark.withOpacity(0.7) : AppTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Divider(color: widget.isPopular ? AppTheme.textDark.withOpacity(0.2) : AppTheme.borderSubtle),
            const SizedBox(height: 24),
            ...widget.features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: widget.isPopular ? AppTheme.textDark : AppTheme.primaryDark,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      f,
                      style: TextStyle(
                        color: widget.isPopular ? AppTheme.textDark : AppTheme.textMuted,
                        fontSize: 14,
                        fontWeight: widget.isPopular ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: widget.isPopular ? AppTheme.textDark : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: widget.isPopular ? null : Border.all(color: AppTheme.primaryGold),
                ),
                child: Text(
                  widget.isPopular ? 'احجز الآن' : 'اختيار الباقة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.isPopular ? AppTheme.primaryGold : AppTheme.primaryDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.4)),
      ),
      child: const Text(
        'PRICING',
        style: TextStyle(
          color: AppTheme.primaryDark,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}