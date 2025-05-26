import 'package:flutter/material.dart';
import '../models/support/app_constants.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstants.defaultPadding * 2),
      color: Color(AppConstants.darkColorHex),
      child: Text(
        '© 2023 Album Reviews. Crafted with care. All rights reserved.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: AppConstants.bodyFontSize,
        ),
      ),
    );
  }
}