import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: GlassCard(
            padding: const EdgeInsets.all(34),
            tint: OviColors.primary.withValues(alpha: 0.07),
            borderColor: OviColors.primary.withValues(alpha: 0.22),
            child: Column(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  color: OviColors.primary,
                  size: 42,
                ),
                const SizedBox(height: 22),
                Text(
                  'CALENDAR',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: OviColors.primary,
                    letterSpacing: 1.6,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Make space for what matters',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'See your time with enough context to plan a day that feels like yours.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: OviColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
