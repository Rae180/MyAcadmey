import '../../../list_of_courses_and_details_teacher/data/all_courses_teacher_model.dart';
import '../../data/list_of_student_in_course.dart';

abstract class StudentInTeacherState{}
 class StudentInTeacherInitializeState extends StudentInTeacherState{}

 class StudentInTeacherLoadingState extends StudentInTeacherState{}
 class StudentInTeacherSuccessState extends StudentInTeacherState{

  AllCoursesTeacherModel allCoursesTeacherModel;

  StudentInTeacherSuccessState(this.allCoursesTeacherModel);
}
 class StudentInTeacherErrorState extends StudentInTeacherState{}

class StudentInTeacherDetailsLoadingState extends StudentInTeacherState{}
class StudentInTeacherDetailsSuccessState extends StudentInTeacherState{
 ListOfStudentInCourseModel listOfStudentInCourseModel;

 StudentInTeacherDetailsSuccessState(this.listOfStudentInCourseModel);
}
class StudentInTeacherDetailsErrorState extends StudentInTeacherState{}