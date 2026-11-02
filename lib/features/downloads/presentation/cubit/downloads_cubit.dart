import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/downloads_repository.dart';
import 'downloads_state.dart';

class DownloadsCubit extends Cubit<DownloadsState> {
  final DownloadsRepository repository;

  DownloadsCubit({required this.repository}) : super(DownloadsInitial());

  Future<void> loadDownloads() async {
    emit(DownloadsLoading());
    try {
      final tracks = await repository.getDownloadedTracks();
      if (tracks.isEmpty) {
        emit(DownloadsEmpty());
      } else {
        // Here we simulate the 4.2 GB of 128 GB metric
        emit(DownloadsLoaded(downloadedTracks: tracks, storageUsedParams: "4.2 GB of 128 GB used"));
      }
    } catch (e) {
      emit(DownloadsEmpty());
    }
  }
}
