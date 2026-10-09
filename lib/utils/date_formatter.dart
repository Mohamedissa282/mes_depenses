String formatDate(DateTime date) {
  return "${date.day} ${_monthName(date.month)} ${date.year} – ${_two(date.hour)}:${_two(date.minute)}";
}

String _monthName(int m) {
  const months = [
    "janv.", "févr.", "mars", "avr.", "mai", "juin",
    "juil.", "août", "sept.", "oct.", "nov.", "déc."
  ];
  return months[m - 1];
}

String _two(int n) => n.toString().padLeft(2, '0');
