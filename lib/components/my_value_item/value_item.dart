import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/clippers/value_image_clipper.dart';
import 'package:value_client/widgets/index.dart';

class ValueItem extends StatelessWidget {
  final DiscountModel item;
  final VoidCallback onPress;
  const ValueItem({Key? key, required this.item, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return GestureDetector(
          onTap: () => {onPress()},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: ValueImageClipper(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: Stack(
                        children: [
                          AppImage(
                            imageURL: item.image,
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: AppColors.clip.withOpacity(0.7),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              item.description,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Container(
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
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  radius: 20,
                                  child: ClipOval(
                                    child: AppImage(imageURL: item.storeImage),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(item.storeName,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 2.0,
                                        // left: 15,
                                        // right: 15,
                                      ),
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primaryL,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.price,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 2.0,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item.priceBeforeDiscount,
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: AppColors.gray,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // 'Exp 30 May ,2021'
                              Text(
                                '${AppLocalizations.of(context)!.exp} ${DateFormat('d MMM ,y', cubit.locale.languageCode).format(DateTime.parse(item.expireDate))}',
                                style: const TextStyle(
                                  color: AppColors.red,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
