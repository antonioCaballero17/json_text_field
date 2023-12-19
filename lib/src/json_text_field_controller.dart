import 'package:flutter/material.dart';
import 'package:json_text_field_editor/src/json_utils.dart';

class JsonTextFieldController extends TextEditingController {
  JsonTextFieldController();

  formatJson({required bool sortJson}) {
    if (JsonUtils.isValidJson(text)) {
      JsonUtils.formatTextFieldJson(sortJson: sortJson, controller: this);
    }
  }
}
