import 'dart:io';
import 'package:database_sa/model/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';

class EditStudent extends StatefulWidget {
  final box = Hive.box<Student>('student');
  final List<Student> obj;
  final int index;
  // final formKey = GlobalKey<FormState>();

  EditStudent({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  int? newKey;
  int? accessKey;
  XFile? image;
  String? imagePath;

  void details() {
    nameController.text = widget.obj[widget.index].name;
    ageController.text = widget.obj[widget.index].age.toString();
    placeController.text = widget.obj[widget.index].place;
    imagePath = widget.obj[widget.index].imagepath;
    qualificationController.text = widget.obj[widget.index].qualification;

    newKey = widget.obj[widget.index].key;
    List<Student> student = widget.box.values.toList();
    for (int i = 0; i < student.length; i++) {
      if (student[i].key == newKey) {
        accessKey = i;
        break;
      }
    }
  }

  @override
  void initState() {
    details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 55, 80, 94),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 36, 55, 65),
          title: const Text('Edit Student'),
          elevation: 8,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imagePath == null
                      ? const CircleAvatar(
                          radius: 105,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            // backgroundImage: AssetImage(
                            //     'assets/image/d9569bbed4393e2ceb1af7ba64fdf86a.jpg'),
                            backgroundColor: Color.fromARGB(255, 137, 158, 115),
                          ),
                        )
                      : CircleAvatar(
                          radius: 102,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(
                              File(imagePath!),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0)),
                        ),
                        onPressed: () => getImage(source: ImageSource.gallery),
                        child: const Text(
                          'Select New Image',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () => getImage(source: ImageSource.camera),
                        child: const Text(
                          'Take New Image',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: placeController,
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                    decoration: const InputDecoration(
                        labelText: 'Place',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: qualificationController,
                    style: const TextStyle(fontSize: 18, color: Colors.yellow),
                    decoration: const InputDecoration(
                        labelText: 'qualification',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        widget.box.putAt(
                            accessKey!,
                            Student(
                                imagepath: imagePath,
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                place: placeController.text,
                                qualification: qualificationController.text));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = (image!.path);
      });
    } else {
      return null;
    }
  }
}
