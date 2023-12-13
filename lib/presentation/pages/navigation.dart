import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/pages/animation_page.dart';
import 'package:flutter_nd/presentation/pages/color.dart';
import 'package:flutter_nd/presentation/pages/dataproduct_page.dart';
import 'package:flutter_nd/presentation/pages/qr_page.dart';
import 'package:flutter_nd/presentation/pages/story_page.dart';
import 'package:flutter_nd/presentation/pages/user_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class Bttom extends StatelessWidget {
  final List<Widget> _pageList = [
    UserPage(),
    DataProductPage(),
    StoryPage(),
    CosmeticsAnimationPage(),
    Qr(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.people),
        title: LocaleKeys.Profile.tr(),
        activeColorPrimary: ColorColors.color6,
        inactiveColorPrimary: ColorColors.color7,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shop),
        title: LocaleKeys.Shop.tr(),
        activeColorPrimary: ColorColors.color8,
        inactiveColorPrimary: ColorColors.color7,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: LocaleKeys.Stories.tr(),
        activeColorPrimary: ColorColors.color9,
        inactiveColorPrimary: ColorColors.color7,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.video_camera_back),
        title: LocaleKeys.Palette.tr(),
        activeColorPrimary: ColorColors.primaryColor,
        inactiveColorPrimary: ColorColors.color7,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.qr_code),
        title: 'QR',
        activeColorPrimary: ColorColors.color10,
        inactiveColorPrimary: ColorColors.color7,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersistentTabView(
        context,
        screens: _pageList,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorColors.color11,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(Bttom());
}