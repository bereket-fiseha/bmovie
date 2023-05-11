class StringOps {
  static shortenString(String str, int length) {
    return str.length <= length ? str : "${str.substring(0, length)}...";
  }
}
