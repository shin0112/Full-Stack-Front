import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/provider/index.dart';
import 'package:project/widgets/thin_bar.dart';
import 'package:provider/provider.dart';

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

  HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 20.sp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ThinBar(
            brown: true,
            icon: Icons.local_cafe_outlined,
            text: "오늘 마신 음료 추가하기",
          ),
          ThinBar(
            brown: false,
            icon: Icons.today,
            text: "지난 기록 보러가기",
            onTap: () => context.read<PageIndex>().setIndex(1),
          )
        ],
      ),
    );
  }
}
