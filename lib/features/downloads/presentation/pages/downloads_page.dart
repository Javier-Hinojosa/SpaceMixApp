import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacemix/features/downloads/presentation/cubit/downloads_cubit.dart';
import 'package:spacemix/features/downloads/presentation/cubit/downloads_state.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/services/service_locator.dart';

@RoutePage()
class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadsCubit(repository: sl())..loadDownloads(),
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
            'DOWNLOADS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: BlocBuilder<DownloadsCubit, DownloadsState>(
            builder: (context, state) {
              if (state is DownloadsLoading || state is DownloadsInitial) {
                return const Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                );
              } else if (state is DownloadsEmpty) {
                return _buildEmptyState(context);
              } else if (state is DownloadsLoaded) {
                return _buildLoadedState(context, state);
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
                color: AppTheme.surfaceVariant.withValues(alpha: 0.5),
              ),
              child: const Icon(
                Icons.cloud_off,
                size: 80,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No offline content.',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your downloads folder is empty. Download tracks to listen when signal is lost.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.outlineVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, DownloadsLoaded state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offline Space',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  state.storageUsedParams,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.outlineVariant,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 4.2 / 128.0,
                  backgroundColor: AppTheme.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primary,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final track = state.downloadedTracks[index];
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
                          '${track.artist} • ${track.duration}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.download_done, color: AppTheme.primary),
                ],
              ),
            );
          }, childCount: state.downloadedTracks.length),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Text(
                  'Want more sounds?',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Expand your offline collection with the latest cosmic frequencies.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.outlineVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.router.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    'Discover',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppTheme.onPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
