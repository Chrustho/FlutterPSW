import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double starSize;
  final bool showRatingText;
  final Color activeColor;
  final Color inactiveColor;

  const StarRatingWidget({
    Key? key,
    required this.rating,
    this.starSize = 20,
    this.showRatingText = false,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                ? Icons.star_half
                : Icons.star_border,
            color: index < rating ? activeColor : inactiveColor,
            size: starSize,
          );
        }),
        if (showRatingText) ...[
          SizedBox(width: 8),
          Text(
            '(${rating.toStringAsFixed(1)} stars)',
            style: TextStyle(
              fontSize: starSize * 0.7,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}