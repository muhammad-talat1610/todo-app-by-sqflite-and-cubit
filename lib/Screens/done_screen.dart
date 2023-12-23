

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc&cubit/cubit.dart';
import '../bloc&cubit/states.dart';
import '../component/myWidgets.dart';
class DoneScreen extends StatelessWidget {
  // final List<Map> tasks ; TaskScreen({required this.tasks});
  Widget build(BuildContext context) {
    // مش هينفع ابدأ ب Scaffold
    // لأني بستدعي الكلام دا ف body بتاع ال to do list فمش محتاج  الشاشه كامله Scafold() ف حاجه تاني ..
    return BlocConsumer<AppCubit , AppState>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).donetasks;
        return ListView.separated(
          itemBuilder:(context, index)//=>buildTaskItem(tasks[index], context),
          { //print('task status ${tasks[index]}');
          return  buildTaskItem(tasks[index], context);},
          separatorBuilder:(context, index) => Padding(padding: const EdgeInsets.all(8.0),
                child: Container(width: double.infinity, height: 2.0, color: Colors.blue,),),
          itemCount: tasks.length,);},
    );

  }}
