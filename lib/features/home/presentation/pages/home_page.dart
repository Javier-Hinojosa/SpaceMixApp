import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/models/track_model.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/space_mix_drawer.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(sl())..loadDiscoverData(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        drawer: const SpaceMixDrawer(activeItem: DrawerItem.home),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return _buildLoadingState(context);
              } else if (state is HomeError) {
                return Center(child: Text(state.message, style: TextStyle(color: AppTheme.onSurface)));
              } else if (state is HomeLoaded) {
                return _buildLoadedState(context, state);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppTheme.primary),
    );
  }

  Widget _buildLoadedState(BuildContext context, HomeLoaded state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'COS',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: AppTheme.onSurface, size: 32),
                  tooltip: 'Open menu',
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )
              ]
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _buildSectionHeader(context, 'Nebula Collections'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              itemCount: state.tracks.length,
              itemBuilder: (context, index) {
                final track = state.tracks[index];
                return _buildPlaylistCard(context, track.title, track.description, track.imageurl, 1);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 32),
        ),
        SliverToBoxAdapter(
          child: _buildSectionHeader(context, 'Sonic Suggestions'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              itemCount: state.tracks.length,
              itemBuilder: (context, index) {
                final track = state.tracks[state.tracks.length - 1 - index]; // Reverse for variety visually
                return _buildGlassCard(context, track.title, track.artist, track.imageurl, track, state.tracks);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  Widget _buildPlaylistCard(BuildContext context, String title, String subtitle, String imageUrl, int playlistId) {
    return GestureDetector(
      onTap: () {
        context.router.push(PlaylistRoute(playlistId: playlistId));
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: AppTheme.surfaceVariant.withOpacity(0.7),
          borderRadius: BorderRadius.circular(AppConstants.borderLg),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderLg),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                AppConstants.dummyImagePlaceholder,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.outlineVariant,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, String title, String subtitle, String imageUrl, [TrackModel? track, List<TrackModel>? allTracks]) {
    return GestureDetector(
      onTap: () {
        if (track != null && allTracks != null) {
           final upcoming = allTracks.where((t) => t.id != track.id).toList();
           context.router.push(PlayerRoute(track: track, upcomingTracks: upcoming));
        }
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: AppTheme.surfaceVariant.withOpacity(0.7),
          borderRadius: BorderRadius.circular(AppConstants.borderLg),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderLg),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                AppConstants.dummyImagePlaceholder,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSurface.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
