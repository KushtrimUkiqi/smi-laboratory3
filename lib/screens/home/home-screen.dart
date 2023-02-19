import 'package:flutter/material.dart';
import 'package:lab3/dtos/examDto.dart';
import './components/add-exam-modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExamDto> exams = [];

  void _addNewExam(exam){
    setState(() {
      exams.add(exam);
    });
  }

  void _deleteSubject(int idx)
  {
    if(idx < exams.length)
    {
     setState(() {
       exams.removeAt(idx);
     });
    }
  }

  Future<void> _addExamDialogOpen(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExamModal(addNewExam: (value){
          _addNewExam(value);

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(onPressed: () {
            _addExamDialogOpen(context);
          }, icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...exams.asMap().entries.map((e) =>
                Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              e.value.subject,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          IconButton(onPressed: () {
                            _deleteSubject(e.key);
                          }, icon: Icon(
                              Icons.delete,
                              color: Colors.indigo))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            e.value.getDateFormatted(),
                            style: TextStyle(
                              color: Colors.grey[700]
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                              e.value.getFormattedTime(),
                              style: TextStyle(
                                color: Colors.grey[700]
                          ))
                        ],
                      )
                    ]
                  ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}