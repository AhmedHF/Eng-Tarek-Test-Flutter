import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/core/services/dynamic_links_service.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/offerDetails/cubit/fav_cubit.dart';
import 'package:value_client/widgets/alert_dialogs/login_alert_dialog.dart';
import 'package:value_client/widgets/app_snack_bar.dart';
import 'package:value_client/widgets/index.dart';

class OfferActions extends StatefulWidget {
  final Map<String, dynamic> data;

  const OfferActions({Key? key, required this.data}) : super(key: key);

  @override
  State<OfferActions> createState() => _OfferActionsState();
}

class _OfferActionsState extends State<OfferActions> {
  late bool isFav = widget.data['favourite'];

  bool _isCreatingLink = false;

  Future<void> _createDynamicLink(bool short, link) async {
    setState(() {
      _isCreatingLink = true;
    });
    await createDynamicLink(short, link);
    setState(() {
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppCubit appCubit = AppCubit.get(context);
    FavCubit favCubit = FavCubit.get(context);

    return BlocConsumer<FavCubit, FavState>(
      listener: (context, state) {
        if (state is ToggleFavErrorState) {
          debugPrint('=== errrrrror ');
          AppSnackBar.showError(context, state.error);
        } else if (state is ToggleFavLoadedState) {
          debugPrint('=== message ');
          setState(() {
            isFav = !isFav;
          });
          AppSnackBar.showSuccess(context, AppLocalizations.of(context)!.done);
        }
      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, .6),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                widget.data['image'],
                width: double.infinity,
                height: 200,
                // fit: BoxFit.cover,
                // color: AppColors.red,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  widget.data['price'] == '0'
                      ? AppLocalizations.of(context)!.free
                      : AppLocalizations.of(context)!.percenatage,
                  style: const TextStyle(
                      color: AppColors.primaryDark, fontSize: 18),
                ),
                decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 40,
                height: 40,
                // padding: EdgeInsets.all(5),
                child: _isCreatingLink
                    ? const AppLoading()
                    : IconButton(
                        onPressed: () => {
                          _createDynamicLink(true,
                              '${NetworkConstants.baseUrlDev}${NetworkConstants.couponDetails}/${widget.data['id']}')
                        },
                        icon: const Icon(
                          Icons.share_outlined,
                          color: AppColors.red,
                          size: 25,
                        ),
                      ),
                decoration: BoxDecoration(
                  color: AppColors.primaryL,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 60,
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                // padding: EdgeInsets.all(5),
                child: IconButton(
                    onPressed: () {
                      if (appCubit.userData.user == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              const LoginAlertDialog(),
                        );
                      } else {
                        favCubit.toggleFav({'coupon_id': widget.data['id']});
                      }
                    },
                    icon: Icon(
                      isFav == true ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.red,
                      size: 25,
                    )),
                decoration: BoxDecoration(
                  color: AppColors.primaryL,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
