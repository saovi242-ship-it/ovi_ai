import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/responsive/app_breakpoints.dart';
import '../../core/widgets/glass_card.dart';
import '../../shared/widgets/natasha_avatar.dart';
import '../theme/app_theme.dart';

class OviShell extends StatelessWidget {
  const OviShell({required this.location, required this.child, super.key});

  final String location;
  final Widget child;

  static const _destinations = [
    _NavDestination(
      label: 'Home',
      icon: Icons.grid_view_rounded,
      activeIcon: Icons.grid_view_rounded,
      route: '/',
    ),
    _NavDestination(
      label: 'Chat',
      icon: Icons.forum_outlined,
      activeIcon: Icons.forum_rounded,
      route: '/chat',
    ),
    _NavDestination(
      label: 'Notes',
      icon: Icons.sticky_note_2_outlined,
      activeIcon: Icons.sticky_note_2_rounded,
      route: '/notes',
    ),
    _NavDestination(
      label: 'Tasks',
      icon: Icons.check_circle_outline_rounded,
      activeIcon: Icons.check_circle_rounded,
      route: '/tasks',
    ),
    _NavDestination(
      label: 'Calendar',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_month_rounded,
      route: '/calendar',
    ),
    _NavDestination(
      label: 'Settings',
      icon: Icons.tune_rounded,
      activeIcon: Icons.tune_rounded,
      route: '/settings',
    ),
  ];

  int get _selectedIndex {
    final index = _destinations.indexWhere(
      (destination) =>
          destination.route == location ||
          (destination.route != '/' && location.startsWith(destination.route)),
    );
    return index < 0 ? 0 : index;
  }

  void _navigate(BuildContext context, int index) {
    context.go(_destinations[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= OviBreakpoints.desktop;
        if (isDesktop) {
          return _DesktopShell(
            selectedIndex: _selectedIndex,
            destinations: _destinations,
            onDestinationSelected: (index) => _navigate(context, index),
            child: child,
          );
        }
        return _MobileShell(
          selectedIndex: _selectedIndex,
          destinations: _destinations,
          onDestinationSelected: (index) => _navigate(context, index),
          child: child,
        );
      },
    );
  }
}

class _DesktopShell extends StatelessWidget {
  const _DesktopShell({
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final List<_NavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            _SideNavigation(
              selectedIndex: selectedIndex,
              destinations: destinations,
              onDestinationSelected: onDestinationSelected,
            ),
            Expanded(
              child: Column(
                children: [
                  const _DesktopTopBar(),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1440),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final List<_NavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations:
            destinations
                .map(
                  (destination) => NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.activeIcon),
                    label: destination.label,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _SideNavigation extends StatelessWidget {
  const _SideNavigation({
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final List<_NavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 22),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: OviColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 34),
            child: _BrandMark(),
          ),
          Expanded(
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              extended: true,
              groupAlignment: -0.9,
              labelType: NavigationRailLabelType.none,
              destinations:
                  destinations
                      .map(
                        (destination) => NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.activeIcon),
                          label: Text(destination.label),
                        ),
                      )
                      .toList(),
            ),
          ),
          const _UserChip(),
        ],
      ),
    );
  }
}

class _DesktopTopBar extends StatelessWidget {
  const _DesktopTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 24, 36, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Your personal intelligence layer',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
          const NatashaAvatar(size: 34),
        ],
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            gradient: const LinearGradient(
              colors: [OviColors.primary, OviColors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: OviColors.background,
            size: 19,
          ),
        ),
        const SizedBox(width: 11),
        Text(
          'OVI AI',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(letterSpacing: 1.3),
        ),
      ],
    );
  }
}

class _UserChip extends StatelessWidget {
  const _UserChip();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const NatashaAvatar(size: 30, showGlow: false),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Alex Morgan',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const Icon(
            Icons.more_horiz_rounded,
            color: OviColors.textMuted,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _NavDestination {
  const _NavDestination({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}
