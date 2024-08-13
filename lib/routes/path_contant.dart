abstract final class PathConstant {
  static const userIdParam = 'userId';

  static const signUpPath = '/sign-up';
  static const signInPath = '/sign-in';
  static const userListPath = '/user-list';

  static String userDetailsPath({String? id}) =>
      '$userListPath/${id ?? ':$userIdParam'}';
}
