import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authenrication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJSON(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile({
    required UserCredential credential,
    required String name,
    required String email,
    required String birthday,
  }) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: "Describe yourself",
      link: "Write your link",
      email: credential.user!.email ?? email,
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? name,
      birthday: birthday,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;

    state = AsyncValue.data(
      state.value!.copyWith(hasAvatar: true),
    );

    await _usersRepository.updateUser(
      state.value!.uid,
      {"hasAvatar": true},
    );
  }

  Future<void> updateProfile(String? bio, String? link) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(bio: bio, link: link));
    await _usersRepository.updateUser(
      state.value!.uid,
      {"bio": bio, "link": link},
    );
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
