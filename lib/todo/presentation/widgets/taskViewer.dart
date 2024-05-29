// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'taskServices.dart';

class TaskViewer extends StatefulWidget {
  final String title;
  final String description;
  final String formattedDate;
  final bool completed;
  const TaskViewer({
    super.key,
    required this.title,
    required this.description,
    required this.formattedDate,
    required this.completed,
  });

  @override
  State<TaskViewer> createState() => _TaskViewerState();
}

class _TaskViewerState extends State<TaskViewer> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late bool readOnly = true;
  final TaskServices taskServices = TaskServices();
  late bool completed = widget.completed;

  @override
  void initState() {
    completed = widget.completed;
    readOnly = true;
    _descriptionController.text = widget.description;
    _titleController.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Viewer'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.grey.withOpacity(0.2),
                    Colors.white.withOpacity(0.3)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // boxShadow: const [
                //   BoxShadow(
                //     color: Colors.amber,
                //     blurRadius: 1,
                //     spreadRadius: 1,
                //     offset: Offset(0, 0),
                //   )
                // ],
                border: const Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  // left: BorderSide(
                  //   color: Colors.white,
                  //   width: 2,
                  // ),
                  bottom: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                  right: BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    enabled: !readOnly,
                    readOnly: readOnly,
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      labelText: 'Title',
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    enabled: !readOnly,
                    readOnly: readOnly,
                    maxLines: null,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      labelText: 'Description',
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        thickness: 2,
                        height: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.all(10),
                        // padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple.withOpacity(0.3),
                        ),
                        child: readOnly
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Iconbutton(
                                    icon: completed
                                        ? const Icon(Icons
                                            .check_box_outline_blank_rounded)
                                        : const Icon(Icons.check_box_outlined),
                                    onTap: markTask,
                                  ),
                                  VerticalDivider(
                                    endIndent: 10,
                                    indent: 10,
                                    thickness: 2,
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  Iconbutton(
                                    icon: const Icon(Icons.edit_note_rounded),
                                    onTap: editMode,
                                  ),
                                  VerticalDivider(
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 2,
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  Iconbutton(
                                      icon: const Icon(Icons.delete),
                                      onTap: deleteTask),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: updateTask,
                                child: const Text(
                                  'Save Task',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editMode() {
    setState(() {
      readOnly = false;
    });
  }

  void deleteTask() {
    taskServices.deleteTask(widget.formattedDate, context);
    Fluttertoast.showToast(
      msg: 'Task Deleted',
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.secondary,
    );
    Navigator.pop(context);
  }

  void markTask() {
    setState(() {
      completed = !completed;
    });
    taskServices.markTask(widget.formattedDate, !widget.completed, context);
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: completed ? 'Task Marked Incomplete' : 'Task Marked Completed',
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.secondary,
    );
  }

  void updateTask() {
    setState(() {
      readOnly = true;
    });
    taskServices.updateTask(_titleController.text, _descriptionController.text,
        widget.formattedDate, widget.completed, context);
    Fluttertoast.showToast(
      msg: 'Task Updated',
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.secondary,
    );
  }
}

class Iconbutton extends StatefulWidget {
  final Icon icon;
  final void Function()? onTap;
  const Iconbutton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  State<Iconbutton> createState() => _IconbuttonState();
}

class _IconbuttonState extends State<Iconbutton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        iconSize: WidgetStateProperty.all(30),
        elevation: WidgetStateProperty.all(10),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: widget.onTap,
      icon: widget.icon,
      color: Colors.black,
    );
  }
}
