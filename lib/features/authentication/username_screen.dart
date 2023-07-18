import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  static String routeName = "username";
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  bool _isUsernamedValid() {
    return _username.isNotEmpty &&
        _username.length >= 3 &&
        _username.length <= 12;
  }

  void _onNextTap() {
    if (!_isUsernamedValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
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
          title: const Text(
            "Sign Up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v24,
              const Text(
                "Create username",
                style: TextStyle(
                  fontSize: Sizes.size20 + Sizes.size1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                "You can always change this later.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: Sizes.size14 + Sizes.size1,
                ),
              ),
              Gaps.v32,
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                onEditingComplete: _onNextTap,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Username",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                "Your username must have:",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isUsernamedValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h7,
                  const Text(
                    "3 to 12 characters",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  ),
                ],
              ),
              Gaps.v36,
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: !_isUsernamedValid(),
                  text: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
