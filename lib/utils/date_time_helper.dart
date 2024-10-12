

extension DateTimeHelper on DateTime{
  static DateTime fromEpoch(int epoch) => DateTime.fromMillisecondsSinceEpoch(epoch);

  static int toEpoch(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}