import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/models/discount.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreOffers extends StatefulWidget {
  final List<dynamic> coupons;
  StoreOffers(this.coupons);

  @override
  _StoreOffersState createState() => _StoreOffersState();
}

class _StoreOffersState extends State<StoreOffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: WeirdBorder(
            radius: 10,
            pathWidth: 1000,
          ),
          color: AppColors.white,
        ),
        child: DottedBorder(
          color: AppColors.gray,
          strokeWidth: 2,
          // radius: Radius.circular(5),
          dashPattern: [5],
          customPath: (size) {
            return Path()
              ..moveTo(10, size.height)
              ..lineTo(size.width - 10, size.height);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    AppLocalizations.of(context)!.offers,
                    style: TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Column(
                children: [
                  ...widget.coupons
                      .map((item) => Column(
                            children: [
                              ValueItem(
                                  item: DiscountModel(
                                    id: item['id'],
                                    name: item['name'],
                                    // offer: item['offer'],
                                    description: item['description'],
                                    image: item['image'],
                                    expire: item['expire'],
                                    expireDate: item['to_date'],
                                    price: item['price'],
                                    priceBeforeDiscount:
                                        item['price_before_discount'],
                                    storeName: item['store']['store_name'],
                                    storeImage: item['store']['image'],
                                  ),
                                  onPress: () => Navigator.of(context)
                                      .pushNamed(AppRoutes.offerDetailsScreen,
                                          arguments: {'id': item['id']})),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                      .toList(),
                ],
              )),
            ],
          ),
        ));
  }
}
