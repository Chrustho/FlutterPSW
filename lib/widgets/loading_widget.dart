// widgets/loading_widget.dart
import 'package:flutter/material.dart';
import '../models/support/app_constants.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(AppConstants.primaryColorHex),
            ),
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}