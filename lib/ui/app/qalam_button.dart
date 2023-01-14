import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_app/ui/app/app_theme.dart';

class QalamButton extends StatefulWidget {
  

  const QalamButton({super.key, required this.onPressed, required this.child, required this.color});

  final Widget child;
  final Function() onPressed;
  final Color color;

  @override
  State<QalamButton> createState() => _QalamButtonState();
}

class _QalamButtonState extends State<QalamButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        splashColor: AppTheme.primaryColor,
        child: Ink(
            decoration: BoxDecoration(
              color: widget.color, 
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: widget.child));
  }
}
