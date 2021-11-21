import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:value_client/components/index.dart';

import 'package:value_client/models/saving.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({Key? key}) : super(key: key);

  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  bool isSendGift = false;
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<SavingModel> mySavings = [
      SavingModel(
        id: 1,
        amount: 1,
        price: 50,
        oldPrice: 40,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      ),
      SavingModel(
        id: 2,
        amount: 1,
        price: 80,
        oldPrice: 70,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      ),
      SavingModel(
        id: 3,
        amount: 1,
        price: 100,
        oldPrice: 75,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      ),
      SavingModel(
        id: 1,
        amount: 1,
        price: 50,
        oldPrice: 30,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      ),
      SavingModel(
        id: 2,
        amount: 1,
        price: 80,
        oldPrice: 60,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      ),
      SavingModel(
        id: 3,
        amount: 1,
        price: 100,
        oldPrice: 90,
        purchaseDate: "30 May ,2021",
        name: "Noon",
      )
    ];
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.savings)),
      body: NetworkSensitive(
        child: Stack(children: <Widget>[
          Image.asset(
            AppImages.background,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipPath(
                  clipper: FullTicketClipper(10, 200),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.accentL,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentL,
                          AppColors.accentL.withOpacity(.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: DottedBorder(
                          color: AppColors.gray,
                          padding: EdgeInsets.only(top: 20, bottom: 30),
                          strokeWidth: 2,
                          dashPattern: [5],
                          customPath: (size) {
                            return Path()
                              ..moveTo(5, size.height)
                              ..lineTo(size.width - 5, size.height);
                          },
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                AppImages.savings,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${AppLocalizations.of(context)!.since} Jul 10, 2020 ${AppLocalizations.of(context)!.you_saved}',
                                      style: const TextStyle(
                                          color: AppColors.white, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '1300 ${AppLocalizations.of(context)!.sar}',
                                      style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  // height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                    shape: WeirdBorder(
                      radius: 10,
                      pathWidth: 1000,
                      top: true,
                    ),
                    color: AppColors.white,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.savings,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: ShapeDecoration(
                      shape: WeirdBorder(
                        radius: 10,
                        pathWidth: 1000,
                        bottom: true,
                      ),
                      color: AppColors.white,
                    ),
                    child: Container(
                        child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          SavingItem(item: mySavings[index]),
                      separatorBuilder: separatorBuilder,
                      itemCount: mySavings.length,
                    )),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
