
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app/db/category/category_db.dart';
import 'package:money_manage_app/db/tranctions/tranctions_db.dart';
import 'package:money_manage_app/models/category/category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/tranctions/tranctions_model.dart';

class ScreenTranctions extends StatelessWidget {
  const ScreenTranctions({super.key});

  

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDb.instance.refreshUI();
    
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.tranctionListNotifier, 
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget?_) {
        //Message to add tran when the list is empty
         if (newList.isEmpty) {
          return Center(
            child: Text(
              'Hit ➕ to add a new transaction',
              style: GoogleFonts.mPlusCodeLatin(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
          );
        }
        return  ListView.separated(
      padding: const EdgeInsets.all(10),
      //All the values comes here so change it
      itemBuilder: (ctx, index) {
        final _value = newList[index];
        return Slidable(
          key: Key(_value.id!),
          startActionPane: ActionPane(
            motion: StretchMotion(), 
            children: [
              SlidableAction(onPressed: (ctx) {
                TransactionDB.instance.deleteTranction(_value.id!);
              },
              icon: FontAwesomeIcons.trashCan,
              label: 'Delete',
              backgroundColor: const Color.fromARGB(255, 252, 114, 114),
              ),
            
            ],
            
          ),
          child: Card(
            elevation: 0,
            child: ListTile( 
              leading: CircleAvatar(
                radius: 50,
                // backgroundColor: _value.type == CategoryType.income ? Colors.greenAccent : Colors.redAccent,
                backgroundImage: _value.type == CategoryType.income ? const NetworkImage('https://img.freepik.com/free-vector/indian-rupee-investment-concept_23-2148005752.jpg?w=740&t=st=1688798489~exp=1688799089~hmac=583bbf96ca3e71cf02685529c3f34f4a98cda654e46b7d7d090d7d1da0edca8b') :const NetworkImage('https://img.freepik.com/free-vector/vector-illustration-retro-style-hand-giving-money-other-hand_1284-42589.jpg?w=740&t=st=1688798554~exp=1688799154~hmac=33d85602d7fc54ac92af79e530ca29bfafb1b4fba33872524ee90616ea8c77f1'),
                child: Text(
                  parseDate(_value.date),
                  style: GoogleFonts.mPlusCodeLatin(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                   
                  ),
                  textAlign: TextAlign.center,
                  
                ),
              ),
              title: Text(
                '₹${_value.amount} ',
                style: GoogleFonts.mPlusCodeLatin(),
              ),
              subtitle: Text(
                _value.category.name,
                style: GoogleFonts.mPlusCodeLatin(),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: newList.length,
    );
      },);
  }

  String parseDate(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' '); 
     return '${_splitedDate.last}\n${_splitedDate.first}';
  }
}
