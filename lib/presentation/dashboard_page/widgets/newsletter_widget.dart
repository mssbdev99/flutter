import '../models/newsletter_model.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/app_export.dart';

// ignore: must_be_immutable
class NewsletterItemWidget extends StatelessWidget {
  NewsletterItemWidget(
    this.newsletterItemModelObj, {
    Key? key,
    this.onTapNewsItem,
  }) : super(
          key: key,
        );

  NewsletterItemModel newsletterItemModelObj;

  VoidCallback? onTapNewsItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 141.h,
      child: GestureDetector(
        onTap: () {
          onTapNewsItem!.call();
          //onTaunchURL(context, newsletterItemModelObj.url);
        },
        child: Container(
          padding: EdgeInsets.all(15.h),
          decoration: AppDecoration.outlineBlue.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: newsletterItemModelObj.image,
                height: 109.adaptSize,
                width: 141.adaptSize,
                radius: BorderRadius.circular(
                  5.h,
                ),
              ),
              SizedBox(height: 10.v),
              SizedBox(
                width: 105.h,
                child: Text(
                  newsletterItemModelObj.newsRef!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  //style: theme.textTheme.labelSmall!.copyWith(height: 1.50,),
                  style: theme.textTheme.labelSmall!,
                ),
              ),                           
            ],
            
          ),
        ),
      ),
    );

  }
}
