List<T> mapWithIndex<S, T>(
  List<S> items,
  T Function(S item, int index) fn,
) {
  return items
      .asMap()
      .map((int i, S element) => MapEntry(i, fn(element, i)))
      .values
      .toList();
}
