/// Hero carousel — local stitch assets in web/assets/hero/.
class HeroImages {
  HeroImages._();

  static const String _base = 'hero';

  static String asset(int n) => '$_base/hero-$n.png';

  static List<({String imageUrl, String alt})> get defaultSlides => [
        (
          imageUrl: asset(1),
          alt: 'خدمة تنظيف احترافية',
        ),
        (
          imageUrl: asset(2),
          alt: 'تنظيف المنازل والفيلات',
        ),
        (
          imageUrl: asset(3),
          alt: 'فريق عمل مصري محترف',
        ),
        (
          imageUrl: asset(4),
          alt: 'معايير جودة عالمية',
        ),
      ];

  static bool isLowQualityUrl(String url) =>
      url.contains('aida-public') ||
      url.contains('googleusercontent.com/aida');

  static bool shouldUpgradeHeroUrl(String url) =>
      isLowQualityUrl(url) ||
      url.contains('images.unsplash.com') ||
      url.contains('images.pexels.com') ||
      url.contains('assets/hero/') ||
      url.startsWith('/hero/');
}
