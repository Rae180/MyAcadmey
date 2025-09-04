import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/Student/featuers/notification_student_management/prisentation/bloc/status.dart';

import '../../../../../util/end_pointes.dart';
import 'package:http/http.dart'as http;

import '../../../../../util/shared_preferences.dart';
import '../../data/ListAcceptInstituteNotificationModel.dart';
import '../../data/List_lesson_notification_model.dart';
import '../../data/list_accept_offer_notification_model.dart';
import '../../data/showOfferDetailsNotificationModel.dart';
import '../../data/show_lesson_notificaiton_model.dart';
class ShowNotificationInstituteCubit extends Cubit<ShowNotificationInstituteState>{
  ShowNotificationInstituteCubit():super(ShowNotificationInstituteInitializeState());

static ShowNotificationInstituteCubit get(context)=>BlocProvider.of(context);

///add lesson get----------------------------------------------------------notification
ListLessonsAddedNotificationModel ?lessonsAddedNotificationModel;
  Future<ListLessonsAddedNotificationModel?> getLessonNotification() async {

    final url = '${URL}student/notification/course/1'; // Replace with your API endpoint URL

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      lessonsAddedNotificationModel=ListLessonsAddedNotificationModel.fromJson(jsonData);
      print(response.body);
     emit(ShowNotificationAddLessonSuccessState(lessonsAddedNotificationModel!));
    } else {
      throw Exception('Failed to load profile data');
    }
  }
///get institute notification ---------------------------------------------------------
  ListAcceptOfferNotificationModel? listAcceptOfferNotificationModel;
  Future<ListAcceptOfferNotificationModel?> getOfferNotification() async {
    final url = '${URL}student/notification/offers'; // Replace with your API endpoint URL
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowNotificationOfferLoadingState());
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      listAcceptOfferNotificationModel=ListAcceptOfferNotificationModel.fromJson(jsonData);
      print(response.body);
      emit(ShowNotificationOfferSuccessState(listAcceptOfferNotificationModel!));
    } else {
      emit(ShowNotificationOfferErrorState());
      throw Exception('Failed offer notification data');
    }
  }

///get notification institute --------------------------------------------------------------
  ListAcceptInstituteNotificationModel ?listAcceptInstituteNotificationModel;
  Future<ListAcceptInstituteNotificationModel?> getNotificationInstitute() async {

    final url = '${URL}student/notification/acceptAcademy'; // Replace with your API endpoint URL
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowNotificationInstituteLoadingState());
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      listAcceptInstituteNotificationModel=ListAcceptInstituteNotificationModel.fromJson(jsonData);
      emit(ShowNotificationInstituteSuccessState(listAcceptInstituteNotificationModel!));
    } else {
      emit(ShowNotificationInstituteErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///show details offer notification --------------------------------------------------------------------------------------------------
  ShowOfferDetailsNotificationModel? showOfferDetailsNotificationModel;
  Future<ShowOfferDetailsNotificationModel?> showDetailsOfferNotification(int id) async {

    final url = '${URL}student/notification/offer/$id'; // Replace with your API endpoint URL
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowOfferDetailsLoadingState());
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      showOfferDetailsNotificationModel=ShowOfferDetailsNotificationModel.fromJson(jsonData);
      emit(ShowOfferDetailsSuccessState(showOfferDetailsNotificationModel!));
    } else {
      emit(ShowOfferDetailsErrorState());
      throw Exception('and data');
    }
  }
///show lesson details notification ----------------------------------------------------
  ShowLessonNotificationModel ? showLessonNotificationModel;
  Future<ShowLessonNotificationModel?> showDetailsLessonNotification(int id) async {

    final url = '${URL}student/notification/lesson/$id'; // Replace with your API endpoint URL
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowLessonDetailsLoadingState());
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      showLessonNotificationModel=ShowLessonNotificationModel.fromJson(jsonData);
      emit(ShowLessonDetailsSuccessState(showLessonNotificationModel!));
    } else {
      emit(ShowLessonDetailsErrorState());
      throw Exception('and data');
    }
  }
}