import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/repositories/index.dart';

part 'user_membership_state.dart';

class UserMembershipCubit extends Cubit<UserMembershipState> {
  UserMembershipCubit() : super(UserMembershipInitial());

  static UserMembershipCubit get(context) => BlocProvider.of(context);

  static final MyValuesDataProvider dataProvider = MyValuesDataProvider();
  static final MyValuesRepository repository = MyValuesRepository(dataProvider);

  /// get user memberShip details
  void getUserMemberShipDetails() {
    emit(UserMemberShipLoadingState());
    repository.getUserMemberShipDetails().then(
      (value) {
        Map<String, dynamic> userMemberShip = {};

        if (value.errorMessages != null) {
          emit(UserMemberShipErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(UserMemberShipErrorState(value.errors!));
        } else {
          userMemberShip.addAll(value.data);
          userMemberShip.addAll({'saving': value.meta});
          emit(UserMemberShipSuccessState(userMemberShip));
        }
      },
    );
  }
}
