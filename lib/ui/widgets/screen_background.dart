import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Stack( //stack- 1ta jinisher moddhe arekta jinish rakhe.
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
          width: screenSize.width,
          height: screenSize.height,
        ),
        SafeArea(child: child),
      ],
    );
  }
}