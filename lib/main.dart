import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:splitwise/core/constants.dart';
import 'package:splitwise/model/group_model.dart';
import 'package:splitwise/model/participant_model.dart';
import 'package:splitwise/screens/home_screen.dart';

Future<void> main(List<String> args) async{
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(ParticipantModelAdapter().typeId)){
    Hive.registerAdapter(ParticipantModelAdapter());
  }
  if(!Hive.isAdapterRegistered(GroupModelAdapter().typeId)){
    Hive.registerAdapter(GroupModelAdapter());
  }

  await Hive.openBox<ParticipantModel>('participants');
  await Hive.openBox<GroupModel>('groups');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splitwise',
      theme: ThemeData(primaryColor:themeColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(splashColor: cyanColor,backgroundColor: themeColor
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: themeColor

      )),
      home:  HomeScreen(),

    );
  }
}