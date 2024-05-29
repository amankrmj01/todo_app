extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    final List<String> words = split(' ');
    final capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return '';
      }
    });

    return capitalizedWords.join(' ');
  }
}
