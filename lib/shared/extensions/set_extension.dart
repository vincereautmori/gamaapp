extension SetExtension<T> on Set {
  T operator [](int index) {
    return elementAt(index);
  }
}
