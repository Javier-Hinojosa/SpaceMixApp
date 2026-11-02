import 'package:equatable/equatable.dart';
import '../../../../core/models/track_model.dart';

abstract class DownloadsState extends Equatable {
  const DownloadsState();

  @override
  List<Object?> get props => [];
}

class DownloadsInitial extends DownloadsState {}

class DownloadsLoading extends DownloadsState {}

class DownloadsEmpty extends DownloadsState {}

class DownloadsLoaded extends DownloadsState {
  final List<TrackModel> downloadedTracks;
  final String storageUsedParams;
  
  const DownloadsLoaded({required this.downloadedTracks, required this.storageUsedParams});

  @override
  List<Object?> get props => [downloadedTracks, storageUsedParams];
}
