import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.seletedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.mPlusCodeLatin(),
          unselectedLabelStyle: GoogleFonts.mPlusCodeLatin(),
          selectedFontSize: 16,
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.blueGrey[200],
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          ScreenHome.seletedIndexNotifier.value = newIndex;
        },
        items:const  [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cubesStacked),
            label: 'Category',
            
          )
        ],
      );
      },
    );
  }
}
