import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc&cubit/cubit.dart';
import '../bloc&cubit/states.dart';
import '../component/myWidgets.dart';

class TaskScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;
        print('Tasks length: ${tasks.length}'); // Check tasks length
        return tasks.isEmpty
            ? Center(child: Text("No Tasks available", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey)))
            : ListView.separated(
          itemBuilder: (context, index) {
            if (tasks[index]['status'] == 'new') {
              return buildTaskItem(tasks[index], context);
            }
            return SizedBox();
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: double.infinity, height: 2.0, color: Colors.blue,),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
