import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: AppConstants.defaultElevation,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: Color(AppConstants.darkColorHex)),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(AppConstants.primaryColorHex),
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.album, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.subtitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}