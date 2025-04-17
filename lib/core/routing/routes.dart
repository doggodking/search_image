abstract class Routes {
  static const String home = '/search_home';
  static const String detail = 'detail';
  static String detailPath() => '$home/$detail'; // '/search_home/detail'
}
