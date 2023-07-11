import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/db/category/category_db.dart';

import 'expence_category_list.dart';
import 'income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        TabBar(
           controller: _tabController,
           labelStyle: GoogleFonts.mPlusCodeLatin(fontWeight: FontWeight.bold),
           indicatorSize: TabBarIndicatorSize.tab,
           indicatorColor: Colors.lightBlue,
           indicatorPadding: EdgeInsets.symmetric(horizontal: 4),
          tabs:const [
          Tab(
            text: 'Income',
          ),
          Tab(
            text: 'Expence',
          ),
        ], 
        
       
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:const [
              IncomeCategoryList(),
              ExpenceCategoryList(),
              
            ],
            ),
        )
      ],
    );
  }
}
