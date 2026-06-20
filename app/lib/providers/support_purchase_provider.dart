import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../l10n/app_localizations.dart';
import '../models/support_products.dart';
import '../services/support_purchase_service.dart';

class SupportTier {
  const SupportTier({
    required this.id,
    required this.title,
    required this.subtitle,
    this.product,
  });

  final String id;
  final String title;
  final String subtitle;
  final ProductDetails? product;

  bool get isPurchasable => product != null;

  String priceLabel(AppLocalizations l10n) =>
      product?.price ?? l10n.supportPricePending;
}

class SupportPurchaseProvider extends ChangeNotifier {
  SupportPurchaseProvider({SupportPurchaseService? service})
      : _service = service ?? SupportPurchaseService();

  final SupportPurchaseService _service;

  bool _initialized = false;
  bool _billingAvailable = false;
  bool _loadingProducts = false;
  bool _purchasing = false;
  bool _purchaseSucceeded = false;
  String? _activeProductId;
  List<SupportTier> _tiers = const [];

  bool get isSupported => _service.isSupported;
  bool get billingAvailable => _billingAvailable;
  bool get hasPlayProducts => _tiers.any((tier) => tier.isPurchasable);
  bool get loadingProducts => _loadingProducts;
  bool get purchasing => _purchasing;
  List<SupportTier> get tiers => _tiers;

  bool consumePurchaseSuccess() {
    if (!_purchaseSucceeded) return false;
    _purchaseSucceeded = false;
    return true;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    _billingAvailable = await _service.initialize(
      onPurchaseSuccess: _onPurchaseSuccess,
      onPurchaseError: _onPurchaseError,
    );
    notifyListeners();
  }

  Future<void> loadProducts(AppLocalizations l10n) async {
    if (!isSupported || _loadingProducts) return;

    _loadingProducts = true;
    notifyListeners();

    try {
      if (!_initialized) {
        await initialize();
      }

      final byId = <String, ProductDetails>{};
      if (_billingAvailable) {
        final response = await _service.queryProducts();
        for (final product in response.productDetails) {
          byId[product.id] = product;
        }
      }

      _tiers = _buildTiers(l10n, byId);
    } finally {
      _loadingProducts = false;
      notifyListeners();
    }
  }

  List<SupportTier> _buildTiers(
    AppLocalizations l10n,
    Map<String, ProductDetails> byId,
  ) {
    return [
      SupportTier(
        id: SupportProducts.supportCoffee,
        title: l10n.supportCoffeeTitle,
        subtitle: l10n.supportCoffeeSubtitle,
        product: byId[SupportProducts.supportCoffee],
      ),
      SupportTier(
        id: SupportProducts.supportMeal,
        title: l10n.supportMealTitle,
        subtitle: l10n.supportMealSubtitle,
        product: byId[SupportProducts.supportMeal],
      ),
      SupportTier(
        id: SupportProducts.supportGenerous,
        title: l10n.supportGenerousTitle,
        subtitle: l10n.supportGenerousSubtitle,
        product: byId[SupportProducts.supportGenerous],
      ),
    ];
  }

  Future<bool> buy(SupportTier tier) async {
    final product = tier.product;
    if (product == null || _purchasing) return false;

    _purchasing = true;
    _purchaseSucceeded = false;
    _activeProductId = tier.id;
    notifyListeners();

    try {
      return await _service.buy(product);
    } catch (_) {
      _purchasing = false;
      _activeProductId = null;
      notifyListeners();
      return false;
    }
  }

  bool isPurchasingTier(String id) => _purchasing && _activeProductId == id;

  void _onPurchaseSuccess(PurchaseDetails purchase) {
    _purchasing = false;
    _activeProductId = null;
    _purchaseSucceeded = true;
    notifyListeners();
  }

  void _onPurchaseError(PurchaseDetails purchase) {
    _purchasing = false;
    _activeProductId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
