import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customToast({
  required BuildContext context,
  required double width,
  required String text,
  required Color color,
  required int seconds,
  IconData? icon,
  double? radius,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  final scaffoldMessenger = ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: width,
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      content: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (icon != null) ...[
            SizedBox(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          SizedBox(
            width: icon == null ? width * .9 : width * .75,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: seconds),
    ),
  );
  return scaffoldMessenger;
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successMessageToast({
  required BuildContext context,
  required String text,
  required int seconds,
  double? width,
}) {
  return customToast(
    context: context,
    width: width ?? MediaQuery.of(context).size.width * .9,
    text: text,
    color: const Color.fromARGB(255, 36, 190, 36),
    seconds: seconds,
    icon: FontAwesomeIcons.check,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMessageToast({
  required BuildContext context,
  required String text,
  required int seconds,
  double? width,
}) {
  return customToast(
    context: context,
    width: width ?? MediaQuery.of(context).size.width * .9,
    text: text,
    color: const Color.fromARGB(255, 231, 37, 37),
    seconds: seconds,
    icon: FontAwesomeIcons.solidCircleXmark,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> warningMessageToast(
    {required BuildContext context,
    required String text,
    required int seconds,
    double? width}) {
  return customToast(
    context: context,
    width: width ?? MediaQuery.of(context).size.width * .9,
    text: text,
    color: const Color.fromARGB(255, 236, 133, 37),
    seconds: seconds,
    icon: FontAwesomeIcons.triangleExclamation,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> infoMessageToast({
  required BuildContext context,
  required String text,
  required int seconds,
  double? width,
}) {
  return customToast(
    context: context,
    width: width ?? MediaQuery.of(context).size.width * .9,
    text: text,
    color: const Color.fromARGB(255, 40, 115, 212),
    seconds: seconds,
    icon: FontAwesomeIcons.circleInfo,
  );
}
