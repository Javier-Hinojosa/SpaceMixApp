import 'package:equatable/equatable.dart';
import '../../../../core/models/playlist_model.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();

  @override
  List<Object?> get props => [];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistError extends PlaylistState {
  final String message;

  const PlaylistError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PlaylistLoaded extends PlaylistState {
  final PlaylistModel playlist;

  const PlaylistLoaded({required this.playlist});

  @override
  List<Object?> get props => [playlist];
}
