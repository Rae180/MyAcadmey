
import '../../data/show_details_institute_student_model.dart';
import '../../data/show_student_institute_model.dart';

abstract class InstituteStudentStatus{}
class InstituteStudentInitializeState extends InstituteStudentStatus{}
class InstituteStudentLoadingState extends InstituteStudentStatus{}
class InstituteStudentSuccessState extends InstituteStudentStatus{
  ShowStudentInstituteModel showStudentInstituteModel;

  InstituteStudentSuccessState(this.showStudentInstituteModel);
}
class InstituteStudentErrorState extends InstituteStudentStatus{}

//////
class InstituteDetailsStudentLoadingState extends InstituteStudentStatus{}
class InstituteDetailsStudentSuccessState extends InstituteStudentStatus{
  ShowDetailsInstituteStudentModel showDetailsInstituteStudentModel;

  InstituteDetailsStudentSuccessState(this.showDetailsInstituteStudentModel);
}
class InstituteDetailsStudentErrorState extends InstituteStudentStatus{}