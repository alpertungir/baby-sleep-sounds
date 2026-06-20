import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'package_info_loader.dart';

class AppInfoFooter extends StatelessWidget {
  const AppInfoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
      letterSpacing: 0.2,
    );

    return FutureBuilder<PackageInfoData>(
      future: PackageInfoLoader.instance.load(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '…';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.developedBy, style: style, textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text(l10n.versionLabel(version), style: style, textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }
}
