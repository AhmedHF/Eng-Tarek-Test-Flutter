import 'package:flutter/material.dart';
import 'package:value_client/models/saving.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/images/index.dart';

class SavingItem extends StatelessWidget {
  final SavingModel item;
  const SavingItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {}
      // Navigator.of(context).pushNamed(AppRoutes.purchasedCouponScreen)
      ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.white,
                                radius: 20,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    AppImages.noon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${AppLocalizations.of(context)!.purchase_d}: ${item.purchaseDate}',
                              style: const TextStyle(
                                color: AppColors.grayText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: AppColors.grayText,
                      height: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${AppLocalizations.of(context)!.amount}: ${item.amount}',
                            style: const TextStyle(
                                color: AppColors.primaryDark, fontSize: 16),
                          ),
                          Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 2.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${item.price.toString()} ${AppLocalizations.of(context)!.sar}',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.gray,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 3.0,
                                    left: 15,
                                    right: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${item.price.toString()} ${AppLocalizations.of(context)!.sar}',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
