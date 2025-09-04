
import '../../data/search_teacher_model.dart';

abstract class SearchTeacherStatus{}
class SearchTeacherInitializeStatus extends SearchTeacherStatus{}
class SearchTeacherLoadingStatus extends SearchTeacherStatus{}
class SearchTeacherSuccessStatus extends SearchTeacherStatus{
  SearchTeacherModel searchTeacherModel;

  SearchTeacherSuccessStatus(this.searchTeacherModel);
}
class SearchTeacherErrorStatus extends SearchTeacherStatus{}

///enroll in institute status--------------------------
class EnrollInstituteTeacherLoadingState extends SearchTeacherStatus{}
class EnrollInstituteTeacherSuccessState extends SearchTeacherStatus{
}
class EnrollInstituteTeacherErrorState extends SearchTeacherStatus{}

