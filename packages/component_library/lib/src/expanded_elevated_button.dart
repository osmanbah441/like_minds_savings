import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  const ExpandedElevatedButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  static const _buttonHeight = 48.0;

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  ExpandedElevatedButton.inProgress(String label, {Key? key})
      : this(
          key: key,
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CenteredCircularProgressIndicator(),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonHeight,
      width: double.infinity,
      child: (icon == null)
          ? ElevatedButton(
              onPressed: onTap,
              child: Text(label),
            )
          : ElevatedButton.icon(
              onPressed: onTap,
              label: Text(label),
              icon: icon,
            ),
    );
  }
}
