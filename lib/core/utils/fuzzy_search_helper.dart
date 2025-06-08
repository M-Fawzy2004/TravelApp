import 'dart:math';

class FuzzySearchHelper {
  static int levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> matrix = List.generate(
      s1.length + 1,
      (i) => List.generate(s2.length + 1, (j) => 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce(min);
      }
    }

    return matrix[s1.length][s2.length];
  }

  static double similarity(String s1, String s2) {
    if (s1.isEmpty && s2.isEmpty) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    int maxLength = max(s1.length, s2.length);
    int distance = levenshteinDistance(s1.toLowerCase(), s2.toLowerCase());

    return 1.0 - (distance / maxLength);
  }

  static String normalizeArabicText(String text) {
    return text
        .replaceAll(RegExp(r'[َُِّْ]'), '')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
  }

  static List<T> fuzzySearch<T>(
    List<T> items,
    String query,
    String Function(T) getSearchableText, {
    double threshold = 0.6,
    int maxResults = 10,
  }) {
    if (query.isEmpty) return items;

    String normalizedQuery = normalizeArabicText(query);

    List<MapEntry<T, double>> scoredItems = [];

    for (T item in items) {
      String itemText = normalizeArabicText(getSearchableText(item));

      if (itemText.contains(normalizedQuery)) {
        scoredItems.add(MapEntry(item, 1.0));
        continue;
      }

      double score = similarity(normalizedQuery, itemText);

      List<String> words = itemText.split(' ');
      for (String word in words) {
        double wordScore = similarity(normalizedQuery, word);
        if (wordScore > score) {
          score = wordScore;
        }
      }

      if (score >= threshold) {
        scoredItems.add(MapEntry(item, score));
      }
    }

    scoredItems.sort((a, b) => b.value.compareTo(a.value));

    return scoredItems.take(maxResults).map((entry) => entry.key).toList();
  }

  static List<String> getSuggestions(
    List<String> availableOptions,
    String query, {
    double threshold = 0.4,
    int maxSuggestions = 5,
  }) {
    return fuzzySearch(
      availableOptions,
      query,
      (String option) => option,
      threshold: threshold,
      maxResults: maxSuggestions,
    );
  }
}
