abstract class UtilFunctions {
  static DateTime parseDateTime(
    dynamic data, {
    bool mustReturnDate = false,
  }) {
    try {
      if (data is DateTime) return data;
      return DateTime.parse(data);
    } on FormatException {
      return DateTime.fromMillisecondsSinceEpoch(data as int);
    } catch (e, stackTrace) {
      if (mustReturnDate) return DateTime(DateTime.now().year);
      rethrow;
    }
  }
}
