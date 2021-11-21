import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/widgets/index.dart';

class AppSwiper extends StatefulWidget {
  final List<SliderModel> slider;
  AppSwiper({Key? key, required this.slider});
  @override
  _AppSwiperState createState() => _AppSwiperState();
}

class _AppSwiperState extends State<AppSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Container(
            child: Builder(builder: (context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(
                  imageURL: widget.slider[index].image,
                ),
              );
            }),
          ),
          height: 190,
          width: double.infinity,
        );
      },
      autoplay: true,
      autoplayDelay: 10000,
      itemCount: widget.slider.length,
      pagination: SwiperPagination(
        margin: EdgeInsets.only(bottom: 25),
        builder: DotSwiperPaginationBuilder(
          activeColor: AppColors.primaryL,
          color: Colors.grey,
        ),
      ),
      // control: SwiperControl(),
    );
  }
}
