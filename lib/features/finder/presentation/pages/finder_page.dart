import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/routing/app_router.dart';
import '../cubit/finder_cubit.dart';
import '../cubit/finder_state.dart';

@RoutePage()
class FinderPage extends StatelessWidget {
  const FinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinderCubit(repository: sl())..loadFinderData(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: BlocBuilder<FinderCubit, FinderState>(
            builder: (context, state) {
              if (state is FinderLoading || state is FinderInitial) {
                return _buildLoadingState(context);
              } else if (state is FinderLoaded) {
                return _buildLoadedState(context, state);
              } else if (state is FinderError) {
                return Center(child: Text(state.message, style: const TextStyle(color: AppTheme.error)));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
  }

  Widget _buildLoadedState(BuildContext context, FinderLoaded state) {
    return CustomScrollView(
      slivers: [
        // App Bar & Search Input
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('FINDER', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32)),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppTheme.onSurface, size: 32),
                      onPressed: () => context.router.pop(),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  style: const TextStyle(color: AppTheme.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Search the void...',
                    hintStyle: TextStyle(color: AppTheme.onSurface.withOpacity(0.5)),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
                    filled: true,
                    fillColor: AppTheme.surfaceVariant.withOpacity(0.5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Recent Searches
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Recent Searches', style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    _buildChip(context, 'Nova Pulse'),
                    _buildChip(context, 'Stardust Echo'),
                    _buildChip(context, 'Deep House'),
                    _buildChip(context, 'Luna Drift'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),

        // Trending Now
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Trending Now', style: Theme.of(context).textTheme.headlineMedium),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final track = state.trendingTracks[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      track.imageurl.isNotEmpty ? track.imageurl : AppConstants.dummyImagePlaceholder,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(track.title, style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text(track.artist, style: TextStyle(color: AppTheme.primary)),
                  onTap: () {
                    final upcoming = state.trendingTracks.where((t) => t.id != track.id).toList();
                    context.router.push(PlayerRoute(track: track, upcomingTracks: upcoming));
                  },
                );
              },
              childCount: state.trendingTracks.length,
            ),
          ),
        ),

        // Explore Genres
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Explore Genres', style: Theme.of(context).textTheme.headlineMedium),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.5,
            children: [
              _buildGenreCard(context, 'Techno', AppTheme.primary),
              _buildGenreCard(context, 'Cyberpunk', AppTheme.secondary),
              _buildGenreCard(context, 'Psybient', AppTheme.tertiary),
              _buildGenreCard(context, 'Deep House', AppTheme.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: AppTheme.surfaceVariant.withOpacity(0.5),
        labelStyle: TextStyle(color: AppTheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildGenreCard(BuildContext context, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: -20,
            right: -20,
            child: Icon(Icons.music_note, size: 100, color: color.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
