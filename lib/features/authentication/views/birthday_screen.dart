import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';

import '../../../utils.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
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
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "birthday": _birthdayController.text
    };
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = getMonthName(date.month);
    final year = date.year.toString();

    final textDate = '$month $day $year';
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  String getMonthName(int month) {
    final monthMap = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    return monthMap[month] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
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
                    children: [
                      const Text(
                        "When's your birthday?",
                        style: TextStyle(
                          fontSize: Sizes.size20 + Sizes.size1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v8,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const Opacity(
                          opacity: 0.8,
                          child: Text(
                            "Your birthday won't be shown publicly.",
                            style: TextStyle(
                              fontSize: Sizes.size14 + Sizes.size1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image(
                    image: isDark
                        ? const AssetImage("assets/images/cake_negative.png")
                        : const AssetImage("assets/images/cake.png"),
                    width: Sizes.size80,
                    height: Sizes.size80,
                  ),
                ],
              ),
              Gaps.v32,
              TextField(
                readOnly: true,
                controller: _birthdayController,
                onEditingComplete: _onNextTap,
                autocorrect: false,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v36,
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: ref.watch(signUpProvider).isLoading,
                  text: "Next",
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size56,
              horizontal: Sizes.size64,
            ),
            child: SizedBox(
              height: 210,
              width: 300,
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
