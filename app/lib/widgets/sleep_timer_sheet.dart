import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';

const sleepTimerOptions = <Duration>[
  Duration(minutes: 15),
  Duration(minutes: 30),
  Duration(minutes: 45),
  Duration(minutes: 60),
  Duration(minutes: 90),
  Duration(minutes: 120),
];

String formatSleepTimerCountdown(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (hours > 0) {
    return '$hours:$minutes:$seconds';
  }
  return '$minutes:$seconds';
}

Future<void> showSleepTimerSheet(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;

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
            child: Consumer<AppState>(
              builder: (context, state, _) {
                final selectedDuration = state.hasActiveTimer
                    ? state.timerDuration
                    : state.lastSleepTimerDuration;

                return ListView(
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
                    if (state.hasActiveTimer && state.timerRemaining != null) ...[
                      const SizedBox(height: 12),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.timer_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(
                            l10n.timerRemaining(
                              formatSleepTimerCountdown(state.timerRemaining!),
                            ),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          subtitle: state.timerDuration != null
                              ? Text(l10n.minutesOption(state.timerDuration!.inMinutes))
                              : null,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    ...sleepTimerOptions.map((duration) {
                      final isActiveSelection =
                          state.hasActiveTimer && state.timerDuration == duration;
                      final isLastSelection =
                          !state.hasActiveTimer && selectedDuration == duration;

                      return ListTile(
                        leading: Icon(
                          isActiveSelection ? Icons.timer_rounded : Icons.timer_outlined,
                          color: isActiveSelection || isLastSelection
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(l10n.minutesOption(duration.inMinutes)),
                        trailing: isActiveSelection || isLastSelection
                            ? Icon(
                                Icons.check_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        selected: isActiveSelection || isLastSelection,
                        onTap: () {
                          sheetContext.read<AppState>().startSleepTimer(duration);
                          Navigator.pop(sheetContext);
                        },
                      );
                    }),
                    if (state.hasActiveTimer)
                      ListTile(
                        leading: const Icon(Icons.close),
                        title: Text(l10n.cancelTimer),
                        onTap: () {
                          state.cancelSleepTimer();
                          Navigator.pop(sheetContext);
                        },
                      ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}
