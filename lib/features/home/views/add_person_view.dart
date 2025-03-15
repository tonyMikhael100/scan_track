import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/no_data_view.dart';
import 'package:scan_track/generated/l10n.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/utils/fonts_data.dart';
import 'package:scan_track/utils/reponsive_font_size.dart';
import 'package:scan_track/widgets/custom_classes_listview.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_text_form_field.dart';

class AddPersonView extends StatelessWidget {
  AddPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    var myHomeCubit = BlocProvider.of<HomeCubit>(context);
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    TextEditingController studentNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController parentPhoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: S.of(context).full_data_of_student,
                    content: Container(
                      margin: EdgeInsets.all(16),
                      width: width,
                      height: height * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QrImageView(
                              data: myHomeCubit.randomNumber.toString()),
                          Text(
                            "${S.of(context).name} : " +
                                studentNameController.text,
                            style: FontsData().getBody(context),
                          ),
                          Text(
                            "${S.of(context).phone} : " + phoneController.text,
                            style: FontsData().getBody(context),
                          ),
                          Text(
                            "${S.of(context).parent_phone} : " +
                                parentPhoneController.text,
                            style: FontsData().getBody(context),
                          ),
                          Text(
                            "${S.of(context).code}: ${myHomeCubit.randomNumber} ",
                            style: FontsData().getBody(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: QrImageView(data: myHomeCubit.randomNumber.toString()),
              )),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).this_filed_cant_be_empty;
                        } else {
                          return null;
                        }
                      },
                      maxLength: 30,
                      onChanged: (value) {
                        studentNameController.text = value;
                      },
                      hintText:S.of(context).student_name,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).this_filed_cant_be_empty;
                        }
                        if (value.length < 11) {
                          return S.of(context).wrong_number;
                        }
                        return null;
                      },
                      maxLength: 11,
                      onChanged: (value) {
                        phoneController.text = value;
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      hintText: S.of(context).phone,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return  S.of(context).this_filed_cant_be_empty;
                        }
                        if (value.length < 11) {
                          return  S.of(context).wrong_number;
                        }
                        return null;
                      },
                      maxLength: 11,
                      onChanged: (value) {
                        parentPhoneController.text = value;
                      },
                      keyboardType: const TextInputType.numberWithOptions(),
                      hintText:  S.of(context).parent_phone,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomElevatedButton(
                width: width,
                text: myHomeCubit.classNameChoosen,
                bgColor: Colors.grey,
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: SingleChildScrollView(
                          child: StreamBuilder(
                              stream: myHomeCubit.fetchClassesStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Container(
                                      width: double.infinity,
                                      height: height / 2,
                                      child: Center(child: NoDataView()));
                                }
                                final data = snapshot.data;
                                return CustomClassesListView(classesList: data);
                              })),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [Colors.grey, ColorsData.secondryColor])),
                child: Text(
                  "${ S.of(context).student_code}:  ${myHomeCubit.randomNumber}",
                  style: TextStyle(
                      fontSize:
                          getResponsiveFontSize(context, baseFontSize: 18),
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    width: width / 2 - 19,
                    text:  S.of(context).add,
                    bgColor: ColorsData.primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        myHomeCubit.insertStudent(
                          name: studentNameController.text,
                          phone: phoneController.text,
                          parentPhone: parentPhoneController.text,
                          qrCode: myHomeCubit.randomNumber,
                          classId: myHomeCubit.classNumberChoosen,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  CustomElevatedButton(
                    width: width / 2 - 19,
                    text: S.of(context).generate,
                    bgColor: ColorsData.secondryColor,
                    onPressed: () {
                      myHomeCubit.generateRandom6DigitNumber();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
