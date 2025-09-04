import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart'as http;
import 'package:start/features/teacher/features/list_institute_and_details_teacher/prisentation/bloc/status.dart';
import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/all_institute_teacher_model.dart';
import '../../data/details_institute_teacher_model.dart';


class InstituteTeacherCubit extends Cubit<InstituteTeacherStatus>{
  InstituteTeacherCubit():super(InstituteTeacherInitializeState());
///show Teacher institute List-----------------
AllInstituteTeacherModel ?allInstituteTeacherModel;
  Future<AllInstituteTeacherModel?> getListTeacherInstitute() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(
        Uri.parse('${URL}AllAcademyTeacher'),headers: headers);
emit(InstituteTeacherLoadingState());
    if (response.statusCode == 200) {
      print("institute success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
allInstituteTeacherModel=AllInstituteTeacherModel.fromJson(parsedJson);
      emit(InstituteTeacherSuccessState(allInstituteTeacherModel!));
    }else {
      print("certificate field");
      emit(InstituteTeacherErrorState());
      throw Exception('Failed to load profile data');
    }
  }


  ///show details institute
  DetailsInstituteTeacherModel? detailsInstituteTeacherModel;
  Future<DetailsInstituteTeacherModel?> getListTeacherInstituteDetails(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.post(
        Uri.parse('${URL}DetailsAcademyTeacher/${id}'),headers: headers);
    emit(InstituteDetailsTeacherLoadingState());

    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
     // print(response.body);
   detailsInstituteTeacherModel=DetailsInstituteTeacherModel.fromJson(parsedJson);
      emit(InstituteDetailsTeacherSuccessState(detailsInstituteTeacherModel!));
    }else {
      print(response.body);
      print("show institute details field");
      emit(InstituteDetailsTeacherErrorState());
      throw Exception('Failed to load profile data');
    }
  }
}