import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/notes/presentation/pages/notes_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../widgets/ovi_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return OviShell(location: state.uri.path, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _page(state, const HomePage()),
        ),
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) => _page(state, const ChatPage()),
        ),
        GoRoute(
          path: '/notes',
          pageBuilder: (context, state) => _page(state, const NotesPage()),
        ),
        GoRoute(
          path: '/tasks',
          pageBuilder: (context, state) => _page(state, const TasksPage()),
        ),
        GoRoute(
          path: '/calendar',
          pageBuilder: (context, state) => _page(state, const CalendarPage()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => _page(state, const SettingsPage()),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _page(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 360),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.015, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}
