import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/countdown_timer.dart';

class OfferDetailsTimer extends StatefulWidget {
  final Map<String, dynamic> data;
  const OfferDetailsTimer({Key? key, required this.data}) : super(key: key);

  @override
  _OfferDetailsTimerState createState() => _OfferDetailsTimerState();
}

class _OfferDetailsTimerState extends State<OfferDetailsTimer> {
  @override
  Widget build(BuildContext context) {
    final to = DateTime.parse(widget.data['to_date']);
    final from = DateTime.now();
    final difference = to.difference(from).inSeconds;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.expiration_date,
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${DateTime.parse(widget.data['to_date']).day.toString()}, ${DateTime.parse(widget.data['to_date']).month.toString()}, ${DateTime.parse(widget.data['to_date']).year.toString()}',
              style: TextStyle(
                color: AppColors.primaryDark,
                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        //send time as seconds
        CountDownTimer(widget.data['expire'] == true ? 0 : difference, 70, true)
      ],
    );
  }
}
