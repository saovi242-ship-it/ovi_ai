import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: GlassCard(
            padding: const EdgeInsets.all(34),
            tint: OviColors.peach.withValues(alpha: 0.07),
            borderColor: OviColors.peach.withValues(alpha: 0.22),
            child: Column(
              children: [
                const Icon(
                  Icons.tune_rounded,
                  color: OviColors.peach,
                  size: 42,
                ),
                const SizedBox(height: 22),
                Text(
                  'SETTINGS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: OviColors.peach,
                    letterSpacing: 1.6,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Make OVI yours',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Personalize the way Natasha supports your attention, ideas, and everyday rhythm.',
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
