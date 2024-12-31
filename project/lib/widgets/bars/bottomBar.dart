import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/main.dart';

class Destination {
  const Destination(
      this.index, this.title, this.icon, this.selectedIcon, this.iconSize);
  final int index;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final double iconSize;
}

class bottomBarWidget extends State<MyStatefulWidget> {
  final PageController _pageController = PageController();

  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home_outlined, Icons.home, 20.0),
    Destination(1, 'Calendar', Icons.today, Icons.today, 18.0),
    Destination(2, 'Community', Icons.groups_outlined, Icons.groups, 24.0),
    Destination(3, 'Settings', Icons.settings_outlined, Icons.settings, 20.1),
  ];

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CalendarWidget(),
    CommunityWidget(),
    SettingWidget(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Coffhy',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgetOptions,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          indicatorColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          destinations: allDestinations.map<NavigationDestination>(
            (Destination destination) {
              return NavigationDestination(
                selectedIcon: Icon(
                  destination.selectedIcon,
                  size: destination.iconSize.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                icon: Icon(
                  destination.icon,
                  size: destination.iconSize.sp,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: destination.title,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
