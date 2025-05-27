// widgets/error_widget.dart
import 'package:flutter/material.dart';
import '../models/support/app_constants.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: AppConstants.titleFontSize,
                fontWeight: FontWeight.bold,
                color: Color(AppConstants.darkColorHex),
              ),
            ),
            SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.subtitleFontSize,
                color: Colors.grey[600],
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(AppConstants.primaryColorHex),
                  foregroundColor: Colors.white,
                ),
                child: Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}