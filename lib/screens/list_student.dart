import 'dart:io';
import 'package:h/function/function.dart';
import 'package:h/model/model.dart';
import 'package:h/screens/add_student.dart';
import 'package:h/screens/edit.dart';
import 'package:h/screens/screen.dart';


import 'package:flutter/material.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  // --------------------------------
  String _search = '';
  List<StudentModel> searchedlist = [];
  List<StudentModel> studentList = [];
  // ---------------------------------------------
  loadstudent() async {
    final allstudents = await getAllStudents();
    studentListNotifier.value = allstudents;
  }

  @override
  void initState() {
    super.initState();
    searchResult();
    loadstudent();
  }

  void searchResult() {
    setState(() {
      searchedlist = studentListNotifier.value
          .where((StudentModel) =>
              StudentModel.name.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }

  // --------------------------------------

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
      appBar: AppBar(
         flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                Color.fromARGB(255, 0, 11, 46),
                 Colors.red ,
                ]
                )
            ),
          ),
        title: Center(
          child: Text('𝕾 𝖙 𝖚 𝖉 𝖊 𝖓 𝖙 𝕷 𝖎 𝖘 𝖙'),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddStudentWidget()));
              },
              icon: Icon(Icons.group_add_rounded,color: Colors.black,))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/istockphoto-1257005098-170667a.webp'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(75),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  // ----------------------
                  setState(() {
                    _search = value;
                  });
                  searchResult();

                  // ---------------------
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (BuildContext ctx, List<StudentModel> studentList,
                    Widget? child) {
                  final displayedStudents =
                      searchedlist.isNotEmpty ? searchedlist : studentList;
                  return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final data = displayedStudents[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewStudentScreen(
                                    name: data.name,
                                    age: data.age,
                                    phone: data.edu,
                                    place: data.address,
                                    imagePath: data.image ?? "",
                                  ),
                                ),
                              );
                            },
                            textColor: Colors.white,
                            title: Text(data.name),
                            subtitle: Text(data.age),
                            leading: CircleAvatar(
                                backgroundImage: data.image != null
                                    ? FileImage(File(data.image!))
                                    : AssetImage("assets/gk.jpeg")
                                        as ImageProvider),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditStudent(
                                            index: index,
                                            name: data.name,
                                            age: data.age,
                                            edu: data.edu,
                                            address: data.address,
                                            imagePath: data.image),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteStudent(index);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 255, 17, 0))),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: displayedStudents.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
