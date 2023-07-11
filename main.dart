import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage_app/screens/add_tranctions/screen_add_tranctions.dart';
import 'package:money_manage_app/screens/splash/screen_splash.dart';

import 'models/category/category.dart';
import 'models/tranctions/tranctions_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId )){
      Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId )){
      Hive.registerAdapter(CategoryModelAdapter());
  }

   if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId )){
      Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const ScreenSplash(), //screenhome
      routes: {
        ScreenaddTranction.routeName: (ctx) =>const ScreenaddTranction(), 
      },
    );
  }
}

