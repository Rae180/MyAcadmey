abstract class PendingListStudentStatus{}
class PendingListStudentInitializeState extends PendingListStudentStatus{}
class PendingListStudentLoadingState extends PendingListStudentStatus{}
class PendingListStudentSuccessState extends PendingListStudentStatus{

}
class PendingListStudentErrorState extends PendingListStudentStatus{}

class DeleteSuccessState extends PendingListStudentStatus{
  String message;

  DeleteSuccessState(this.message);
}
class DeleteErrorState extends PendingListStudentStatus{}
class DeleteLoadingState extends PendingListStudentStatus{}

