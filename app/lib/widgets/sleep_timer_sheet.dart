import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';

Future<void> showSleepTimerSheet(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final options = <Duration>[
    const Duration(minutes: 15),
    const Duration(minutes: 30),
    const Duration(minutes: 45),
    const Duration(minutes: 60),
    const Duration(minutes: 90),
    const Duration(minutes: 120),
  ];

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.45,
        minChildSize: 0.3,
        maxChildSize: 0.75,
        builder: (context, scrollController) {
          return SafeArea(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    l10n.sleepTimer,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  l10n.sleepTimerHint,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                ...options.map((duration) {
                  return ListTile(
                    leading: const Icon(Icons.timer_outlined),
                    title: Text(l10n.minutesOption(duration.inMinutes)),
                    onTap: () {
                      sheetContext.read<AppState>().startSleepTimer(duration);
                      Navigator.pop(sheetContext);
                    },
                  );
                }),
                Consumer<AppState>(
                  builder: (context, state, _) {
                    if (!state.hasActiveTimer) return const SizedBox.shrink();
                    return ListTile(
                      leading: const Icon(Icons.close),
                      title: Text(l10n.cancelTimer),
                      onTap: () {
                        state.cancelSleepTimer();
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
