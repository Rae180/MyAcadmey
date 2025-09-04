
import '../../data/all_courses_teacher_model.dart';
import '../../data/details_courses_teacher_model.dart';
import '../../data/show_lessons_teacher_model.dart';
import '../../data/studentForAddDegreeModel.dart';

abstract class CourseTeacherStatus{}
class CourseTeacherInitializeState extends CourseTeacherStatus{}
class CourseTeacherLoadingState extends CourseTeacherStatus{}
class CourseTeacherSuccessState extends CourseTeacherStatus{
  AllCoursesTeacherModel allCoursesTeacherModel;

  CourseTeacherSuccessState(this.allCoursesTeacherModel);
}
class CourseTeacherErrorState extends CourseTeacherStatus{}

///details ------------course
class CourseTeacherOneLoadingState extends CourseTeacherStatus{}
class CourseTeacherOneSuccessState extends CourseTeacherStatus{
  DetailsCoursesTeacherModel detailsCoursesTeacherModel;

  CourseTeacherOneSuccessState(this.detailsCoursesTeacherModel);
}
class CourseTeacherOneErrorState extends CourseTeacherStatus{}

///show lessons------------
class ShowLessonsLoadingState extends CourseTeacherStatus{}
class ShowLessonsSuccessState extends CourseTeacherStatus{
 ShowLessonsTeacherModel showLessonsTeacherModel;

 ShowLessonsSuccessState(this.showLessonsTeacherModel);
}
class ShowLessonsErrorState extends CourseTeacherStatus{}
///add degree status student
class GetStudentAddDegreeLoadingState extends CourseTeacherStatus{}
class GetStudentAddDegreeSuccessState extends CourseTeacherStatus{
  StudentForAddDegreeModel studentForAddDegreeModel;

  GetStudentAddDegreeSuccessState(this.studentForAddDegreeModel);
}
class GetStudentAddDegreeErrorState extends CourseTeacherStatus{}

///
///
class AddDegreeLoadingState extends CourseTeacherStatus{}
class AddDegreeSuccessState extends CourseTeacherStatus{
  AddDegreeModel addDegreeModel;

  AddDegreeSuccessState(this.addDegreeModel);
}
class AddDegreeErrorState extends CourseTeacherStatus{}

class AddDegreeModel {
  int? status;
  String? message;

  AddDegreeModel({this.status, this.message});

  AddDegreeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}