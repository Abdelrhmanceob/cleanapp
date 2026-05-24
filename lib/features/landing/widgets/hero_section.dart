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
  int _imgIndex = 0;
  Timer? _timer;

  // Carousel slides: icon + gradient + label
  static const _slides = [
    {
      'icon': Icons.bedroom_parent_outlined,
      'label': 'تنظيف غرف النوم',
      'sub': 'نظافة عميقة لكل ركن',
      'grad1': Color(0xFFF6F3EE),
      'grad2': Color(0xFFEDE8DF),
    },
    {
      'icon': Icons.kitchen_outlined,
      'label': 'تنظيف المطابخ',
      'sub': 'إزالة الدهون والبقع',
      'grad1': Color(0xFFF0EDE8),
      'grad2': Color(0xFFE8E2D8),
    },
    {
      'icon': Icons.bathtub_outlined,
      'label': 'تنظيف الحمامات',
      'sub': 'تعقيم وتلميع كامل',
      'grad1': Color(0xFFEEEDF6),
      'grad2': Color(0xFFDFDEED),
    },
    {
      'icon': Icons.weekend_outlined,
      'label': 'تنظيف غرف المعيشة',
      'sub': 'أريكة، سجاد، وأكثر',
      'grad1': Color(0xFFF2EEE8),
      'grad2': Color(0xFFE8E0D2),
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) setState(() => _imgIndex = (_imgIndex + 1) % _slides.length);
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

    return SizedBox(
      width: double.infinity,
      height: isMobile ? null : 640,
      child: isMobile
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return ColoredBox(
      color: AppTheme.surfaceWhite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: text content
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextContent(false),
                ],
              ),
            ),
          ),
          // Right: image carousel (fixed width, fills row height)
          SizedBox(
            width: 420,
            child: _buildCarousel(false),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        SizedBox(height: 280, child: _buildCarousel(true)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: _buildTextContent(true),
        ),
      ],
    );
  }

  Widget _buildCarousel(bool isMobile) {
    final slide = _slides[_imgIndex];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: child,
        ),
      ),
      child: Container(
        key: ValueKey(_imgIndex),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [slide['grad1'] as Color, slide['grad2'] as Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: isMobile
              ? BorderRadius.zero
              : const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Big icon card
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGold.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                slide['icon'] as IconData,
                color: AppTheme.primaryDark,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              slide['label'] as String,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              slide['sub'] as String,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 28),
            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _imgIndex ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == _imgIndex
                        ? AppTheme.primaryGold
                        : AppTheme.primaryGold.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
          child: Text(
            'خدمة تنظيف منازل\nعلى الطلب',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: isMobile ? 32 : 52,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 480),
          child: Text(
            'نحن نعيد تعريف مفهوم النظافة المنزلية. استمتع بمعايير الفنادق الفاخرة في منزلك الخاص مع فريقنا المدرب بعناية فائقة.',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 17,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ).animate().fadeIn(delay: 150.ms, duration: 800.ms),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _GoldButton(label: 'ابدأ الآن', onTap: widget.onCta),
            _OutlineButton(label: 'اكتشف خدماتنا'),
          ],
        ).animate().fadeIn(delay: 300.ms, duration: 800.ms),
        if (!isMobile) ...[
          const SizedBox(height: 56),
          _StatsRow().animate().fadeIn(delay: 500.ms, duration: 800.ms),
        ],
      ],
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