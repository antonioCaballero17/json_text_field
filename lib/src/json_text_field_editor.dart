import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:json_text_field_editor/src/bindings.dart';
import 'package:json_text_field_editor/src/error_message_container.dart';
import 'package:json_text_field_editor/src/json_highlight/json_highlight.dart';
import 'package:json_text_field_editor/src/json_utils.dart';

class JsonTextField extends ExtendedTextField {
  const JsonTextField(
      {super.key,
      super.autocorrect,
      super.autofillHints,
      super.autofocus,
      super.buildCounter,
      super.canRequestFocus,
      super.clipBehavior,
      super.controller,
      super.cursorColor,
      super.cursorHeight,
      super.cursorRadius,
      super.cursorWidth,
      super.decoration,
      super.enableInteractiveSelection,
      super.enableSuggestions,
      super.expands,
      super.focusNode,
      super.inputFormatters,
      super.keyboardAppearance,
      super.keyboardType,
      super.maxLength,
      super.maxLines,
      super.minLines,
      super.obscureText,
      super.onAppPrivateCommand,
      super.onChanged,
      super.onEditingComplete,
      super.onSubmitted,
      super.onTap,
      super.readOnly,
      super.scrollController,
      super.scrollPadding,
      super.scrollPhysics,
      super.showCursor,
      super.smartDashesType,
      super.smartQuotesType,
      super.style,
      super.textAlign,
      super.textAlignVertical,
      super.textCapitalization,
      super.textDirection,
      super.textInputAction,
      super.toolbarOptions,
      super.contentInsertionConfiguration,
      super.selectionControls,
      super.mouseCursor,
      super.dragStartBehavior,
      super.cursorOpacityAnimates,
      super.enableIMEPersonalizedLearning,
      super.enabled,
      super.extendedContextMenuBuilder,
      super.extendedSpellCheckConfiguration,
      super.maxLengthEnforcement,
      super.obscuringCharacter,
      super.onTapOutside,
      super.restorationId,
      super.scribbleEnabled,
      super.selectionHeightStyle,
      super.selectionWidthStyle,
      super.strutStyle,
      super.undoController,
      required this.isFormating});

  final bool isFormating;

  @override
  JsonTextFieldState createState() {
    return JsonTextFieldState();
  }
}

class JsonTextFieldState extends State<JsonTextField> {
  String? jsonError;
  late final TextEditingController controller = widget.controller ?? TextEditingController();

  void _setJsonError(String? error) => setState(() => jsonError = error);
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: Bindings.getbindings(
        controller: controller,
        onFormatJson: _setJsonError,
        isFormateable: widget.isFormating,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ExtendedTextField(
            autocorrect: widget.autocorrect,
            autofillHints: widget.autofillHints,
            autofocus: widget.autofocus,
            buildCounter: widget.buildCounter,
            canRequestFocus: widget.canRequestFocus,
            clipBehavior: widget.clipBehavior,
            controller: widget.controller,
            cursorColor: widget.cursorColor,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius,
            cursorWidth: widget.cursorWidth,
            decoration: widget.decoration,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enableSuggestions: widget.enableSuggestions,
            expands: widget.expands,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
            keyboardAppearance: widget.keyboardAppearance,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            obscureText: widget.obscureText,
            onAppPrivateCommand: widget.onAppPrivateCommand,
            onChanged: (value) {
              widget.onChanged?.call(value);
              if (widget.isFormating) {
                JsonUtils.validateJson(json: value, onError: _setJsonError);
              }
            },
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            scrollController: widget.scrollController,
            scrollPadding: widget.scrollPadding,
            scrollPhysics: widget.scrollPhysics,
            showCursor: widget.showCursor,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            specialTextSpanBuilder: widget.isFormating ? JsonHighlight() : null,
            style: widget.style,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            textCapitalization: widget.textCapitalization,
            textDirection: widget.textDirection,
            textInputAction: widget.textInputAction,
            contentInsertionConfiguration: widget.contentInsertionConfiguration,
            selectionControls: widget.selectionControls,
            mouseCursor: widget.mouseCursor,
            dragStartBehavior: widget.dragStartBehavior,
            cursorOpacityAnimates: widget.cursorOpacityAnimates,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            enabled: widget.enabled,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            obscuringCharacter: widget.obscuringCharacter,
            onTapOutside: widget.onTapOutside,
            restorationId: widget.restorationId,
            scribbleEnabled: widget.scribbleEnabled,
            selectionHeightStyle: widget.selectionHeightStyle,
            selectionWidthStyle: widget.selectionWidthStyle,
            strutStyle: widget.strutStyle,
            undoController: widget.undoController,
          ),
          ErrorMessageContainer(jsonError: jsonError),
        ],
      ),
    );
  }
}
