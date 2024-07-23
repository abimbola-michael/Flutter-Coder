// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_coder/features/shared/utils/colors.dart';
import 'package:flutter_coder/features/shared/utils/extensions.dart';
import 'package:flutter_svg/svg.dart';

class SvgAsset extends StatelessWidget {
  final Color? color;
  final LinearGradient? gradient;
  final double? size;
  final String name;
  final bool useTint;
  const SvgAsset(
      {super.key,
      this.color,
      this.size,
      this.useTint = true,
      required this.name,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    if (!useTint && color == null) {
      return SvgPicture.asset(
        "assets/images/svg/$name.svg",
        height: size,
        width: size,
      );
    }
    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return gradient!.createShader(bounds);
        },
        child: SvgPicture.asset(
          "assets/images/svg/$name.svg",
          height: size,
          width: size,
        ),
      );
    }

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          color ?? context.iconColor ?? lightTint, BlendMode.srcIn),
      child: SvgPicture.asset(
        "assets/images/svg/$name.svg",
        height: size,
        width: size,
      ),
    );
  }
}
