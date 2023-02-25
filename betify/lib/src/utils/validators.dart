String? emailValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter an email!';
  }
  if (value.length < 5) {
    return 'Email too short!';
  }
  
  final regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final hasMatch = regex.hasMatch(value);
  return hasMatch ? null : 'Please enter a valid email address';
}

String? passwordValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a password!';
  }
  if (value.length < 5) {
    return 'Password too short!';
  }
  
  //final regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  //final hasMatch = regex.hasMatch(value);
  //return hasMatch ? null : 'Please enter a valid Password';
  return null;
}

String? usernameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a username!';
  }
  if (value.length < 5) {
    return 'Username too short!';
  }
  
  return null;
}

String? confirmPasswordValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a password!';
  }
  if (value.length < 5) {
    return 'Password too short!';
  }

  return null;
}