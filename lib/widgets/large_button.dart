import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton(
      {super.key, required this.buttonText, this.onPressed, this.color});

  final String buttonText;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(buttonText, style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }
}
