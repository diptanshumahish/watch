extension TextFieldValidators on String {
  bool isValidEmail() {
    if (isEmpty) {
      return false;
    }
    if (!contains('@')) {
      return false;
    }
    return true;
  }

  bool isValidPassword() {
    if (isEmpty) {
      return false;
    }
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }

  bool isValidName() {
    if (isEmpty) {
      return false;
    }
    if (length < 3) {
      return false;
    }
    return true;
  }

  bool isSame(String pattern) {
    if (pattern.compareTo(this) == 0) {
      return true;
    }
    return false;
  }
}
