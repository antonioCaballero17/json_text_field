import 'package:flutter/material.dart';
import 'package:json_text_field/src/json_utils.dart';

class JsonTextFieldController extends TextEditingController {
  JsonTextFieldController();

  /// Format the JSON text in the controller. Use [sortJson] to sort the JSON keys.
  formatJson({required bool sortJson}) {
    if (JsonUtils.isValidJson(text)) {
      JsonUtils.formatTextFieldJson(sortJson: sortJson, controller: this);
    }
  }
}
