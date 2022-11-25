import 'dart:io';
import 'dart:core';

import 'package:database_sa/model/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<AddStudent> {
  var box = Hive.box<Student>('student');

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController placeController = TextEditingController();

  final TextEditingController qualificationcontroller = TextEditingController();

  XFile? image;
  String? imagepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        titleSpacing: 70,
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 81, 96, 104),
        title: const Text('Add Student'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  imagepath == null
                      ? const CircleAvatar(
                          radius: 102,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage(
                                'assets/image/d9569bbed4393e2ceb1af7ba64fdf86a.jpg'),
                          ),
                        )
                      : CircleAvatar(
                          radius: 102,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(
                              File(imagepath!),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      //minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color.fromARGB(255, 59, 61, 59),
                    ),
                    onPressed: () => getImage(source: ImageSource.gallery),
                    child: const Text(
                      'Select Image',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, wordSpacing: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      //minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color.fromARGB(255, 83, 88, 83),
                    ),
                    onPressed: () => getImage(source: ImageSource.camera),
                    child: const Text(
                      'Camera',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: placeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Place',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: qualificationcontroller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Qualification',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: const Color.fromARGB(255, 33, 36, 33),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      box.add(Student(
                          imagepath: imagepath,
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          place: placeController.text,
                          qualification: qualificationcontroller.text));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagepath = (image!.path);
      });
    } else {
      return null;
    }
  }
}
