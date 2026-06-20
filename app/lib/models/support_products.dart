/// Google Play / App Store product IDs for voluntary support (consumables).
///
/// Create matching products in Play Console → Monetize → Products → In-app products.
abstract final class SupportProducts {
  static const ids = <String>[
    supportCoffee,
    supportMeal,
    supportGenerous,
  ];

  static const supportCoffee = 'support_coffee';
  static const supportMeal = 'support_meal';
  static const supportGenerous = 'support_generous';
}
