import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart'as http;
import 'package:start/features/Student/featuers/pending_list_student/prisentation/bloc/status.dart';

import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
class PendingListStudentCubit extends Cubit<PendingListStudentStatus>{
  PendingListStudentCubit():super(PendingListStudentInitializeState());
  ///show pending list student and cancel enrollment

  Future<Map<String,dynamic>?> getPendingList() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    emit(PendingListStudentLoadingState());
    final response =
    await http.get(Uri.parse('${URL}student/academies/show-request'), headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
     // pendingListStudentModel = PendingListStudentModel.fromJson(parsedJson);
      //print(pendingListStudentModel!.message);
      emit(PendingListStudentSuccessState());
    } else {
      print("certificate field");
      emit(PendingListStudentErrorState());
      throw Exception('Failed to load profile data');
    }
  }

  Future<void> deleteRequest(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    final String apiUrl = '${URL}student/academies/cancelRequest/$id';

    try {
      final response = await http.delete(Uri.parse(apiUrl), headers: headers);
      emit(DeleteLoadingState());
      if (response.statusCode == 200) {
        // Successful deletion
        print('Item with ID $id deleted successfully.');

        final jsonResponse = json.decode(response.body);
        final responseMessage = jsonResponse['message'];
        emit(DeleteSuccessState(responseMessage));
      } else {
        emit(DeleteErrorState());
        // Unsuccessful deletion
        print(
            'Failed to delete item with ID $id. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      emit(DeleteErrorState());
      print('An error occurred: $e');
    }
  }

}