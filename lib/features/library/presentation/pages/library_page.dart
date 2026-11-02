import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/services/service_locator.dart';
import '../cubit/library_cubit.dart';
import '../cubit/library_state.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryCubit(repository: sl())..loadLibraryData(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.onSurface),
            onPressed: () => context.router.pop(),
          ),
          title: Text(
            'SAVES',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: BlocBuilder<LibraryCubit, LibraryState>(
            builder: (context, state) {
              if (state is LibraryLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                );
              } else if (state is LibraryEmpty) {
                return _buildEmptyState(context);
              } else if (state is LibraryLoaded) {
                return _buildLoadedState(context, state);
              } else if (state is LibraryError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppTheme.error),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.surfaceVariant.withOpacity(0.5),
              ),
              child: const Icon(
                Icons.bookmark_border,
                size: 80,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No signals detected.',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Return to the Discover feed or Search the void to start adding targets to your Saves.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.outlineVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.router.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: Text(
                'Explore The Grid',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, LibraryLoaded state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Text(
              'Saved Tracks',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final track = state.savedTracks[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.surfaceVariant,
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          track.artist,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: AppTheme.primary),
                    onPressed: () {
                      context.read<LibraryCubit>().removeSavedItem(track.id);
                    },
                  ),
                ],
              ),
            );
          }, childCount: state.savedTracks.length),
        ),
      ],
    );
  }
}
