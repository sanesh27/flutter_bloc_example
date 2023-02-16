import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timer/album_app/view/album_screen.dart';
import 'package:timer/home.dart';
import 'package:timer/timer_app/view/timer_page.dart';

final GoRouter myRoute = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
        builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
              path: 'timer',
            builder: (BuildContext context, GoRouterState state) {
                return const TimerPage();
            }
          ),
          GoRoute(
              path: 'album',
            builder: (BuildContext context, GoRouterState state) {
                return const AlbumPage();
            }
          ),
        ]
      ),
    ]
);