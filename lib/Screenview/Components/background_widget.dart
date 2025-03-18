import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_app/const/app_image_path.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SvgPicture.asset(
          AppImagePath.backgroundSvg,
          alignment: Alignment.center,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    ));
  }
}
