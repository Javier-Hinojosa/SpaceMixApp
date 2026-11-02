import 'package:equatable/equatable.dart';
import '../../../../core/models/track_model.dart';

class PlayerState extends Equatable {
  final bool isPlaying;
  final TrackModel? currentTrack;
  final Duration position;
  final Duration duration;
  final List<TrackModel> upcomingTracks;

  const PlayerState({
    required this.isPlaying,
    this.currentTrack,
    required this.position,
    required this.duration,
    required this.upcomingTracks,
  });

  PlayerState copyWith({
    bool? isPlaying,
    TrackModel? currentTrack,
    Duration? position,
    Duration? duration,
    List<TrackModel>? upcomingTracks,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTrack: currentTrack ?? this.currentTrack,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      upcomingTracks: upcomingTracks ?? this.upcomingTracks,
    );
  }

  @override
  List<Object?> get props => [isPlaying, currentTrack, position, duration, upcomingTracks];
}
