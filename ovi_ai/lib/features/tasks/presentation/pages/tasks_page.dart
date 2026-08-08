import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _TaskPlaceholderPage();
  }
}

class _TaskPlaceholderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: GlassCard(
            padding: const EdgeInsets.all(34),
            tint: OviColors.cyan.withValues(alpha: 0.07),
            borderColor: OviColors.cyan.withValues(alpha: 0.22),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: OviColors.cyan,
                  size: 42,
                ),
                const SizedBox(height: 22),
                Text(
                  'TASKS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: OviColors.cyan,
                    letterSpacing: 1.6,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Move with intention',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'A clear view of what matters now, what can wait, and what is already done.',
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
