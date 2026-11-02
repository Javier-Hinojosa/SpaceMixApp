import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacemix/core/app_constants.dart';
import 'package:spacemix/core/app_theme.dart';
import 'package:spacemix/core/services/service_locator.dart';
import 'package:spacemix/features/playlist/presentation/cubit/playlist_cubit.dart';
import 'package:spacemix/features/playlist/presentation/cubit/playlist_state.dart';

@RoutePage()
class PlaylistPage extends StatelessWidget {
  final int playlistId;

  const PlaylistPage({super.key, @PathParam('id') required this.playlistId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlaylistCubit(repository: sl())..fetchPlaylistDetails(playlistId),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: BlocBuilder<PlaylistCubit, PlaylistState>(
          builder: (context, state) {
            if (state is PlaylistLoading || state is PlaylistInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.primary),
              );
            } else if (state is PlaylistError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppTheme.error),
                ),
              );
            } else if (state is PlaylistLoaded) {
              final playlist = state.playlist;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 400.0,
                    pinned: true,
                    backgroundColor: AppTheme.background,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        playlist.title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(playlist.coverUrl, fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.background,
                                  AppTheme.background.withOpacity(0.1),
                                  AppTheme.background,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.router.pop(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COSMIC PLAYLIST',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppTheme.primary,
                                  letterSpacing: 2.0,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            playlist.creator,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            playlist.description,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppTheme.outlineVariant),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppTheme.secondary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${playlist.rating} Community Rating',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('DISCOVER MORE'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: AppTheme.onPrimary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final track = playlist.tracks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 8.0,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      track.imageurl.isNotEmpty
                                          ? track.imageurl
                                          : AppConstants.dummyImagePlaceholder,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      track.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${track.artist} • ${track.duration}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.outlineVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: AppTheme.outlineVariant,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: playlist.tracks.length),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 64)),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
