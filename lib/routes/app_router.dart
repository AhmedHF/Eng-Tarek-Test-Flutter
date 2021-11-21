import 'package:flutter/material.dart';
import 'package:value_client/layout/home/home_layout.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/index.dart';
import 'package:value_client/screens/savings/savings.dart';
import 'package:value_client/screens/search/branch_list.dart';

class AppRouter {
  static Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
    debugPrint('App route =========== > $settings.name');
    debugPrint('App route =========== > $settings.arguments');

    switch (settings.name) {
      case AppRoutes.testScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const TestScreen();
          },
          settings: settings,
        );

      case AppRoutes.appHome:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const HomeLayout();
          },
          settings: settings,
        );

      case AppRoutes.loginScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const LoginScreen();
          },
          settings: settings,
        );

      case AppRoutes.signupScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SignUpScreen();
          },
          settings: settings,
        );

      case AppRoutes.mapScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return MapScreen(
                address: settings.arguments as Map<String, dynamic>);
          },
          settings: settings,
        );

      case AppRoutes.resetPasswordScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ResetPassword();
          },
          settings: settings,
        );
      case AppRoutes.verifyCodeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const VerifyCode();
          },
          settings: settings,
        );
      case AppRoutes.verifiedScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const VerifiedScreen();
          },
          settings: settings,
        );
      case AppRoutes.storesListScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const StoresListScreen();
          },
          settings: settings,
        );
      case AppRoutes.storeDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const StoreDetailsScreen();
          },
          settings: settings,
        );
      case AppRoutes.offerDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return OfferDetailsScreen();
          },
          settings: settings,
        );
      case AppRoutes.checkoutScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CheckoutScreen();
          },
          settings: settings,
        );

      case AppRoutes.paymentDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PaymentDetailsScreen();
          },
          settings: settings,
        );

      case AppRoutes.orderCreatedScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const OrderCreatedScreen();
          },
          settings: settings,
        );
      case AppRoutes.ratedOffersScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const RatedOffersScreen();
          },
          settings: settings,
        );
      case AppRoutes.branchListScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const BranchListScreen();
          },
          settings: settings,
        );
      case AppRoutes.memberShipScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const MemberShipScreen();
          },
          settings: settings,
        );
      case AppRoutes.notificationsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const NotificationsScreen();
          },
          settings: settings,
        );
      case AppRoutes.aboutusScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const AboutusScreen();
          },
          settings: settings,
        );
      case AppRoutes.termsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const TermsScreen();
          },
          settings: settings,
        );
      case AppRoutes.privacyScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PrivacyScreen();
          },
          settings: settings,
        );
      case AppRoutes.searchResultScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SearchResultScreen();
          },
          settings: settings,
        );

      case AppRoutes.checkoutMemberShipScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CheckoutMemberShipScreen();
          },
          settings: settings,
        );
      case AppRoutes.changePasswordScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangePasswordScreen();
          },
          settings: settings,
        );
      case AppRoutes.profileScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ProfileScreen();
          },
          settings: settings,
        );
      case AppRoutes.contactUsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ContactUsScreen();
          },
          settings: settings,
        );
      case AppRoutes.purchasedCouponScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PurchasedCouponScreen();
          },
          settings: settings,
        );
      case AppRoutes.followingsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const FollowingsScreen();
          },
          settings: settings,
        );
      case AppRoutes.purchasedCouponDetailsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PurchasedCouponDetailScreen();
          },
          settings: settings,
        );
      case AppRoutes.changeLanguageScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangeLanguageScreen();
          },
          settings: settings,
        );
      case AppRoutes.qrScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const QRScreen();
          },
          settings: settings,
        );

      case AppRoutes.changePhoneScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ChangePhoneScreen();
          },
          settings: settings,
        );
      case AppRoutes.sortByScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SortByScreen();
          },
          settings: settings,
        );
      case AppRoutes.myValueSortByScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const MyValueSortByScreen();
          },
          settings: settings,
        );
      case AppRoutes.savingsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SavingsScreen();
          },
          settings: settings,
        );
      case AppRoutes.searchScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SearchScreen();
          },
          settings: settings,
        );
      case AppRoutes.storeCategoryScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const StoreCategoryScreen();
          },
          settings: settings,
        );
      case AppRoutes.citiesScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CitiesScreen();
          },
          settings: settings,
        );
      case AppRoutes.areaScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const AreaScreen();
          },
          settings: settings,
        );
      case AppRoutes.tagsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const TagsScreen();
          },
          settings: settings,
        );
      case AppRoutes.valueTypeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ValueTypeScreen();
          },
          settings: settings,
        );
      case AppRoutes.categoryScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CategoryScreen();
          },
          settings: settings,
        );
      case AppRoutes.couponTypeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const CouponTypeScreen();
          },
          settings: settings,
        );
      case AppRoutes.forgetPasswordScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const ForgetPasswordScreen();
          },
          settings: settings,
        );
      case AppRoutes.searchBranchListScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SearchBreanchListScreen();
          },
          settings: settings,
        );
      case AppRoutes.mapSearchScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const MapSearchScreen();
          },
          settings: settings,
        );
      case AppRoutes.verifyUpdateMobile:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const VerifyUpdateMobile();
          },
          settings: settings,
        );

      case AppRoutes.selectCountryScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const SelectCountryScreen();
          },
          settings: settings,
        );

      case AppRoutes.paymentWebViewScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const PaymentWebViewScreen();
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return const LoginScreen();
          },
          settings: settings,
        );
    }
  }
}
