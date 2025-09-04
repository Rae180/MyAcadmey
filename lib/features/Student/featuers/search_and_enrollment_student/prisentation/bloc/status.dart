
import '../../data/search_institute_student_mode.dart';
import '../../data/search_offer_student_model.dart';

abstract class  SearchStudentStatus {}
 class SearchStudentInstituteInitializeState extends SearchStudentStatus{}
 ///search for institute
 class SearchStudentInstituteLoadingState extends SearchStudentStatus{}
 class SearchStudentInstituteSuccessState extends SearchStudentStatus{
 SearchInstituteStudentModel searchInstituteStudentModel;

 SearchStudentInstituteSuccessState(this.searchInstituteStudentModel);
}
 class SearchStudentInstituteErrorState extends SearchStudentStatus{}
 ///---------------------------------------------------
 class ChangeValueIndex extends SearchStudentStatus{}
///search for offers-------------------------------------
 class SearchStudentOfferLoadingState extends SearchStudentStatus{}
 class SearchStudentOfferSuccessState extends SearchStudentStatus{
 SearchOfferStudentModel searchOfferStudentModel;

 SearchStudentOfferSuccessState(this.searchOfferStudentModel);
}
 class SearchStudentOfferErrorState extends SearchStudentStatus{}
///enroll in offer status ----------------------------------
 class EnrollOfferLoadingState extends SearchStudentStatus{}
 class EnrollOfferSuccessState extends SearchStudentStatus{
 }
 class EnrollOfferErrorState extends SearchStudentStatus{}
 ///enroll in institute status--------------------------
 class EnrollInstituteLoadingState extends SearchStudentStatus{}
 class EnrollInstituteSuccessState extends SearchStudentStatus{
 }
 class EnrollInstituteErrorState extends SearchStudentStatus{}


