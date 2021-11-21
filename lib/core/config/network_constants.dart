class NetworkConstants {
  NetworkConstants._();

  static const String baseUrlDev = 'https://allvalue.club';
  static const String baseUrlStage = 'https://allvalue.club';
  static const String baseUrlProd = 'https://allvalue.club';

  static const String apiVersion = '/v1';
  static const String apiPrefix = '/api';

  static const String webPrefix = '/web';

  static const String webFAQ = "/faq";
  static const String termsAndConditions = "/terms";
  static const String privacy = "/privacy";
  static const String aboutUs = "/about-us";
  static const String contactUs = "/contact-us";

  /// auth
  static const String login = "/login";
  static const String checkCode = "/check-code";
  static const String resendCode = "/resend-code";
  static const String register = "/register";
  static const String forgetPassword = "/forget-password";
  static const String resetPassword = "/reset-password";
  static const String changePassword = "/change-password";
  static const String updateMobile = "/update-profile";
  static const String updateMobileVerify = "/update-mobile";
  static const String updateProfile = "/update-profile";
  static const String logout = "/logout";

  /// search
  static const String categories = "/categories";
  static const String couponTypes = "/coupon-types";

  /// Home page
  static const String slider = '/ads';
  static const String stores = "/stores";
  static const String coupons = "/coupons";

  /// cart
  static const String cart = '/cart';
  static const String updateItemInCart = '/update-cart';
  static const String addItemToCart = '/add-to-cart';
  static const String deleteItemFromCart = '/delete-cart';
  static const String checkout = '/checkout';
  static const String totalPrice = '/cart-total';
  static const String paymentMethods = '/payment-methods';


  /// my values
  static const String userCoupons = "/user-coupons";
  static const String userCouponDetails = "/user-coupon";
  static const String sendGift = "/send-gift";
  static const String couponDetails = "/coupon-details";
  static const String userMemberShip = "/user-memberships";
  static const String saving = "/saving";

  // countries
  static const String countries = "/countries";

  // statesByCountry
  static const String statesByCountry = "/states-by-country";

  // citiesByState
  static const String citiesByState = "/cities-by-state";

  //fav
  static const String toggleFav = "/fav-coupon";

  // QR
  static const String qr = "/qr";

  //store details
  static const String storeDetails = "/store-details";

  //notifications
  static const String notifications = "/notifications";
  static const String readNotification = "/read-notification";
  static const String removeNotification = "/delete-notification";

  // memberships
  static const String memberships = "/memberships";
  static const String subscribe = "/subscribe";
}
