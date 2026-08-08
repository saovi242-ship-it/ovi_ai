import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../shared/widgets/natasha_avatar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeaturePlaceholderPage(
      title: 'Chat',
      eyebrow: 'CONVERSATIONS',
      description:
          'A thoughtful space for ideas, questions, and getting unstuck.',
      icon: Icons.forum_rounded,
      accent: OviColors.primary,
      avatar: true,
    );
  }
}

class _FeaturePlaceholderPage extends StatelessWidget {
  const _FeaturePlaceholderPage({
    required this.title,
    required this.eyebrow,
    required this.description,
    required this.icon,
    required this.accent,
    this.avatar = false,
  });

  final String title;
  final String eyebrow;
  final String description;
  final IconData icon;
  final Color accent;
  final bool avatar;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: GlassCard(
            padding: const EdgeInsets.all(34),
            tint: accent.withValues(alpha: 0.07),
            borderColor: accent.withValues(alpha: 0.22),
            child: Column(
              children: [
                if (avatar)
                  const NatashaAvatar(size: 80)
                else
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: accent, size: 30),
                  ),
                const SizedBox(height: 24),
                Text(
                  eyebrow,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: accent,
                    letterSpacing: 1.6,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: OviColors.textMuted),
                ),
                const SizedBox(height: 22),
                Text(
                  'This foundation is ready for the next feature layer.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
