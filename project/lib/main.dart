import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/text.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/provider/index.dart';
import 'package:project/view/home/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (create) => PageIndex())],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  final _title = 'Coffhy';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
    const brightness = Brightness.light;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
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

  final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CalendarWidget(),
    CommunityWidget(),
    SettingWidget(),
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

  SettingWidget({super.key});

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

  CommunityWidget({super.key});

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
