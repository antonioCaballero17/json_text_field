import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_text_field/json_text_field.dart';

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(JsonTextField), findsOneWidget);
  });
}
