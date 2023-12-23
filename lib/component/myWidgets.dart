import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../bloc&cubit/cubit.dart';



Widget defaultTextFromField({
  // for email and password button
  required TextEditingController controller,
  required TextInputType typeOfText,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  bool isPassword = false,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(

      controller: controller,
      keyboardType: typeOfText,
      obscureText: isPassword,
      onFieldSubmitted: (s) {onSubmit!(s);},
      onChanged: (s) {onChange!(s);},
      onTap: () {onTap!();},
      validator: (String? value) {
        if (value!.isEmpty) {
          print('The Time Of Task Must Not Be Empty');
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Widget buildTaskItem(Map model,
    context) => Dismissible(
  // model is just name
  key: Key(model['id'].toString()),
  child: Padding(
    //for Task time
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        // ThemeData.dark()=>AA.isdark ? ThemeMode.dark : ThemeMode.light;
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1, // in case (dark & light)
                  // TextStyle(
                  //     fontSize: 18.5,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.grey),
                ),
                Text(
                  '${model['date']}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2, // in case (dark & light)
                  //TextStyle(color: Colors.grey),
                ),
              ],
            )),
        IconButton(
            onPressed: () {
           AppCubit.get(context)
                  .updateDataBase(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box,
                color: Colors
                    .lightBlueAccent)),
        IconButton(
            icon: Icon(
              Icons.archive_outlined,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              AppCubit.get(context).updateDataBase(
                  status: 'archive',
                  id: model[
                  'id']);
            }),
      ],
    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteDataBase(id: model['id']);
  },
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
      itemBuilder: (context, index) {
        return buildTaskItem(tasks[index], context);
      },
      separatorBuilder: (context, index) => Container(),
      itemCount: tasks.length), fallback: (BuildContext context){ return Container() ; },
);


