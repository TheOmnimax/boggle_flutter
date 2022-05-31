import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const bigLoading = SpinKitDualRing(
  color: themeColor,
);

OverlayEntry loadingOverlay({
  required double screenWidth,
  double top = 0,
  String message = 'Loading, please wait...',
}) {
  return overlayPopup(
    screenWidth: screenWidth,
    top: top,
    child: Column(
      children: [
        bigLoading,
        Text(message),
      ],
    ),
  );
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    this.message = 'Loading, please wait...',
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    required this.status,
    Key? key,
  }) : super(key: key);

  final LoadingStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == LoadingStatus.working) {
      return const SpinKitDualRing(
        color: themeColor,
        size: 10,
      );
    } else if (status == LoadingStatus.ready) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else if (status == LoadingStatus.error) {
      return const Icon(
        Icons.error,
        color: Colors.red,
      );
    } else if (status == LoadingStatus.warning) {
      return const Icon(
        Icons.warning,
        color: Colors.orange,
      );
    } else {
      return Container();
    }
  }
}
