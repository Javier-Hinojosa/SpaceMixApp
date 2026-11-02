import 'package:equatable/equatable.dart';
import 'package:spacemix/core/models/track_model.dart';
import 'package:spacemix/core/models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<TrackModel> topTracks;

  const ProfileLoaded({required this.user, required this.topTracks});

  @override
  List<Object?> get props => [user, topTracks];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
