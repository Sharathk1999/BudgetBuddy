import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/db/category/category_db.dart';

import '../../models/category/category.dart';

class ExpenceCategoryList extends StatelessWidget {
  const ExpenceCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenceCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget?_) {
        if (newList.isEmpty) {
          return Center(
            child: Text('Hit ➕ to add new Expence Category',style: GoogleFonts.mPlusCodeLatin(fontSize: 16,fontWeight: FontWeight.w500),),
          );
        }
        return  ListView.separated(
      padding:const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final category = newList[index];
        return Card(
          elevation: 0,
          child: ListTile(
            title: Text(category.name,style: GoogleFonts.mPlusCodeLatin(),),
            trailing: IconButton(onPressed: () {
              CategoryDb().deleteCategory(category.id);
            }, icon:const Icon(FontAwesomeIcons.deleteLeft)),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10,);
      },
      itemCount: newList.length,
    );
      },
    );
  }
}
