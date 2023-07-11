import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTips extends StatelessWidget {
  final List<String> imageUrls = [
    'https://i.pinimg.com/736x/f4/92/9a/f4929a8d7730414e60333ec88f8a6c8d.jpg',
    'https://www.clevergirlfinance.com/wp-content/uploads/2020/07/Manage-your-money-infographic-1-576x1024.jpg',
    'https://www.ourcuonline.org/files/ourcu22/1/image/CU%20Pictures/CollegeMoneyManagementTips.jpg',
    'https://callhallfirst.com/wp-content/uploads/2020/05/Infographic-4-Easy-Money-Management-Tips-.png',
    'https://www.sbsfin.com/wp-content/uploads/2017/07/january-infographic.jpg',
  ];

   ScreenTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddy Tips',style: GoogleFonts.mPlusCodeLatin(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(50.0),
            child: Card(
              child: Image.network(
                imageUrls[index],
                width:300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
