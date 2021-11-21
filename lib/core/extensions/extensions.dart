extension ExtStringValidations on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailRegExp.hasMatch(this) == true) {
      if (trim().length >= 10) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
    // return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    // final nameRegExp =
    //     new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");

    // return nameRegExp.hasMatch(this);
    if (trim().length >= 3) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidPassword {
    // final passwordRegExp = RegExp(
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{8,}$');
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_-]).{4,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }

  bool get isNumeric {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    return phoneRegExp.hasMatch(this);
  }

  bool isValidMinLength(int nim) {
    if (trim().length >= nim) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidMaxLength(int max) {
    if (trim().length <= max) {
      return true;
    } else {
      return false;
    }
  }

  String? get isValidMinLengthS {
    if (length >= 3) {
      return null;
    } else {
      return 'false min';
    }
  }

  String? get isValidMaxLengthS {
    if (length <= 5) {
      return null;
    } else {
      return 'false max';
    }
  }

  String? get isEmptyS {
    if (isEmpty) {
      return null;
    } else {
      return 'false _isEmpty';
    }
  }
}
