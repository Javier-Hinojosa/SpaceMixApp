import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacemix/features/profile/domain/repositories/profile_repository.dart';
import 'package:spacemix/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await repository.getUserProfile();
      final tracks = await repository.getArtistTopTracks();
      emit(ProfileLoaded(user: user, topTracks: tracks));
    } catch (e) {
      emit(
        const ProfileError(
          message: 'Connection Failed: Could not load artist matrix.',
        ),
      );
    }
  }
}
