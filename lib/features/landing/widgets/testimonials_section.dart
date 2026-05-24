import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _testimonials = [
    {
      'quote': 'أفضل تجربة تنظيف حصلت عليها على الإطلاق. الفريق احترافي للغاية والنتيجة كانت مبهرة.',
      'name': 'أحمد صالح',
      'location': 'القاهرة، مصر',
      'stars': 5,
    },
    {
      'quote': 'التطبيق سهل الاستخدام والمواعيد دقيقة جداً. أنصح به بشدة لكل من يقدر الجودة.',
      'name': 'سارة خالد',
      'location': 'الإسكندرية، مصر',
      'stars': 5,
    },
    {
      'quote': 'خدمة عملاء ممتازة واستجابة سريعة. شعرت بالأمان والراحة طوال فترة تواجد الفريق.',
      'name': 'محمد علي',
      'location': 'المنصورة، مصر',
      'stars': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      color: AppTheme.backgroundCream,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 80),
      child: Column(
        children: [
          Text(
            'ماذا يقول عملاؤنا',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxis = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: _testimonials.length,
                itemBuilder: (context, i) => _TestimonialCard(
                  quote: _testimonials[i]['quote'] as String,
                  name: _testimonials[i]['name'] as String,
                  location: _testimonials[i]['location'] as String,
                  stars: _testimonials[i]['stars'] as int,
                ).animate().fadeIn(delay: (i * 150).ms).slideY(begin: 0.2),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String quote;
  final String name;
  final String location;
  final int stars;
  const _TestimonialCard({
    required this.quote,
    required this.name,
    required this.location,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSubtle.withOpacity(0.4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              5,
              (i) => Icon(
                i < stars ? Icons.star : Icons.star_border,
                color: AppTheme.primaryGold,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Quote
          Expanded(
            child: Text(
              '"$quote"',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 14,
                height: 1.7,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Author
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.primaryGold, width: 2),
                  color: AppTheme.primaryGold.withOpacity(0.15),
                ),
                child: const Icon(Icons.person, color: AppTheme.primaryDark, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}