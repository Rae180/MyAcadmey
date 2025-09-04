import '../../data/pending_list_model.dart';

abstract class PendingListTeacherStatus{}
class PendingListTeacherInitializeState extends PendingListTeacherStatus{}
class PendingListTeacherLoadingState extends PendingListTeacherStatus{}
class PendingListTeacherSuccessState extends PendingListTeacherStatus{
  PendingListTeacherModel pendingListTeacherModel;

  PendingListTeacherSuccessState(this.pendingListTeacherModel);
}
class PendingListTeacherErrorState extends PendingListTeacherStatus{}

class DeleteSuccessState extends PendingListTeacherStatus{
  String message;

  DeleteSuccessState(this.message);
}
class DeleteErrorState extends PendingListTeacherStatus{}
class DeleteLoadingState extends PendingListTeacherStatus{}

