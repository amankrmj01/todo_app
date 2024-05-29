// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widgets/taskServices.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  late Timestamp timestamp;
  late DateTime date;
  late String formattedDate;
  final TaskServices taskServices = TaskServices();

  @override
  void initState() {
    super.initState();
    timestamp = Timestamp.now();
    date = timestamp.toDate();
    formattedDate = DateFormat('ddMMyyHHmmss').format(date);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  addTask(BuildContext context) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondary,
      );
      return;
    }
    try {
      taskServices.addTask(_titleController.text, _descriptionController.text,
          formattedDate, false, context);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Task Added',
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    maxLength: 20,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                        ),
                        labelText: 'Title',
                        labelStyle: Theme.of(context).textTheme.headlineSmall),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLength: 120,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          addTask(context);
                        },
                        child: const Text(
                          'Save Task',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
