// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AboutSpacemixPage]
class AboutSpacemixRoute extends PageRouteInfo<void> {
  const AboutSpacemixRoute({List<PageRouteInfo>? children})
    : super(AboutSpacemixRoute.name, initialChildren: children);

  static const String name = 'AboutSpacemixRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutSpacemixPage();
    },
  );
}

/// generated route for
/// [DownloadsPage]
class DownloadsRoute extends PageRouteInfo<void> {
  const DownloadsRoute({List<PageRouteInfo>? children})
    : super(DownloadsRoute.name, initialChildren: children);

  static const String name = 'DownloadsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DownloadsPage();
    },
  );
}

/// generated route for
/// [FinderPage]
class FinderRoute extends PageRouteInfo<void> {
  const FinderRoute({List<PageRouteInfo>? children})
    : super(FinderRoute.name, initialChildren: children);

  static const String name = 'FinderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FinderPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LibraryPage]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute({List<PageRouteInfo>? children})
    : super(LibraryRoute.name, initialChildren: children);

  static const String name = 'LibraryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryPage();
    },
  );
}

/// generated route for
/// [PlayerPage]
class PlayerRoute extends PageRouteInfo<PlayerRouteArgs> {
  PlayerRoute({
    Key? key,
    required TrackModel track,
    required List<TrackModel> upcomingTracks,
    List<PageRouteInfo>? children,
  }) : super(
         PlayerRoute.name,
         args: PlayerRouteArgs(
           key: key,
           track: track,
           upcomingTracks: upcomingTracks,
         ),
         initialChildren: children,
       );

  static const String name = 'PlayerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayerRouteArgs>();
      return PlayerPage(
        key: args.key,
        track: args.track,
        upcomingTracks: args.upcomingTracks,
      );
    },
  );
}

class PlayerRouteArgs {
  const PlayerRouteArgs({
    this.key,
    required this.track,
    required this.upcomingTracks,
  });

  final Key? key;

  final TrackModel track;

  final List<TrackModel> upcomingTracks;

  @override
  String toString() {
    return 'PlayerRouteArgs{key: $key, track: $track, upcomingTracks: $upcomingTracks}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerRouteArgs) return false;
    return key == other.key &&
        track == other.track &&
        const ListEquality<TrackModel>().equals(
          upcomingTracks,
          other.upcomingTracks,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      track.hashCode ^
      const ListEquality<TrackModel>().hash(upcomingTracks);
}

/// generated route for
/// [PlaylistPage]
class PlaylistRoute extends PageRouteInfo<PlaylistRouteArgs> {
  PlaylistRoute({
    Key? key,
    required int playlistId,
    List<PageRouteInfo>? children,
  }) : super(
         PlaylistRoute.name,
         args: PlaylistRouteArgs(key: key, playlistId: playlistId),
         rawPathParams: {'id': playlistId},
         initialChildren: children,
       );

  static const String name = 'PlaylistRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PlaylistRouteArgs>(
        orElse: () => PlaylistRouteArgs(playlistId: pathParams.getInt('id')),
      );
      return PlaylistPage(key: args.key, playlistId: args.playlistId);
    },
  );
}

class PlaylistRouteArgs {
  const PlaylistRouteArgs({this.key, required this.playlistId});

  final Key? key;

  final int playlistId;

  @override
  String toString() {
    return 'PlaylistRouteArgs{key: $key, playlistId: $playlistId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaylistRouteArgs) return false;
    return key == other.key && playlistId == other.playlistId;
  }

  @override
  int get hashCode => key.hashCode ^ playlistId.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [SubmitFeedbackPage]
class SubmitFeedbackRoute extends PageRouteInfo<void> {
  const SubmitFeedbackRoute({List<PageRouteInfo>? children})
    : super(SubmitFeedbackRoute.name, initialChildren: children);

  static const String name = 'SubmitFeedbackRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SubmitFeedbackPage();
    },
  );
}
