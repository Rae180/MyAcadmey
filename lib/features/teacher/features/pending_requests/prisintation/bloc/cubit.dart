import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/teacher/features/pending_requests/prisintation/bloc/status.dart';
import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/pending_list_model.dart';
import 'package:http/http.dart' as http;

class PendingListTeacherCubit extends Cubit<PendingListTeacherStatus> {
  PendingListTeacherCubit() : super(PendingListTeacherInitializeState());

  static PendingListTeacherCubit get(context) => BlocProvider.of(context);

  ///show pending list Teacher and cancel enrollment
  PendingListTeacherModel? pendingListTeacherModel;

  Future<PendingListTeacherModel?> getPendingList() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    emit(PendingListTeacherLoadingState());
    final response =
        await http.get(Uri.parse('${URL}pendingListTeacher'), headers: headers);

    if (response.statusCode == 200) {
      print(PendingListTeacherCubit().pendingListTeacherModel?.data);

      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      pendingListTeacherModel = PendingListTeacherModel.fromJson(parsedJson);
      // print(pendingListTeacherModel!.message);
      emit(PendingListTeacherSuccessState(pendingListTeacherModel!));
    } else {
      print("certificate field");
      emit(PendingListTeacherErrorState());
      throw Exception('Failed to load profile data');
    }
  }

  Future<void> deleteRequest(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    final String apiUrl = '${URL}deletePendingRequest/$id';

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
