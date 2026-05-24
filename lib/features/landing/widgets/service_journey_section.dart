import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class ServiceJourneySection extends StatelessWidget {
  const ServiceJourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Column(
        children: [
          _SectionLabel(label: 'LIVE DEMO'),
          const SizedBox(height: 16),
          Text(
            'Precision in Motion',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 8),
          Text(
            'Experience the complete service journey — from booking to payment.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontSize: 16,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 64),
          isMobile
              ? const _JourneyMobileLayout()
              : const _JourneyDesktopLayout(),
        ],
      ),
    );
  }
}

class _JourneyDesktopLayout extends StatefulWidget {
  const _JourneyDesktopLayout();

  @override
  State<_JourneyDesktopLayout> createState() => _JourneyDesktopLayoutState();
}

class _JourneyDesktopLayoutState extends State<_JourneyDesktopLayout> {
  int _stage = 0;

  void _onStageChange(int stage) {
    if (mounted) setState(() => _stage = stage);
  }

  static const _stageInfo = [
    {
      'title': 'Choose Your Service',
      'desc': 'Open the app and select the service type, preferred time, and location with just a few taps.',
    },
    {
      'title': 'AI Broadcasts Request',
      'desc': 'Our engine instantly notifies the nearest available professionals in real-time.',
    },
    {
      'title': 'Worker Matched!',
      'desc': 'The best-rated professional accepts your request. View their profile and ratings instantly.',
    },
    {
      'title': 'Live Navigation',
      'desc': 'Track your worker on a live map with real-time ETA updates as they head to you.',
    },
    {
      'title': 'Service In Progress',
      'desc': 'Communicate with your worker directly and monitor live progress updates.',
    },
    {
      'title': 'Done & Paid!',
      'desc': 'Rate your experience and payment is processed automatically. Full receipt provided.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left step labels
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              _stageInfo.length,
              (i) => _StepLabel(
                number: i + 1,
                title: _stageInfo[i]['title']!,
                desc: _stageInfo[i]['desc']!,
                isActive: _stage == i,
                onTap: () => _onStageChange(i),
              ),
            ),
          ),
        ),
        const SizedBox(width: 60),
        // Center phone mockup
        _PhoneJourneyMockup(onStageChange: _onStageChange),
        const SizedBox(width: 60),
        // Right side padding
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

class _JourneyMobileLayout extends StatelessWidget {
  const _JourneyMobileLayout();

  @override
  Widget build(BuildContext context) {
    return const _PhoneJourneyMockup();
  }
}

class _StepLabel extends StatelessWidget {
  final int number;
  final String title;
  final String desc;
  final bool isActive;
  final VoidCallback onTap;

  const _StepLabel({
    required this.number,
    required this.title,
    required this.desc,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGold.withOpacity(0.08)
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? AppTheme.primaryGold.withOpacity(0.4)
                : Colors.white.withOpacity(0.06),
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isActive
                    ? AppTheme.primaryGold
                    : Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: isActive ? AppTheme.textDark : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneJourneyMockup extends StatefulWidget {
  final void Function(int)? onStageChange;
  const _PhoneJourneyMockup({this.onStageChange});

  @override
  State<_PhoneJourneyMockup> createState() => _PhoneJourneyMockupState();
}

class _PhoneJourneyMockupState extends State<_PhoneJourneyMockup>
    with TickerProviderStateMixin {
  int _stage = 0;
  Timer? _timer;
  late AnimationController _progressController;
  late AnimationController _navController;

  static const _stages = [
    {'icon': Icons.home_repair_service, 'label': 'Book a Service', 'color': AppTheme.primaryGold},
    {'icon': Icons.radar, 'label': 'Finding Workers...', 'color': Colors.blueAccent},
    {'icon': Icons.person_pin_circle, 'label': 'Worker Matched!', 'color': AppTheme.successGreen},
    {'icon': Icons.directions_car, 'label': 'Worker En Route', 'color': Colors.orange},
    {'icon': Icons.cleaning_services, 'label': 'Service In Progress', 'color': AppTheme.primaryGold},
    {'icon': Icons.verified, 'label': 'Done & Paid!', 'color': AppTheme.successGreen},
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    _navController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    _startCycle();
  }

  void _startCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        setState(() {
          _stage = (_stage + 1) % _stages.length;
        });
        widget.onStageChange?.call(_stage);
        if (_stage == 4) {
          _progressController.forward(from: 0);
        }
        if (_stage == 3) {
          _navController.forward(from: 0);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 480,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1918),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
            color: AppTheme.primaryGold.withOpacity(0.35), width: 2),
        boxShadow: [
          BoxShadow(
              color: AppTheme.primaryGold.withOpacity(0.12),
              blurRadius: 50,
              spreadRadius: 0),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Column(
          children: [
            // Status bar / notch
            Container(
              height: 36,
              color: const Color(0xFF121110),
              child: Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            // App bar
            Container(
              height: 40,
              color: const Color(0xFF1E1D1A),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nazavly',
                    style: const TextStyle(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.notifications_outlined,
                      color: Colors.white.withOpacity(0.4), size: 18),
                ],
              ),
            ),
            // Stage content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _buildStageContent(_stage),
              ),
            ),
            // Progress dots
            Container(
              height: 40,
              color: const Color(0xFF121110),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _stages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _stage ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _stage
                          ? AppTheme.primaryGold
                          : Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageContent(int stage) {
    switch (stage) {
      case 0:
        return _Stage1Widget(key: const ValueKey(0));
      case 1:
        return _Stage2Widget(key: const ValueKey(1));
      case 2:
        return _Stage3Widget(key: const ValueKey(2));
      case 3:
        return _Stage4Widget(key: const ValueKey(3), controller: _navController);
      case 4:
        return _Stage5Widget(key: const ValueKey(4), controller: _progressController);
      case 5:
        return _Stage6Widget(key: const ValueKey(5));
      default:
        return _Stage1Widget(key: const ValueKey(0));
    }
  }
}

// Stage 1: Book a Service
class _Stage1Widget extends StatelessWidget {
  const _Stage1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.home_repair_service,
                      color: AppTheme.primaryGold, size: 28),
                ),
                const SizedBox(height: 16),
                const Text('Premium Service Booking',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppTheme.textDark)),
                const SizedBox(height: 6),
                Text('Professional services delivered to your door.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 11, color: AppTheme.textDark.withOpacity(0.5))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F4EE),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                _BookingRow(icon: Icons.bed, label: 'Rooms', value: '2'),
                const SizedBox(height: 8),
                _BookingRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: 'Maadi, Cairo'),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Request Service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _BookingRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryGold),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 11, color: AppTheme.textDark.withOpacity(0.5))),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark)),
        ],
      ),
    );
  }
}

// Stage 2: Broadcasting / Finding Workers
class _Stage2Widget extends StatefulWidget {
  const _Stage2Widget({super.key});

  @override
  State<_Stage2Widget> createState() => _Stage2WidgetState();
}

class _Stage2WidgetState extends State<_Stage2Widget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0EDEC),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Grid background
                CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: _GridPainter(),
                ),
                // Pulse rings
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, __) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: (1 - _pulseController.value).clamp(0, 1),
                        child: Container(
                          width: 120 * _pulseController.value + 20,
                          height: 120 * _pulseController.value + 20,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryGold,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                // Worker icons
                const Positioned(
                    top: 30,
                    left: 30,
                    child: Icon(Icons.person_pin_circle,
                        color: AppTheme.primaryGold, size: 24)),
                const Positioned(
                    bottom: 40,
                    right: 25,
                    child: Icon(Icons.person_pin_circle,
                        color: AppTheme.primaryGold, size: 24)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -5)),
              ],
            ),
            child: Column(
              children: [
                const Text('Searching for available workers...',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppTheme.textDark)),
                const SizedBox(height: 4),
                Text('12 professionals nearby',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textDark.withOpacity(0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7e7761).withOpacity(0.2)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += size.width / 5) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += size.height / 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// Stage 3: Worker Matched
class _Stage3Widget extends StatelessWidget {
  const _Stage3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F4EE),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border(
                  left: BorderSide(color: AppTheme.primaryGold, width: 3)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12)
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bolt,
                      color: AppTheme.primaryGold, size: 18),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NEW MATCH',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark.withOpacity(0.5),
                            letterSpacing: 1)),
                    const Text('Accept for instant service!',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.primaryGold, width: 2.5),
                  ),
                  child: const Icon(Icons.person,
                      color: AppTheme.primaryGold, size: 36),
                ),
                const SizedBox(height: 12),
                const Text('Ahmed Mohamed',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppTheme.textDark)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star,
                        color: AppTheme.primaryGold, size: 14),
                    const SizedBox(width: 4),
                    const Text('4.9',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: AppTheme.textDark)),
                    Text(' (250+ reviews)',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.textDark.withOpacity(0.4))),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('Accept',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Stage 4: Navigation
class _Stage4Widget extends StatefulWidget {
  final AnimationController controller;
  const _Stage4Widget({super.key, required this.controller});

  @override
  State<_Stage4Widget> createState() => _Stage4WidgetState();
}

class _Stage4WidgetState extends State<_Stage4Widget> {
  @override
  void initState() {
    super.initState();
    widget.controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(color: const Color(0xFFE8E5E0)),
                CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: _GridPainter(),
                ),
                // Route line
                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (_, __) => CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: _RoutePainter(progress: widget.controller.value),
                  ),
                ),
                // Home icon at top
                const Positioned(
                  top: 20,
                  child: Icon(Icons.home, color: AppTheme.primaryGold, size: 28),
                ),
                // Car moving upward
                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (_, __) {
                    final bottom = 20 + (widget.controller.value * 120);
                    return Positioned(
                      bottom: bottom,
                      child: const Icon(Icons.directions_car,
                          color: AppTheme.successGreen, size: 24),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4)),
              ],
            ),
            child: Row(
              children: [
                _InfoBox(label: 'ETA', value: '8 min'),
                const SizedBox(width: 12),
                _InfoBox(label: 'Distance', value: '1.2 km', isGold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isGold;
  const _InfoBox(
      {required this.label, required this.value, this.isGold = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F4EE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(),
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark.withOpacity(0.4),
                    letterSpacing: 0.8)),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color:
                        isGold ? AppTheme.primaryGold : AppTheme.textDark)),
          ],
        ),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final double progress;
  const _RoutePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryGold
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width / 2, size.height - 20)
      ..lineTo(size.width / 2, size.height * (1 - progress));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RoutePainter old) => old.progress != progress;
}

// Stage 5: In Progress with chat and progress bars
class _Stage5Widget extends StatefulWidget {
  final AnimationController controller;
  const _Stage5Widget({super.key, required this.controller});

  @override
  State<_Stage5Widget> createState() => _Stage5WidgetState();
}

class _Stage5WidgetState extends State<_Stage5Widget> {
  bool _showChat2 = false;
  Timer? _chatTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.forward(from: 0);
    _chatTimer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted) setState(() => _showChat2 = true);
    });
  }

  @override
  void dispose() {
    _chatTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Worker header
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F4EE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGold, width: 1.5),
                  ),
                  child: const Icon(Icons.person,
                      color: AppTheme.primaryGold, size: 20),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ahmed Mohamed',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: AppTheme.textDark)),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppTheme.successGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('Worker arrived',
                            style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.successGreen)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Chat
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Text(
              'Hello! Starting the service now.',
              style: TextStyle(fontSize: 11, color: AppTheme.textDark),
            ),
          ).animate().fadeIn().slideX(begin: 0.2),
          if (_showChat2) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDEC),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  'Great, thank you!',
                  style: TextStyle(fontSize: 11, color: AppTheme.textDark),
                ),
              ).animate().fadeIn().slideX(begin: -0.2),
            ),
          ],
          const SizedBox(height: 12),
          // Progress bars
          AnimatedBuilder(
            animation: widget.controller,
            builder: (_, __) => Column(
              children: [
                _ProgressBar(
                    label: 'Initial Cleaning',
                    progress: widget.controller.value.clamp(0.0, 1.0)),
                const SizedBox(height: 8),
                _ProgressBar(
                    label: 'Deep Cleaning',
                    progress: ((widget.controller.value - 0.5) * 2)
                        .clamp(0.0, 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final String label;
  final double progress;
  const _ProgressBar({required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark.withOpacity(0.5),
                    letterSpacing: 0.5)),
            Text('${(progress * 100).round()}%',
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark.withOpacity(0.5))),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryGold,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Stage 6: Done & Payment
class _Stage6Widget extends StatelessWidget {
  const _Stage6Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified,
                color: AppTheme.successGreen, size: 36),
          ).animate().scale(delay: 100.ms),
          const SizedBox(height: 16),
          const Text('Service Complete!',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppTheme.textDark)),
          const SizedBox(height: 6),
          Text('How was your experience?',
              style: TextStyle(
                  fontSize: 11, color: AppTheme.textDark.withOpacity(0.5))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => Icon(Icons.star,
                  color: i < 4
                      ? AppTheme.primaryGold
                      : Colors.grey.withOpacity(0.3),
                  size: 24),
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.successGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.check_circle, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text('Payment Successful',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 8),
          Text('350 EGP — Thank you for using Nazavly!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, color: AppTheme.textDark.withOpacity(0.45))),
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
        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primaryGold,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}