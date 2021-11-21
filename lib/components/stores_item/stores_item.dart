import 'package:flutter/material.dart';
import 'package:value_client/models/store.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/index.dart';

class StoreItem extends StatelessWidget {
  final StoreModel item;
  const StoreItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.storeDetailsScreen,
        arguments: {'id': item.id, 'name': item.name},
      ),
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        margin: const EdgeInsets.all(5),
        child: AppImage(imageURL: item.image),
      ),
    );
  }
}
