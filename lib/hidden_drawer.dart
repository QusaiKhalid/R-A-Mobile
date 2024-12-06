import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:qusai_final_project/login_page.dart';
import 'package:qusai_final_project/user_page.dart';
import 'package:qusai_final_project/settings_page.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final base = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    fontFamily: 'quicksand',
    color: Colors.white
  );
  final selected = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    fontFamily: 'quicksand',
    color: Colors.white
  );
  @override
  void initState() {
    super.initState();
    _pages =[
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Users-Dashboard',
          baseStyle: base,
          selectedStyle: selected
        ),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Parts-Dashpoard',
          baseStyle: base,
          selectedStyle: selected
        ),
        const SettingsPage(),
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blue.shade300,
      screens: _pages,
      initPositionSelected: 0,
      actionsAppBar:  <Widget>[
        IconButton(
          onPressed: (() {
            Navigator.push(context, MaterialPageRoute(builder: ((context) => const LogInPage())));
          }),
          icon: const Icon(Icons.logout_rounded),
        )
      ],
    );
  }
}