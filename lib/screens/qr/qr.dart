import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/index.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: NetworkSensitive(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                AppImages.bgverify,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: ClipPath(
                clipper: FullTicketClipper(10, 260),
                child: Container(
                  width: 300,
                  height: 350,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: DottedBorder(
                        color: AppColors.gray,
                        strokeWidth: 1,
                        dashPattern: [5],
                        customPath: (size) {
                          return Path()
                            ..moveTo(0, size.height * 0.75)
                            ..lineTo(size.width, size.height * 0.75);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(
                                    AppIcons.close,
                                    color: AppColors.primaryL,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: QrImage(
                                data: 'memberShip:${arguments['id']}',
                                version: QrVersions.auto,
                                size: 180,
                                gapless: false,
                                errorStateBuilder: (cxt, err) {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                        "Uh oh! Something went wrong...",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '#${arguments['id']}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              arguments['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentL,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)!.member_since +
                                  " " +
                                  arguments['date'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
