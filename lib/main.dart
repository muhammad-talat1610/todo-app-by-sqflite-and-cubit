import 'package:coders/sqfliteDatabase/dataBaseScreen.dart';
import 'package:coders/sqfliteDatabase/task_home_screen.dart';
import 'package:dio_helper_flutter/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'bloc&cubit/cubit.dart';
import 'bloc&cubit/states.dart';
import 'component/themes.dart';


main(){
  runApp(myApp());
   new myApp();
DioHelper;

}

class myApp extends StatefulWidget{
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
   // getDataFromDatabase(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
create: (context) => AppCubit()..createDatabase(),
child: BlocConsumer<AppCubit, AppState>(
listener: (context, state) {},
builder: (context, state) {
  AppCubit cubitVariable = AppCubit.get(context);
return MaterialApp(
debugShowCheckedModeBanner: false,
home: taskScreens(),
theme:cubitVariable.isdark?AppThemes.lightTheme():AppThemes.darkTheme(),
);}));} }