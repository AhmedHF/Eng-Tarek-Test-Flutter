import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/screens/search/cubit/search_cubit.dart';
import 'package:value_client/widgets/index.dart';

class CouponTypeScreen extends StatefulWidget {
  const CouponTypeScreen({Key? key}) : super(key: key);

  @override
  _CouponTypeScreenState createState() => _CouponTypeScreenState();
}

class _CouponTypeScreenState extends State<CouponTypeScreen> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getCouponsTypes(),
      child: Scaffold(
        backgroundColor: AppColors.bg,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
        ),
        body: NetworkSensitive(
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppImages.backgroundwhite,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  header(),
                  searchInput(),
                  couponTypesList(),
                  continueButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget couponTypesList() {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        return Expanded(
          flex: 5,
          child: AppConditionalBuilder(
            loadingCondition: state is CouponTypesLoadingState,
            emptyCondition:
                state is CouponTypesSuccessState && state.couponTypes.isEmpty,
            errorCondition: state is CouponTypesErrorState,
            errorMessage: state is CouponTypesErrorState ? state.error : '',
            successCondition: state is CouponTypesSuccessState,
            successBuilder: (context) => state is CouponTypesSuccessState
                ? ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCheckbox(state.couponTypes[index], index),
                    itemCount: state.couponTypes.length,
                  )
                : Container(),
          ),
        );
      },
    );
  }

  Widget radioIcon(value) {
    return CustomRadioWidget<int>(
      value: value,
      groupValue: selected,
      onChanged: (int? value) {
        setState(() {
          selected = value!;
        });
      },
    );
  }

  Widget buildCheckbox(CheckBoxModal item, index) {
    /// if select only one item
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        title: Row(
          children: [
            Text(
              item.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '(${item.count})',
              style: TextStyle(
                color: AppColors.gray,
              ),
            )
          ],
        ),
        trailing: radioIcon(item.id),
      ),
    );

    /// if select more than one item

    // return CheckboxListTile(
    //   title: Row(children: [
    //     Text(
    //       item.title,
    //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //     ),
    //     const SizedBox(
    //       width: 5,
    //     ),
    //     Text(
    //       '(${item.count})',
    //       style: TextStyle(
    //         color: AppColors.gray,
    //       ),
    //     )
    //   ]),
    //   value: item.value,
    //   tileColor: AppColors.red,
    //   activeColor: AppColors.gray.withOpacity(.2),
    //   checkColor: AppColors.accentL,
    //   onChanged: (bool? _value) {
    //     print(_value);
    //     setState(() {
    //       item.value = _value!;
    //     });
    //   },
    // );
  }

  Widget searchInput() {
    return Container(
      padding: EdgeInsets.all(20),
      color: AppColors.bg,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: AppLocalizations.of(context)!.search,
          hintStyle: TextStyle(color: AppColors.grayText, fontSize: 15),
          prefixIcon: Icon(
            AppIcons.search,
            color: AppColors.grayText,
            size: 16,
          ),
          fillColor: AppColors.bg,
          labelStyle: TextStyle(
            color: AppColors.grayText,
            backgroundColor: AppColors.grayText,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.grayText),
          ),
          hoverColor: AppColors.bg,
        ),
      ),
    );
  }

  Widget continueButton() {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        return Expanded(
          flex: 1,
          child: Center(
            child: Container(
              child: AppButton(
                width: 280,
                title: AppLocalizations.of(context)!.continue_btn,
                onPressed: () {
                  Navigator.of(context).pop(selected);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget header() {
    return DottedBorder(
      color: AppColors.gray,
      strokeWidth: 1,
      dashPattern: [5, 3],
      customPath: (size) {
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height);
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 50,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.couponType,
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () => {
                Navigator.of(context).pop(),
              },
              icon: Icon(
                AppIcons.close,
                size: 16,
                color: AppColors.primaryL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
