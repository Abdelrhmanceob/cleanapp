import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onCta;
  const HeroSection({super.key, required this.onCta});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _bgIndex = 0;
  Timer? _timer;

  final List<Color> _bgColors = [
    const Color(0xFFF6F3F2),
    const Color(0xFFF0EDEC),
    const Color(0xFFEBE7E7),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) setState(() => _bgIndex = (_bgIndex + 1) % _bgColors.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 500 : 700),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.surfaceWhite, _bgColors[_bgIndex]],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Stack(
        children: [
          // Sparkle decorations
          Positioned(
            top: 80,
            right: isMobile ? 20 : 150,
            child: Icon(Icons.auto_awesome, color: AppTheme.primaryGold.withOpacity(0.3), size: 80)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .fadeIn(delay: 400.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 3000.ms),
          ),
          Positioned(
            bottom: 120,
            right: isMobile ? 40 : 280,
            child: Icon(Icons.color_lens, color: AppTheme.primaryGold.withOpacity(0.2), size: 40)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .slideY(begin: 0, end: -0.3, duration: 2000.ms, curve: Curves.easeInOut),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: isMobile ? 60 : 96,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Headline
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 700),
                  child: Text(
                    'خدمة تنظيف منازل\nعلى الطلب',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1),
                ),
                const SizedBox(height: 24),
                // Subtitle
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 540),
                  child: Text(
                    'نحن نعيد تعريف مفهوم النظافة المنزلية. استمتع بمعايير الفنادق الفاخرة في منزلك الخاص مع فريقنا المدرب بعناية فائقة.',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 18,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ).animate().fadeIn(delay: 150.ms, duration: 800.ms),
                ),
                const SizedBox(height: 40),
                // CTA Buttons
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    _GoldButton(label: 'ابدأ الآن', onTap: widget.onCta),
                    _OutlineButton(label: 'اكتشف خدماتنا'),
                  ],
                ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
                if (!isMobile) ...[
                  const SizedBox(height: 64),
                  _StatsRow().animate().fadeIn(delay: 500.ms, duration: 800.ms),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoldButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GoldButton({required this.label, required this.onTap});

  @override
  State<_GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<_GoldButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryDark : AppTheme.primaryGold,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGold.withOpacity(_hovered ? 0.5 : 0.25),
                blurRadius: _hovered ? 24 : 12,
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF221B00),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  const _OutlineButton({required this.label});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.primaryGold.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryGold),
        ),
        child: Text(
          widget.label,
          style: const TextStyle(
            color: AppTheme.primaryDark,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StatItem(value: '+5000', label: 'عميل سعيد'),
        Container(width: 1, height: 48, color: AppTheme.borderSubtle, margin: const EdgeInsets.symmetric(horizontal: 32)),
        _StatItem(value: '+120', label: 'خبير تنظيف'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.primaryDark,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}