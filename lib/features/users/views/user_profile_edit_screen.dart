import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';

import '../view_models/users_view_model.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditScreen> {
  late TextEditingController _bioController;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(usersProvider);
    _bioController = TextEditingController(text: user.value!.bio);
    _linkController = TextEditingController(text: user.value!.link);
  }

  @override
  void dispose() {
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    final updatedBio = _bioController.text;
    final updatedLink = _linkController.text;
    ref.read(usersProvider.notifier).updateProfile(updatedBio, updatedLink);

    Navigator.of(context).pop();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                "Bio",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: _bioController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your bio',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Gaps.v20,
              const Text(
                "Link",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: _linkController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Enter your Link',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Gaps.v32,
              GestureDetector(
                onTap: _onSavePressed,
                child: const FormButton(
                  text: "SAVE",
                  disabled: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
