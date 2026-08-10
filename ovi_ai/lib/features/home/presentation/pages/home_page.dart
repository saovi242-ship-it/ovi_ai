import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/natasha_avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning, OVI ☀️';
    } else if (hour < 17) {
      return 'Good afternoon, OVI 🌤️';
    } else {
      return 'Good evening, OVI 🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 800;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48.0 : 24.0,
              vertical: 24.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // ১. Natasha Avatar with Glow Effect
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: isDesktop ? 180 : 130,
                        height: isDesktop ? 180 : 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.35),
                              blurRadius: 40.0,
                              spreadRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                      NatashaAvatar(
                        size: isDesktop ? 180 : 130,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ২. Dynamic Time-based Greeting
                  Text(
                    _getGreeting(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // ৩. Natasha Introduction Text
                  Text(
                    "I'm Natasha. How can I help you today?",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // ৪. Glassmorphism Interaction Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Conversation action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.auto_awesome),
                              label: const Text(
                                'Start Conversation',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../shared/widgets/natasha_avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AnimatedEntrance(child: _WelcomeHeader()),
              const SizedBox(height: 28),
              const AnimatedEntrance(
                delay: Duration(milliseconds: 90),
                child: _StatusCard(),
              ),
              const SizedBox(height: 28),
              const AnimatedEntrance(
                delay: Duration(milliseconds: 150),
                child: _QuickActions(),
              ),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= OviBreakpoints.wide;
                  if (isWide) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 12, child: _ConversationsCard()),
                        SizedBox(width: 18),
                        Expanded(flex: 8, child: _NotesCard()),
                      ],
                    );
                  }
                  return const Column(
                    children: [
                      _ConversationsCard(),
                      SizedBox(height: 18),
                      _NotesCard(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= OviBreakpoints.wide;
                  if (isWide) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _TasksCard()),
                        SizedBox(width: 18),
                        Expanded(child: _CalendarCard()),
                      ],
                    );
                  }
                  return const Column(
                    children: [
                      _TasksCard(),
                      SizedBox(height: 18),
                      _CalendarCard(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NatashaAvatar(size: 76),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, Alex',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'I’ve been keeping an eye on things. What should we focus on today?',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: OviColors.textMuted),
              ),
            ],
          ),
        ),
        if (MediaQuery.sizeOf(context).width >= OviBreakpoints.desktop)
          IconButton(
            onPressed: () {},
            tooltip: 'Customize home',
            icon: const Icon(Icons.tune_rounded),
          ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      tint: OviColors.primary.withValues(alpha: 0.08),
      borderColor: OviColors.primary.withValues(alpha: 0.24),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: OviColors.success.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: OviColors.success,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Natasha is online',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 3),
                Text(
                  'All systems ready · Last sync just now',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const _OnlineIndicator(),
        ],
      ),
    );
  }
}

class _OnlineIndicator extends StatelessWidget {
  const _OnlineIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: OviColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: OviColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            'READY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: OviColors.success,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        label: 'Ask Natasha',
        caption: 'Start a conversation',
        icon: Icons.forum_rounded,
        color: OviColors.primary,
        onTap: () {},
      ),
      _QuickAction(
        label: 'Capture a thought',
        caption: 'Save a quick note',
        icon: Icons.edit_note_rounded,
        color: OviColors.peach,
        onTap: () {},
      ),
      _QuickAction(
        label: 'Plan my day',
        caption: 'See what’s next',
        icon: Icons.wb_sunny_rounded,
        color: OviColors.cyan,
        onTap: () {},
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: 'QUICK ACTIONS'),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 24) / 3;
            if (constraints.maxWidth < 520) {
              return Column(
                children:
                    actions
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _QuickActionTile(action: action),
                          ),
                        )
                        .toList(),
              );
            }
            return Row(
              children:
                  actions
                      .map(
                        (action) => SizedBox(
                          width: itemWidth,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: action == actions.last ? 0 : 12,
                            ),
                            child: _QuickActionTile(action: action),
                          ),
                        ),
                      )
                      .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action});

  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: action.onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(action.icon, color: action.color, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 3),
                Text(
                  action.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_outward_rounded,
            color: OviColors.textMuted,
            size: 17,
          ),
        ],
      ),
    );
  }
}

class _ConversationsCard extends StatelessWidget {
  const _ConversationsCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            title: 'Recent conversations',
            icon: Icons.forum_outlined,
            actionLabel: 'View all',
            onAction: () {},
          ),
          const SizedBox(height: 8),
          const _ConversationRow(
            title: 'Ideas for the launch campaign',
            preview: 'You mentioned a warmer, more human direction...',
            time: '10:42 AM',
            color: OviColors.primary,
          ),
          const _ConversationRow(
            title: 'Weekend trip to the coast',
            preview: 'I found three quiet places with great walking trails.',
            time: 'Yesterday',
            color: OviColors.cyan,
          ),
          const _ConversationRow(
            title: 'Untangling the product brief',
            preview: 'Let’s turn those loose ideas into a clear next step.',
            time: 'Mon',
            color: OviColors.peach,
          ),
        ],
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            title: 'Notes preview',
            icon: Icons.sticky_note_2_outlined,
            actionLabel: 'Open notes',
            onAction: () {},
          ),
          const SizedBox(height: 18),
          Text(
            'Things worth remembering',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'The best ideas arrive when there’s room to notice them. Keep creating that room.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(label: 'Reflection', color: OviColors.primary),
              _Tag(label: 'Creative', color: OviColors.peach),
              _Tag(label: 'Personal', color: OviColors.cyan),
            ],
          ),
        ],
      ),
    );
  }
}

class _TasksCard extends StatelessWidget {
  const _TasksCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            title: 'Tasks for today',
            icon: Icons.check_circle_outline_rounded,
            actionLabel: 'See tasks',
            onAction: () {},
          ),
          const SizedBox(height: 14),
          const _TaskRow(
            title: 'Review the Q3 creative brief',
            meta: 'Due at 2:00 PM',
            complete: false,
          ),
          const _TaskRow(
            title: 'Send notes to the design team',
            meta: 'Due at 4:30 PM',
            complete: false,
          ),
          const _TaskRow(
            title: 'Morning pages',
            meta: 'Completed at 8:12 AM',
            complete: true,
          ),
        ],
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            title: 'Coming up',
            icon: Icons.calendar_today_outlined,
            actionLabel: 'Open calendar',
            onAction: () {},
          ),
          const SizedBox(height: 16),
          const _CalendarEvent(
            time: '11:30',
            period: 'AM',
            title: 'Creative sync',
            detail: 'Studio room · 45 min',
            color: OviColors.primary,
          ),
          const _CalendarEvent(
            time: '03:00',
            period: 'PM',
            title: 'Focus block',
            detail: 'Protected time',
            color: OviColors.cyan,
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.title,
    required this.icon,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: OviColors.textMuted, size: 18),
        const SizedBox(width: 9),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            foregroundColor: OviColors.primaryBright,
            textStyle: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontSize: 12),
          ),
          child: Text(actionLabel),
        ),
      ],
    );
  }
}

class _ConversationRow extends StatelessWidget {
  const _ConversationRow({
    required this.title,
    required this.preview,
    required this.time,
    required this.color,
  });

  final String title;
  final String preview;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 7),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 3),
                Text(
                  preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({
    required this.title,
    required this.meta,
    required this.complete,
  });

  final String title;
  final String meta;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            complete
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: complete ? OviColors.success : OviColors.textMuted,
            size: 21,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    decoration: complete ? TextDecoration.lineThrough : null,
                    color: complete ? OviColors.textMuted : OviColors.text,
                  ),
                ),
                const SizedBox(height: 3),
                Text(meta, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarEvent extends StatelessWidget {
  const _CalendarEvent({
    required this.time,
    required this.period,
    required this.title,
    required this.detail,
    required this.color,
  });

  final String time;
  final String period;
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 51,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  period,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 2, height: 35, color: color),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 3),
              Text(detail, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: OviColors.textMuted,
        fontSize: 10,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: color, fontSize: 11),
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.label,
    required this.caption,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String caption;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}
