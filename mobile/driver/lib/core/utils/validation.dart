String? passWordValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone Number can not be empty';
  }

  if (value.length < 8) {
    return 'Password length must be atleast 8 characters long';
  }

  var pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character';
  }

  return null;
}


