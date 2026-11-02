import 'package:equatable/equatable.dart';
import '../../../../core/models/track_model.dart';

abstract class FinderState extends Equatable {
  const FinderState();

  @override
  List<Object?> get props => [];
}

class FinderInitial extends FinderState {}

class FinderLoading extends FinderState {}

class FinderLoaded extends FinderState {
  final List<TrackModel> trendingTracks;

  const FinderLoaded({required this.trendingTracks});

  @override
  List<Object?> get props => [trendingTracks];
}

class FinderError extends FinderState {
  final String message;

  const FinderError({required this.message});

  @override
  List<Object?> get props => [message];
}
