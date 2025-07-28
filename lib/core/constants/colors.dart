import 'dart:ui';

class MyColors {
  // الألوان الأساسية المستوحاة من Breaking Bad
  static const Color primary = Color(0xFF2C3E50); // أزرق داكن/رمادي
  static const Color primaryDark = Color(0xFF1A252F); // نسخة داكنة من الأساسي
  static const Color primaryLight = Color(0xFF34495E); // نسخة فاتحة من الأساسي

  // الألوان الثانوية المستوحاة من اللون الأصفر في الشعار
  static const Color secondary = Color(0xFFF1C40F); // أصفر ذهبي
  static const Color secondaryDark = Color(0xFFD4AC0D); // أصفر داكن
  static const Color secondaryLight = Color(0xFFF7DC6F); // أصفر فاتح

  // ألوان الخلفية
  static const Color background = Color(0xFFECF0F1); // رمادي فاتح جداً
  static const Color surface = Color(0xFFFFFFFF); // أبيض

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF2C3E50); // نفس اللون الأساسي
  static const Color textSecondary = Color(0xFF7F8C8D); // رمادي
  static const Color textOnPrimary = Color(0xFFFFFFFF); // أبيض
  static const Color textOnSecondary = Color(0xFF000000); // أسود

  // ألوان الحالات
  static const Color error = Color(0xFFE74C3C); // أحمر (لحالة الموت)
  static const Color success = Color(0xFF2ECC71); // أخضر (لحالة الحياة)
  static const Color warning = Color(0xFFE67E22); // برتقالي
  static const Color info = Color(0xFF3498DB); // أزرق

  // ألوان إضافية
  static const Color accent = Color(0xFF9B59B6); // بنفسجي (لإضافات خاصة)
  static const Color divider = Color(0xFFBDC3C7); // رمادي للفواصل
}
