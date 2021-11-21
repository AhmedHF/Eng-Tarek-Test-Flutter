import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'top_discount_state.dart';

class TopDiscountCubit extends Cubit<TopDiscountState> {
  TopDiscountCubit() : super(TopDiscountInitial());

  static TopDiscountCubit get(context) => BlocProvider.of(context);
  static final dataProvider = HomeDataProvider();
  static final HomeRepository repository = HomeRepository(dataProvider);

  /// get Top discount
  void getTopDiscount(countryId) {
    emit(TopDiscountLoadingState());
    Map<String, dynamic> query = {};
    if (countryId != -1) {
      query.addAll({'country_id': countryId});
    }
    repository.getTopDiscount(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(TopDiscountErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(TopDiscountErrorState(value.errors!));
        } else {
          List<DiscountModel> topDiscount = [];

          value.data.forEach((item) {
            topDiscount.add(DiscountModel(
              id: item['store']['id'],
              name: item['name'],
              offer: item['discount_amount'],
              image: item['image'],
              description: item['description'],
              expire: item['is_active'],
              expireDate: item['to_date'],
              price: item['price'],
              priceBeforeDiscount: item['price_before_discount'],
              storeName: item['store']['store_name'],
              storeImage: item['store']['image'],
            ));
          });
          emit(TopDiscountSuccessState(topDiscount));
        }
      },
    );
  }
}
