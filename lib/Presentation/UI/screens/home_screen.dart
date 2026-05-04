import 'package:bmi_calculator/Presentation/UI/screens/bmi_calculate_screen.dart';
import 'package:bmi_calculator/Presentation/UI/screens/coming_soon_screen.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/Presentation/UI/Pages/show_all_conversion_types_page.dart';
import 'package:bmi_calculator/Data/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void redirectionfromPage1(int index) {
    if (allConvertersForPage2[index]['type'] == 'BMI') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BmiCalculatePage(
            conversionTypes2: allConvertersForPage2[index]['conversionData'],
            topSelectedUnit: allConvertersForPage2[index]['topSelectedUnit'],
            bottomSelectedUnit:
                allConvertersForPage2[index]['bottomSelectedUnit'],
            appBarTitle: allConvertersForPage2[index]['type'],
          ),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComingSoon()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: .center,
        children: [
          SafeArea(
            minimum: .zero,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calculate_outlined,
                      size: 30,
                      color: _currentPageIndex == 0
                          ? const Color.fromARGB(255, 255, 115, 34)
                          : Colors.grey,
                    ),
                    onPressed: () => _updateCurrentPageIndex(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.grid_view_rounded,
                      size: 30,
                      color: _currentPageIndex == 1
                          ? const Color.fromARGB(255, 255, 115, 34)
                          : Colors.grey,
                    ),
                    onPressed: () => _updateCurrentPageIndex(1),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _handlePageViewChanged,
              children: <Widget>[
                const Center(child: Text("Calculator")),
                ShowAllConversionTypesPage(
                  allConverters: allConvertersForPage2,
                  redirect: redirectionfromPage1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
