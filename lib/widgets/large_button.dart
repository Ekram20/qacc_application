import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({super.key, required this.buttonText, this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor.shade600,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(buttonText,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }
}