import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_pageview/main.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final String title;
  final String description;
  final String imageUrl;
  final IconData iconData;

  Data({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.iconData,
  });
}

class PView extends StatefulWidget {
  const PView({Key? key}) : super(key: key);

  @override
  State<PView> createState() => _PViewState();
}

class _PViewState extends State<PView> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;
  final _pageIndexNotifier = ValueNotifier<int>(0);

  List<Data> myData = [
    Data(
        title: 'Title 1',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        imageUrl: 'images/q1.jpg',
        iconData: Icons.add_box),
    Data(
      title: 'Title 2',
      description:
          'Sed do eiusmod tempor et dolore magna aliqua. Ut enim ad minim veniam',
      imageUrl: 'images/q2.jpg',
      iconData: Icons.add_circle,
    ),
    Data(
      title: 'Title 3',
      description:
          'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex consequat.',
      imageUrl: 'images/q3.jpg',
      iconData: Icons.add_circle_outline,
    ),
    Data(
      title: 'Title 4',
      description:
          'Duis aute irure dolor in reprehenderit in voluptatenulla pariatur.',
      imageUrl: 'images/q4.jpg',
      iconData: Icons.add_comment,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_currentIndex < 3) _currentIndex++;

      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => MyHomePage(),
      },
      home: Scaffold(
        body: Stack(
          alignment: const Alignment(0, 0.7),
          children: [
            Builder(
              builder: (ctx) => PageView(
                controller: _controller,
                children: myData
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.iconData, size: 130),
                            const SizedBox(height: 50),
                            Text(item.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                            const SizedBox(height: 10),
                            Text(
                              item.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onPageChanged: (val) {
                  _pageIndexNotifier.value = val;
                  setState(() {
                    _currentIndex = val;
                    /*if (_currentIndex == 3) {
                      Future.delayed(Duration(seconds: 2),
                          () => Navigator.of(ctx).pushNamed('/a'));
                    }*/
                  });
                },
              ),
            ),

            PageViewDotIndicator(
              currentItem: _pageIndexNotifier.value,
              count: myData.length,
              unselectedColor: Colors.black,
              selectedColor: Colors.white,
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.zero,
              alignment: Alignment.bottomCenter,
            ),

            //Indicator(_currentIndex),
            Builder(
              builder: (ctx) => Align(
                alignment: const Alignment(0, 0.93),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(7)),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pushNamed('/a');
                      // الاحتفاظ بالبيانات
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('x', true);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  const Indicator(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(0, index == 0 ? Colors.green : Colors.red),
          buildContainer(1, index == 1 ? Colors.green : Colors.red),
          buildContainer(2, index == 2 ? Colors.green : Colors.red),
          buildContainer(3, index == 3 ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget buildContainer(int i, Color color) {
    return index == i
        ? const Icon(Icons.star)
        : Container(
            margin: const EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          );
  }
}
