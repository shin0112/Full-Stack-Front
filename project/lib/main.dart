import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _title = 'Coffhy';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          theme: lightTheme,
          home: child,
          color: Theme.of(context).colorScheme.surfaceDim,
        );
      },
      child: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MainWidget();
}

class Destination {
  const Destination(
      this.index, this.title, this.icon, this.selectedIcon, this.iconSize);
  final int index;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final double iconSize;
}

class MainWidget extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home_outlined, Icons.home, 20),
    Destination(1, 'Calendar', Icons.today, Icons.today, 18),
    Destination(2, 'Community', Icons.turned_in_not, Icons.turned_in, 18),
    Destination(3, 'Settings', Icons.settings_outlined, Icons.settings, 20.1),
  ];

  final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CalendarWidget(),
    CommunityWidget(),
    SettingWidget(),
  ];

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coffhy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 14,
                offset: Offset(0, -4),
                spreadRadius: 0,
              )
            ]),
        width: 360.sp,
        padding: EdgeInsets.only(top: 8.sp),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          fixedColor: Theme.of(context).colorScheme.onSurface,
          items: allDestinations.map<BottomNavigationBarItem>(
            (Destination destination) {
              return BottomNavigationBarItem(
                activeIcon: Container(
                  height: 32.sp,
                  width: 64.sp,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16)),
                  child: Icon(
                    destination.selectedIcon,
                    size: destination.iconSize.sp,
                  ),
                ),
                icon: SizedBox(
                  height: 32.sp,
                  width: 64.sp,
                  child: Icon(
                    destination.icon,
                    size: destination.iconSize.sp,
                  ),
                ),
                label: destination.title,
              );
            },
          ).toList(),
          onTap: _onItemTapped,
          selectedFontSize: 12.sp,
          selectedLabelStyle: ThemeData().textTheme.labelMedium,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12.sp,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSecondaryContainer,
          unselectedLabelStyle: ThemeData().textTheme.labelMedium,
        ),
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  final Map info = {
    'titleImageLink': 'https://storage.googleapis.com/cms-storage-bucket/'
        '2f118a9971e4ca6ad737.png',
    'titleSectionHeader': 'Flutter on Mobile',
    'titleSectionBody': 'https://flutter.dev/multi-platform/mobile',
    'titleSectionScore': 100,
    'textSection': 'Bring your app idea to more users from day one by'
        ' building with Flutter '
        'on iOS and Android simultaneously, without sacrificing features, '
        'quality, or performance. All mobile on day one: '
        'Reach your full addressable market from day one by targeting users'
        ' in both ecosystems from a single codebase. Do more with less: '
        'Unite your mobile development team resources towards building '
        'one seamless customer experience. One experience: '
        'Release simultaneously on iOS and Android with feature parity '
        'for the best experience for all users.',
  };

  @override
  Widget build(BuildContext context) {
    final titleImage = _buildTitleImage(info['titleImageLink']);
    Widget textSection = _buildTextSection(info['textSection']);
    Widget buttonSection = _buildButtonSection(Theme.of(context).primaryColor);
    Widget titleSection = _buildTitleSection(info['titleSectionHeader'],
        info['titleSectionBody'], info['titleSectionScore']);

    return ListView(
      children: [
        titleImage,
        titleSection,
        buttonSection,
        textSection,
      ],
    );
  }
}

// star widget : volume-E-chapter-07.dart

class CommunityWidget extends StatelessWidget {
  final Map info = {
    'titleImageLink': 'https://storage.googleapis.com/cms-storage-bucket/'
        '2f118a9971e4ca6ad737.png',
    'titleSectionHeader': 'Flutter on Mobile',
    'titleSectionBody': 'https://flutter.dev/multi-platform/mobile',
    'titleSectionScore': 100,
    'textSection': 'Bring your app idea to more users from day one by'
        ' building with Flutter '
        'on iOS and Android simultaneously, without sacrificing features, '
        'quality, or performance. All mobile on day one: '
        'Reach your full addressable market from day one by targeting users'
        ' in both ecosystems from a single codebase. Do more with less: '
        'Unite your mobile development team resources towards building '
        'one seamless customer experience. One experience: '
        'Release simultaneously on iOS and Android with feature parity '
        'for the best experience for all users.',
  };

  @override
  Widget build(BuildContext context) {
    final titleImage = _buildTitleImage(info['titleImageLink']);
    Widget textSection = _buildTextSection(info['textSection']);
    Widget buttonSection = _buildButtonSection(Theme.of(context).primaryColor);
    Widget titleSection = _buildTitleSection(info['titleSectionHeader'],
        info['titleSectionBody'], info['titleSectionScore']);

    return ListView(
      children: [
        titleImage,
        titleSection,
        buttonSection,
        textSection,
      ],
    );
  }
}

Image _buildTitleImage(String imageName) {
  return Image.network(
    imageName,
    width: 600,
    height: 240,
    fit: BoxFit.cover,
  );
}

Container _buildTitleSection(String name, String addr, int count) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                addr,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        const Counter(),
      ],
    ),
  );
}

Widget _buildButtonSection(Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.assistant_navigation, 'Visit'),
      _buildButtonColumn(color, Icons.add_alert_sharp, 'Alarm'),
      _buildButtonColumn(color, Icons.share, 'Share'),
    ],
  );
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Container _buildTextSection(String section) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      section,
      softWrap: true,
      textAlign: TextAlign.justify,
      style: const TextStyle(height: 1.5, fontSize: 15),
    ),
  );
}

class Counter extends StatefulWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int _counter = 0;
  bool _boolStatus = false;
  Color _statusColor = Colors.black;

  void _buttnPressed() {
    setState(() {
      if (_boolStatus == true) {
        _boolStatus = false;
        _counter--;
        _statusColor = Colors.black;
      } else {
        _boolStatus = true;
        _counter++;
        _statusColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.star),
          color: _statusColor,
          onPressed: _buttnPressed,
        ),
        Text('$_counter'),
      ],
    );
  }
}

// hello widget : volume-E-chapter-02.dart

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 32,
          ),
        ),
        onPressed: () {
          showAlertDialog(context);
        },
        child: const Text('Hello, Press Here!'),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Sample'),
        content: const Text("Select button you want"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context, "OK");
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, "Cancel");
            },
          ),
        ],
      );
    },
  );

  print("showAlertDialog(): $result");
}

// home widget : volume-E-chapter-03-code-22.dart

class HomeWidget extends StatelessWidget {
  final groupAggregated = Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        const Text(
          'Shop Name',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
        Center(
          child: Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/'
              '780e0e64d323aad2cdd5.png',
              width: 300,
              height: 300),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.green[500]),
                  Icon(Icons.star, color: Colors.green[500]),
                  const Icon(Icons.star, color: Colors.black),
                ],
              ),
              const Text(
                '170 Reviews',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        DefaultTextStyle.merge(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
            fontSize: 18,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.kitchen, color: Colors.green[500]),
                    const Text('kitchen:'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.timer, color: Colors.green[500]),
                    const Text('timer:'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.restaurant, color: Colors.green[500]),
                    const Text('restaurant:'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        groupAggregated,
      ],
    );
  }
}
