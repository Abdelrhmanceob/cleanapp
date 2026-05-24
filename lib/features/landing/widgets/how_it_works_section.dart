import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      decoration: const BoxDecoration(color: AppTheme.backgroundCream),
      child: Column(
        children: [
          const _SectionLabel(label: 'HOW IT WORKS'),
          const SizedBox(height: 16),
          Text(
            'From request to completion\nin seconds',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 64),
          isMobile
              ? Column(children: _buildSteps())
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildSteps(),
                ),
          const SizedBox(height: 80),
          const _AnimationShowcase(),
        ],
      ),
    );
  }

  List<Widget> _buildSteps() {
    final steps = [
      {
        'num': '01',
        'icon': Icons.install_mobile,
        'title': 'تحميل التطبيق',
        'desc': 'متوفر على جميع المتاجر الذكية'
      },
      {
        'num': '02',
        'icon': Icons.touch_app,
        'title': 'اختيار الخدمة',
        'desc': 'حدد الموعد والنوع الذي يناسبك'
      },
      {
        'num': '03',
        'icon': Icons.cleaning_services,
        'title': 'استمتع بالنظافة',
        'desc': 'اجلس واسترخي، نحن سنهتم بكل شيء'
      },
    ];

    return steps
        .asMap()
        .entries
        .map(
          (e) => Expanded(
            child: _StepCard(
              num: e.value['num']! as String,
              icon: e.value['icon']! as IconData,
              title: e.value['title']! as String,
              desc: e.value['desc']! as String,
              isLast: e.key == steps.length - 1,
            ).animate().fadeIn(delay: (e.key * 120).ms).slideY(begin: 0.2),
          ),
        )
        .toList();
  }
}

class _StepCard extends StatefulWidget {
  final String num;
  final IconData icon;
  final String title;
  final String desc;
  final bool isLast;

  const _StepCard({
    required this.num,
    required this.icon,
    required this.title,
    required this.desc,
    required this.isLast,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: _hovered ? AppTheme.primaryGold.withOpacity(0.15) : AppTheme.surfaceWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _hovered ? AppTheme.primaryGold : AppTheme.borderSubtle,
                      width: _hovered ? 2 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16),
                    ],
                  ),
                  child: Icon(widget.icon, color: AppTheme.primaryDark, size: 40),
                ),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppTheme.textDark,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.num,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 14,
                height: 1.65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimationShowcase extends StatelessWidget {
  const _AnimationShowcase();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.borderSubtle),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
      ),
      child: Column(
        children: [
          const Text(
            'Live Service Journey Simulation',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Experience our complete service flow — from booking to payment — powered by the Nazavly engine.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 32),
          const _PhoneMockup(),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}

class _PhoneMockup extends StatefulWidget {
  const _PhoneMockup();

  @override
  State<_PhoneMockup> createState() => _PhoneMockupState();
}

class _PhoneMockupState extends State<_PhoneMockup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _stage = 0;
  final List<Map<String, dynamic>> _stages = [
    {'icon': Icons.home_repair_service, 'label': 'Service Requested', 'color': AppTheme.primaryGold},
    {'icon': Icons.search, 'label': 'Finding Workers...', 'color': Colors.blue},
    {'icon': Icons.person_pin_circle, 'label': 'Worker Matched!', 'color': AppTheme.successGreen},
    {'icon': Icons.directions_car, 'label': 'Worker En Route', 'color': Colors.orange},
    {'icon': Icons.cleaning_services, 'label': 'Service In Progress', 'color': AppTheme.primaryGold},
    {'icon': Icons.verified, 'label': 'Service Completed!', 'color': AppTheme.successGreen},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _startCycle();
  }

  void _startCycle() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _stage = (_stage + 1) % _stages.length);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _stages[_stage];
    return Container(
      width: 200,
      height: 360,
      decoration: BoxDecoration(
        color: AppTheme.textDark,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(color: AppTheme.primaryGold.withOpacity(0.15), blurRadius: 40, spreadRadius: 0),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 60,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                key: ValueKey(_stage),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: (current['color'] as Color).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      current['icon'] as IconData,
                      color: current['color'] as Color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    current['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _stages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _stage ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: i == _stage
                              ? AppTheme.primaryGold
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primaryDark,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}