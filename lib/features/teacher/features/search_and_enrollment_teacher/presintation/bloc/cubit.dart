import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:start/features/teacher/features/search_and_enrollment_teacher/presintation/bloc/status.dart';

import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/enrollment_teacher_model.dart';
import '../../data/search_teacher_model.dart';
class SearchTeacherCubit extends Cubit<SearchTeacherStatus>{
  SearchTeacherCubit():super(SearchTeacherInitializeStatus());
  static SearchTeacherCubit get(context)=>BlocProvider.of(context);

///search Teacher----------------------------------------
  SearchTeacherModel? searchTeacherModel;
  Future<void> searchTeacher(String search_key) async {
    //
    //
    // // final headers = {
    // //   'Accept': 'application/json',
    // //   // 'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    // //   // Replace with your header key and value
    // // };
    // // // Define the API endpoint URL
    // // var request = http.MultipartRequest('POST', Uri.parse('${URL}searchByAcademy'));
    // // // Create a map with the request data
    // // final data = {'search_key': search_key};
    // // //
    // // request.fields.addAll({
    // //   'search': search_key
    // // });
    // //
    // // request.headers.addAll(headers);
    // // http.StreamedResponse response = await request.send();
    // //
    // //  final response1 = await http.post(Uri.parse('${URL}searchByAcademy'), body: data,headers: headers);
    // // if (response.statusCode == 200) {
    // //   print(response1.body);
    // //   print(search_key);
    // //
    // // }
    // // else {
    // //   print("error");
    // // }
    //
    //
    //
    //
    //
    // //
    // final headers = {
    //   'Accept': 'application/json',
    //   // 'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    //   // Replace with your header key and value
    // };
    // // // Define the API endpoint URL
    //  final url = Uri.parse('${URL}searchByAcademy');
    // //
    // // // Create a map with the request data
    //  final data = {'search_key': "ar"};
    // //
    // // try {
    // //   print("tryyy");
    // //   emit(SearchTeacherLoadingStatus());
    // //
    // //   final response = await http.post(url, body: data,headers: headers);
    // //   // Check if the request was successful
    // //   // print(response.body);
    // //   if (response.statusCode == 200) {
    // //
    // //     // Request successful, do something with the response
    // //     print('Search Teacher successful');
    // //     print(response.body);
    // //     final responseData = jsonDecode(response.body);
    // //     // return UserModel.fromJson(responseData);
    // //     searchTeacherModel=SearchTeacherModel.fromJson(responseData);
    // //     emit(SearchTeacherSuccessStatus(searchTeacherModel!));
    // //     // print(loginModel.role);
    // //     // print(loginModel.token);
    // //   } else {
    // //     emit(SearchTeacherErrorStatus());
    // //     // Request failed, handle the error
    // //     print('Login failed');
    // //     print('Status code: ${response.statusCode}');
    // //     print('Error message: ${response.body}');
    // //   }
    // // } catch (e) {
    // //   print(e);
    // //
    // // }
    //
    // if (search_key.isNotEmpty) {
    //   try {
    //     print("tryyy");
    //     emit(SearchTeacherLoadingStatus());
    //
    //     final response = await http.post(url, body: data, headers: headers);
    //
    //     if (response.statusCode == 200) {
    //       print('Search Teacher successful');
    //       print(response.body);
    //       final responseData = jsonDecode(response.body);
    //       searchTeacherModel = SearchTeacherModel.fromJson(responseData);
    //       emit(SearchTeacherSuccessStatus(searchTeacherModel!));
    //     } else {
    //       emit(SearchTeacherErrorStatus());
    //       print('Search Teacher failed');
    //       print('Status code: ${response.statusCode}');
    //       print('Error message: ${response.body}');
    //     }
    //   } catch (e) {
    //     print(e);
    //     emit(SearchTeacherErrorStatus());
    //   }
    // } else {
    //   // Handle empty search_key
    //   emit(SearchTeacherErrorStatus());
    //   print('Search key is empty');
    // }
    //


    var headers = {
      'Accept': 'application/json'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${URL}searchByAcademy'));
    request.fields.addAll({
      'search': search_key
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }



  }
///enrollment teacher in institute---------------------
  EnrollmentTeacherModel? enrollmentTeacherModel;
  Future<void> enrollmentTeacher({required int id,
   required int saturday,required int sunday,required int monday,required int tuesday,required int wednsday,required int thursday,required int friday,
   required String start_saturday,required String start_sunday,required String start_monday,required String start_tuesday,required String start_wednsday,required String start_thursday,required String start_friday,
   required String end_saturday,required String end_sunday,required String end_monday,required String end_tuesday,required String end_wednsday,required String end_thursday,required String end_friday
  }
      ) async {
    // Define the API endpoint URL
    final url = Uri.parse('${URL}teacher/institutes/$id/add-request');

    // Create a map with the request data
    final data = {
      'saturday': saturday,
      'start_saturday': start_saturday,
      'end_saturday': end_saturday,
      'sunday': sunday,
      'start_sunday': start_sunday,
      'end_sunday':end_sunday,
      'monday': monday,
      'start_monday': start_monday,
      'end_monday': end_monday,
      'tuesday': tuesday,
      'start_tuesday': start_tuesday,
      'end_tuesday': end_tuesday,
      'wednsday': wednsday,
      'start_wednsday': start_wednsday,
      'end_wednsday': end_wednsday,
      'thursday': thursday,
      'start_thursday': start_thursday,
      'end_thursday': end_thursday,
      'friday': friday,
      'start_friday': start_friday,
      'end_friday': end_friday
    };

    try {
      print("tryyy");
      emit(EnrollInstituteTeacherErrorState());

      final response = await http.post(url, body: data);
      // Check if the request was successful
      if (response.statusCode == 200) {

        // Request successful, do something with the response
        print('Login successful');
        print(response.body);
        final responseData = jsonDecode(response.body);

        emit(EnrollInstituteTeacherSuccessState());

      } else {
        emit(EnrollInstituteTeacherErrorState());
        // Request failed, handle the error
        print('Login failed');
        print('Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print(e);

    }
  }

}