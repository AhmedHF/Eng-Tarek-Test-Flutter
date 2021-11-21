import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultCard extends StatefulWidget {
  final String name;
  final String upTo;
  final String valueType;
  final String city;
  final String area;

  final Color categoryColor;

  const SearchResultCard({
    Key? key,
    required this.name,
    required this.upTo,
    required this.valueType,
    required this.city,
    required this.area,
    required this.categoryColor,
  }) : super(key: key);
  @override
  _SearchResultCardState createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.storeDetailsScreen),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
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
        child: Row(
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
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: AppColors.primaryL,
              ),
              width: 90,
              height: 100,
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        AppImages.noon,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 220,
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.primaryDark,
                    width: .3,
                  ))),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15, left: 10),
                    width: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text(
                              'Up To:',
                              style: TextStyle(
                                  color: AppColors.primaryDark, fontSize: 14),
                            ),
                            Text('${widget.upTo} ٪',
                                style: const TextStyle(
                                    color: AppColors.accentL, fontSize: 14)),
                            const Icon(
                              AppIcons.sale_tag,
                              color: AppColors.accentL,
                              size: 18,
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${AppLocalizations.of(context)!.value_type}:',
                              style: const TextStyle(
                                  color: AppColors.primaryDark, fontSize: 12),
                            ),
                            const Text('free',
                                style: TextStyle(
                                    color: AppColors.accentL, fontSize: 12)),
                          ],
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '${AppLocalizations.of(context)!.city}:',
                            style: const TextStyle(
                                color: AppColors.primaryDark, fontSize: 12),
                          ),
                          Text(
                            widget.city,
                            style: const TextStyle(
                                color: AppColors.accentL, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${AppLocalizations.of(context)!.area}:',
                            style: const TextStyle(
                                color: AppColors.primaryDark, fontSize: 12),
                          ),
                          Text(
                            widget.area,
                            style: const TextStyle(
                                color: AppColors.accentL, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
