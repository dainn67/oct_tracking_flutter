bool isEmailValid(String email) {
  // Define a regular expression pattern for a simple email validation
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  // Use the hasMatch method to check if the email matches the pattern
  return emailRegex.hasMatch(email);
}

String getDisplayDateAndTime(DateTime selectedTime) {
  final String displayDay = selectedTime.day < 10 ? '0${selectedTime.day}' : selectedTime.day.toString();
  final String displayMonth = selectedTime.month < 10 ? '0${selectedTime.month}' : selectedTime.month.toString();
  return '$displayDay / $displayMonth / ${selectedTime.year}';
}