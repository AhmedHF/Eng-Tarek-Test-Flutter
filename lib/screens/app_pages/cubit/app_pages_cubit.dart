import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/config/index.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'app_pages_state.dart';

class AppPagesCubit extends Cubit<AppPagesState> {
  AppPagesCubit() : super(AppPagesInitial());

  static AppPagesCubit get(context) => BlocProvider.of(context);
  static final dataProvider = new AppPagesDataProvider();
  static final AppPagesRepository repository = AppPagesRepository(dataProvider);

  /// terms and conditions
  void getTermsAndConditions() {
    emit(TermsAndConditionsLoadingState());
    repository.getPageData(NetworkConstants.termsAndConditions).then(
      (value) {
        print("🚀 ~ file: app_cubit.dart ~ line 1300000  $value");
        if (value.errorMessages != null) {
          emit(TermsAndConditionsErrorState(value.errorMessages!));
        } else
          emit(TermsAndConditionsSuccessState(value.data));
      },
    );
  }

  /// app privacy
  void getPrivacy() {
    emit(PrivacyLoadingState());
    repository.getPageData(NetworkConstants.privacy).then(
      (value) {
        print("🚀 ~ file: app_cubit.dart ~ line 1300000  $value");
        if (value.errorMessages != null) {
          emit(PrivacyErrorState(value.errorMessages!));
        } else
          emit(PrivacySuccessState(value.data));
      },
    );
  }

  /// about us
  void getAboutUs() {
    emit(AboutUsLoadingState());
    repository.getPageData(NetworkConstants.aboutUs).then(
      (value) {
        print("🚀 ~ file: app_cubit.dart ~ line 1300000  $value");
        if (value.errorMessages != null) {
          emit(AboutUsErrorState(value.errorMessages!));
        } else
          emit(AboutUsSuccessState(value.data));
      },
    );
  }
}
