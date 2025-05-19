import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qacc_application/models/app_colors.dart';

class AnimatedText extends StatefulWidget {
  final List<String> texts;
  final int startIndex;

  const AnimatedText({Key? key, required this.texts, this.startIndex = 0,})
      : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  late int index;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    index = widget.startIndex;

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        index = (index + 1) % widget.texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  IconData getIconForText(String text) {
    switch (text) {
      case 'جديد':
        return FontAwesomeIcons.star;
      case 'اكتشف':
        return FontAwesomeIcons.search;
      case 'ترقبوا':
        return FontAwesomeIcons.hourglassHalf;
      case 'قريباً':
        return FontAwesomeIcons.clock;
      default:
        return Icons.access_time_filled;
    }
  }

  Color getBackgroundColorForText(String text) {
    switch (text) {
      case 'جديد':
        return Colors.green;
      case 'اكتشف':
        return AppColors.primaryColor;
      case 'ترقبوا':
        return AppColors.primaryColor;
      case 'قريباً':
        return AppColors.secondaryColor.shade500;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(index),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: getBackgroundColorForText(widget.texts[index]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getIconForText(widget.texts[index]),
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 6),
            Text(
              widget.texts[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
