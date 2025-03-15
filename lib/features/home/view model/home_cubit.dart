import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:scan_track/core/models/attendance_model.dart';
import 'package:scan_track/core/models/class_model.dart';
import 'package:scan_track/core/models/studnet_model.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/my_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int randomNumber = 0;
  int classesLenght = 0;
  int classNumberChoosen = 0;
  String classNameChoosen = "choose class and group no";
  String classNameAtStudentDeails = '';
  String groupNameAtStudentDeails = '';
  int selectedClassInStudentEdit = 0;
  String classNameChoosenScanView = "choose class and group no";
  int? classNumberChooseScanView;
  List<AttendanceModel> studentAttendanceList = [];
  TextEditingController studentSearchController = TextEditingController();

  void changeNavBarIndex() {
    emit(HomeNavBarState());
  }

  void generateRandom6DigitNumber() {
    Random random = Random();
    randomNumber = 100000 + random.nextInt(900000);
    emit(GenterateRandomNumberState());
  }

// class operations -----------------------------------------------------------
// ----------------------------------------------------------------------------
  Future<void> insertClass(String className, String groupName) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('class').insert(
        {
          "class_name": className,
          "group_name": groupName,
        },
      );

      Get.back();
      customSnackbar(
          title: "Added",
          message: "Class Added successful",
          color: ColorsData.secondryColor);
    } catch (error) {
      print("Error inserting user: $error");
      customSnackbar(
          title: "Failed", message: "Class Not added", color: Colors.redAccent);
    }
    emit(InsertDataState());
  }

  Future<void> deleteClass({required int id}) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('class').delete().eq("id", id);
    } catch (error) {
      print("Error inserting user: $error");
    }
    emit(DeleterClassState());
  }

  Future<void> upadateClass(
      {required String className, required groupName, required int id}) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('class').update(
        {"class_name": className, "group_name": groupName},
      ).eq('id', id);
    } catch (error) {
      print("Error updating user: $error");
      customSnackbar(
          title: "Failed",
          message: "Class Not updated, try again",
          color: Colors.redAccent);
    }
    emit(UpdateClassState());
  }

  Stream<List<ClassModel>>? fetchClassesStream() {
    final supabase = Supabase.instance.client;
    return supabase
        .from('class')
        .stream(primaryKey: ['id']) // استماع للتحديثات في Supabase
        .map((data) => data.map((data) => ClassModel.toJson(data)).toList());
  }

  void getClassAndGroupNamdByStudentId({required int id}) async {
    try {
      final supabase = Supabase.instance.client;
      var response;
      dynamic classId =
          await supabase.from('student').select('class_id').eq('id', id);
      print(classId);
      var temp = classId[0]['class_id'];
      print(temp);
      response = await supabase
          .from('class')
          .select('class_name,group_name')
          .eq('id', temp);
      print(response);
      classNameAtStudentDeails = response[0]['class_name'];
      groupNameAtStudentDeails = response[0]['group_name'];
      emit(GettClassAndGroupNamdByStudentIdState());
    } on Exception catch (e) {
      print(e);
    }
  }

  Stream<List<StudentModel>>? fetchStudentsByClassIdStream(
      {required int classId}) {
    final supabase = Supabase.instance.client;
    return supabase
        .from('student')
        .stream(primaryKey: ['id'])
        .eq('class_id', classId) // استماع للتحديثات في Supabase
        .map((data) => data.map((data) => StudentModel.toJson(data)).toList());
  }

// student operations -----------------------------------------------------------
// ----------------------------------------------------------------------------

  Future<void> insertStudent({
    required String name,
    required String phone,
    required String parentPhone,
    required int qrCode,
    required int classId,
  }) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('student').insert({
        'name': name,
        'phone': phone,
        'parent_phone': parentPhone,
        'qr_code': qrCode,
        'class_id': classId,
      });
      customSnackbar(
          title: "Added",
          message: "Student Added",
          color: ColorsData.secondryColor);
      print("Student added successfully");
    } catch (error) {
      print("Error inserting student: $error");
      customSnackbar(
          title: "Error",
          message: "please regenerate qr code and choose class",
          color: Colors.redAccent);
    }
  }

  Future<void> upadateStudent({
    required int studentId,
    required String studentName,
    required String phone,
    required String parentPhone,
    required qrCode,
    required classId,
  }) async {
    final supabase = Supabase.instance.client;
    var response;
    print(classId);
    try {
      response = await supabase.from('student').update(
        {
          "name": studentName,
          "phone": phone,
          "parent_phone": parentPhone,
          "qr_code": qrCode,
          "class_id": classId
        },
      ).eq('id', studentId);
      customSnackbar(
          title: "success",
          message: "user ( ${studentName} ) updated",
          color: ColorsData.secondryColor);
    } catch (error) {
      print("Error updating student: $error");
      customSnackbar(
          title: "Failed",
          message: "user Not updated, choose class and try again",
          color: Colors.redAccent);
    }
    emit(UpdateStudentState());
  }

  Stream<List<StudentModel>>? fetchStudentsStream() {
    final supabase = Supabase.instance.client;
    return supabase
        .from('student')
        .stream(primaryKey: ['id']) // استماع للتحديثات في Supabase
        .map((data) => data.map((data) => StudentModel.toJson(data)).toList());
  }

  Future<void> deleteStudent({required int id}) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('student').delete().eq("id", id);
    } catch (error) {
      print("Error deleteing user: $error");
    }
  }

  void setClassDetail({required String className, required int classId}) {
    this.classNameChoosen = className;
    this.classNumberChoosen = classId;
    emit(SetClassDetailsState());
  }

  void changeBorderColorOfSelectedClass() {
    emit(ChangeBorderColorOfSelectedClassState());
  }

  //attendance operation

  Future<void> insertAttendance(
      {required int attendceClassId,
      required int attendanceStudentQrCode}) async {
    final supabase = Supabase.instance.client;
    var response;
    try {
      response = await supabase.from('attendance').insert(
        {
          "class_id": attendceClassId,
          "qr_code": attendanceStudentQrCode,
        },
      );
      customSnackbar(
          title: "Added",
          message: "student Added successful",
          color: ColorsData.secondryColor);
    } catch (error) {
      print("Error inserting user: $error");
      customSnackbar(
          title: "Failed", message: "$error", color: Colors.redAccent);
    }
    emit((InsertStudentAttendanceState()));
  }

  void chooseClassName() {
    emit(ChooseClassNameState());
  }

  bool checkVisibileScanButton() {
    if (classNumberChooseScanView == null) {
      emit(CheckVisibileScanButtonState());
      return false;
    } else {
      emit(CheckVisibileScanButtonState());
      return true;
    }
  }

  Stream<List<AttendanceModel>>? fetchStudentAttendanceList(
      {required int qrCode}) {
    final supabase = Supabase.instance.client;
    return supabase
        .from('attendance')
        .stream(primaryKey: ['id'])
        .eq('qr_code', qrCode) // استماع للتحديثات في Supabase
        .map((data) =>
            data.map((data) => AttendanceModel.toJson(data)).toList());
  }

  void deleteAttendance({required attendanceId}) async {
    final supabase = Supabase.instance.client;
    try {
      var respnose;
      respnose =
          await supabase.from('attendance').delete().eq('id', attendanceId);
    } on Exception catch (e) {
      print(e);
    }
    emit(DeleterStudentAttendanceState());
  }

  Stream<List<StudentModel>>? searchStudentBynameStream(
      {required String studentName}) {
    final supabase = Supabase.instance.client;

    return supabase
        .from('student')
        .select('*') // Fetch all matching students
        .like('name', "%$studentName%") // Partial search
        .asStream()
        .map((data) => data
            .map((item) => StudentModel.toJson(item))
            .toList()); // Convert JSON to StudentModel list
  }

//for updating ui after search becaue we cant emit after return
  void searchStudentStateMethod() {
    emit(SearchStudentState());
  }

  //
}
