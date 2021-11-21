import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/widgets/clippers/discount_clipper.dart';
import 'package:value_client/widgets/index.dart';

class StoreInfo extends StatefulWidget {
  final Map<String, dynamic> storeDetails;
  StoreInfo(this.storeDetails);
  @override
  _StoreInfoState createState() => _StoreInfoState();
}

class _StoreInfoState extends State<StoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: FullTicketClipper(
            10, widget.storeDetails['brief'] == null ? 100 : 160),
        child: Container(
          height: widget.storeDetails['brief'] == null ? 100 : 160,
          width: double.infinity,
          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backgroundGrey,
          ),
          // decoration: ShapeDecoration(
          //   shape: WeirdBorder(
          //       radius: 16, pathWidth: 1000, bottom: true),
          //   color: AppColors.white,
          // ),
          child: DottedBorder(
            color: AppColors.gray,
            strokeWidth: 2,
            dashPattern: [5],
            customPath: (size) {
              return Path()
                ..moveTo(5, size.height)
                ..lineTo(size.width - 5, size.height);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () => {},
                                  child: Text(
                                    AppLocalizations.of(context)!.follow,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.red,
                                      onPrimary: AppColors.white,
                                      minimumSize: Size(100, 40)),
                                ),
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(children: <Widget>[
                                      Icon(Icons.person,
                                          color: AppColors.backgroundGray),
                                      Text(
                                          widget.storeDetails['followers']
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.red,
                                              fontSize: 16))
                                    ]))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    widget.storeDetails['rate'].toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: AppColors.accentL),
                                  ),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StarRatingAlertDialog();
                                      },
                                    ),
                                    icon: Icon(
                                      Icons.star_outline_rounded,
                                      size: 30,
                                      color: AppColors.accentL,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        widget.storeDetails['brief'] != null
                            ? Container(
                                width: double.infinity,
                                child: Text(
                                  widget.storeDetails['brief'],
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ))
                            : Container()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
