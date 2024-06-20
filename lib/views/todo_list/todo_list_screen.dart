import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist_app/const/app_fonts.dart';

import '../../controller/todo_list_controller.dart';
import '../../model/todo_list_model.dart';
import 'edit_todo_screen.dart';
import 'todo_add_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  int activeIndex = 0;

  var textEditingController = TextEditingController();
  var descriptionController = TextEditingController();

  final taskController = Get.find<TodolistController>();

  bool ischeck = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ToDo - List',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    
                    ],
                  ),
                  ksizedBox30,
                  CarouselSlider(
                    options: CarouselOptions(
                      initialPage: 0,
                      height: 105.h,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                    items: [
                      Container(
                        height: 70.h,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          child: Stack(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hii , There',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Welcome Home\nYour Ultimae time management solution',
                                  style: primaryfonts.copyWith(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                            Positioned(
                                top: 10,
                                right: 0,
                                child: Icon(
                                  Icons.schedule_outlined,
                                  size: 70,
                                  color: Colors.white10,
                                ))
                          ]),
                        ),
                      ),
                      Container(
                        height: 70.h,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          child: Stack(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Text(
                                  'Effortlessly manage your todo list and take control of your day',
                                  style: primaryfonts.copyWith(
                                      fontSize: 13, color: Colors.white),
                                )
                              ],
                            ),
                            Positioned(
                                top: 10,
                                right: 0,
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 70,
                                  color: Colors.white10,
                                ))
                          ]),
                        ),
                      )
                    ],
                  ),
                  ksizedBox30,
                  Obx(() => taskController.taskList.isNotEmpty
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: taskController.taskList.length,
                          itemBuilder: (context, index) {
                            //  final task = taskController.taskList[index];
                            return Slidable(
                              
                                key:
                                    ValueKey(taskController.taskList[index].id),
                                startActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                     SlidableAction(
                                      
                                      onPressed: (context) {
                                         Get.to(() => EditTodoScreen(
                                          todoTaskModel: taskController.taskList[index]));
                                      },
                                      backgroundColor: Colors.blue.shade200,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                    
                                      onPressed: (context) {
                                        taskController.deleteTask(int.parse(
                                            taskController.taskList[index].id
                                                .toString()));
                                      },
                                      backgroundColor: Colors.red.shade400,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70.h,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white24,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() => Transform.scale(
                                                      scale: 1.5,
                                                      child: Checkbox(
                                                        shape: CircleBorder(),
                                                        value: taskController
                                                            .taskList[index]
                                                            .isCompleted,
                                                        onChanged:
                                                            (bool? value) {
                                                          taskController
                                                                  .taskList[index]
                                                                  .isCompleted =
                                                              value ?? false;
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  title: Column(
                                                                    children: [
                                                                      // Image.asset(
                                                                      //     'assets/images/exit.png'),
                                                                    ],
                                                                  ),
                                                                  content: taskController.taskList[index].isCompleted? Text(
                                                                      "Your Task is completed",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black)):Text(
                                                                      "Your Task is Not completed",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black)),
                                                                  actions: [
                                                                    ksizedBox10,
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                100,
                                                                            decoration: BoxDecoration(
                                                                                // ignore: unrelated_type_equality_checks
                                                                                color: Colors.white),
                                                                            child:
                                                                                Center(child: Text("Cancel", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            TodoTaskModel
                                                                                todoTaskModel =
                                                                                TodoTaskModel(
                                                                              id: DateTime.now().millisecondsSinceEpoch,
                                                                              title: taskController.taskList[index].title,
                                                                              description: taskController.taskList[index].description,
                                                                            );
                                                                            taskController.updateTask(todoTaskModel);
                                                                            taskController.loadTasks();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                backgroundColor: Colors.green[100],
                                                                                content: Text(
                                                                                  'Todo-Add updated successfully',
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                                duration: Duration(seconds: 2),
                                                                              ),
                                                                            );
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Center(
                                                                              child: Text("Update", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    ksizedBox10
                                                                  ],
                                                                );
                                                              });

                                                          taskController.updateTask(
                                                              taskController
                                                                      .taskList[
                                                                  index]);
                                                        },
                                                      ),
                                                    )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      taskController
                                                          .taskList[index]
                                                          .title,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp),
                                                    ),
                                                    Text(
                                                      taskController
                                                          .taskList[index]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ksizedBox20,
                                  ],
                                ));
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 300.h,
                            width: 250.w,
                            child: Lottie.asset(
                                'assets/images/nodata_animation.json',
                                fit: BoxFit.contain),
                          ),
                        )),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(TodoAddScreen());
        },
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration:
              BoxDecoration(color: Colors.red.shade300, shape: BoxShape.circle),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
