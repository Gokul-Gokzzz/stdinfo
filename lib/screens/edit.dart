import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h/function/function.dart';
import 'package:h/model/model.dart';
import 'package:h/screens/list_student.dart';
import 'package:image_picker/image_picker.dart';

class EditStudent extends StatefulWidget {
  var name;
  var age;
  var edu;
  var address;
  int index;
  dynamic imagePath;

  EditStudent({
    required this.index,
    required this.name,
    required this.age,
    required this.edu,
    required this.address,
    required this.imagePath,
  });

  @override
  State<EditStudent> createState() => _edit_studentState();
}

class _edit_studentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _eduController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _eduController = TextEditingController(text: widget.edu);
    _addressController = TextEditingController(text: widget.address);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
         flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                     Colors.orangeAccent,
                ]
                )
            ),
          ),
        title: const Text("𝕰𝖉𝖎𝖙"),
        backgroundColor: Colors.black,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListStudentWidget()));
              },
              icon: const Icon(Icons.list,color: Colors.black,)),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/polygon-orange-abstract-4k-3l-640x960.jpg'),
                fit: BoxFit.cover)),
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage("assetsgk.jpeg") as ImageProvider,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY")),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("CAMERA")),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _eduController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Education',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLength: 10,
                        controller: _addressController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Address',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue),
                          onPressed: () {
                            updateall();
                          },
                          icon: const Icon(Icons.done),
                          label: const Text("Update")),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> updateall() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final edu = _eduController.text.trim();
    final address = _addressController.text.trim();
    final image = _selectedImage!.path;

    if (name.isEmpty ||
        age.isEmpty ||
        edu.isEmpty ||
        address.isEmpty ||
        image.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name, age: age, edu: edu, address: address, image: image);

      editstudent(widget.index, update);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));
    }
  }

  Future _pickImage(ImageSource source) async {
    final returnImage =
        await ImagePicker().pickImage(source: source);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  // _pickImageFromCam() async {
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);

  //   if (returnImage == null) {
  //     return;
  //   }

  //   setState(() {
  //     _selectedImage = File(returnImage.path);
  //   });
  // }
}
