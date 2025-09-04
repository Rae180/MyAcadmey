import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';

import 'package:flutter/material.dart';

import '../data/Question.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
// ... other imports ...

// class Question {
//   final int? id;
//   final int? examId;
//   final String? value;
//   final String? choice1;
//   final String? choice2;
//   final String? choice3;
//   final int? correctChoice;
//
//   Question({
//     this.id,
//     this.examId,
//     this.value,
//     this.choice1,
//     this.choice2,
//     this.choice3,
//     this.correctChoice,
//   });
// }

class SolveExamStudent extends StatefulWidget {


  @override
  _SolveExamStudentState createState() => _SolveExamStudentState();
  final int id ;

  SolveExamStudent({required this.id});

}

class _SolveExamStudentState extends State<SolveExamStudent> {
  // List<Question> questions = [
  //   Question(
  //     id: 1,
  //     examId: 123,
  //     value: 'What is the capital of France?',
  //     choice1: 'Paris',
  //     choice2: 'Berlin',
  //     choice3: 'London',
  //     correctChoice: 1,
  //   ),
  //   Question(
  //     id: 2,
  //     examId: 123,
  //     value: 'What is the capital of France?',
  //     choice1: 'Paris',
  //     choice2: 'Berlin',
  //     choice3: 'London',
  //     correctChoice: 1,
  //   ),
  //   // Add more Question objects here
  // ];

  Map<int, int> selectedAnswers = {};


  void selectOption(int questionId, int optionIndex) {
    setState(() {
      selectedAnswers[questionId] = optionIndex;
    });
  }
ShowExamQuestionModel ?showExamQuestionModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseStudentCubit()..getQuestion(widget.id),
      child: BlocConsumer<CourseStudentCubit, CourseStudentStatus>(
        listener: (context, state) {
          if (state is ShowQuestionSuccessState)
            showExamQuestionModel=state.showExamQuestionModel;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'solve your exam',
                style: TextStyle(color: mainColor),
              ),
              backgroundColor: fillColorInTextFormField,
              iconTheme: IconThemeData(color: mainColor),
            ),
            body:showExamQuestionModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
              itemCount: showExamQuestionModel!.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Question ${showExamQuestionModel!.data![index].id}: ${showExamQuestionModel!.data![index].value}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                      for (int optionIndex = 0;
                      optionIndex < 3;
                      optionIndex++) // Assuming you have 3 choices
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, top: 10.h, right: 0, bottom: 0),
                          child: OptionButton(
                            questionId: showExamQuestionModel!.data![index].id!,
                            optionIndex: optionIndex,
                            text: [
                              showExamQuestionModel!.data![index].choise1!,
                              showExamQuestionModel!.data![index].choise2!,
                              showExamQuestionModel!.data![index].choise3!,
                            ][optionIndex],
                            isSelected:
                            selectedAnswers[showExamQuestionModel!.data![index].id!] == optionIndex,
                            onTap: () =>
                                selectOption(showExamQuestionModel!.data![index].id!, optionIndex),
                          ),
                        ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(mainColor),
              ),
              onPressed: () {
                // Handle answer submission here
                print(selectedAnswers
                    .map((questionId, optionIndex) =>
                    MapEntry('"$questionId"', '${optionIndex + 1}')));
              },
              child: Text('Submit'),
            ),
          );
        },
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final int questionId;
  final int optionIndex;
  final String text;
  final bool isSelected;
  final Function onTap;

  OptionButton({
    required this.questionId,
    required this.optionIndex,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? mainColor : fillColorInTextFormField,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: mainColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

