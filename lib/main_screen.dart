import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:study_path/features/favorite/views/favourite_screen.dart';
import 'package:study_path/features/filter/presentation/screens/filter_screen.dart';
import 'package:study_path/features/home/presentation/screens/home_screen.dart';
import 'package:study_path/features/notification/presentation/screens/notification_screen.dart';
import 'package:study_path/features/search/presentation/search_screen.dart';
import 'package:study_path/features/settings/presentation/screens/setting_view.dart';

import 'core/utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {"icon": CupertinoIcons.house},
    {"icon": CupertinoIcons.search},
    {"icon": CupertinoIcons.bookmark},
    {"icon": CupertinoIcons.person},
  ];
  static final List<Map<String, dynamic>> _titles = [
    {"name": "Home"},
    {"name": "Search"},
    {"name": "Favourite"},
    {"name": "Profile"},
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final activeColor = isDark ? Colors.white : AppColors.blackSecondary;
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        HomeScreen(),
        SearchScreen(),
        // NotificationScreen(),
        FavouriteScreen(),
        SettingView(),
      ],
      items: MainScreen._screens
          .map(
            (e) => PersistentBottomNavBarItem(
              icon: Icon(e["icon"]),
              activeColorPrimary: activeColor,
              inactiveColorPrimary: Colors.grey,
            ),
          )
          .toList(),
      confineToSafeArea: true,
      backgroundColor: backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}
