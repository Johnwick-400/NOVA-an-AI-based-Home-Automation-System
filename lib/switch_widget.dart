import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onStateChanged;

  SwitchWidget({
    required this.label,
    required this.value,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Switch(
        value: value,
        onChanged: onStateChanged,
      ),
    );
  }
}
