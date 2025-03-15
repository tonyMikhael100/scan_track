import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:scan_track/core/models/studnet_model.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/nav_bar_view.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';
import 'package:scan_track/widgets/custom_edit_student_sheet.dart';
import 'package:scan_track/widgets/custom_setting_item.dart';
import 'package:scan_track/widgets/custom_stream_builder.dart';

class StudentInfromationView extends StatelessWidget {
  const StudentInfromationView({
    super.key,
    required this.studentModel,
  });

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    TextEditingController nameController =
        TextEditingController(text: studentModel.firstName);
    TextEditingController phoneController =
        TextEditingController(text: studentModel.phone);
    TextEditingController parentPhoneController =
        TextEditingController(text: studentModel.parentPhone);
    TextEditingController classNameController =
        TextEditingController(text: myHomeCubit.classNameAtStudentDeails);
    TextEditingController grouopNameController =
        TextEditingController(text: myHomeCubit.groupNameAtStudentDeails);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).profile,
              style: FontsData().getHeadline1(context),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      CustomEditStudentSheet(
                          nameController: nameController,
                          phoneController: phoneController,
                          parentPhoneController: parentPhoneController,
                          myHomeCubit: myHomeCubit,
                          width: width,
                          studentModel: studentModel),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.penToSquare,
                    color: ColorsData.primaryColor,
                  )),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    title:
                        " ${S.of(context).delete} ' ${studentModel.firstName} '  ?",
                    type: QuickAlertType.warning,
                    borderRadius: 16,
                    confirmBtnColor: Colors.redAccent,
                    barrierColor: Colors.grey.withOpacity(0.7),
                    cancelBtnText: S.of(context).cancel,
                    confirmBtnText: S.of(context).delete,
                    cancelBtnTextStyle: TextStyle(
                      color: ColorsData.secondryColor,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          getResponsiveFontSize(context, baseFontSize: 18),
                    ),
                    showCancelBtn: true,
                    onConfirmBtnTap: () {
                      myHomeCubit.deleteStudent(id: studentModel.id);
                      Get.offAll(() => NavBarView());
                    },
                    onCancelBtnTap: () {
                      Get.back();
                    },
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.redAccent,
                  size: getResponsiveFontSize(context, baseFontSize: 22),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: width / 4,
                          backgroundColor: ColorsData.secondryColor,
                          child:
                              QrImageView(data: studentModel.qrCode.toString()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          studentModel.firstName.toString(),
                          style: FontsData().getHeadline1(context),
                        ),
                        CustomSettingItem(
                          icon: FontAwesomeIcons.qrcode,
                          title: studentModel.qrCode.toString(),
                        ),
                        CustomSettingItem(
                          icon: FontAwesomeIcons.phone,
                          title: studentModel.phone.toString(),
                        ),
                        CustomSettingItem(
                          icon: FontAwesomeIcons.phone,
                          title: studentModel.parentPhone.toString(),
                        ),
                        CustomSettingItem(
                          icon: Icons.meeting_room_rounded,
                          title: myHomeCubit.classNameAtStudentDeails,
                        ),
                        CustomSettingItem(
                          icon: Icons.group,
                          title: myHomeCubit.groupNameAtStudentDeails,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.grey, ColorsData.secondryColor],
                            ),
                          ),
                          child: ExpansionTile(
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            leading: Icon(
                              Icons.person,
                              size: getResponsiveFontSize(context,
                                  baseFontSize: 22),
                            ),
                            title: Text(
                              S.of(context).attendance,
                              style: GoogleFonts.aBeeZee(
                                color: Colors.white,
                                fontSize: getResponsiveFontSize(
                                  context,
                                  baseFontSize: 20,
                                ),
                              ),
                            ),
                            children: [
                              CustomStreamBuilder(
                                stream: myHomeCubit.fetchStudentAttendanceList(
                                    qrCode: studentModel.qrCode),
                                builderFunction: (data) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (contex, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${S.of(context).attend_at} : ${data[index].scannedAt} ",
                                              style:
                                                  FontsData().getBody(context),
                                            ),
                                            Text(
                                              getDayFromDate(
                                                  data[index].scannedAt),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                myHomeCubit.deleteAttendance(
                                                    attendanceId:
                                                        data[index].id);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

String getDayFromDate(String dateString) {
  DateFormat format = DateFormat("dd-MM-yyyy");
  DateTime date = format.parse(dateString);
  return DateFormat('EEEE').format(date); // Returns full weekday name
}
