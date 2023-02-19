import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3/dtos/examDto.dart';

class AddExamModal extends StatefulWidget {
  final Function addNewExam;
  
  const AddExamModal({Key? key, required this.addNewExam}) : super(key: key);

  @override
  State<AddExamModal> createState() => _AddExamModalState();
}

class _AddExamModalState extends State<AddExamModal> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  late String subjectName;
  late TimeOfDay time;
  late DateTime date;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add new exam"),
      content: Padding(
        padding: EdgeInsets.all(5),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Name of subject"
                    ),
                    validator: (value){
                      if(value == null || value.trim() == "")
                      {
                        return "Please enter the name of the subject";
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        subjectName = value ?? "";
                      });
                    },
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.indigo
                    ),
                    readOnly: true,
                    controller: dateController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today, color: Colors.indigo,), //icon of text field
                        labelText: "Date of exam",
                        focusColor: Colors.indigo,
                    ),
                    validator: (value){
                      if(value == null || value.trim() == "")
                      {
                        return "Please enter the date of the exam";
                      }
                    },
                    onTap:  () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.indigo, // <-- SEE HERE
                                  onPrimary: Colors.white, // <-- SEE HERE
                                  onSurface: Colors.indigo, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.indigo, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );

                      if(pickedDate != null){
                        String formattedDate = DateFormat("dd-mm-yyyy").format(pickedDate);

                        setState(() {
                          date = pickedDate;
                          dateController.text = formattedDate.toString();
                        });
                      }
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: timeController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.access_time_rounded, color: Colors.indigo,), //icon of text field
                        labelText: "Time",
                        focusColor: Colors.indigo,
                    ),
                    validator: (value){
                      if(value == null || value.trim() == "")
                      {
                        return "Please enter the time of the exam";
                      }
                    },
                    onTap:  () async {
                      var pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.indigo, // <-- SEE HERE
                                  onPrimary: Colors.white, // <-- SEE HERE
                                  onSurface: Colors.indigo, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.indigo, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );

                      if(pickedTime != null){
                        setState(() {
                          time = pickedTime;
                          timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                        });
                      }
                    }
                  ),
                ],
              )),
          ),
        ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel', style: TextStyle(
            color: Colors.indigo
          ),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.indigo,
            // textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Add'),
          onPressed: () {
            final form = _formKey.currentState;

            if(form != null && form.validate())
            {
              form.save();
              this.widget.addNewExam(new ExamDto(subjectName, date, time));
              Navigator.of(context).pop();
            }
          },
        ),
      ]
    );
  }
}
