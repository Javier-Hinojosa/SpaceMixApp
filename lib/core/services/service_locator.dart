import 'package:get_it/get_it.dart';
import 'package:spacemix/core/services/service_provider.dart';
import '../database/database_helper.dart';

import 'package:spacemix/features/home/data/repositories/home_repository_impl.dart';
import 'package:spacemix/features/home/domain/repositories/home_repository.dart';
import 'package:spacemix/features/library/data/repositories/library_repository_impl.dart';
import 'package:spacemix/features/library/domain/repositories/library_repository.dart';
import 'package:spacemix/features/finder/data/repositories/finder_repository_impl.dart';
import 'package:spacemix/features/finder/domain/repositories/finder_repository.dart';
import 'package:spacemix/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:spacemix/features/profile/domain/repositories/profile_repository.dart';
import 'package:spacemix/features/downloads/data/repositories/downloads_repository_impl.dart';
import 'package:spacemix/features/downloads/domain/repositories/downloads_repository.dart';
import 'package:spacemix/features/playlist/data/repositories/playlist_repository_impl.dart';
import 'package:spacemix/features/playlist/domain/repositories/playlist_repository.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<LibraryRepository>(() => LibraryRepositoryImpl(databaseHelper: sl()));
  sl.registerLazySingleton<FinderRepository>(() => FinderRepositoryImpl());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  sl.registerLazySingleton<DownloadsRepository>(() => DownloadsRepositoryImpl());
  sl.registerLazySingleton<PlaylistRepository>(() => PlaylistRepositoryImpl());
  // Future registrations for Repositories, UseCases, and Cubits
}
