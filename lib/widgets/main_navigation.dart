import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class MainNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const MainNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        children: [
          _buildNavItem('Home', 0),
          SizedBox(width: 32),
          _buildNavItem('Reviews', 1),
          SizedBox(width: 32),
          _buildNavItem('About', 2),
          Spacer(),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Implementa carrello
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color(AppConstants.primaryColorHex) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Color(AppConstants.primaryColorHex) : Color(AppConstants.darkColorHex),
          ),
        ),
      ),
    );
  }
}