import 'package:flutter/material.dart';

class ResultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResultAppBar({
    required this.onReset,
    this.isResolved,
    super.key,
  });

  final bool? isResolved;
  final Function onReset;

  Color get _color {
    if (isResolved == null) {
      return Colors.yellow;
    } else if (isResolved!) {
      return Colors.green.shade300;
    } else {
      return Colors.red;
    }
  }

  IconData get _icon {
    if (isResolved == null) {
      return Icons.sentiment_neutral;
    } else if (isResolved!) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: _color,
        child: IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => onReset(),
            icon: Icon(
              _icon,
              color: Colors.black,
              size: 35,
            )),
      ),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
