import '../../data/Question.dart';
import '../../data/courses_and_offers_model.dart';
import '../../data/show_lessons_student_model.dart';
import '../../data/show_ten_offers_model.dart';

abstract class CourseStudentStatus{}
class CourseStudentInitializeState extends CourseStudentStatus{}
class CourseStudentLoadingState extends CourseStudentStatus{}
class CourseStudentSuccessState extends CourseStudentStatus{
  ShowCoursesAndOffersModel showCoursesAndOffersModel;

  CourseStudentSuccessState(this.showCoursesAndOffersModel);
}
class CourseStudentErrorState extends CourseStudentStatus{}
///show ten offer
class TenOffersLoadingState extends CourseStudentStatus{}
class TenOffersSuccessState extends CourseStudentStatus{
  ShowTenOffersModel showTenOffersModel;

  TenOffersSuccessState(this.showTenOffersModel);
}
class TenOffersErrorState extends CourseStudentStatus{}

///show lesson in student -----------------------------------
class ShowLessonStudentLoadingState extends CourseStudentStatus{}
class ShowLessonStudentSuccessState extends CourseStudentStatus{
  ShowLessonStudentModel showLessonStudentModel;

  ShowLessonStudentSuccessState(this.showLessonStudentModel);
}
class ShowLessonStudentErrorState extends CourseStudentStatus{}

///get question  state
class ShowQuestionLoadingState extends CourseStudentStatus{}
class ShowQuestionSuccessState extends CourseStudentStatus{
  ShowExamQuestionModel showExamQuestionModel;

  ShowQuestionSuccessState(this.showExamQuestionModel);
}
class ShowQuestionErrorState extends CourseStudentStatus{}
