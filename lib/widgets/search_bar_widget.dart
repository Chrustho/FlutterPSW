import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;

  const SearchBarWidget({
    Key? key,
    required this.onSearch,
    this.hintText = 'Search artists, albums...',
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppConstants.defaultPadding),
      child: TextField(
        controller: _controller,
        onSubmitted: widget.onSearch,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              widget.onSearch('');
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(AppConstants.lightGrayHex),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}