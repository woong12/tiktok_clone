import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = AsyncValue.data(
      UserProfileModel(
        bio: "undefined",
        link: "undefined",
        email: credential.user!.email ?? "anon@anon.com",
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "Anon",
      ),
    );
  }
}

final userProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
