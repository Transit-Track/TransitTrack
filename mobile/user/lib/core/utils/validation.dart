String? phoneNumberValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone Number can not be empty';
  }

  var pattern = r'^(?:\+251|0)?[1-9][0-9]{8}$|^(?:\+254|07)[0-9]{8}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Invalid phone number, use +251 or 07(+254)';
  }

  return null;
}

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

String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? fullNameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Full name cannot be empty';
  }

  // Pattern to match a full name with at least two words, each starting with an uppercase letter followed by lowercase letters
  String pattern = r'^[A-Z][a-z]+(?: [A-Z][a-z]+)+$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid full name (e.g., John Doe)';
  }

  return null;
}

// String? emailOrPhoneNumberValidation(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Enter your email or phone number';
//   }

//   final emailResponse = emailValidation(value);
//   final phoneNumberResponse = phoneNumberValidation(value);

//   if (emailResponse != null || phoneNumberResponse != null) {
//     return 'Enter a valid email or phone number';
//   }

//   return null;
// }
