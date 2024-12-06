import 'package:flutter/material.dart';

// Define a function that returns a ListTile with a PopupMenuButton
Widget buildListTileWithPopupMenu({
  required bool isDarkModeEnabled,
  required String title,
  required String item1,
  required String item2,
  required String item3,
  required ValueChanged<String> onTitleChanged,
}) {
  return ListTile(
    minLeadingWidth: 50,
    title: Text(
      title,
      style: TextStyle(color: isDarkModeEnabled ? Colors.white: Colors.black,),
    ),
    trailing: PopupMenuButton<String>(
      color: isDarkModeEnabled ? Colors.grey[900] : Colors.grey[300],
      icon: Icon(
        Icons.more_vert,
        color: isDarkModeEnabled ? Colors.white: Colors.black,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: item1,
          child: Text(item1, style: TextStyle(color: isDarkModeEnabled ? Colors.white: Colors.black,)),
        ),
        PopupMenuItem<String>(
          value: item2,
          child: Text(item2, style: TextStyle(color: isDarkModeEnabled ? Colors.white: Colors.black,)),
        ),
        PopupMenuItem<String>(
          value: item3,
          child: Text(item3, style: TextStyle(color: isDarkModeEnabled ? Colors.white: Colors.black,)),
        ),
        
      ],
      onSelected: (value) {
        onTitleChanged(value);
      },
    ),
  );
}
