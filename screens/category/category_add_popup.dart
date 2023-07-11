import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/db/category/category_db.dart';
import 'package:money_manage_app/models/category/category.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  final _formkey2 = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: _formkey2,
        child: SimpleDialog(
          title: Text(
            'Add Category',
            style: GoogleFonts.mPlusCodeLatin(),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
               
                decoration: InputDecoration(
                  hintText: 'Enter Categories here',
                  labelText: 'Categories here',
                  labelStyle: GoogleFonts.mPlusCodeLatin(),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))
                  ),
                  // hintStyle: GoogleFonts.mPlusCodeLatin(),
                  fillColor:const Color.fromARGB(255, 197, 222, 233),
                  filled: true,
                ),
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER CATEGORIES';
                    } else {
                      return null;
                    }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expence', type: CategoryType.expenxe),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    
                    return showAddCategorySnackBar(ctx);
                  }
      
                  final _type = selectedCategoryNotifier.value;
                  final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      type: _type);
      
                      CategoryDb().insertCategory(_category);
                      Navigator.of(ctx).pop();
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.mPlusCodeLatin(color: Colors.black87),
                ),
              
              ),
            ),
          ],
        ),
      );
    },
  );

}

void showAddCategorySnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Please add a category',style: GoogleFonts.mPlusCodeLatin(),),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ),
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;

                selectedCategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(
          title,
          style: GoogleFonts.mPlusCodeLatin(),
        ),
      ],
    );
  }
}
