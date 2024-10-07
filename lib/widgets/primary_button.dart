import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool inverted;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.inverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: const Color(0x3F9BB068).withOpacity(.1),
        elevation: 2,
        enableFeedback: true,
        backgroundColor: inverted
            ? const Color(0xff2a2a2b)
            : Theme.of(context).colorScheme.inversePrimary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: onPressed,
      label: Image.asset(
        "assets/icons/arrow-right.png",
        height: 24,
        width: 24,
        color: inverted ? Theme.of(context).colorScheme.primary : Colors.black,
      ),
      icon: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color:
              inverted ? Theme.of(context).colorScheme.primary : Colors.black,
        ),
      ),
    );
  }
}
