import 'package:field_suggestion/src/styles.dart';
import 'package:flutter/material.dart';

// Custom private class, for build [SuggestionItem]
class SuggestionItem extends StatelessWidget {
  final SuggestionItemStyle style;
  final Function onTap;
  final Function onIconTap;
  final String title;

  const SuggestionItem({
    Key key,
    @required this.style,
    @required this.onTap,
    @required this.onIconTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: style.margin,
      decoration: _buildBoxDecoration(),
      child: ListTile(
        hoverColor: Colors.transparent,
        onTap: onTap,
        title: _buildTitle(),
        trailing: _buildIconButton(),
      ),
    );
  }

  Text _buildTitle() => Text(
        title,
        style: style.titleStyle,
      );

  IconButton _buildIconButton() => IconButton(
        splashColor: Colors.transparent,
        icon: Icon(style.icon, color: style.iconColor, size: style.iconSize),
        onPressed: onIconTap,
      );

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: style.backgroundColor,
      border: style.border,
      borderRadius: style.borderRadius,
      boxShadow: style.boxShadow,
      gradient: style.gradient,
    );
  }
}
