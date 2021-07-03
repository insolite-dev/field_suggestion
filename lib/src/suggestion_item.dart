import 'package:flutter/material.dart';
import 'package:field_suggestion/src/styles.dart';

// Custom private class, for build [SuggestionItem].
class SuggestionItem extends StatelessWidget {
  final SuggestionItemStyle style;
  final Function onTap;
  final Function onIconTap;
  final String title;
  final String? subTitle;
  final bool disableItemTrailing;

  const SuggestionItem({
    Key? key,
    required this.style,
    required this.onTap,
    required this.onIconTap,
    required this.title,
    required this.subTitle,
    required this.disableItemTrailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.margin,
      decoration: buildBoxDecoration(),
      child: ListTile(
        hoverColor: Colors.transparent,
        onTap: onTap as void Function()?,
        title: Text(title, style: style.titleStyle),
        subtitle: (subTitle == "null")
            ? null
            : Text(subTitle!, style: style.subtitleStyle),
        trailing:
            !disableItemTrailing ? buildIconButton() : const SizedBox.shrink(),
        leading: style.leading,
      ),
    );
  }

  IconButton buildIconButton() => IconButton(
        key: const Key('SuggestionItem.icon'),
        splashColor: Colors.transparent,
        icon: Icon(style.icon, color: style.iconColor, size: style.iconSize),
        onPressed: onIconTap as void Function()?,
      );

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: style.backgroundColor,
      border: style.border,
      borderRadius: style.borderRadius,
      boxShadow: style.boxShadow,
      gradient: style.gradient,
    );
  }
}
