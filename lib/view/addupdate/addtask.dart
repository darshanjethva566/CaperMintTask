import 'package:animate_do/animate_do.dart';
import 'package:capermint_task/controller/taskcontroller.dart';
import 'package:capermint_task/view/global_things/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/taskmodel.dart';
import '../global_things/spacer.dart';

class AddUpdateTask extends StatefulWidget {

bool update;
int index;

AddUpdateTask({super.key, required this.update,required this.index});

  @override
  State<AddUpdateTask> createState() => _AddUpdateTaskState();
}

class _AddUpdateTaskState extends State<AddUpdateTask> {
  // homepage.initial_DOB.value =
  // new DateFormat("dd MMMM, yyyy").parse(homepage.dob.value);
  getdata(){
    get.date.value = get.tasks[widget.index].date!;
    get.initial_DOB.value =
        DateFormat("dd MMMM, yyyy").parse(get.date.value);
    get.cat.value = get.tasks[widget.index].cat!;
    get.title.value.text = get.tasks[widget.index].title!;
    get.des.value.text = get.tasks[widget.index].description!;

  }
  final key = GlobalKey<FormState>();
  final get =  Get.find<TaskController>();
  List categories = [
    "StudySession",
        "CricketPractice",
        "ShoppingSpree",
        "GamingNight",
        "CoffeeBreak",
        "MovieMarathon",
        "LunchOuting",
        "ReadingSession",
        "FitnessWorkout",
        "DinnerParty",
        "MusicJam",
        "StudyGroup",
        "SnackTime",
        "VideoGames",
        "HikingAdventure"
  ];
  clearVal(){
    get.des.value.clear();
    get.title.value.clear();
    get.date.value = '';
    get.cat.value = '';
  }
  @override
  void dispose() {

    clearVal();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    widget.update?  getdata():null;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,title: TextWid(color: Colors.white,txt: widget.update?"Update your task":"Add your task",fontWeight: FontWeight.w600,size: 18,),
      leading: IconButton(onPressed: () {
        Get.back();
      },icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white),)),
      backgroundColor: Colors.black,
      body:Obx(() =>  SingleChildScrollView(
        child: Form(
          key: key,
          child: FadeInUp(duration: const Duration(seconds: 2),child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWid(txt: "   Your Task ", color: Colors.black, fontWeight: FontWeight.w500, size: 20),
                    CustomSpacer(value: 20, height: true),

                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Container(
                                  height: 54.h,
                                  width: 1.sw,
                                  color:Colors.black,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:  EdgeInsets.only(left: 16.0.w),
                                        child:TextWid(color: Colors.white,size: 16,fontWeight: FontWeight.w600,txt: "Select Category",)
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          get.cat.value = categories[index];
                                          Get.back();
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(4, 16, 4, 16),
                                              child: Text(
                                                "   ${categories[index]}",
                                                style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            Container(
                                              height: 0.2,
                                              width: 1.sw,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 52.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)
                        ),
                        child: Center(child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [

                              const Icon(Icons.arrow_drop_down,color: Colors.white,),
                              CustomSpacer(height: false,value: 10),

                              TextWid(txt: get.cat.value.isEmpty?"Select Category":get.cat.value,color:Colors.white,fontWeight: FontWeight.w500,size: 14),
                              const Spacer(),
                              const Icon(Icons.category,color: Colors.white,)
                            ],
                          ),
                        )),
                      ),
                    ),
                    CustomSpacer(value: 10, height: true),
                    GestureDetector(
                      onTap: () async{
                        await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate:  get.initial_DOB.value,
                          firstDate: DateTime.now(),

                          dateFormat: "dd MMMM, yyyy",
                          backgroundColor: Colors.white,
                          itemTextStyle: const TextStyle(
                              color: Colors.black, fontFamily: "Poppins"),
                          textColor: Colors.black,
                        ).then((value) {
                          if (value != null) {
                            get.initial_DOB.value = value;
                            get.date.value =
                                DateFormat('dd MMMM, yyyy').format(value);
                          }
                        });
                      },
                      child: Container(
                        height: 52.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white)
                        ),
                        child: Center(child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [

                              const Icon(Icons.arrow_drop_down,color: Colors.white,),
                              CustomSpacer(height: false,value: 10),

                              TextWid(txt:get.date.value.isEmpty? "Select Date":get.date.value,color:Colors.white,fontWeight: FontWeight.w500,size: 14),
                              const Spacer(),
                              const Icon(Icons.date_range,color: Colors.white,)
                            ],
                          ),
                        )),
                      ),
                    ),
                    CustomSpacer(value: 10, height: true),

                    SizedBox(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,

                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please enter title';
                          }
                          return null;
                        },
                        controller:  get.title.value,
                        style: const TextStyle(color: Colors.white,fontSize: 16),
                        decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            prefixIcon: const Icon(Icons.title,color: Colors.white),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ) ,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            hintText: "Enter Title",
                            hintStyle: const TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    CustomSpacer(value: 10, height: true),

                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      textInputAction: TextInputAction.done,


                      textCapitalization: TextCapitalization.words,
                      controller:  get.des.value,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Please enter description';
                        }
                        return null;
                      },
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white,fontSize: 16),
                      decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          //  prefixIcon: Icon(Icons.title,color: Colors.white),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ) ,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: "Description",
                          hintStyle: const TextStyle(color: Colors.white)
                      ),
                    ),
                    CustomSpacer(value: 10, height: true),

                    Row(
                      children: [
                        ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),onPressed: () {
                          clearVal();
                          Get.back();
                        }, child: TextWid(color: Colors.white,size: 14,fontWeight: FontWeight.w500,txt: "Cancel",)),
                        CustomSpacer(value: 10, height: false),

                        ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),onPressed: () {
                          if(get.cat.value.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select category")));

                          }
                          else if(get.date.value.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select date")));
                          }
                          else if(key.currentState!.validate()){
                            widget.update?null:  get.tasks.add(TaskModel(title: get.title.value.text,task: false,cat: get.cat.value,date: get.date.value,description: get.des.value.text));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( widget.update?"Task Updated Successfully":"Task Added Successfully")));

                            get.updatetask();
                            Get.back();

                          }
                        }, child: TextWid(color: Colors.white,size: 14,fontWeight: FontWeight.w500,txt: "Save",)),
                      ],
                    )

                  ],
                ),
              ),
            ),
          )),
        ),
      )),
    );
  }
}
