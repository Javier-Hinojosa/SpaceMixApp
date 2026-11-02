import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../features/splash/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/player/presentation/pages/player_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/finder/presentation/pages/finder_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/downloads/presentation/pages/downloads_page.dart';
import '../../features/playlist/presentation/pages/playlist_page.dart';
import '../../features/about/presentation/pages/about_spacemix_page.dart';
import '../../features/feedback/presentation/pages/submit_feedback_page.dart';
import '../../core/models/track_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: PlayerRoute.page),
    AutoRoute(page: LibraryRoute.page),
    AutoRoute(page: FinderRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: DownloadsRoute.page),
    AutoRoute(page: PlaylistRoute.page),
    AutoRoute(page: AboutSpacemixRoute.page),
    AutoRoute(page: SubmitFeedbackRoute.page),
  ];
}
