bool isEmailValid(String email) {
  // Define a regular expression pattern for a simple email validation
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  // Use the hasMatch method to check if the email matches the pattern
  return emailRegex.hasMatch(email);
}

String getDisplayDateAndTime(DateTime selectedTime) {
  return '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}';
}