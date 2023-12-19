import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_text_field_editor/src/bindings.dart';

void main() {
  group('Bindings', () {
    test('handleTab inserts one tabs', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      Bindings.handleTab(controller: controller);
      expect(controller.text, equals("  "));
    });
    test('handleEnter inserts one new line', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      Bindings.handleEnter(
          orderJson: false, controller: controller, onFormatJson: (String? json) {}, isFormateable: false);
      expect(controller.text, equals("\n"));
    });

    test('handleEnter inserts newline and formats JSON if valid and formattable', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '{"key": "value"}',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      bool isFormateable = true;
      bool orderJson = false;
      onFormatJson(String? json) {}
      Bindings.handleEnter(
        orderJson: orderJson,
        controller: controller,
        onFormatJson: onFormatJson,
        isFormateable: isFormateable,
      );

      // Assert
      expect(controller.text, equals('{\n  "key": "value"\n}'));
    });

    test('handleEnter insert newline in invalid Json', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '{"key": "value"',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      bool isFormateable = true;
      bool orderJson = false;
      onFormatJson(String? json) {}
      Bindings.handleEnter(
        orderJson: orderJson,
        controller: controller,
        onFormatJson: onFormatJson,
        isFormateable: isFormateable,
      );

      // Assert
      expect(controller.text, equals('\n{"key": "value"'));
    });

    test('handleEnter inster newline in valid Json and format', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '{"key": "value","anotherKey": "anotherValue","list": [3,2,1]}',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      bool isFormateable = true;
      bool orderJson = true;
      onFormatJson(String? json) {}
      Bindings.handleEnter(
        orderJson: orderJson,
        controller: controller,
        onFormatJson: onFormatJson,
        isFormateable: isFormateable,
      );
      expect(controller.text,
          equals('{\n  "anotherKey": "anotherValue",\n  "key": "value",\n  "list": [\n    3,\n    2,\n    1\n  ]\n}'));
    });

    test('getbindings returns correct bindings', () {
      final controller = TextEditingController();
      controller.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(
            offset: 0,
          ));
      final bindings = Bindings.getbindings(
        controller: controller,
        onFormatJson: (_) {},
        isFormateable: true,
      );

      expect(bindings, isA<Map<ShortcutActivator, VoidCallback>>());

      const tabActivator = SingleActivator(LogicalKeyboardKey.tab);
      const enterActivator = SingleActivator(LogicalKeyboardKey.enter, control: true, alt: true);

      expect(bindings.containsKey(tabActivator), true);
      expect(bindings.containsKey(enterActivator), true);

      // Test tab action
      bindings[tabActivator]!();
      expect(controller.text, '  ');

      // Test enter action
      bindings[enterActivator]!();
      expect(controller.text, '  \n');
    });
  });
}
