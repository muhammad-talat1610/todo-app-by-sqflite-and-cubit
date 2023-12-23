import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
          fontSize: 17.0,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
          fontSize: 15.0,
        ),
      ),
      primarySwatch: Colors.deepOrange,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

 static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark, // تحديد الوضع الداكن
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, // لون النص الأساسي
          fontSize: 17.0,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.cyan, // لون النص الثانوي
          fontSize: 15.0,
        ),
      ),
      primarySwatch: Colors.deepOrange, // لون الثيم الرئيسي
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black, // لون شريط التطبيق
        iconTheme: IconThemeData(color: Colors.white), // لون الأيقونات
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black, // لون شريط الحالة في الأندرويد
          statusBarIconBrightness: Brightness.light, // لون أيقونات شريط الحالة
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // لون عنوان الشاشة
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange, // لون العنصر المحدد في شريط التنقل السفلي
        backgroundColor: Colors.black, // لون خلفية شريط التنقل السفلي
        type: BottomNavigationBarType.fixed,
      ),
      scaffoldBackgroundColor: Colors.black, // لون خلفية الـ Scaffold
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange, // لون زر الإضافة السريعة
      ),
    );
  }

}



