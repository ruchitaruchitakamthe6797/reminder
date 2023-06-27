import 'package:flutter/material.dart';
import 'package:send_remider_to_user/constants/colors.dart';
import 'package:send_remider_to_user/responsive.dart';
import 'package:send_remider_to_user/utils/device/device_utils.dart';

class BackButtonWidget extends StatelessWidget {
  BackButtonWidget({Key? key, this.back, this.ontap}) : super(key: key);
  final ontap;
  bool? back;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: back == true
          ? ontap
          : () async {
              DeviceUtils.hideKeyboard(context);
              Navigator.of(context).pop();
            },
      child: Container(
        height: Responsive.isTablet(context) && size.height < 1000
            ? DeviceUtils.getScaledWidth(context, 11)
            : Responsive.isTablet(context) ||
                    size.width > 500 && size.height < 1000
                ? DeviceUtils.getScaledWidth(context, 8.7)
                : DeviceUtils.getScaledWidth(context, 9),
        width: Responsive.isTablet(context) && size.height < 1000
            ? DeviceUtils.getScaledWidth(context, 11)
            : Responsive.isTablet(context) ||
                    size.width > 500 && size.height < 1000
                ? DeviceUtils.getScaledWidth(context, 8.7)
                : DeviceUtils.getScaledWidth(context, 9),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //     borderRadius: BorderRadius.all(
          //  Radius.circular(40),
          //     ),
          color: Colors.white,

          border: Border.all(
            width: DeviceUtils.getScaledWidth(context, 0.5),
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColors.blackColor,
          size: DeviceUtils.getScaledWidth(context, 5.7),
        ),
      ),
    );
  }
}
