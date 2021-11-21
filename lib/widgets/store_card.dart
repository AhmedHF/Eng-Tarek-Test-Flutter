import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCard extends StatefulWidget {
  final String name;
  final String upTo;
  final String value;
  final String image;
  final Color categoryColor;
  final bool featured;
  final String id;

  StoreCard(
      {required this.name,
      required this.upTo,
      required this.value,
      required this.image,
      required this.categoryColor,
      required this.featured,
      required this.id});
  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.storeDetailsScreen,
              arguments: {'id': widget.id, 'name': widget.name}),
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white,
            ),
            child: Stack(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.categoryColor.withOpacity(.7),
                            widget.categoryColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: cubit.isRTL(context)
                                ? Radius.zero
                                : Radius.circular(15),
                            topLeft: cubit.isRTL(context)
                                ? Radius.zero
                                : Radius.circular(15),
                            bottomRight: cubit.isRTL(context)
                                ? Radius.circular(15)
                                : Radius.zero,
                            topRight: cubit.isRTL(context)
                                ? Radius.circular(15)
                                : Radius.zero),
                        color: AppColors.primaryL,
                      ),
                      width: 90,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.network(
                                widget.image,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 220,
                            padding: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: AppColors.primaryDark,
                              width: .3,
                            ))),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              width: 220,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Up To:',
                                        style: TextStyle(
                                            color: AppColors.primaryDark,
                                            fontSize: 14),
                                      ),
                                      Text(
                                          '${widget.upTo != 'null' ? widget.upTo : 0} ٪',
                                          style: TextStyle(
                                              color: AppColors.accentL,
                                              fontSize: 14)),
                                      Icon(
                                        AppIcons.sale_tag,
                                        color: AppColors.accentL,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Coupon:',
                                        style: TextStyle(
                                            color: AppColors.primaryDark,
                                            fontSize: 14),
                                      ),
                                      Text('(${widget.value})',
                                          style: TextStyle(
                                              color: AppColors.accentL,
                                              fontSize: 14)),
                                      Icon(
                                        AppIcons.flat,
                                        color: AppColors.accentL,
                                        size: 18,
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                widget.featured
                    ? Positioned(
                        top: 0,
                        left: cubit.isRTL(context) ? 0 : null,
                        right: !cubit.isRTL(context) ? 0 : null,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.only(
                                bottomLeft: cubit.isRTL(context)
                                    ? Radius.zero
                                    : Radius.circular(10),
                                topLeft: cubit.isRTL(context)
                                    ? Radius.circular(15)
                                    : Radius.zero,
                                bottomRight: cubit.isRTL(context)
                                    ? Radius.circular(10)
                                    : Radius.zero,
                                topRight: cubit.isRTL(context)
                                    ? Radius.zero
                                    : Radius.circular(15)),
                          ),
                          child: Text(
                            'Adv',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
