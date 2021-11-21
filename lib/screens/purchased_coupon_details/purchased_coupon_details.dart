import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/branch_list_btn.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/widgets/weird_border.dart';

class PurchasedCouponDetailScreen extends StatefulWidget {
  const PurchasedCouponDetailScreen({Key? key}) : super(key: key);

  @override
  _PurchasedCouponDetailScreenState createState() =>
      _PurchasedCouponDetailScreenState();
}

class _PurchasedCouponDetailScreenState
    extends State<PurchasedCouponDetailScreen> {
  bool isSendGift = false;
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return
        // BlocProvider(
        //     create: (context) => MyValuesCubit()  ..getQR(arguments['id'].toString()),
        //     child:
        Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.purchased_coupon)),
      body: NetworkSensitive(
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppImages.background,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(10),
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
                        color: AppColors.backgroundGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DottedBorder(
                          color: AppColors.gray,
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          strokeWidth: 2,
                          dashPattern: const [5],
                          customPath: (size) {
                            return Path()
                              ..moveTo(5, size.height)
                              ..lineTo(size.width - 5, size.height);
                          },
                          child: Center(
                            child: QrImage(
                              data: 'coupon:${arguments['id']}',
                              version: QrVersions.auto,
                              size: 150,
                              gapless: false,
                              errorStateBuilder: (cxt, err) {
                                return const Center(
                                  child: Text(
                                    "Uh oh! Something went wrong...",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                          // child: BlocBuilder<MyValuesCubit, MyValuesState>(
                          //   builder: (context, state) {
                          //     return AppConditionalBuilder(
                          //         loadingCondition: state is GetQRLoadingState,
                          //         loadingColor: AppColors.primaryL,
                          //         emptyCondition: state is GetQRSuccessState &&
                          //             state.data.isEmpty,
                          //         errorCondition: state is GetQRErrorState,
                          //         errorMessage: state is GetQRErrorState
                          //             ? state.error
                          //             : '',
                          //         successCondition: state is GetQRSuccessState,
                          //         successBuilder: (context) => state
                          //                 is GetQRSuccessState
                          //             ? Container(
                          //                 alignment: Alignment.center,
                          //                 child: SvgPicture.string(state.data))
                          //             //  Image.asset(
                          //             //   AppImages.qr,
                          //             //   width: 150,
                          //             //   height: 150,
                          //             //   fit: BoxFit.contain,
                          //             // ))
                          //             : Container());
                          //   },
                          // ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: ShapeDecoration(
                      shape: WeirdBorder(
                        radius: 10,
                        pathWidth: 1000,
                      ),
                      color: AppColors.backgroundGrey,
                    ),
                    child: DottedBorder(
                      color: AppColors.gray,
                      strokeWidth: 2,
                      dashPattern: const [5],
                      customPath: (size) {
                        return Path()
                          ..moveTo(0, size.height)
                          ..lineTo(size.width, size.height);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: 22,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(24),
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
                                      child: Image.network(
                                        arguments['coupon']['store']['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text(
                                      arguments['coupon']['store']
                                          ['store_name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(
                                          color: AppColors.primaryDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: arguments['coupon']['price'] == "0"
                                      ? AppColors.red
                                      : AppColors.backgroundGray,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  arguments['coupon']['price'] == '0'
                                      ? AppLocalizations.of(context)!.free
                                      : AppLocalizations.of(context)!
                                          .percenatage,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: arguments['coupon']['price'] == '0'
                                        ? AppColors.white
                                        : AppColors.primaryDark,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ExpandablePanel(
                            header: Text(
                              arguments['coupon']['name'],
                              softWrap: true,
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                arguments['coupon']['description'],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          DottedBorder(
                              color: AppColors.gray,
                              strokeWidth: 2,
                              dashPattern: const [5],
                              customPath: (size) {
                                return Path()
                                  ..moveTo(0, size.height)
                                  ..lineTo(size.width, size.height);
                              },
                              child: Container()),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .coupon_expiration_date,
                                style: const TextStyle(
                                    color: AppColors.primaryDark,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              // Text(
                              //   arguments['coupon']['validity_period_date'] !=
                              //           null
                              //       ? DateFormat('d MMM y').format(
                              //           DateTime.parse(arguments['coupon']
                              //               ['validity_period_date']),
                              //         )
                              //       : '',
                              //   style: TextStyle(
                              //       color: AppColors.primaryDark,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 16),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .coupon_purchased_date,
                                style: const TextStyle(
                                    color: AppColors.primaryDark,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                arguments['created_at'],
                                style: const TextStyle(
                                    color: AppColors.primaryDark,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DottedBorder(
                              color: AppColors.gray,
                              strokeWidth: 2,
                              dashPattern: const [5],
                              customPath: (size) {
                                return Path()
                                  ..moveTo(0, size.height)
                                  ..lineTo(size.width, size.height);
                              },
                              child: Container()),
                          //  send branches in the third param
                          BranchListBtn(
                            AppColors.backgroundGrey,
                            AppRoutes.searchBranchListScreen,
                            arguments['coupon']['store']['working_from'],
                            arguments['coupon']['store']['working_to'],
                            arguments['coupon']['branches'],
                          ),
                          // DottedBorder(
                          //     color: AppColors.gray,
                          //     strokeWidth: 2,
                          //     dashPattern: [5],
                          //     customPath: (size) {
                          //       return Path()
                          //         ..moveTo(0, size.height)
                          //         ..lineTo(size.width, size.height);
                          //     },
                          //     child: Container()),
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 50),
                          //   alignment: Alignment.center,
                          //   child: ElevatedButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       AppLocalizations.of(context)!.redeem,
                          //       style: TextStyle(
                          //         color: AppColors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //         minimumSize: Size(250, 40),
                          //         shape: const RoundedRectangleBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(30)),
                          //         ),
                          //         primary: AppColors.accentL,
                          //         padding: EdgeInsets.all(15)),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // )
    );
  }
}
