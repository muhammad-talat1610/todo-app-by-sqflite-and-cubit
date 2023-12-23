import 'package:bloc/bloc.dart';
import 'package:coders/bloc&cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../Screens/archive_screen.dart';
import '../Screens/done_screen.dart';
import '../Screens/tasks_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
// var tasks =AppCubit.get(context).tasks;
  int currentIndex = 0;
  List<Widget> screens = [
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  //  خلاصة القول في الكلاسات بداخل الاستيتس هو ان لو انا عملت ميثود هنا في الكيوبيت لازم يقابلها كلاس في الاستيتس عشان
  //  اعمله ايميت بداخل الميثود هنا زي ما حصل بداخل isBottomSheet و changeBNBar

  void changeBNBar(index) {
    // عملت ميثود تعمل نفس عمل ال(onTap(){})يعني اعطيتها (parameter) ورجعت ساويته با(CurrentIndex)
    // لما نيجي ننادي عليها هنادي جوة ال(onTap) كدا ((AppCubit.get(context).changeBNBar(index))
    currentIndex = index;
    emit(bottomNavBar());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void isBottomSheet({required IconData icon, required bool showIt}) {
    fabIcon = icon;
    isBottomSheetShown = showIt;
    emit(isBottomSheetDataBaseState());
  } // نحاول نعملها بالنا=تغيرات من غير ميثود ونشوف هلي هينفع كدا ولا لازم ميثود

  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('Database Created');
          emit(createDataBaseState());
        }).catchError((error) {
          print('Error in creating database is ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(createDataBaseState());
    });
  }

  // لا تخلط في اسماء المتغيرات كما فعلت انا فيtasks حيث كان لليست وللأسكرينات ودا كان سبب الايرور(اوبو 28 سطر بسبب database not intialise) والتي اعطيتها فيما بعد اسم screens
  insertToDatabase({
    //  context ,
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) async {
      //لما كنت بضغط علي الزرار + مكنش بيرضي يقفل علي الرغم من اني عامل النافيجيتور.بوب ولكن بسبب انه
      //ان الانسيرت مش قابله النال لأن الفيوتشر ليست لا تقبل النال فبالتالي عوضتها بوجود اسينك بعد } ((txn)((async)
      // طالما فيه اويت يبقي فيه اسينك
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted Successfully');
      }); // (( Future<T> , return await // دا عوضا عن .then((value) {
      emit(insertDataBaseState());
      // Navigator.pop(context);      // بشرط كتابه فوق في اقواس البارميتر للأنسيرت context
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error when inserting database is ${error.toString()}');
    });
  }

  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks =
        []; // انا ليه صفررت الليستات قبل الدخول ميضفش علي القديم انا عاوزه يأبديت
    archivedtasks = [];
    emit(databaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(
              element); //لو عملت value بدل element هيطلع ايرور من 10 اخطاء بسبب كدا
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivedtasks.add(element);
      });
      emit(
          getDataFromDataBaseState()); // لو معملتهاش  هيعملك مشكله لما تيجي تحول التاسك من النيو للضان والاركيف (التاسكات كلها هتختفي تاني )
    });
  }

  void updateDataBase({required String status, required int id}) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE  id = ? ',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(
          database); //    بعد ما تستدعي الكلام دا في الاخر هتعمل جيت
      // بعد ما خلصت اعمل جيت تاني
      emit(updateDataBaseState());
    });
  }

  void deleteDataBase({required int id}) async {
    database.rawUpdate(
      'DELETE From tasks WHERE  id = ? ',
      [id],
    ).then((value) {
      getDataFromDatabase(
          database); //    بعد ما تستدعي الكلام دا في الاخر هتعمل جيت
      // بعد ما خلصت اعمل جيت تاني
      emit(deleteDataBaseState());
    });
  }

  bool isdark = false;
   void changeAppMode() {
    isdark = !isdark;
    emit(changeApp());
  }
}
