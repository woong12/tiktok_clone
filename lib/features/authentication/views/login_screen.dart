import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';

import 'login_form_screen.dart';

class LoginScreen extends ConsumerWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Log in to TikTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Manage your account, check comment on videos, notifications, and more.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  GestureDetector(
                    onTap: () => _onEmailLoginTap(context),
                    child: const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: "Use email & password",
                    ),
                  ),
                  Gaps.v14,
                  GestureDetector(
                    onTap: () => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context),
                    child: const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.github),
                      text: "Continue with GitHub",
                    ),
                  ),
                  Gaps.v14,
                  GestureDetector(
                    onTap: () {},
                    child: const AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black,
                      ),
                      text: "Continue with Apple",
                    ),
                  ),
                  Gaps.v14,
                  GestureDetector(
                    onTap: () {},
                    child: const AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      text: "Continue with Facebook",
                    ),
                  ),
                  Gaps.v14,
                  GestureDetector(
                    onTap: () {},
                    child: const AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                      ),
                      text: "Continue with Google",
                    ),
                  ),
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailLoginTap(context),
                            child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.user),
                              // text: S.of(context).emailPasswordButton,
                              text: "Use email & password",
                            ),
                          ),
                        ),
                        Gaps.v14,
                        Expanded(
                          child: GestureDetector(
                            onTap: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                            child: const AuthButton(
                              icon: FaIcon(FontAwesomeIcons.github),
                              text: "Continue with GitHub",
                            ),
                          ),
                        ),
                        Gaps.v14,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.apple,
                                color: Colors.black,
                              ),
                              text: "Continue with Apple",
                            ),
                          ),
                        ),
                        Gaps.v14,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              ),
                              text: "Continue with Facebook",
                            ),
                          ),
                        ),
                        Gaps.v14,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const AuthButton(
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.black,
                              ),
                              text: "Continue with Google",
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 140),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      "By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect, use, and share your data.",
                      style: TextStyle(
                        fontSize: Sizes.size12 + Sizes.size1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size1,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onSignUpTap(context),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size16 + Sizes.size1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ConsumerStatelessWidget {}
