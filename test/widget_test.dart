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
            const Directionality(
              textDirection: TextDirection.ltr,
              child: FormButton(
                disabled: false,
                text: "Next",
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
        },
      );
    },
  );
}
