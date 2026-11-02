import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/models/track_model.dart';
import '../cubit/player_cubit.dart';
import '../cubit/player_state.dart';

@RoutePage()
class PlayerPage extends StatelessWidget {
  final TrackModel track;
  final List<TrackModel> upcomingTracks;

  const PlayerPage({
    super.key,
    required this.track,
    required this.upcomingTracks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerCubit()..loadTrack(track, upcomingTracks),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.onSurface,
              size: 32,
            ),
            onPressed: () => context.router.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppTheme.onSurface),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<PlayerCubit, PlayerState>(
          builder: (context, state) {
            final activeTrack = state.currentTrack ?? track;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Album Art
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withValues(alpha: 0.15),
                            blurRadius: 40,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            AppConstants.dummyImagePlaceholder,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Title & Artist
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeTrack.title,
                              style: Theme.of(
                                context,
                              ).textTheme.displayLarge?.copyWith(fontSize: 32),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              activeTrack.artist,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppTheme.primary,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: AppTheme.onSurface,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Progress Bar
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      activeTrackColor: AppTheme.tertiary, // Neon precision
                      inactiveTrackColor: AppTheme.surfaceVariant,
                      thumbColor: AppTheme.tertiary,
                      overlayColor: AppTheme.tertiary.withOpacity(0.2),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                    ),
                    child: Slider(
                      value: state.position.inSeconds.toDouble().clamp(
                        0.0,
                        state.duration.inSeconds.toDouble() > 0
                            ? state.duration.inSeconds.toDouble()
                            : 1.0,
                      ),
                      max: state.duration.inSeconds.toDouble() > 0
                          ? state.duration.inSeconds.toDouble()
                          : 1.0,
                      onChanged: (value) {
                        context.read<PlayerCubit>().seekTo(
                          Duration(seconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(state.position),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        _formatDuration(state.duration),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 40,
                          color: AppTheme.onSurface,
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                            color: AppTheme.onPrimary,
                          ),
                          onPressed: () =>
                              context.read<PlayerCubit>().togglePlayPause(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next,
                          size: 40,
                          color: AppTheme.onSurface,
                        ),
                        onPressed: () =>
                            context.read<PlayerCubit>().skipToNext(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),
                  Text(
                    "Upcoming Songs",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 16),

                  // Upcoming Track List
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.upcomingTracks.length,
                    itemBuilder: (context, index) {
                      final item = state.upcomingTracks[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            AppConstants.dummyImagePlaceholder,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          item.artist,
                          style: TextStyle(color: AppTheme.outlineVariant),
                        ),
                        trailing: const Icon(
                          Icons.more_horiz,
                          color: AppTheme.outlineVariant,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
