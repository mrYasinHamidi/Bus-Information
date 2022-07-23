class DatabaseError extends Error {
  final String message;

  DatabaseError(this.message);

  @override
  String toString() {
    return 'HiveError: $message';
  }
}
