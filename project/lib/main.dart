import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/text.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/view/home/beverage_view_model.dart';
import 'package:project/view/setting/theme_view_model.dart';
import 'package:project/provider/index.dart';
import 'package:project/view/community/community_page.dart';
import 'package:project/view/community/post_view_model.dart';
import 'package:project/view/home/home_page.dart';
import 'package:project/view/home/hotlist_view_model.dart';
import 'package:project/view/setting/setting_page.dart';
import 'package:project/view/setting/user_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => PageIndex()),
        ChangeNotifierProvider(create: (context) => ThemeViewModel()),
        ChangeNotifierProvider(create: (context) => HotlistViewModel()),
        ChangeNotifierProvider(create: (context) => PostViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => BeverageViewModel()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  final _title = 'Coffhy';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: context.watch<ThemeViewModel>().themeMode,
          home: child,
        );
      },
      child: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => MainWidget();
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.selectedIcon);
  final int index;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
}

class MainWidget extends State<MyStatefulWidget> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home_outlined, Icons.home),
    Destination(1, 'Calendar', Icons.today, Icons.today),
    Destination(2, 'Community', Icons.turned_in_not, Icons.turned_in),
    Destination(3, 'Settings', Icons.settings_outlined, Icons.settings),
  ];

  final List<Widget> _widgetOptions = const <Widget>[
    HomeWidget(),
    CalendarWidget(),
    CommunityPage(),
    SettingPage(),
  ];

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: Container(
          height: 36.sp,
          margin: EdgeInsets.only(top: 10.sp),
          child: const Text('Coffhy'),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        toolbarHeight: 56.sp,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: _widgetOptions[context.read<PageIndex>().index],
      bottomNavigationBar: Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          destinations: allDestinations.map<NavigationDestination>(
            (Destination destination) {
              return NavigationDestination(
                selectedIcon: Container(
                  height: 32.sp,
                  width: 64.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    destination.selectedIcon,
                    size: 24.sp,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                icon: SizedBox(
                  height: 32.sp,
                  width: 64.sp,
                  child: Icon(
                    destination.icon,
                    size: 24.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                label: destination.title,
              );
            },
          ).toList(),
          onDestinationSelected: (int index) {
            setState(() {
              context.read<PageIndex>().setIndex(index);
            });
          },
          selectedIndex: context.watch<PageIndex>().index,
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    super.key,
  });

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
  const CalendarWidget({super.key});

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
