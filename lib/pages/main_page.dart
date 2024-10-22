import 'package:falah/api/urls.dart';
import 'package:flutter/material.dart';
import 'package:falah/screens/home_screen.dart';
import 'package:falah/screens/create_screen.dart';
import 'package:falah/screens/me_screen.dart';
import 'package:falah/models/user_repository.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  final List<Widget> _mainPages = [
    HomeScreen(),
    CreateScreen(),
    MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
    return Scaffold(
      body: _mainPages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int value) {
          setState(() {
            _selectedPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create, size: 30),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                userRepo.user != null ? userRepo.user.pfpUrl ?? Urls.DEFAULT_PFP_URL : Urls.DEFAULT_PFP_URL,
              ),
            ),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
