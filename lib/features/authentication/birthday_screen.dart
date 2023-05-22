import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    initialDate = DateTime(now.year - 12, now.month, now.day);
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
    );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "When's your birthday?",
                        style: TextStyle(
                          fontSize: Sizes.size20 + Sizes.size1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v8,
                      Text(
                        "Your birthday won't be shown",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: Sizes.size14 + Sizes.size1,
                        ),
                      ),
                      Gaps.v2,
                      Text(
                        "publicly.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: Sizes.size14 + Sizes.size1,
                        ),
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage("assets/cake.png"),
                    width: Sizes.size80,
                    height: Sizes.size80,
                  ),
                ],
              ),
              Gaps.v32,
              TextField(
                enabled: false,
                controller: _birthdayController,
                keyboardType: TextInputType.name,
                onEditingComplete: _onNextTap,
                autocorrect: false,
                decoration: InputDecoration(
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
              Gaps.v36,
              GestureDetector(
                onTap: _onNextTap,
                child: const FormButton(disabled: false),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size56,
              horizontal: Sizes.size64,
            ),
            child: SizedBox(
              height: 210,
              child: CupertinoDatePicker(
                maximumDate: initialDate,
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: _setTextFieldDate,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
