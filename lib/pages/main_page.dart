import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zarashop/pages/settings_page.dart';

import '../registerpage/phone.dart';
import '../service/auth_service.dart';
import 'home_page.dart';
import 'likes_page.dart';
import 'market_page.dart';

class MainPage extends StatefulWidget {
  final bool? dataSaved;

  const MainPage({super.key, this.dataSaved});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLogged = false;
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    (AuthService.isLoggedIn()) ? LikesPage() : LoginScreen(),
    (AuthService.isLoggedIn()) ? marketPage() : LoginScreen(),
    (AuthService.isLoggedIn()) ? SettingPage() : LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  backgroundGradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(248, 184, 225, 1.0),
                        Color.fromRGBO(69, 172, 243, 1.0)
                      ]),
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  backgroundGradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(248, 184, 225, 1.0),
                        Color.fromRGBO(69, 172, 243, 1.0)
                      ]),
                  icon: Icons.favorite_border,
                  text: 'Likes',
                ),
                GButton(
                  backgroundGradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(248, 184, 225, 1.0),
                        Color.fromRGBO(69, 172, 243, 1.0)
                      ]),
                  icon: Icons.shopping_cart_outlined,
                  text: 'shop',
                ),
                GButton(
                  backgroundGradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(248, 184, 225, 1.0),
                        Color.fromRGBO(69, 172, 243, 1.0)
                      ]),
                  icon: Icons.settings,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) async {
                setState(() {
                  _selectedIndex = index;
                });

                // if (_selectedIndex == 2 || _selectedIndex ==3) {
                //   initPage();
                // }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPage() async {
    await Future.delayed(
      Duration(microseconds: 1),
    );
    isLogged = AuthService.isLoggedIn();
    if (isLogged) {
    } else {
      setState(() {
        _selectedIndex = 0;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    // initPage();
    setState(() {
      isLogged = AuthService.isLoggedIn();
    });
    super.initState();
  }
}
