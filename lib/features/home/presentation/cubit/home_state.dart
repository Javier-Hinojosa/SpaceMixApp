import 'package:equatable/equatable.dart';
import '../../../../core/models/track_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TrackModel> tracks;

  const HomeLoaded({required this.tracks});

  @override
  List<Object?> get props => [tracks];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
