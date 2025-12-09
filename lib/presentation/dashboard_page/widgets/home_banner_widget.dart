import '../models/home_banner_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';

// ignore: must_be_immutable
class HomeBannerItemWidget extends StatelessWidget {
  HomeBannerItemWidget(
    this.homebannerItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  HomeBannerItemModel homebannerItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomImageView(
            imagePath: homebannerItemModelObj.imgBanner,
            height: 297.v,
            width: double.maxFinite,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.h,right: 110.h,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300.h,
                    child: Text(
                      homebannerItemModelObj.moto!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        height: 1.50,color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
