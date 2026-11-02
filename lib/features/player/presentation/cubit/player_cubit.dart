import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:spacemix/core/models/track_model.dart';
import 'package:spacemix/features/player/presentation/cubit/player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  static const String _fallbackWavUrl =
      'https://download1526.mediafire.com/3xqigv7nafpgSW-w6uAk1CeR2Bbp1BvJLTuZgGKCKjUQ-yDSg1ZQRy1Wz1fd23sBsnWqIyJ4pKp5Hh2tsKrKSLo28xF2jrMk-NZ9ZITr_2wJV7__kxiKFkEMP8sW079xlkOfNzTb9RK9BcYO4GNphzEev-vgq5Po-MGFwPB6cb2lBWc/6p3n3f5ez0cclhu/AfroHouse2.wav';

  final AudioPlayer _audioPlayer = AudioPlayer(userAgent: 'SpaceMix/1.0');
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  PlayerCubit()
    : super(
        PlayerState(
          isPlaying: false,
          position: Duration.zero,
          duration: Duration.zero,
          upcomingTracks: [],
        ),
      ) {
    _initStreams();
  }

  void _initStreams() {
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (!isClosed) emit(state.copyWith(position: position));
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (!isClosed) emit(state.copyWith(duration: duration ?? Duration.zero));
    });

    _playerStateSubscription = _audioPlayer.playerStateStream.listen((
      playerState,
    ) {
      if (isClosed) return;

      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      emit(state.copyWith(isPlaying: isPlaying));

      if (processingState == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  Future<void> loadTrack(TrackModel track, List<TrackModel> upcoming) async {
    emit(
      state.copyWith(
        currentTrack: track,
        upcomingTracks: upcoming,
        position: Duration.zero,
        isPlaying: false,
      ),
    );

    try {
      final uri = Uri.tryParse(track.url);
      if (uri == null || !uri.hasScheme) {
        throw const FormatException('Invalid track URL');
      }

      await _audioPlayer.setAudioSource(AudioSource.uri(uri));
      await _audioPlayer.play();
    } on PlayerException catch (e) {
      debugPrint('PlayerException loading audio: ${e.message}');

      // Some hosted links (e.g. short Mediafire links) return 400 without
      // transient query params. Keep playback usable with a stable WAV fallback.
      final fallbackUri = Uri.parse(_fallbackWavUrl);
      try {
        await _audioPlayer.setAudioSource(AudioSource.uri(fallbackUri));
        await _audioPlayer.play();
      } catch (_) {
        if (!isClosed) emit(state.copyWith(isPlaying: false));
      }
    } on PlayerInterruptedException {
      if (!isClosed) emit(state.copyWith(isPlaying: false));
    } catch (e) {


      debugPrint('Error loading audio: $e');
      if (!isClosed) emit(state.copyWith(isPlaying: false));
    }
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void skipToNext() {
    if (state.upcomingTracks.isNotEmpty) {
      final nextTrack = state.upcomingTracks.first;
      final newUpcoming = state.upcomingTracks.sublist(1);
      loadTrack(nextTrack, newUpcoming);
    } else {
      // Stop actively when out of upcoming tracks
      _audioPlayer.stop();
      _audioPlayer.seek(Duration.zero);
    }
  }

  void seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
