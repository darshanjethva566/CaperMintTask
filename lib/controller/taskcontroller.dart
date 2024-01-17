import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/taskmodel.dart';

class TaskController extends GetxController{
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> des = TextEditingController().obs;
  Rx<DateTime> initial_DOB = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;
  var cat  =  ''.obs;
  var date  =  ''.obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;

  gettaskList ()async{
    final get =  await SharedPreferences.getInstance();
    var lst =  get.getString('savedtask');
    if(lst!=null) {
      List<Map<String, dynamic>> serializedList = List<Map<String, dynamic>>.from(json.decode(lst));


      List<TaskModel> mylist = serializedList.map((map) =>
          TaskModel.fromJson(map)).toList();
      tasks.value = mylist;
      print("Shar list:${mylist}");
    }

  }

  updatetask()async{

    final shar =  await SharedPreferences.getInstance();

    List<Map<String, dynamic>> serializedList = tasks.map((data) => data.toJson()).toList();


    String jsonString = json.encode(serializedList);

    shar.setString('savedtask', jsonString);
    gettaskList();
  }
  @override
  void onInit() {
    gettaskList();
    // TODO: implement onInit
    super.onInit();
  }

}