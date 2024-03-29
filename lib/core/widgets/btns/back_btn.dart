import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siignores/constants/main_config_app.dart';

import '../../../constants/colors/color_styles.dart';




class BackBtn extends StatelessWidget {
  final Function() onTap;
  const BackBtn({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onTap,
      duration: Duration(milliseconds: 110),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MainConfigApp.app.isSiignores ? ColorStyles.white : ColorStyles.black2
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/svg/back.svg',
          color: MainConfigApp.app.isSiignores ? null : ColorStyles.lilac,
        ),
      ),
    );
  }
}




