import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/models/discount.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/app_button.dart';
import 'package:value_client/widgets/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscountItem extends StatelessWidget {
  final int index;
  final DiscountModel item;
  const DiscountItem({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FullTicketClipper(10, 140),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientList1[index % 4],
              AppColors.gradientList2[index % 4],
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: DottedBorder(
            color: AppColors.gray,
            strokeWidth: 1,
            dashPattern: const [5],
            customPath: (size) {
              return Path()
                ..moveTo(0, size.height * 0.7)
                ..lineTo(size.width, size.height * 0.7);
            },
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(
                    AppIcons.my_value,
                    size: 160,
                    color: Colors.white.withOpacity(.1),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        margin: const EdgeInsets.only(top: 5),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: ClipOval(
                              child: AppImage(imageURL: item.image),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        item.name,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        item.offer.toString() + '%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          item.expire ? 'OFF' : 'ON',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        height: 40,
                        child: AppButton(
                          backgroundColor: AppColors.white,
                          titleColor: AppColors.gradientList2[index % 4],
                          title: AppLocalizations.of(context)!.visit_store,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.storeDetailsScreen,
                                arguments: {'id': item.id, 'name': item.name});
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
