import 'package:flutter/material.dart';
import 'package:json_text_field_editor/src/json_utils.dart';

class JsonTextFieldController extends TextEditingController {
  JsonTextFieldController();

  formatJson({required bool orderJson}) {
    if (JsonUtils.isValidJson(text)) {
      JsonUtils.formatTextFieldJson(orderJson: orderJson, controller: this);
    }
  }
}
