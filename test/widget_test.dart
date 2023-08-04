import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';

void main() {
  group(
    "Form Button",
    () {
      testWidgets(
        "Enabled State",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            Theme(
              data: ThemeData(
                primaryColor: const Color(0xFFE9435A),
              ),
              child: const Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(
                  disabled: false,
                  text: "Next",
                ),
              ),
            ),
          );
          expect(find.text("Next"), findsOneWidget);
          expect(
            tester
                .firstWidget<AnimatedDefaultTextStyle>(
                  find.byType(AnimatedDefaultTextStyle),
                )
                .style
                .color,
            Colors.white,
          );
          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration as BoxDecoration)
                .color,
            const Color(0xFFE9435A),
          );
        },
      );

      testWidgets(
        "Disabled State",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MediaQuery(
              data: MediaQueryData(),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(
                  disabled: true,
                  text: "Next",
                ),
              ),
            ),
          );
          expect(find.text("Next"), findsOneWidget);
          expect(
            tester
                .firstWidget<AnimatedDefaultTextStyle>(
                  find.byType(AnimatedDefaultTextStyle),
                )
                .style
                .color,
            Colors.grey.shade400,
          );
        },
      );

      testWidgets(
        "Disabled State Dark Mode",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MediaQuery(
              data: MediaQueryData(
                platformBrightness: Brightness.dark,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(
                  disabled: true,
                  text: "Next",
                ),
              ),
            ),
          );
          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration as BoxDecoration)
                .color,
            Colors.grey.shade800,
          );
        },
      );

      testWidgets(
        "Disabled State Light Mode",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MediaQuery(
              data: MediaQueryData(
                platformBrightness: Brightness.light,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: FormButton(
                  disabled: true,
                  text: "Next",
                ),
              ),
            ),
          );
          expect(
            (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration as BoxDecoration)
                .color,
            Colors.grey.shade200,
          );
        },
      );
    },
  );
}
