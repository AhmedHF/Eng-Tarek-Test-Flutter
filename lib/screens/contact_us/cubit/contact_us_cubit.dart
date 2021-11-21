import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  ComplainTypeModel? complainType;

  void setSelectedComplainType(ComplainTypeModel type) {
    complainType = type;
  }

  static final dataProvider = new ContactUsDataProvider();

  static final ContactUsRepository repository =
      ContactUsRepository(dataProvider);

  void sendContactUs(values) {
    emit(ContactUsLoadingState());
    repository.sendContactUs(values).then(
      (value) {
        print("🚀 ~ file: app_cubit.dart ~ line 12000   $value");
        if (value.errorMessages != null) {
          emit(ContactUsErrorState(value.errorMessages!));
        } else
          emit(ContactUsSuccessState(value.data));
      },
    );
  }
}
