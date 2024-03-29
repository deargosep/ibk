import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siignores/constants/texts/text_styles.dart';
import 'package:siignores/core/utils/toasts.dart';
import '../../../../constants/colors/color_styles.dart';
import '../../../../constants/main_config_app.dart';
import '../../../../core/services/network/config.dart';
import '../../../../core/widgets/image/cached_image.dart';
import '../../domain/entities/module_enitiy.dart';

class ModuleCard extends StatelessWidget {
  final Function() onTap;
  final int index;
  final ModuleEntity moduleEntity;
  final bool back;
  const ModuleCard(
      {Key? key,
      required this.back,
      required this.onTap,
      required this.moduleEntity,
      this.index = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MainConfigApp.app.isSiignores) {
      return GestureDetector(
        onTap: (){
          if(moduleEntity.perm){
            onTap();
          }else{
            showSuccessAlertToast('Модуль недоступен');
          }
        }, 
        child: Container(
          margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 10.h),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              back
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: CachedImage(
                          height: null,
                          isProfilePhoto: false,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(14.h),
                          alignment: Alignment.bottomRight,
                          urlImage: moduleEntity.image == null
                              ? null
                              : Config.url.url + moduleEntity.image!),
                    )
                  : Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CachedImage(
                            height: 80.w,
                            isProfilePhoto: false,
                            fit: BoxFit.contain,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(14.h)),
                            alignment: Alignment.bottomRight,
                            urlImage: moduleEntity.image == null
                                ? null
                                : Config.url.url + moduleEntity.image!),
                      )),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      moduleEntity.title.toUpperCase(),
                      style: TextStyles.cormorant_black_18_w400,
                    ),
                    Text(
                      moduleEntity.description ?? '',
                      style: TextStyles.cormorant_black_12_w400,
                    ),
                  ],
                ),
              ),
              if(!moduleEntity.perm)
              Positioned( 
                top: 15.h,
                right: 15.w,
                child: Image.asset(
                  'assets/images/lock.png',
                  width: 20.w,
                ) 
              ) 
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: (){
          if(moduleEntity.perm){
            onTap();
          }else{
            showSuccessAlertToast('Модуль недоступен');
          }
        }, 
        child: Container(
          margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 14.h),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: ColorStyles.black2,
              borderRadius: BorderRadius.circular(14.h)),
          child: Stack(
            children: [
              back
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: CachedImage(
                          height: null,
                          isProfilePhoto: false,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(14.h),
                          alignment: Alignment.bottomRight,
                          urlImage: moduleEntity.image == null
                              ? null
                              : Config.url.url + moduleEntity.image!),
                    )
                  : Positioned(
                      bottom: 0,
                      right: 0,
                      left: 14.w,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedImage(
                            height: 80.w,
                            isProfilePhoto: false,
                            fit: BoxFit.contain,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(14.h)),
                            alignment: Alignment.bottomRight,
                            urlImage: moduleEntity.image == null
                                ? null
                                : Config.url.url + moduleEntity.image!),
                      )),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 22.h, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      moduleEntity.title.toUpperCase(),
                      style: MainConfigApp.app.isSiignores
                          ? TextStyles.cormorant_black_18_w400
                          : TextStyles.white_16_w300,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      moduleEntity.description ?? '',
                      style: TextStyles.grey_10_w400.copyWith(
                          color: ColorStyles.grey929292,
                          fontFamily: MainConfigApp.fontFamily4),
                    ),
                  ],
                ),
              ),
              if(!moduleEntity.perm)
              Positioned( 
                top: 15.h,
                right: 15.w,
                child: Image.asset(
                  'assets/images/lock.png',
                  width: 20.w,
                ) 
              ) 
            ],
          ),
        ),
      );
    }
  }
}
