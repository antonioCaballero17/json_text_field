import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_text_field_editor/json_text_field_editor.dart';
import 'package:json_text_field_editor/src/bindings.dart';

void main() {
  testWidgets('JsonTextField Widget Test. Formatting a valid json', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final controller = JsonTextFieldController();
    controller.value = const TextEditingValue(
        text: '{"key": "value"}',
        selection: TextSelection.collapsed(
          offset: 0,
        ));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
            height: 300,
            width: 300,
            child: JsonTextField(
              isFormating: true,
              controller: controller,
            )),
      ),
    ));

    // Verify that JsonTextField is present.
    expect(find.byType(JsonTextField), findsOneWidget);
    expect(controller.text, equals('{\n  "key": "value"\n}'));
  });

  testWidgets('JsonTextField Widget Test. Formatting a valid json using controller', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final controller = JsonTextFieldController();
    controller.value = const TextEditingValue(
        text: '{"key": "value"}',
        selection: TextSelection.collapsed(
          offset: 0,
        ));
    controller.formatJson(sortJson: false);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
            height: 300,
            width: 300,
            child: JsonTextField(
              isFormating: true,
              controller: controller,
            )),
      ),
    ));

    // Verify that JsonTextField is present.
    expect(find.byType(JsonTextField), findsOneWidget);
    expect(controller.text, equals('{\n  "key": "value"\n}'));
  });

  testWidgets('JsonTextField Widget Test, invalid Json', (WidgetTester tester) async {
    final controller = JsonTextFieldController();
    controller.value = const TextEditingValue(
        text: '{"key": "value"',
        selection: TextSelection.collapsed(
          offset: 0,
        ));

    // Build our app and trigger a frame.
    final bindings = Bindings.getbindings(
      controller: controller,
      onFormatJson: (_) {},
      isFormateable: true,
    );
    const enterActivator = SingleActivator(LogicalKeyboardKey.enter, control: true, alt: true);

    bindings[enterActivator]!();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: JsonTextField(isFormating: true, controller: controller),
      ),
    ));

    // Verify that JsonTextField is present.
    expect(find.byType(JsonTextField), findsOneWidget);
    expect(controller.text, equals('\n{"key": "value"'));
  });
  testWidgets('JsonTextField Widget Test, in a valid Json', (WidgetTester tester) async {
    final controller = JsonTextFieldController();
    controller.value = const TextEditingValue(
        text: '{"key": "value","anotherKey": "anotherValue","list": [3,2,1]}',
        selection: TextSelection.collapsed(
          offset: 0,
        ));

    // Build our app and trigger a frame.
    final bindings = Bindings.getbindings(
      controller: controller,
      onFormatJson: (_) {},
      isFormateable: true,
    );
    const enterActivator = SingleActivator(LogicalKeyboardKey.enter, control: true, alt: true);

    bindings[enterActivator]!();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: JsonTextField(isFormating: true, controller: controller),
      ),
    ));

    // Verify that JsonTextField is present.
    expect(find.byType(JsonTextField), findsOneWidget);
    expect(controller.text,
        equals('{\n  "anotherKey": "anotherValue",\n  "key": "value",\n  "list": [\n    3,\n    2,\n    1\n  ]\n}'));
  });
}
