import 'package:flutter/material.dart';
import 'package:field_suggestion/src/styles.dart';

// Very basic, default suggestion item widget.
class SuggestionItem extends StatelessWidget {
  final SuggestionItemStyle style;
  final Function onTap;
  final String title;

  const SuggestionItem({
    Key? key,
    required this.style,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        margin: style.margin,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          border: style.border,
          borderRadius: style.borderRadius,
          boxShadow: style.boxShadow,
          gradient: style.gradient,
        ),
        child: ListTile(
          hoverColor: Colors.transparent,
          onTap: onTap as void Function()?,
          title: Text(title, style: style.titleStyle),
          leading: style.leading,
        ),
      ),
    );
  }
}
