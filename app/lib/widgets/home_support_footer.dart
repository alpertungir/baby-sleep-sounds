import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/support_screen.dart';
import 'screen_insets.dart';

class HomeSupportFooter extends StatelessWidget {
  const HomeSupportFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        12,
        0,
        12,
        ScreenInsets.miniPlayerBottom(context),
      ),
      child: Material(
        elevation: 4,
        shadowColor: primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.surface.withValues(alpha: 0.88),
        child: InkWell(
          onTap: () => openSupportScreen(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.coffee_rounded, color: primary, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.homeSupportCta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
