

import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';


void getSnackBar({
   BuildContext? context,

   String? text ,
}) {
     ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.baseDark,
        content: Text(
         text!,
          style: TextStyle(
              color: AppColors.baseWhite
          ),
        ),
        action: SnackBarAction(
          textColor: AppColors.baseWhite,
          label: 'OK',
          onPressed: () {},
        ),
      )

  );
}
