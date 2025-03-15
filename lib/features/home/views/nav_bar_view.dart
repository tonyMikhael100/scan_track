import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:scan_track/features/home/view%20model/home_cubit.dart';
import 'package:scan_track/features/home/views/add_class_view.dart';
import 'package:scan_track/features/home/views/add_person_view.dart';
import 'package:scan_track/features/home/views/home_view.dart';
import 'package:scan_track/features/home/views/scan_view.dart';
import 'package:scan_track/features/home/views/settings_view.dart';
import 'package:scan_track/utils/colors_data.dart';

int navBarIndex = 0;

class NavBarView extends StatelessWidget {
  NavBarView({
    super.key,
  });
  final List<Widget> pages = [
    HomeView(),
    AddClassView(),
    ScanView(),
    AddPersonView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     homeCubit.getNumberOfStudentAtClass(classId: 33);
          //   },
          // ),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: navBarIndex,
            onTap: (index) {
              navBarIndex = index;
              homeCubit.changeNavBarIndex();
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: ColorsData.primaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(FontAwesomeIcons.folder),
                title: const Text("Classes"),
                selectedColor: ColorsData.secondryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(FontAwesomeIcons.qrcode),
                title: const Text("Qr Scan"),
                selectedColor: ColorsData.primaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.face),
                title: const Text("Add person"),
                selectedColor: ColorsData.secondryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text("Settings"),
                selectedColor: ColorsData.primaryColor,
              ),
            ],
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 54, left: 16, right: 16),
              child: pages[navBarIndex]),
        );
      },
    );
  }
}
