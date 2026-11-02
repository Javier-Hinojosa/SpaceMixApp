import 'package:equatable/equatable.dart';
import '../../../../core/models/track_model.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class LibraryLoading extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<TrackModel> savedTracks;

  const LibraryLoaded({required this.savedTracks});

  @override
  List<Object> get props => [savedTracks];
}

class LibraryEmpty extends LibraryState {}

class LibraryError extends LibraryState {
  final String message;

  const LibraryError({required this.message});

  @override
  List<Object> get props => [message];
}
