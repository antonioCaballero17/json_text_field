import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_text_field_editor/src/extensions/text_editing_controller_extension.dart';
import 'package:json_text_field_editor/src/json_utils.dart';

class Bindings {
  static Map<ShortcutActivator, VoidCallback> getbindings(
      {required TextEditingController controller,
      required Function(String?) onFormatJson,
      required bool isFormateable}) {
    return <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.tab): () => handleTab(controller: controller),
      const SingleActivator(LogicalKeyboardKey.enter, control: true, alt: true): () => handleEnter(
          orderJson: true, controller: controller, onFormatJson: onFormatJson, isFormateable: isFormateable),
      const SingleActivator(LogicalKeyboardKey.enter, control: true): () => handleEnter(
          orderJson: false, controller: controller, onFormatJson: onFormatJson, isFormateable: isFormateable),
    };
  }

  static void handleTab({required TextEditingController controller}) => controller.insert("  ");

  static void handleEnter(
      {required bool orderJson,
      required TextEditingController controller,
      required Function(String?) onFormatJson,
      required bool isFormateable}) {
    controller.insert("\n");
    if (isFormateable && JsonUtils.isValidJson(controller.text)) {
      JsonUtils.formatTextFieldJson(orderJson: orderJson, controller: controller);
      onFormatJson(null);
    }
  }
}
