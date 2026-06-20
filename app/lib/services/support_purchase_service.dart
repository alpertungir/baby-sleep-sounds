import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../models/support_products.dart';

class SupportPurchaseService {
  SupportPurchaseService({InAppPurchase? iap}) : _iap = iap ?? InAppPurchase.instance;

  final InAppPurchase _iap;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<bool> initialize({
    required void Function(PurchaseDetails purchase) onPurchaseSuccess,
    required void Function(PurchaseDetails purchase) onPurchaseError,
  }) async {
    if (!isSupported) return false;

    final available = await _iap.isAvailable();
    if (!available) return false;

    _subscription ??= _iap.purchaseStream.listen((purchases) async {
      for (final purchase in purchases) {
        switch (purchase.status) {
          case PurchaseStatus.pending:
            break;
          case PurchaseStatus.purchased:
          case PurchaseStatus.restored:
            if (purchase.pendingCompletePurchase) {
              await _iap.completePurchase(purchase);
            }
            onPurchaseSuccess(purchase);
          case PurchaseStatus.error:
            if (purchase.pendingCompletePurchase) {
              await _iap.completePurchase(purchase);
            }
            onPurchaseError(purchase);
          case PurchaseStatus.canceled:
            if (purchase.pendingCompletePurchase) {
              await _iap.completePurchase(purchase);
            }
            onPurchaseError(purchase);
        }
      }
    });

    return true;
  }

  Future<ProductDetailsResponse> queryProducts() {
    return _iap.queryProductDetails(SupportProducts.ids.toSet());
  }

  Future<bool> buy(ProductDetails product) {
    return _iap.buyConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  void dispose() {
    unawaited(_subscription?.cancel());
    _subscription = null;
  }
}
