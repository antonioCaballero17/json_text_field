import 'package:flutter/material.dart';

class ErrorMessageContainer extends StatelessWidget {
  const ErrorMessageContainer({
    super.key,
    required this.jsonError,
  });

  final String? jsonError;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: jsonError == null
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minHeight: 40, maxHeight: 60),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(jsonError ?? '', style: const TextStyle(color: Colors.red))),
            ),
    );
  }
}
