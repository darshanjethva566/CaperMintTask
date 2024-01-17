
import 'package:animate_do/animate_do.dart';
import 'package:capermint_task/controller/taskcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'addtask.dart';
import '../global_things/appbar.dart';

class AddedTask extends StatefulWidget {
  const AddedTask({Key? key}) : super(key: key);

  @override
  State<AddedTask> createState() => _AddedTaskState();
}

class _AddedTaskState extends State<AddedTask> {
  final get = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextWid( txt: "Added Task",color:  Colors.white,fontWeight:  FontWeight.w600,size:  18),
        actions: [
          IconButton(onPressed: () {
            Get.to(AddUpdateTask(update: false,index: 0,));
          }, icon: const Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body:Obx(() => get.tasks.isEmpty?Center(child: TextWid(txt:"No task Available",color: Colors.white, fontWeight: FontWeight.w600, size: 16),):ListView.builder(itemCount: get.tasks.length,itemBuilder: (context, index) {
        return FadeInUp(duration: const Duration(seconds: 2),child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWid(txt: get.tasks[index].cat!, color: Colors.black, fontWeight: FontWeight.w400, size: 14)
                  ],
                ),
                Row(

                  children: [
                    Checkbox(value: get.tasks[index].task, onChanged: (value) {
                      get.tasks[index].task = get.tasks[index].task!?false:true;
                      get.updatetask();
                    },),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWid(txt: get.tasks[index].title!, color: Colors.black, fontWeight: FontWeight.w500, size: 18),
                        TextWid(txt:get.tasks[index].date!, color: Colors.black, fontWeight: FontWeight.w500, size: 14),
                      ],
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {
                      Get.to(AddUpdateTask(update: true,index: index,));

                    }, icon: const Icon(Icons.edit)) ,
                    IconButton(onPressed: () {
                      get.tasks.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text( "Deleted Successfully")));

                    }, icon: const Icon(Icons.delete_forever,color: Colors.red,))
                  ],
                ),

              ],
            ),
          ),
        ));
      },),)
    );
  }
}

