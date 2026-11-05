import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/router/app_routes.dart';
import 'package:sleman_runs/app/router/app_shell.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/features/history/presentation/pages/history_page.dart';
import 'package:sleman_runs/features/plans/presentation/pages/plan_page.dart';
import 'package:sleman_runs/features/settings/presentation/pages/settings_page.dart';
import 'package:sleman_runs/features/tracking/presentation/pages/tracking_page.dart';
import 'package:sleman_runs/shared/widgets/app_error_view.dart';
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// Builds the router.
///
/// Kept as a function so tests and DI can create an isolated instance; a
/// global router would leak navigation state between widget tests.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.track,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.track,
                builder: (context, state) => const TrackingPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.plan,
                builder: (context, state) => const PlanPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return AppScaffold(
        appBar: AppBar(title: AppText(context.l10n.errorTitle)),
        body: AppErrorView(
          failure: const UnknownFailure(),
          onRetry: () => context.go(AppRoutes.track),
        ),
      );
    },
  );
}
