import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NotesPlaceholder();
  }
}

class _NotesPlaceholder extends StatelessWidget {
  const _NotesPlaceholder();

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
                  Icons.sticky_note_2_rounded,
                  color: OviColors.peach,
                  size: 42,
                ),
                const SizedBox(height: 22),
                Text(
                  'NOTES',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: OviColors.peach,
                    letterSpacing: 1.6,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your thinking space',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Capture the ideas, reflections, and fragments you want to keep close.',
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
