
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:h/model/model.dart';
import 'package:h/screens/list_student.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(),
        home: ListStudentWidget(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}