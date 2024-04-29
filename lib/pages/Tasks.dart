import 'package:flutter/material.dart';
import 'package:testapp/widgets/drawer_widget.dart';

import '../dataBase/dataBase.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}): super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List todoList = [];
  String singlevalue = "";
  final DatabaseHelper _db = DatabaseHelper.instance;
  List<Map<String, dynamic>> _Task=[];

  final textcontroller = TextEditingController();

  @override
  void initState(){
    super.initState();
    populateTask();
  }

  addString(content) {
    setState(() {
      singlevalue = content;
    });
  }

  Future<void> populateTask() async{
    final taskItems = await _db.getAllTaskItems();
    setState(() {
      _Task = taskItems;
    });
  }

  Future<void> _addItem(String taskItemName) async {
    if (taskItemName.isNotEmpty){
      await _db.insertTaskItem(taskItemName);
      populateTask();
    }
  }

  Future<void> _deleteItem(int id) async{
    await _db.deleteTaskItem(id);
    populateTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const MyDrawer(

      ),
      appBar: AppBar(
        title: Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                  itemCount: _Task.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[300],
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 80,
                                child: Text(
                                  _Task[index]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 20,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: TextButton(
                                      onPressed: () {
                                        _deleteItem(_Task[index]['id']);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          controller: textcontroller,
                          onChanged: (content) {
                            addString(content);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Colors.blue[300],
                              filled: true,
                              labelText: 'Add a Task....',
                              labelStyle: TextStyle(
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 5,
                        )),
                    Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            _addItem(textcontroller.text);
                            textcontroller.clear();
                          },
                          child: Container(
                              height: 25,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("Add")),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}