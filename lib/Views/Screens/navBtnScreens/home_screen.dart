import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_screen.dart';
import 'package:petsadoption/Views/Widgets/custom_scaffold.dart';
import 'package:petsadoption/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'add_screen.dart';
import 'adopt_screen.dart';
class HomePage extends StatefulWidget {
  static String id='homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Widget>pages = [
    AdoptMe(),
    AddScreen(),
    Profile(),

  ];
  int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }
    return CustomScaffold(
      bottomNav: CircleBottomNavigationBar(

        initialSelection: pageIndex,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 45.0,
        textColor: primaryColor,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        blurShadowRadius: 50.0,
        circleColor: primaryColor,
        activeIconColor: iconPink,
        inactiveIconColor: iconPink,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => pageIndex = index),
      ),
      body: pages[pageIndex],
    );
  }

  List<TabData> getTabsData() {
    return [


      TabData(
        icon: Icons.pets,
        iconSize: 25,
        title: "adoptMe".tr(),
        fontSize: 10,
        fontWeight: FontWeight.bold,


      ),
      TabData(
        icon: Icons.add_circle,
        iconSize: 25,
        title: 'add'.tr(),
        fontSize: 10,
        fontWeight: FontWeight.bold,


      ),
      TabData(
        icon: Icons.person,
        iconSize: 25.0,
        title: 'profile'.tr(),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ];
  }
}
