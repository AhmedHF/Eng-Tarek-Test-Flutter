import 'package:flutter/material.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MemberShipItem extends StatelessWidget {
  final MemberShipModel item;
  const MemberShipItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: item.name.split(' ').length > 1
                    ? item.name.split(' ')[0]
                    : item.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ), // default text style
                children: <TextSpan>[
                  if (item.name.split(' ').length > 1)
                    TextSpan(
                      text: " " + item.name.split(' ')[1],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryL,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(item.description),
            ),
            item.price == '0'
                ? Container()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        item.price.contains('.')
                            ? item.price.split('.')[0]
                            : item.price,
                        style: const TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      if (item.price.contains('.'))
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: '.' + item.price.split('.')[1],
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${AppLocalizations.of(context)!.sar} ',
                                        style: const TextStyle(
                                          color: AppColors.gray,
                                        )),
                                  ],
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Text(
                              'Month',
                              // style: TextStyle(
                              //     fontSize: 45, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                    ],
                  ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.checkoutMemberShipScreen,
                    arguments: item,
                  );
                },
                child: Text(
                  item.price == '0'
                      ? AppLocalizations.of(context)!.free
                      : AppLocalizations.of(context)!.upgrade_now,
                ),
                style: OutlinedButton.styleFrom(
                  primary: AppColors.accentL,
                  side: const BorderSide(
                    color: AppColors.accentL,
                    width: 2,
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
