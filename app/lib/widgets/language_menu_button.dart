import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/app_locales.dart';
import '../providers/locale_provider.dart';

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key, this.color});

  final Color? color;

  void _showLanguageMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
                      child: Text(
                        l10n.language,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      title: Text(l10n.systemLanguage),
                      trailing: localeProvider.usesSystemLocale
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () {
                        localeProvider.useSystemLocale();
                        Navigator.pop(sheetContext);
                      },
                    ),
                    const Divider(height: 1),
                    ...AppLocales.codes.map((code) {
                      final selected =
                          !localeProvider.usesSystemLocale &&
                          localeProvider.locale?.languageCode == code;
                      return ListTile(
                        title: Text(AppLocales.label(l10n, code)),
                        trailing: selected ? const Icon(Icons.check) : null,
                        onTap: () {
                          localeProvider.setLocale(Locale(code));
                          Navigator.pop(sheetContext);
                        },
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: l10n.language,
      onPressed: () => _showLanguageMenu(context),
      icon: Icon(Icons.language, color: color),
    );
  }
}
