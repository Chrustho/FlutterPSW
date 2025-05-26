import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class NavigationSidebar extends StatelessWidget {
  final String selectedItem;
  final Function(String) onItemSelected;

  const NavigationSidebar({
    Key? key,
    required this.selectedItem,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.album, 'title': 'Albums', 'key': 'albums'},
      {'icon': Icons.music_note, 'title': 'Songs', 'key': 'songs'},
      {'icon': Icons.person, 'title': 'Artists', 'key': 'artists'},
      {'icon': Icons.category, 'title': 'Genres', 'key': 'genres'},
      {'icon': Icons.new_releases, 'title': 'New Releases', 'key': 'new_releases'},
      {'icon': Icons.trending_up, 'title': 'Charts', 'key': 'charts'},
    ];

    return Container(
      width: 250,
      color: Color(AppConstants.lightGrayHex),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            child: Text(
              'Browse',
              style: TextStyle(
                fontSize: AppConstants.titleFontSize,
                fontWeight: FontWeight.bold,
                color: Color(AppConstants.darkColorHex),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedItem == item['key'];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(AppConstants.primaryColorHex) : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                  ),
                  child: ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isSelected ? Colors.white : Color(AppConstants.primaryColorHex),
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(AppConstants.darkColorHex),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () => onItemSelected(item['key'] as String),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}