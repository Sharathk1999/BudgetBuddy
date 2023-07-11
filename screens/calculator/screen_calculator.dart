import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double? _currentValue = 0;

  void copyResultToClipboard() {
    Clipboard.setData(ClipboardData(text: _currentValue.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Result copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
      },
      theme: CalculatorThemeData(
        borderColor: const Color.fromARGB(255, 225, 219, 219),
        borderWidth: 2,
        displayColor: const Color.fromARGB(255, 229, 224, 224),
        displayStyle: GoogleFonts.mPlusCodeLatin(fontSize: 80, color: const Color.fromARGB(255, 3, 3, 3)),
        expressionColor: Colors.blueAccent,
        expressionStyle: GoogleFonts.mPlusCodeLatin(fontSize: 20, color: Colors.white),
        operatorColor: const Color.fromARGB(255, 137, 177, 247),
        operatorStyle: GoogleFonts.mPlusCodeLatin(fontSize: 30, color: Colors.white),
        commandColor: const Color.fromARGB(255, 137, 177, 247),
        commandStyle: GoogleFonts.mPlusCodeLatin(fontSize: 30, color: Colors.white),
        numColor: Colors.black26,
        numStyle: GoogleFonts.mPlusCodeLatin(fontSize: 50, color: Colors.white),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: GoogleFonts.mPlusCodeLatin(),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Open Calculator',
            style: GoogleFonts.mPlusCodeLatin(),
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    children: [
                      Expanded(child: calc),
                      ElevatedButton(
                        onPressed: copyResultToClipboard,
                        child: Text('Copy Result'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
