import 'dart:io';

import 'package:database_sa/model/student.dart';
import 'package:database_sa/screen/add_student.dart';
import 'package:database_sa/screen/edit_student.dart';
import 'package:database_sa/screen/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text('Student Data');
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 40, 40),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 41, 40, 40),
        title: myField,
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (myIcon.icon == Icons.search) {
                    myIcon = const Icon(Icons.clear);
                    myField = TextField(
                      onChanged: (value) {
                        setState(() {});
                        searchInput = value;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Search ',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    );
                  } else {
                    setState(() {
                      searchInput = '';
                    });
                    myIcon = const Icon(Icons.search);
                    myField = const Text('Students Data');
                  }
                });
              },
              icon: myIcon),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Student>('student').listenable(),
        builder: (context, Box<Student> value, child) {
          List keys = value.keys.toList();
          if (keys.isEmpty) {
            return const Center(
              child: Text(
                'List is empty',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 182, 182, 182),
                ),
              ),
            );
          } else {
            List<Student> data = value.values
                .toList()
                .where(
                  (element) => element.name.toUpperCase().contains(
                        searchInput.toUpperCase(),
                      ),
                )
                .toList();
            if (data.isEmpty) {
              return const Center(
                child: Text(
                  'Sorry, no results found ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 182, 182, 182),
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                //Student? data = value.getAt(index);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  child: ListTile(
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentView(obj: data, index: index),
                            ),
                          ),
                      tileColor: const Color.fromARGB(255, 110, 111, 108),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: Text(
                        data[index].name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      leading: data[index].imagepath == null
                          ? const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 63, 61, 61),
                              radius: 28,
                              child: CircleAvatar(
                                // backgroundImage: AssetImage(
                                //     'assets/image/d9569bbed4393e2ceb1af7ba64fdf86a.jpg'),
                                backgroundColor:
                                    Color.fromARGB(255, 96, 137, 97),
                                radius: 25,
                              ),
                            )
                          : CircleAvatar(
                              child: ClipOval(
                                child: Image.file(
                                  File(data[index].imagepath),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditStudent(obj: data, index: index),
                              ),
                            ),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Are you sure? '),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () {
                                              data[index].delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes'))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )),
                );
              },

              itemCount: data.length,
              // separatorBuilder: Divider(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudent()),
          );
        },
      ),
    );
  }
}
