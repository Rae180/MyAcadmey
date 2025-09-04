import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:start/features/Student/featuers/search_and_enrollment_student/prisentation/bloc/status.dart';
import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/search_institute_student_mode.dart';
import '../../data/search_offer_student_model.dart';


class SearchStudentCubit extends Cubit<SearchStudentStatus> {
  SearchStudentCubit() : super(SearchStudentInstituteInitializeState());
  static SearchStudentCubit get(context)=>BlocProvider.of(context);
///----------------------------------------------------search for institute
  SearchInstituteStudentModel? searchInstituteStudentModel;
  Future<void> searchForInstitute(String search_key) async {
    emit(SearchStudentInstituteLoadingState());
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final data = {'search_key': search_key};

    try {
      final response = await http.post(
        Uri.parse('${URL}student/academies/search'),
        body: data,
        headers: headers
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
searchInstituteStudentModel=SearchInstituteStudentModel.fromJson(responseData);
        emit(SearchStudentInstituteSuccessState(searchInstituteStudentModel!));
        print ("search institute success");
      } else {
        emit(SearchStudentInstituteErrorState());
        print("search institute  field");
      }
    } catch (e) {
      emit(SearchStudentInstituteErrorState());
      print(e);
    }
  }
  ///----------------------------------------------search for offers
   SearchOfferStudentModel? searchOfferStudentModel;
  Future<void> searchForOffer(String search_key) async {
    emit(SearchStudentOfferLoadingState());
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final data = {'search_key': search_key};

    try {
      final response = await http.post(
        Uri.parse('${URL}student/offers/search'
            '',),
        body: data,
        headers: headers
      );
      if (response.statusCode == 200) {
        print("search institute  success");
        final responseData = jsonDecode(response.body);
        searchOfferStudentModel=SearchOfferStudentModel.fromJson(responseData);
        emit(SearchStudentOfferSuccessState(searchOfferStudentModel!));
      } else {
        print("search offer field ");
        emit(SearchStudentOfferErrorState());
      }
    } catch (e) {
      emit(SearchStudentOfferErrorState());
      print(e);
    }
  }
///enroll on offer-----------------------------------------------------------------
  Future<void> enrollInOffer(int id ) async {
    emit(SearchStudentOfferLoadingState());
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    try {
      final response = await http.post(
          Uri.parse('${URL}student/offers/enroll/$id'),
          headers: headers
      );
      if (response.statusCode == 200) {
        print("enroll offer  success");
        final responseData = jsonDecode(response.body);
        searchOfferStudentModel=SearchOfferStudentModel.fromJson(responseData);
        emit(EnrollOfferSuccessState());
      } else {
        print("enroll offer field ");
        emit(EnrollOfferErrorState());
      }
    } catch (e) {
      emit(EnrollOfferErrorState());
      print(e);
    }
  }
///enroll in institute ----------------------------------
  Future<void> enrollInInstitute(int id ,String lang) async {
    emit(SearchStudentOfferLoadingState());
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final data = {
      'language': lang,
      };
    emit(EnrollInstituteLoadingState());
    try {
      final response = await http.post(
          Uri.parse('${URL}student/academies/join/$id'),headers: headers,body: data

      );

      if (response.statusCode == 200) {
        print("enroll offer  success");
        final responseData = jsonDecode(response.body);
        //searchOfferStudentModel=SearchOfferStudentModel.fromJson(responseData);
        emit(EnrollInstituteSuccessState());
      } else {
        print("enroll offer field ");
        emit(EnrollInstituteErrorState());
      }
    } catch (e) {
      emit(EnrollInstituteErrorState());
      print(e);
    }
  }

    int cc=1;
void changValueOfSearch1(int x){
  cc=x;
  emit(ChangeValueIndex());
}
}

