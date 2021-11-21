import 'dart:async';

import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountDownTimer extends StatefulWidget {
  //selectedDuration is seconds
  final int selectedDuration;
  final double boxSize;
  final bool isUpdate;
  CountDownTimer(this.selectedDuration, this.boxSize, this.isUpdate);
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    setState(() {
      duration = Duration(seconds: widget.selectedDuration);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _updateTime() {
    if (widget.isUpdate == true) {
      setState(() {
        final seconds = duration.inSeconds - 1;
        if (seconds < 0) {
          timer?.cancel();
        } else {
          duration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: buildTime(),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final days = twoDigits(duration.inDays);
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildTimeCard(time: days, header: AppLocalizations.of(context)!.day),
        buildTimeCard(time: hours, header: AppLocalizations.of(context)!.hour),
        buildTimeCard(time: minutes, header: AppLocalizations.of(context)!.min),
        buildTimeCard(time: seconds, header: AppLocalizations.of(context)!.sec),
      ],
    ));
  }

  Widget buildTimeCard({required String time, required String header}) {
    return (Container(
      padding: EdgeInsets.all(2),
      width: widget.boxSize,
      height: widget.boxSize,
      margin: EdgeInsets.symmetric(horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.white,
          border: Border.all(color: AppColors.backgroundGray, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            style: TextStyle(
                color: AppColors.black,
                fontSize: widget.boxSize / 3,
                fontWeight: FontWeight.bold),
          ),
          Text(header)
        ],
      ),
    ));
  }
}
