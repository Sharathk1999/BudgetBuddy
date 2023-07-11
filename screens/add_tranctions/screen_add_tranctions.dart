import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manage_app/db/category/category_db.dart';
import 'package:money_manage_app/db/tranctions/tranctions_db.dart';
import 'package:money_manage_app/models/category/category.dart';
import 'package:money_manage_app/models/tranctions/tranctions_model.dart';

class ScreenaddTranction extends StatefulWidget {
  static const routeName = 'add-tranction';
  const ScreenaddTranction({super.key});

  @override
  State<ScreenaddTranction> createState() => _ScreenaddTranctionState();
}

class _ScreenaddTranctionState extends State<ScreenaddTranction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;

    super.initState();
  }

  /*
    Purpose
    Date
    Amount
    Income/Expence
    CategoryType 
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Purpose
                TextFormField(
                  controller: _purposeTextEditingController,
                  decoration: InputDecoration(
                      hintText: 'Purpose',
                      hintStyle: GoogleFonts.mPlusCodeLatin(),
                      // labelText: 'Enter purpose',
                      labelStyle: GoogleFonts.mPlusCodeLatin(),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER A PURPOSE';
                    } else {
                      return null;
                    }
                  },
                ),
            
                SizedBox(
                  height: 10,
                ),
                //Amount
                TextFormField(
                  controller: _amountTextEditingController,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      hintStyle: GoogleFonts.mPlusCodeLatin(),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER AN AMOUNT';
                    } else {
                      return null;
                    }
                  },
                ),
                //Date
            
                TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());
                    if (_selectedDateTemp == null) {
                      return;
                    } else {
                      // print(_selectedDateTemp.toString());
                      setState(() {
                        _selectedDate = _selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.calendarDays,color: Colors.black,),
                  label: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : _selectedDate.toString(),
                    style: GoogleFonts.mPlusCodeLatin(),
                  ),
                ),
            
                //Income or Expence
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.income;
                                _categoryID = null;
                              });
                            }),
                        Text(
                          'Income',
                          style: GoogleFonts.mPlusCodeLatin(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.expenxe,
                            groupValue: _selectedCategoryType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryType = CategoryType.expenxe;
                                _categoryID = null;
                              });
                            }),
                        Text(
                          'Expence',
                          style: GoogleFonts.mPlusCodeLatin(),
                        ),
                      ],
                    ),
                  ],
                ),
                //Categorytype
                Container(
                  width: 150,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue.shade100,
              // border: Border.all()
              ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _categoryID,
                      icon:const Icon(FontAwesomeIcons.caretDown,size: 16,),
                      
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          'Select Category',
                          style: GoogleFonts.mPlusCodeLatin(),
                        ),
                      ),
                      items: (_selectedCategoryType == CategoryType.income
                              ? CategoryDb().incomeCategoryListListener
                              : CategoryDb().expenceCategoryListListener)
                          .value
                          .map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name),
                          onTap: () {
                            _selectedCategoryModel = e;
                          },
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        // print(selectedValue);
                        setState(() {
                          _categoryID = selectedValue;
                        });
                      },
                    ),
                  ),
                ),
                //Submit
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        addTranction();
                      });
                    } else {
                      // print('Data Empty');
                    }
                  },
                  icon:const Icon(Icons.check,color: Colors.black,),
                  label: Text(
                    'Submit',
                    style: GoogleFonts.mPlusCodeLatin(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> addTranction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    // if (_categoryID == null) {
    //   return;
    // }

    if (_selectedCategoryModel == null) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }

    final _paresedAmount = double.tryParse(_amountText);
    if (_paresedAmount == null) {
      return;
    }

    //_seletedDate
    //_selectedCategory
    //_categoryID

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _paresedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
