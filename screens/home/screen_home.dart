import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/screens/add_tranctions/screen_add_tranctions.dart';
import 'package:money_manage_app/screens/category/category_add_popup.dart';
import 'package:money_manage_app/screens/category/screen_category.dart';
import 'package:money_manage_app/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manage_app/screens/tranctions/screen_tranctions.dart';

import '../calculator/screen_calculator.dart';
import '../privacy_policy/screen_policy.dart';
import '../tips_page/screen_tips.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> seletedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTranctions(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BudgetBuddy',
          style: GoogleFonts.mPlusCodeLatin(),
        ),
        backgroundColor: Colors.lightBlueAccent[100],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ScreenPolicy();
                },
              ));
            },
            icon: Icon(FontAwesomeIcons.handshake,
                size: 30, color: Color.fromARGB(255, 50, 49, 49))),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ScreenTips();
                  },
                ));
              },
              icon: const Icon(FontAwesomeIcons.lightbulb)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const CalculatorScreen();
                  },
                ));
              },
              icon: const Icon(FontAwesomeIcons.calculator))
        ],
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/flat-design-time-management-concept_23-2148813012.jpg?w=740&t=st=1688887823~exp=1688888423~hmac=b48f390b7be3803a0e6c84900b8ef7cadbd41129e7500b8c223593b2217b2d2e'),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: seletedIndexNotifier,
            builder: (BuildContext ctx, int updateIndex, Widget? _) {
              return _pages[updateIndex];
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (seletedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenaddTranction.routeName);
          } else {
            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'Travel',
            //   type: CategoryType.expenxe,
            // );
            // CategoryDb().insertCategory(_sample);
          }
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black54,
        ),
      ),
    );
  }
}
