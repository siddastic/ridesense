import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ridesense/widgets/space.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final Color? textColor;
  final bool readOnly;
  final void Function(String)? onChanged;
  const Input({
    super.key,
    this.label,
    this.controller,
    this.validator,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.autofillHints,
    this.textColor = Colors.white,
    this.readOnly = false,
    this.onChanged,
    this.padding,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Space(8),
            ],
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isFocused
                      ? CupertinoTheme.of(context).primaryColor
                      : const Color(0xff242424),
                ),
                boxShadow: [
                  if (isFocused)
                    const BoxShadow(
                      color: Color(0x3F9BB068),
                      blurRadius: 0,
                      offset: Offset(0, 0),
                      spreadRadius: 4,
                    ),
                ],
              ),
              child: Focus(
                onFocusChange: (value) => setState(() => isFocused = value),
                child: TextFormField(
                  controller: widget.controller,
                  validator: widget.validator,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  autofillHints: widget.autofillHints,
                  readOnly: widget.readOnly,
                  onChanged: widget.onChanged,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: widget.hint,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    fillColor: const Color(0xff242424),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: widget.prefixIcon != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Space(14, isHorizontal: true),
                              widget.prefixIcon!,
                            ],
                          )
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Space(14, isHorizontal: true),
                              widget.suffixIcon!,
                            ],
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
