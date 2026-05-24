import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class LandingNav extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback onDashboard;

  const LandingNav({super.key, required this.isScrolled, required this.onDashboard});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 20),
        decoration: BoxDecoration(
          color: isScrolled
              ? AppTheme.surfaceWhite.withOpacity(0.95)
              : AppTheme.backgroundCream,
          border: Border(
            bottom: BorderSide(color: AppTheme.borderSubtle.withOpacity(isScrolled ? 1.0 : 0.5)),
          ),
          boxShadow: isScrolled
              ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 2))]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('ن', style: TextStyle(color: Color(0xFF221B00), fontWeight: FontWeight.w800, fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'نازافلي',
                  style: TextStyle(
                    color: AppTheme.primaryDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            if (!isMobile)
              Row(
                children: [
                  _NavLink(label: 'الخدمات'),
                  const SizedBox(width: 32),
                  _NavLink(label: 'كيف نعمل'),
                  const SizedBox(width: 32),
                  _NavLink(label: 'الأسعار'),
                  const SizedBox(width: 32),
                  _NavLink(label: 'قالوا عنا'),
                  const SizedBox(width: 40),
                  _CTAButton(label: 'ابدأ الآن', onTap: onDashboard),
                ],
              )
            else
              _CTAButton(label: 'ابدأ الآن', onTap: onDashboard),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  const _NavLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppTheme.textMuted,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _CTAButton({required this.label, required this.onTap});

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryDark : AppTheme.primaryGold,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hovered
                ? [BoxShadow(color: AppTheme.primaryGold.withOpacity(0.4), blurRadius: 20, spreadRadius: 0)]
                : [],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF221B00),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}