import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../todo_list/todo_list_screen.dart';
import 'widgets/onboarding_context.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _pages = [
    OnboardingPage(
      title: 'Add Task',
      description:
          ' It typically includes features that allow users to create task lists, set priorities, assign deadlines, and categorize tasks.',
      imageAsset: 'assets/images/onboarding_image2.jpg',
    ),
    OnboardingPage(
      title: 'Discover',
      description:
          'o-do apps can vary in complexity from simple lists to sophisticated tools with advanced functionality like reminders, collaboration options, and integration with other productivity software',
      imageAsset: 'assets/images/onboarding_image4.jpg',
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSkip() {
    Get.offNamed('/home');
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      _onSkip();
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _currentPage == 1
                    ? TextButton(
                        onPressed: _onSkip,
                        child: Text('Skip',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)),
                      )
                    : TextButton(
                        onPressed: () {
                          Get.to(TodoListScreen());
                        },
                        child: Text('Skip',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)),
                      ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: _pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _currentPage == 1
                    ? TextButton(
                        onPressed: () {
                          _onBack();
                        },
                        child: Text('Back',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)))
                    : Text(''),
                Row(
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 10.0,
                      width: (index == _currentPage) ? 20.0 : 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color:
                            (index == _currentPage) ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
                _currentPage == 0
                    ? TextButton(
                        onPressed: _onNext,
                        child: Text('Next',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)),
                      )
                    : TextButton(
                        onPressed: () {
                          Get.to(TodoListScreen());
                        },
                        child: Text('Next',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
