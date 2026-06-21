import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/support_purchase_provider.dart';
import '../widgets/decorative_background.dart';
import '../widgets/favorites_app_bar_button.dart';
import '../widgets/language_menu_button.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    context.read<SupportPurchaseProvider>().addListener(_onProviderChanged);
  }

  @override
  void dispose() {
    context.read<SupportPurchaseProvider>().removeListener(_onProviderChanged);
    super.dispose();
  }

  Future<void> _load() async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    await context.read<SupportPurchaseProvider>().loadProducts(l10n);
  }

  void _onProviderChanged() {
    if (!mounted) return;
    final provider = context.read<SupportPurchaseProvider>();
    if (provider.consumePurchaseSuccess()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.supportThankYou)),
      );
    }
  }

  Future<void> _buy(SupportTier tier) async {
    final l10n = AppLocalizations.of(context)!;
    if (!tier.isPurchasable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.supportProductsPending)),
      );
      return;
    }

    final provider = context.read<SupportPurchaseProvider>();
    final started = await provider.buy(tier);
    if (!mounted) return;
    if (!started) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.supportPurchaseFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final provider = context.watch<SupportPurchaseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.supportTitle),
        actions: const [FavoritesAppBarButton(), LanguageMenuButton()],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: DecorativeBackground()),
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              Icon(
                Icons.favorite_outline_rounded,
                size: 40,
                color: theme.colorScheme.primary.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.supportBody,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.88),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              if (!provider.isSupported)
                Text(
                  l10n.supportUnavailable,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                )
              else ...[
                if (!provider.hasPlayProducts)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      l10n.supportProductsPending,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                        height: 1.4,
                      ),
                    ),
                  ),
                if (provider.loadingProducts && provider.tiers.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                ...provider.tiers.map(
                  (tier) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SupportTierCard(
                      tier: tier,
                      l10n: l10n,
                      busy: provider.isPurchasingTier(tier.id),
                      onTap: provider.purchasing ? null : () => _buy(tier),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SupportTierCard extends StatelessWidget {
  const _SupportTierCard({
    required this.tier,
    required this.l10n,
    required this.busy,
    required this.onTap,
  });

  final SupportTier tier;
  final AppLocalizations l10n;
  final bool busy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface.withValues(alpha: 0.72),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tier.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tier.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (busy)
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    tier.priceLabel(l10n),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void openSupportScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const SupportScreen()),
  );
}
